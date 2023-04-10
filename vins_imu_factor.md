---
tag: paper_note
---
# VINS IMU预积分&IMU残差
[TOC]

## 优化变量
优化的是每帧imu在世界坐标系中的位姿, 特征点的逆深度, 相机到IMU的外参以及IMU的bias.
$$
\begin{aligned}
\chi &=[\mathbf{x}_0, \mathbf{x}_1, ..., \mathbf{x}_n, \mathbf{x}_c^b, \lambda_0, \lambda_1, ..., \lambda_m] \\
\mathbf{x}_k &= [\mathbf{p}_{b_k}^w, \mathbf{v}_{b_k}^w, \mathbf{q}_{b_k}^w, \mathbf{b}_a, \mathbf{b}_g], k \in [0, n]\\
\mathbf{x}_c^b &= [\mathbf{p}_c^b, \mathbf{q}_c^b]
\end{aligned}
$$

## IMU预积分公式推导
基本数学符号定义
| Notation  | meaning  |Notation  | meaning  |
|-----------|----------|----------|----------|
| $T_a^b \in SE(3)$  |  rt matrix a $\to$ b |$\otimes$ | 四元素相乘符号 |
| $R_a^b \in SO(3)$  |  Rotation matrix a $\to$ b |$\hat{\omega}$  | IMU角速度原始数据 |
| $q_a^b$  | Quaternion a $\to$ b |$\hat{a}$ | IMU加速度原始数据 |
| $B$   | IMU的局部坐标系 |$\mathcal{F}$ | 激光帧原始数据 |
| $L$  | 激光雷达的局部坐标系 |$F$ | 抽取的激光特征 |
| $W$  | 全局坐标系| |

定义IMU状态$X_{B_i}^W$, 和其外参$T_B^L$:
$$
\begin{aligned}
X_{B_i}^W &= [ {p_{B_i}^{W}}^T \quad {v_{B_i}^{W}}^T \quad {q_{B_i}^{W}}^T \quad b_{a_i}^T \quad b_{g_i}^T]^T\\
T_B^L &= [{p_B^{L}}^T \quad {q_B^L}^T]^T
\end{aligned}
$$

则有状态的更新公式
$$
\begin{aligned}
\mathbf{p}_{b_{k+1}}^{w}=\mathbf{p}_{b_{k}}^{w} &+\mathbf{v}_{b_{k}}^{w} \Delta t_{k} \\ &+\iint_{t \in\left[t_{k}, t_{k+1}\right]}\left(\mathbf{R}_{t}^{w}\left(\hat{\mathbf{a}}_{t}-\mathbf{b}_{a_{t}}-\mathbf{n}_{a}\right)-\mathbf{g}^{w}\right) d t^{2} \\ \mathbf{v}_{b_{k+1}}^{w}=\mathbf{v}_{b_{k}}^{w}+& \int_{t \in\left[t_{k}, t_{k+1}\right]}\left(\mathbf{R}_{t}^{w}\left(\hat{\mathbf{a}}_{t}-\mathbf{b}_{a_{t}}-\mathbf{n}_{a}\right)-\mathbf{g}^{w}\right) d t \\ \mathbf{q}_{b_{k+1}}^{w}=\mathbf{q}_{b_{k}}^{w} \otimes & \int_{t \in\left[t_{k}, t_{k+1}\right]} \frac{1}{2} \mathbf{\Omega}\left(\hat{\omega}_{t}-\mathbf{b}_{w_{t}}-\mathbf{n}_{w}\right) \mathbf{q}_{t}^{b_{k}} d t
\end{aligned}
$$

这里, $p, v, q$分别为`position`, `velocity`, `orientation`. $b_{a_i}$是加速度的零偏, $b_{g_i}$是角速度的零偏, $\mathbf{n}_{a} \sim \mathcal{N}(0, \sigma_a^2)$, $\mathbf{n}_{w} \sim \mathcal{N}(0, \sigma_w^2)$. $\Omega$将角速度转化为四元素相乘的矩阵.

