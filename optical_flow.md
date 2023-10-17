---
tag: algorithms
---
# 光流跟踪Note
## 基本原理
三个假设:
1. 相邻帧之间的亮度恒定
2. 相邻帧之间物体的运动比较"微小"
3. 保持空间一致性, 即相邻像素点具有相同的运动

设$t$时刻位于$x, y$处的灰度值为: $I(x, y, t)$
在$t+dt$时刻, 该像素运动到了: $I(x+dx, y+dy, t+dt)$
希望计算$dx, dy$.

$$
\begin{aligned}
I(x+dx, y+dy, t+dt) &\approx I(x, y, t) + \frac{\partial I}{\partial x} dx + \frac{\partial I}{\partial y} dy + \frac{\partial I}{\partial t} dt\\
\Rightarrow \begin{bmatrix}I_x & I_y\end{bmatrix} \begin{bmatrix}dx/dt\\ dy/dt\end{bmatrix} &= -I_t
\end{aligned} \tag{1}
$$

根"相邻像素的空间一致性", 假定一个patch内部运动不变则有:
$$
\begin{bmatrix}I_{x1} & I_{y1}\\I_{x2} & I_{y2}\\ ... & ...\\I_{xk} & I_{yk}\end{bmatrix} \begin{bmatrix}dx/dt\\dy/dt\end{bmatrix} = \begin{bmatrix}I_{t1}\\I_{t2}\\...\\I_{tk}\end{bmatrix} \tag{2}
$$

求最小二乘解即可.

更一般的定义:
目标是将一个模板图像$T(\mathbf{x})$与输入图片$I(\mathbf{x})$对齐. 定义一个warp的参数化表达形式为$W(\mathbf{x}; \mathbf{p})$. $W(\mathbf{x}; \mathbf{p})$将图像$T(\mathbf{x})$上位置为$\mathbf{x}$的像素点映射到图像$I$上. $W(\mathbf{x}; \mathbf{p})$可以是平移, 也可以是一个仿射变换. 光流跟踪的目标函数:
$$
\sum_\mathbf{x} \left[I(W(\mathbf{x}; \mathbf{p}) - T(\mathbf{x}))\right]^2 \tag{3}
$$

迭代优化$\mathbf{p}$(计算$\Delta \mathbf{p}$):
$$
\min \sum_\mathbf{x} \left[I(W(\mathbf{x}; \mathbf{p}+\Delta \mathbf{p}) - T(\mathbf{x}))\right]^2 \tag{4}
$$

泰勒展开:
$$
\begin{aligned}
\min &\sum_{\mathbf{x}} \left[I(\mathbf{W}(\mathbf{x}; \mathbf{p})) + \nabla I \frac{\partial W}{\partial \mathbf{p}} \Delta \mathbf{p} - T(\mathbf{x})\right]^2\\
\Delta \mathbf{p} &= H^{-1} \sum_{\mathbf{x}} \left[\nabla I\frac{\partial W}{\partial \mathbf{p}}\right]^T \left[T(\mathbf{x}) - I(W(\mathbf{x}; \mathbf{p}))\right]\\
H &= \sum_\mathbf{x} \left[\nabla I \frac{\partial W}{\partial \mathbf{p}}\right]^T\left[\nabla I \frac{\partial W}{\partial \mathbf{p}}\right]
\end{aligned} \tag{5}
$$

## 多层光流
Coarse to fine的策略, 由于图像非凸, 为了更鲁棒地应对快速运动.

## Compositional方法
与Additive目标函数(3)有所不同, Compositional方法的目标函数为:
$$
\sum_{\mathbf{x}} [I(W(W(\mathbf{x}; \Delta \mathbf{p}), \mathbf{p})) - T(\mathbf{x})]^2 \tag{6}
$$

迭代更新方式为:$W(\mathbf{x}; \mathbf{p}) \leftarrow W(\mathbf{x}; \mathbf{p}) \circ W(\mathbf{x}; \Delta \mathbf{p}) \equiv W(W(\mathbf{x}; \Delta \mathbf{p}); \mathbf{p})$. 泰勒展开有:
$$
\sum_\mathbf{x} \left[I(W(W(\mathbf{x}; 0); \mathbf{p})) + \nabla I(W) \frac{\partial W}{\partial \mathbf{p}}|_{(\mathbf{x};0)} - T(\mathbf{x}) \right]^2 \tag{7}
$$

与Additive两处不同:①$\nabla I(W)$为变化后的图像的梯度; ②$\frac{\partial W}{\mathbf{\partial x}}$后者在点$(\mathbf{x}; 0)$处计算, 为定值. 而前者在$(\mathbf{x}; \mathbf{q})$处计算.

## 逆向方法
正向的方法, 每次都需要重新计算Hessian并求逆$O(n^3)$. Inverse的方式将Input和Template互换, 计算的是增量的逆. 使用inverse的方法计算时, 由于Template图像是固定的, 因此Hessian矩阵是固定的, 可以预计算, 从而提高计算效率. 目标函数和更新方式:
$$
\begin{aligned}
\sum_{\mathbf{x}} [T(W(\mathbf{x}; \Delta \mathbf{p})) - I(W(\mathbf{x}; \mathbf{p}))]^2\\
W(\mathbf{x}; \mathbf{p}) \leftarrow W(\mathbf{x}; \mathbf{p}) \circ W(\mathbf{x}; \mathbf{\Delta p})^{-1}
\end{aligned}
\tag{8}
$$

## Reference
> SLAM十四讲
> Lucas-Kanade 20 Years On: A Unifying Framework