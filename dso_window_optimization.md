---
tag: algorithms/slam
---
## DSO 滑窗优化
在确定当前帧为关键帧, 并激活了其他帧中的`immaturePoints`之后, 滑窗优化在 __FullSystem::makeKeyFrame()__ 中被调用. 
优化的量: 点的逆深度(M), 相机的4个内参, 相机位姿和两个光度参数($8 \times 8$).

代码流程:
```c++
FullSystem::makeKeyFrame()
{
    FullSystem::optimize(setting_maxOptIterations)
    {
        // 重要步骤, 线性化, 预计算Jacobian的一些零散值, false表示不固定线性化点
        linearizeAll(false);

        // 重要步骤, 将上述计算的Jacobian碎片值传递到energy functiuon对应的变量中
        applyRes_Reductor(true,0,activeResiduals.size(),0,0);

        for(int iteration=0;iteration<mnumOptIts;iteration++)
        {
            // 记录之前的step
            backupState(iteration!=0);
            solveSystem(iteration, lambda)
            {
                getNullspaces(...);
                ef->solveSystemF(iteration, lambda,&Hcalib);
            }
        }
    }
}
```

求解, 公式:

$$
\begin{aligned}
\begin{bmatrix}
H_{\rho \rho} & H_{\rho X} \\
H_{X \rho} & H_{XX}
\end{bmatrix} \begin{bmatrix} \delta \rho \\ \delta X \end{bmatrix} &= -\begin{bmatrix}
J_\rho^T r \\ J_X^T r
\end{bmatrix} \\
\begin{bmatrix}
H_{\rho \rho} & H_{\rho X} \\
0 & H_{XX} - H_{X \rho} H_{\rho \rho}^{-1} H_{\rho X}
\end{bmatrix} \begin{bmatrix} \delta \rho \\ \delta X \end{bmatrix} &= -\begin{bmatrix}
J_\rho^T r \\ J_X^T r - H_{X \rho} H_{\rho \rho}^{-1} J_\rho^T r
\end{bmatrix}
\end{aligned}
$$

在代码实现中$H_{XX}$被拆分成3部分求解:
$$
\begin{aligned}
H_{XX} &= \begin{bmatrix} \frac{\partial r}{\partial C} & \frac{\partial r}{\partial \xi} & \frac{\partial r}{\partial A} \end{bmatrix}^T \begin{bmatrix} \frac{\partial r}{\partial C} & \frac{\partial r}{\partial \xi} & \frac{\partial r}{\partial A} \end{bmatrix} \\
&= \begin{bmatrix}
\frac{\partial r}{\partial C}^T \frac{\partial r}{\partial C} & \frac{\partial r}{\partial C}^T \frac{\partial r}{\partial \xi} & \frac{\partial r}{\partial C}^T \frac{\partial r}{\partial A} \\
\frac{\partial r}{\partial \xi}^T \frac{\partial r}{\partial C} & \frac{\partial r}{\partial \xi}^T \frac{\partial r}{\partial \xi} & \frac{\partial r}{\partial \xi}^T \frac{\partial r}{\partial A} \\
\frac{\partial r}{\partial A}^T \frac{\partial r}{\partial C} & \frac{\partial r}{\partial A}^T \frac{\partial r}{\partial \xi} & \frac{\partial r}{\partial A}^T \frac{\partial r}{\partial A}
\end{bmatrix}
\end{aligned}
$$

在实现时, 通过`acc[tid][htIDX].update`, `acc[tid][htIDX].updateBotRight`, `acc[tid][htIDX].updateTopRight`分别求$H_a, H_b, H_c$, 从而通过`stitchDoubleMT`组合得到$H_{XX}$和$J_X^T r$.
$$
H_{LA} = \begin{bmatrix}
H_{a: 10 \times 10} & H_{b: 10 \times 3} \\
H_{b: 3 \times 10} & H_{c: 3 \times 3}
\end{bmatrix}
$$