IMU状态更新离散化表示($i$, $j$两个激光帧数据之间有多组IMU数据)
$$
\begin{aligned}
\mathrm{p}_j &= \mathrm{p}_i + \sum_{k=i}^{j-1} [v_k \Delta t - \frac{1}{2} g^W \Delta t^2 + \frac{1}{2}R_k(\hat{a}_k - b_{a_k})\Delta t^2] \\
\mathrm{v}_j &= \mathrm{v}_i - g^W \Delta t_{ij} + \sum_{k=i}^{j-1} R_k(\hat{a}_k -b_{a_k}) \Delta t\\
q_j &= q_i \otimes \Pi_{k=i}^{j-1} \delta q_k = q_i \otimes \Pi_{k=i}^{j-1} \begin{bmatrix} \frac{1}{2} \Delta t(\hat{\omega}_k - b_{g_k}) \\ 1 \end{bmatrix}
\end{aligned}
$$

若是按照上述方法更新IMU状态, 当前一个状态被调整后, 后续状态都需要重新计算. 容易想到, 不论之前的状态如何改变, 两个IMU数据的测量值不会变, 因此其加速度和角加速度导致的变化量不变(__真正需要积分计算的部分不变, 因此可以预计算, 此所谓IMU预积分__).

>我的理解:
以一个clean base计算这个变化量:
$$
[\mathrm{p} = 0 \quad v = 0 \quad q=0] \rightarrow [\Delta \mathrm{p}_{ij} \quad \Delta v_{ij} \quad \Delta q_{ij}]
$$
为了计算更加灵活, 将重力部分单独分离:
$$
\begin{aligned}
\mathrm{p}_j &= \mathrm{p}_i + \sum_{k=i}^{j-1} [v_k \Delta t + \frac{1}{2}R_k(\hat{a}_k - b_{a_k})\Delta t^2] - \frac{1}{2} g^W \Delta t_{ij}^2\\
&=\mathrm{p}_i + R(q_i) \Delta \mathrm{p}_{ij} + \mathrm{v}_i \Delta t_{ij} - \frac{1}{2} g^W \Delta t_{ij}^2\\
\mathrm{v}_j &= \mathrm{v}_i - g^W \Delta t_{ij} + \sum_{k=i}^{j-1} R_k(\hat{a}_k -b_{a_k}) \Delta t\\
&=\mathrm{v}_i + R(\mathrm{q}_i)\Delta \mathrm{v}_{ij} - g^W\Delta t_{ij}\\
q_j &= q_i \otimes \Pi_{k=i}^{j-1} \delta q_k \\
&= q_i \otimes \Pi_{k=i}^{j-1} \begin{bmatrix} \frac{1}{2} \Delta t(\hat{\omega}_k - b_{g_k}) \\ 1 \end{bmatrix}\\
&= q_i \otimes \Delta q_{ij}
\end{aligned}
$$
这里$\Delta \mathrm{p}_{ij}, \Delta \mathrm{v}_{ij}, \Delta q_{ij}$即以这个clean base, 忽略重力加速度后, 积分得到的距离和速度和四元素.

定义:
$$
\begin{aligned} \boldsymbol{\alpha}_{b_{k+1}}^{b_{k}} &=\iint_{t \in\left[t_{k}, t_{k+1}\right]} \mathbf{R}_{t}^{b_{k}}\left(\hat{\mathbf{a}}_{t}-\mathbf{b}_{a_{t}}-\mathbf{n}_{a}\right) d t^{2} \\ \boldsymbol{\beta}_{b_{k+1}}^{b_{k}} &=\int_{t \in\left[t_{k}, t_{k+1}\right]} \mathbf{R}_{t}^{b_{k}}\left(\hat{\mathbf{a}}_{t}-\mathbf{b}_{a_{t}}-\mathbf{n}_{a}\right) d t \\ \gamma_{b_{k+1}}^{b_{k}} &=\int_{t \in\left[t_{k}, t_{k+1}\right]} \frac{1}{2} \boldsymbol{\Omega}\left(\hat{\boldsymbol{\omega}}_{t}-\mathbf{b}_{w_{t}}-\mathbf{n}_{w}\right) \boldsymbol{\gamma}_{t}^{b_{k}} d t \end{aligned}
$$

若是不考虑噪声, 可以离散化为:
$$
\begin{array}{l}{\hat{\boldsymbol{\alpha}}_{i+1}^{b_{k}}=\hat{\boldsymbol{\alpha}}_{i}^{b_{k}}+\hat{\boldsymbol{\beta}}_{i}^{b_{k}} \delta t+\frac{1}{2} \mathbf{R}\left(\hat{\gamma}_{i}^{b_{k}}\right)\left(\hat{\mathbf{a}}_{i}-\mathbf{b}_{a_{i}}\right) \delta t^{2}} \\ {\hat{\boldsymbol{\beta}}_{i+1}^{b_{k}}=\hat{\boldsymbol{\beta}}_{i}^{b_{k}}+\mathbf{R}\left(\hat{\gamma}_{i}^{b_{k}}\right)\left(\hat{\mathbf{a}}_{i}-\mathbf{b}_{a_{i}}\right) \delta t} \\ {\hat{\gamma}_{i+1}^{b_{k}}=\hat{\gamma}_{i}^{b_{k}} \otimes\left[\begin{array}{c}{1} \\ {\frac{1}{2}\left(\hat{\boldsymbol{\omega}}_{i}-\mathbf{b}_{w_{i}}\right) \delta t}\end{array}\right]}\end{array}
$$

定义IMU测量残差:
$$
\begin{bmatrix}
\delta \alpha ^{b_{k}}_{b_{k+1}}\\
\delta \theta   ^{b_{k}}_{b_{k+1}}\\
\delta \beta ^{b_{k}}_{b_{k+1}}\\
\delta b_{a}\\
\delta b_{g}
\end{bmatrix}
=\begin{bmatrix}
q^{b_{k}}_{w}(p^{w}_{b_{k+1}}-p_{b_{k}}^{w}+\frac{1}{2}g^{w}\triangle t^{2}-v_{b_{k}}^{w}\triangle t)-\hat{\alpha }^{b_{k}}_{b_{k+1}}\\
2[q_{b_{k+1}}^{w^{-1}}\otimes q^{w}_{b_{k}}\otimes \hat{\gamma  }^{b_{k}}_{b_{k+1}}]_{xyz}\\
q^{b_{k}}_{w}(v^{w}_{b_{k+1}}+g^{w}\triangle t-v_{b_{k}}^{w})-\hat{\beta }^{b_{k}}_{b_{k+1}}\\
b_{ab_{k+1}}-b_{ab_{k}}\\
b_{gb_{k+1}}-b_{gb_{k}}
\end{bmatrix}
$$

这里$\hat{\alpha}_{b_{k+1}}^{b_k}, \hat{\gamma}_{b_{k+1}}^{b_k}, \hat{\beta}_{b_{k+1}}^{b_k}$来自于IMU预计积分(预测值). $[\cdot]_{xyz}$表示取向量的xyz部分, $\delta \theta = 2\sin(\frac{1}{2} \theta_{diff}) \approx \theta_{diff}$.

考虑零偏和测量噪声, 推导可得欧拉法`covariance propagation`(这里忽略推导细节, 认为是理所当然的):
$$
\begin{aligned}
\left[\begin{array}{c}{\delta \dot{\boldsymbol{\alpha}}_{t}^{b_{k}}} \\ {\delta \dot{\boldsymbol{\beta}}_{t}^{b_{k}}} \\ {\dot{\delta} \dot{\boldsymbol{\theta}}_{t}^{b_{k}}} \\ {\delta \dot{\mathbf{b}}_{a_{t}}} \\ {\delta \dot{\mathbf{b}}_{w_{t}}}\end{array}\right] &= \left[\begin{array}{ccccc}{0} & {\mathbf{I}} & {0} & {0} & {0} \\ {0} & {0} & {-\mathbf{R}_{t}^{b_{k}}\left\lfloor\hat{\mathbf{a}}_{t}-\mathbf{b}_{a_{t}}\right\rfloor_\times} & {-\mathbf{R}_{t}^{b_{k}}} & {0} \\ {0} & {0} & {-\left\lfloor\hat{\boldsymbol{\omega}}_{t}-\mathbf{b}_{w_{t}}\right\rfloor_\times} & { 0} & {-\mathbf{I}} \\ {0} & {0} & {0} & {0} & {0} \\ {0} & {0} & {0} & {0} & {0}\end{array}\right] \left[\begin{array}{c}{\delta \boldsymbol{\alpha}_{t}^{b_{k}}} \\ {\delta \boldsymbol{\beta}_{t}^{b_{k}}} \\ {\delta \boldsymbol{\theta}_{t}^{b_{k}}} \\ {\delta \mathbf{b}_{a_{t}}} \\ {\delta \mathbf{b}_{w_{t}}}\end{array}\right]\\&+\left[\begin{array}{cccc}{0} & {0} & {0} & {0} \\ {-\mathbf{R}_{t}^{b_{k}}} & {0} & {0} & {0} \\ {0} & {-\mathbf{I}} & {0} & {0} \\ {0} & {0} & {\mathbf{I}} & {0} \\ {0} & {0} & {0} & {\mathbf{I}}\end{array}\right]\left[\begin{array}{c}{\mathbf{n}_{a}} \\ {\mathbf{n}_{w}} \\ {\mathbf{n}_{b_{a}}} \\ {\mathbf{n}_{b_{w}}}\end{array}\right]=\mathbf{F}_{t} \delta \mathbf{z}_{t}^{b_{k}}+\mathbf{G}_{t} \mathbf{n}_{t}
\end{aligned}
$$