其中
$$
\begin{aligned}
H_{a:10 \times 10} &= \begin{bmatrix}
\frac{\partial r}{\partial C}^T \frac{\partial r}{\partial C}_{4 \times 4} & \frac{\partial r}{\partial C}^T \frac{\partial r}{\partial \xi}_{4 \times 6} \\
\frac{\partial r}{\partial \xi}^T \frac{\partial r}{\partial C}_{6 \times 4} & \frac{\partial r}{\partial \xi}^T \frac{\partial r}{\partial \xi}_{6 \times 6}
\end{bmatrix}\\
H_{b:10\times 3} &= \begin{bmatrix}
\frac{\partial r}{\partial C}^T \frac{\partial r}{\partial A}_{4 \times 2} & \frac{\partial r}{\partial C}^T r_{4 \times 1} \\
\frac{\partial r}{\partial \xi}^T \frac{\partial r}{\partial A}_{6 \times 2} & \frac{\partial r}{ \partial \xi}^T r_{6 \times 1}
\end{bmatrix} \\
H_{c: 3 \times 3} &= \begin{bmatrix}
\frac{\partial r}{\partial A}^T \frac{\partial r}{\partial A}_{2 \times 2} & \frac{\partial r}{\partial A}^T r_{2 \times 1}\\
r^T \frac{\partial r}{\partial A}_{1 \times 2} & r^T r
\end{bmatrix}
\end{aligned}
$$

再通过`EnergyFunctional::accumulateSCF_MT`来计算$H_\phi = H_{X\rho}H_{\rho \rho}^{-1}H_{\rho X}, g_\phi = H_{X\rho}H_{\rho \rho}^{-1}J_\rho^T r$.
$$
\begin{aligned}
H_\phi &= J_X^T J_\rho (J_\rho^T J_\rho)^{-1}J_\rho^TJ_X\\
 &= \begin{bmatrix} \frac{\partial r}{\partial C} & \frac{\partial r}{\partial \xi} \end{bmatrix}^T \frac{\partial r}{\partial \rho} \left( \frac{\partial r}{\partial \rho}^T \frac{\partial r}{\partial \rho} \right)^{-1} \frac{\partial r}{\partial \rho}^T \begin{bmatrix} \frac{\partial r}{\partial C} & \frac{\partial r}{\partial \xi}\end{bmatrix}
\end{aligned}
$$


```c++
void EnergyFunctional::solveSystemF(int iteration, double lambda, CalibHessian* HCalib)
{
    // 计算H_{XX}和J_X^T r
    // 对线性化点非固定的residual
    accumulateAF_MT(HA_top, bA_top,multiThreading)
    {
        for(EFFrame* f : frames)
            for(EFPoint* p : f->points)
                accSSE_top_A->addPoint<0>(p,this)
                {
                    for(EFResidual* r : p->residualsAll)
                    {
                        // 这里mode == 0
                        // 当mode==1时, !r->isLinearized-->accmulateLF_MT
                        if(r->isLinearized || !r->isActive()) continue;

                        // jpdc: d[x, y]/ d[C]
                        // 计算 H_a
                        acc[tid][htIDX].update(
                            rJ->Jpdc[0].data(), rJ->Jpdxi[0].data(),
                            rJ->Jpdc[1].data(), rJ->Jpdxi[1].data(),
                            J->JIdx2(0,0),rJ->JIdx2(0,1),rJ->JIdx2(1,1));

                        // 计算H_b
                        acc[tid][htIDX].updateBotRight(
                            rJ->Jab2(0,0), rJ->Jab2(0,1), Jab_r[0],
                            rJ->Jab2(1,1), Jab_r[1],rr);
    
                        // 计算H_c
                        // JIdx: d[r]/d[x,y]
                        acc[tid][htIDX].updateTopRight(
                            rJ->Jpdc[0].data(), rJ->Jpdxi[0].data(),
                            rJ->Jpdc[1].data(), rJ->Jpdxi[1].data(),
                            rJ->JabJIdx(0,0), rJ->JabJIdx(0,1),
                            rJ->JabJIdx(1,0), rJ->JabJIdx(1,1),
                            JI_r[0], JI_r[1]);
                        }
                }

        // 组合生成H_{xx} 和 \delta X
        accSSE_top_A->stitchDoubleMT(red,H,b,this,false,false);
    }

    // 计算H_{XX}和J_X^T r
    // 线性化点被固定的residual, mode=1
    // 这个没有用!!!
    accumulateLF_MT(HL_top, bL_top,multiThreading);

    // 计算Schur Complement部分的矩阵
    accumulateSCF_MT(H_sc, b_sc,multiThreading)
    {
        for(EFFrame* f : frames)
            for(EFPoint* p : f->points)
                accSSE_bot->addPoint(p, true)
                {

                }
        accSSE_bot->stitchDoubleMT(red, H, b,this,false);
    }
}
```

## Reference
[DSO Windowed optimization代码](https://www.cnblogs.com/JingeTU/p/8395046.html)
[DSO追踪与优化](https://link.zhihu.com/?target=https%3A//blog.csdn.net/xxxlinttp/article/details/90640350)