注意上面是导数, 积分有$\delta \mathbf{z}_{k+1} = \delta \mathbf{z}_{k} + \delta \mathbf{\dot{z}}_{k} \delta t = (\mathbf{I}+\mathbf{F} \delta t) \delta \mathbf{z}_{k} + (\mathbf{G} \delta t) \mathbf{n}_k$.
>在误差传播过程中有这样一种性质(EKF), 如果能够找到状态量的递推公式$\delta z_{k+1} = F \delta z_k + G n_k$, 则有协方差$P_{ik+1}$和IMU残差对于bias的雅可比矩阵$J_{ik+1}^b$的递推更新公式:
$$
\begin{aligned} P_{i k+1}&= F_{k} P_{i k} F_{k}^{T}+G_{k} P_{n} G_{k}^{T} \\ J_{i k+1}^{b}&=F_{k} J_{i k}^{b} \\
P_n &= \mathrm{diag}(\sigma_{noise}^2)
\end{aligned}
$$

到这里我们可以得到需要用来计算残差的几个量: Jacobian matrix $\mathbf{J}_{b_{k+1}}$, covariance matrix $\mathbf{P}_{b_{k+1}}^{b_k}$, 以及$\alpha_{b_{k+1}}^{b_k}, \beta_{b_{k+1}}^{b_k}, \gamma_{b_{k+1}}^{b_k}$基于bias的一阶近似(当bias变化量较小时, 用如下公式更新估计值, 不需要重新积分). ($\mathbf{J}_{b_{k+1}}$只是为了给后面提供对bias的Jacobian).
$$
\begin{aligned} \hat{\boldsymbol{\alpha}}_{b_{k+1}}^{b_{k}} & \approx \hat{\boldsymbol{\alpha}}_{b_{k+1}}^{b_{k}}+\mathbf{J}_{b_{a}}^{\alpha} \delta \mathbf{b}_{a_{k}}+\mathbf{J}_{b_{w}}^{\alpha} \delta \mathbf{b}_{w_{k}} \\ \hat{\boldsymbol{\beta}}_{b_{k+1}}^{b_{k}} & \approx \hat{\boldsymbol{\beta}}_{b_{k+1}}^{b_{k}}+\mathbf{J}_{b_{a}}^{\beta} \delta \mathbf{b}_{a_{k}}+\mathbf{J}_{b_{w}}^{\beta} \delta \mathbf{b}_{w_{k}} \\ \hat{\boldsymbol{\gamma}}_{b_{k+1}}^{b_{k}} & \approx \hat{\boldsymbol{\gamma}}_{b_{k+1}}^{b_{k}} \otimes\left[\begin{array}{c}{1} \\ {\frac{1}{2} \mathbf{J}_{b_{w}}^{\gamma} \delta \mathbf{b}_{w_{k}}}\end{array}\right] \end{aligned}
$$

### 代码实现: 离散状态下中值积分
离散状态下预积分方程
$$
\begin{aligned}
w_{k}^{\prime}&=\frac{w_{k+1}+w_{k}}{2}-b_{w}\\
q_{i+1}&=q_{i} \otimes\left[\begin{array}{c}{1} \\ {0.5 w_{k}^{\prime}}\end{array}\right]\\
a_{k}^{\prime}&=\frac{q_{k}\left(a_{k}+n_{a 0}-b_{a_{k}}\right)+q_{k+1}\left(a_{k+1}+n_{a 1}-b_{a_{k}}\right)}{2} \\
\alpha_{i+1}&=\delta \alpha_{i}+\beta_{i} t+0.5 a_{k}^{\prime} \delta t^{2}\\
\beta_{i+1}&=\delta \beta_{i}+a_{k}^{\prime} \delta t
\end{aligned}
$$

离散状态下的误差方程
$$
\begin{aligned}
\left[\begin{array}{c}{\delta \alpha_{k+1}} \\ {\delta \theta_{k+1}} \\ {\delta \beta_{k+1}} \\ {\delta b_{a k+1}} \\ {\delta b_{g k+1}}\end{array}\right] &= F \delta z_k+ G_k n\\
&= \left[\begin{array}{ccccc}{I} & {f_{01}} & {} & {\delta t} & {-\frac{1}{4}\left(q_{k}+q_{k+1}\right) \delta t^{2}} & {f_{04}} \\ {0} & {I-\left[\frac{w_{k+1}+w_{k}}{2}-b_{w k}\right] _\times \delta t} & {0} & {0} & {-\delta t} \\ {0} & {f_{21}} & {I} & {-\frac{1}{2}\left(q_{k}+q_{k+1}\right) \delta t} & {f_{24}} \\ {0} & {0} & {0} & {I} & {0} \\ {0} & {0} & {0} & {0} & {I}\end{array}\right] \left[\begin{array}{c}{\delta \alpha_{k}} \\ {\delta \theta_{k}} \\ {\delta \beta_{k}} \\ {\delta b_{a k}} \\ {\delta b_{g k}}\end{array}\right] \\
    &+ \left[\begin{array}{cccccc}{\frac{1}{4} q_{k} \delta t^{2}} & {v_{01}} & {\frac{1}{4} q_{k+1} \delta t^{2}} & {v_{03}} & {0} & {0} \\ {0} & {\frac{1}{2} \delta t} & {0} & {\frac{1}{2} \delta t} & {0} & {0} \\ {\frac{1}{2} q_{k} \delta t} & {v_{21}} & {\frac{1}{2} q_{k+1} \delta t} & {v_{23}} & {0} & {0} \\ {0} & {0} & {0} & {0} & {\delta t} & {0} \\ {0} & {0} & {0} & {0} & {0} & {\delta t}\end{array}\right] \left[\begin{array}{l}{n_{a 0}} \\ {n_{w 0}} \\ {n_{a 1}} \\ {n_{w 1}} \\ {n_{b a}} \\ {n_{b g}}\end{array}\right]
\end{aligned}
$$
其中,
$$
\begin{aligned} f_{01} &=-\frac{1}{4} q_{k}\left[a_{k}-b_{a_{k}}\right]_\times \delta t^{2}-\frac{1}{4} q_{k+1}\left[a_{k+1}-b_{a_{k}}\right]_\times\left(I-\left[\frac{w_{k+1}+w_{k}}{2}-b_{g_{k}}\right]_\times \delta t\right) \delta t^{2} \\ f_{21} &=-\frac{1}{2} q_{k}\left[a_{k}-b_{a_{k}}\right]_\times \delta t-\frac{1}{2} q_{k+1}\left[a_{k+1}-b_{a_{k}}\right]_\times\left(I-\left[\frac{w_{k+1}+w_{k}}{2}-b_{g_{k}}\right]_{\times} \delta t\right) \delta t \\ f_{04} &=\frac{1}{4}\left(-q_{k+1}\left[a_{k+1}-b_{a_{k}}\right]_\times \delta t^{2}\right)(-\delta t) \\ f_{24} &=\frac{1}{2}\left(-q_{k+1}\left[a_{k+1}-b_{a_{k}}\right]_\times \delta t\right)(-\delta t) \\ v_{03} &=\frac{1}{4}\left(-q_{k+1}\left[a_{k+1}-b_{a_{k}}\right]_\times \delta t^{2}\right) \frac{1}{2} \delta t \\ v_{21} &=\frac{1}{2}\left(-q_{k+1}\left[a_{k+1}-b_{a_{k}}\right]_{\times} \delta t^{2}\right) \frac{1}{2} \delta t \\ v_{23} &=\frac{1}{2}\left(-q_{k+1}\left[a_{k+1}-b_{a_{k}}\right]_{\times} \delta t^{2}\right) \frac{1}{2} \delta t \end{aligned}
$$

对应代码(__注意, 这里计算的Jacobian是对上一帧残差的Jacobian, 而不是对优化变量的Jacobian__)
```c++
void midPointIntegration(...)
{
    Vector3d un_acc_0 = delta_q * (_acc_0 - linearized_ba);
    Vector3d un_gyr = 0.5 * (_gyr_0 + _gyr_1) - linearized_bg;
    /// 误差项 q
    result_delta_q = delta_q * Quaterniond(1, un_gyr(0) * _dt / 2, un_gyr(1) * _dt / 2, un_gyr(2) * _dt / 2);
    Vector3d un_acc_1 = result_delta_q * (_acc_1 - linearized_ba);
    Vector3d un_acc = 0.5 * (un_acc_0 + un_acc_1);
    /// 误差项p, v
    result_delta_p = delta_p + delta_v * _dt + 0.5 * un_acc* _dt * _dt;
    result_delta_v = delta_v + un_acc * _dt;
    result_linearized_ba = linearized_ba;
    result_linearized_bg = linearized_bg;

    /// 协方差的更新公式: 确实很复杂，推导一遍，弄懂后作为工具拿来主义即可
    if(update_jacobian)
    {
        Vector3d w_x = 0.5 * (_gyr_0 + _gyr_1) - linearized_bg;
        Vector3d a_0_x = _acc_0 - linearized_ba;
        Vector3d a_1_x = _acc_1 - linearized_ba;
        Matrix3d R_w_x, R_a_0_x, R_a_1_x;
        R_w_x<<0, -w_x(2), w_x(1),
            w_x(2), 0, -w_x(0),
            -w_x(1), w_x(0), 0;
        R_a_0_x<<0, -a_0_x(2), a_0_x(1),
            a_0_x(2), 0, -a_0_x(0),
            -a_0_x(1), a_0_x(0), 0;
        R_a_1_x<<0, -a_1_x(2), a_1_x(1),
            a_1_x(2), 0, -a_1_x(0),
            -a_1_x(1), a_1_x(0), 0;
        MatrixXd F = MatrixXd::Zero(15, 15);
        F.block<3, 3>(0, 0) = Matrix3d::Identity();
        F.block<3, 3>(0, 3) = -0.25 * delta_q.toRotationMatrix() * R_a_0_x *_dt * _dt + 
                              -0.25 * result_delta_q.toRotationMatrix() *R_a_1_x * (Matrix3d::Identity() - R_w_x * _dt)* _dt * _dt;
        F.block<3, 3>(0, 6) = MatrixXd::Identity(3,3) * _dt;
        F.block<3, 3>(0, 9) = -0.25 * (delta_q.toRotationMatrix() +result_delta_q.toRotationMatrix()) * _dt * _dt;
        F.block<3, 3>(0, 12) = -0.25 * result_delta_q.toRotationMatrix() *R_a_1_x * _dt * _dt * -_dt;
        F.block<3, 3>(3, 3) = Matrix3d::Identity() - R_w_x * _dt;
        F.block<3, 3>(3, 12) = -1.0 * MatrixXd::Identity(3,3) * _dt;
        F.block<3, 3>(6, 3) = -0.5 * delta_q.toRotationMatrix() * R_a_0_x *_dt + 
                              -0.5 * result_delta_q.toRotationMatrix() *R_a_1_x * (Matrix3d::Identity() - R_w_x * _dt)* _dt;
        F.block<3, 3>(6, 6) = Matrix3d::Identity();
        F.block<3, 3>(6, 9) = -0.5 * (delta_q.toRotationMatrix() +result_delta_q.toRotationMatrix()) * _dt;
        F.block<3, 3>(6, 12) = -0.5 * result_delta_q.toRotationMatrix() *R_a_1_x * _dt * -_dt;
        F.block<3, 3>(9, 9) = Matrix3d::Identity();
        F.block<3, 3>(12, 12) = Matrix3d::Identity();
        //cout<<"A"<<endl<<A<<endl;
        // 这里V对应公式中的G_k
        MatrixXd V = MatrixXd::Zero(15,18);
        V.block<3, 3>(0, 0) =  0.25 * delta_q.toRotationMatrix() * _dt * _dt;
        V.block<3, 3>(0, 3) =  0.25 * -result_delta_q.toRotationMatrix() *R_a_1_x  * _dt * _dt * 0.5 * _dt;
        V.block<3, 3>(0, 6) =  0.25 * result_delta_q.toRotationMatrix() *_dt * _dt;
        V.block<3, 3>(0, 9) =  V.block<3, 3>(0, 3);
        V.block<3, 3>(3, 3) =  0.5 * MatrixXd::Identity(3,3) * _dt;
        V.block<3, 3>(3, 9) =  0.5 * MatrixXd::Identity(3,3) * _dt;
        V.block<3, 3>(6, 0) =  0.5 * delta_q.toRotationMatrix() * _dt;
        V.block<3, 3>(6, 3) =  0.5 * -result_delta_q.toRotationMatrix() *R_a_1_x  * _dt * 0.5 * _dt;
        V.block<3, 3>(6, 6) =  0.5 * result_delta_q.toRotationMatrix() * _dt;
        V.block<3, 3>(6, 9) =  V.block<3, 3>(6, 3);
        V.block<3, 3>(9, 12) = MatrixXd::Identity(3,3) * _dt;
        V.block<3, 3>(12, 15) = MatrixXd::Identity(3,3) * _dt;
        //step_jacobian = F;
        //step_V = V;
        jacobian = F * jacobian;
        /// 协方差, 表示IMU误差的不确定度
        covariance = F * covariance * F.transpose() + V * noise * V.transpose();
        }
}
```

[推导参考](https://www.zybuluo.com/Xiaobuyi/note/866099#11-%E7%A6%BB%E6%95%A3%E7%8A%B6%E6%80%81%E4%B8%8B%E9%A2%84%E7%A7%AF%E5%88%86%E6%96%B9%E7%A8%8B)


IMU残差计算代码实现:
```c++
Eigen::Matrix<double, 15, 1> evaluate(...)
{
    Eigen::Matrix<double, 15, 1> residuals;
    Eigen::Matrix3d dp_dba = jacobian.block<3, 3>(O_P, O_BA);
    Eigen::Matrix3d dp_dbg = jacobian.block<3, 3>(O_P, O_BG);
    Eigen::Matrix3d dq_dbg = jacobian.block<3, 3>(O_R, O_BG);
    Eigen::Matrix3d dv_dba = jacobian.block<3, 3>(O_V, O_BA);
    Eigen::Matrix3d dv_dbg = jacobian.block<3, 3>(O_V, O_BG);
    // linearized_ba是在预积分过程中所用的ba, ba的线性化点.
    // bias距线性化点的变化量, +jacobian来计算Bai处的预积分近似值
    Eigen::Vector3d dba = Bai - linearized_ba;
    Eigen::Vector3d dbg = Bgi - linearized_bg;

    // 线性近似 预积分预测值
    Eigen::Quaterniond corrected_delta_q = delta_q * Utility::deltaQ(dq_dbg * dbg);
    Eigen::Vector3d corrected_delta_v = delta_v + dv_dba * dba + dv_dbg * dbg;
    Eigen::Vector3d corrected_delta_p = delta_p + dp_dba * dba + dp_dbg * dbg;

    // 观测值 - 预测值
    residuals.block<3, 1>(O_P, 0) = Qi.inverse() 
        * (0.5 * G * sum_dt * sum_dt + Pj- Pi - Vi * sum_dt) - corrected_delta_p;
    // 这里取的是四元素的虚部: 2 * \sin(0.5*\theta) * axis
    residuals.block<3, 1>(O_R, 0) = 2 * (corrected_delta_q.inverse() * (Qi.invers() * Qj)).vec();
    residuals.block<3, 1>(O_V, 0) = Qi.inverse() * (G * sum_dt + Vj - Vi) -corrected_delta_v;
    // 预测值为0, bias不变
    residuals.block<3, 1>(O_BA, 0) = Baj - Bai;
    residuals.block<3, 1>(O_BG, 0) = Bgj - Bgi;
    return residuals;
}
```

## IMU残差优化
IMU残差:
$$
\mathbf{r}_{\mathcal{B}}\left(\hat{\mathbf{z}}_{b_{k+1}}^{b_{k}}, \mathcal{X}\right)=\left[\begin{array}{c}{\delta \boldsymbol{\alpha}_{b_{k+1}}^{b_{k}}} \\ {\delta \boldsymbol{\beta}_{b_{k+1}}^{b_k}} \\ {\delta \boldsymbol{\theta}_{b_{k+1}}^{b_k}} \\ {\delta \mathbf{b}_{a}} \\ {\delta \mathbf{b}_{g}}\end{array}\right] = \left[\begin{array}{c}{\mathbf{R}_{w}^{b_{k}}\left(\mathbf{p}_{b_{k+1}}^{w}-\mathbf{p}_{b_{k}}^{w}+\frac{1}{2} \mathbf{g}^{w} \Delta t_{k}^{2}-\mathbf{v}_{b_{k}}^{w} \Delta t_{k}\right)-\hat{\boldsymbol{\alpha}}_{b_{k+1}}^{b_{k}}} \\ {\mathbf{R}_{w}^{b_{k}}\left(\mathbf{v}_{b_{k+1}}^{w}+\mathbf{g}^{w} \Delta t_{k}-\mathbf{v}_{b_{k}}^{w}\right)-\hat{\boldsymbol{\beta}}_{b_{k+1}}^{b_{k}}} \\ {2\left[\mathbf{q}_{b_{k}}^{w^{-1}} \otimes \mathbf{q}_{b_{k+1}}^{w} \otimes\left(\hat{\gamma}_{b_{k+1}}^{b_{k}}\right)^{-1}\right]_{x y z}} \\ {\mathbf{b}_{a b_{k+1}}-\mathbf{b}_{a b_{k}}} \\ {\mathbf{b}_{w b_{k+1}}-\mathbf{b}_{w b_{k}}}\end{array}\right]
$$

参考《SLAM 十四讲》中高斯牛顿法, 若要计算目标函数的最小值, 可以理解为, 当优化变 量有一个增量后, 目标函数值最小, 以IMU残差为例, 可写成如下所示:
$$
\min_{\delta \mathcal{X}} \left\|\mathbf{r}_{\mathcal{B}}\left(\hat{\mathbf{z}}_{b_{k+1}}^{b_{k}}, \mathcal{X}\right)\right\|_{\mathbf{P}_{b_{k+1}}^{b_k}}^{2} = \min_{\delta \mathcal{X}} \left\|\mathbf{r}_{\mathcal{B}}\left(\hat{\mathbf{z}}_{b_{k+1}}^{b_{k}}, \mathcal{X}\right)+\mathbf{H}_{b_{k+1}}^{b_k} \delta \mathcal{X} \right\|_{\mathbf{P}_{b_{k+1}}^{b_k}}^{2}
$$

这里$\mathbf{H}_{b_{k+1}}^{b_k}$为$\mathbf{r}_{\mathcal{B}}$关于$\delta \mathcal{X}$的Jacobian, 展开令$\delta \mathcal{X}$的导数为0, 可得:
$$
{\mathbf{H}_{b_{k+1}}^{b_k}}^T \mathbf{P}_{b_{k+1}}^{b_k} \mathbf{H}_{b_{k+1}}^{b_k} \delta \mathcal{X} = -{\mathbf{H}_{b_{k+1}}^{b_k}}^T {\mathbf{P}_{b_{k+1}}^{b_k}}^{-1} \mathbf{r}_{\mathcal{B}}
$$

残差对优化变量的Jacobian, 在IMUFactor的evaluate中计算, 公式可参考崔华坤p11.


## Reference
https://en.wikipedia.org/wiki/Mahalanobis_distance
http://zhehangt.win/2018/04/24/SLAM/VINS/VINSVIO/
VINS论文推导及代码解析
[VINS算法原理-公式推导](https://www.zybuluo.com/Xiaobuyi/note/866099#31-%E7%9B%B8%E6%9C%BA%E4%B8%8Eimu%E4%B9%8B%E9%97%B4%E7%9A%84%E7%9B%B8%E5%AF%B9%E6%97%8B%E8%BD%AC)
[VINS算法原理-公式推导](https://blog.csdn.net/Darlingqiang/article/details/80689123)