---
tag:summary/basic_theory
---
## 3D激光雷达SLAM点云采样
算法目标: 通过对点云约束的分析, ①来判断ICP配准是否稳定(无法确定唯一解/coveriance matrix不满秩/有的约束分量上约束不足), ②对原始点云数据进行鲁棒采样, 加速ICP过程, 提高ICP精度.

### ICP约束分析
将包含k的点的点集$\mathbf{p}_i$与$\mathbf{q}_i$做对齐, $\mathbf{n}_i$是$\mathbf{q}_i$的法向. 使用点到平面的error metric:

$$
E = \sum_{i=1}^k ((R\mathbf{p}_i + \mathbf{t} - \mathbf{q}_i) \cdot \mathbf{n}_i)^2
$$

对R做线性化, 根据罗德里克斯公式

$$
\begin{aligned}
&R = \cos \theta I + (1 - \cos \theta) a a^T + \sin \theta a^T \\
&\Rightarrow R \mathbf{p_i} \simeq \mathbf{r} \times \mathbf{p_i}
\end{aligned}
$$

这里$\mathbf{r}$是旋转向量. 对于每一个点$p_i$, 其transformation, 可以近似为$[\mathbf{r} \times \mathbf{p}_i \; \mathbf{t}]$, 从而有:

$$
E = \sum_{i=1}^k ((\mathbf{p}_i - \mathbf{q}_i) \cdot \mathbf{n}_i + \mathbf{t} \cdot \mathbf{n_i} + \mathbf{r} \cdot \mathbf{p}_i \times \mathbf{n}_i)^2
$$

上述公式可以直观地理解为, 每一对$\mathbf{p}_i, \mathbf{q}_i$, 都贡献了一个沿着法向$\mathbf{n}_i$的拉扯力和一个沿着$\mathbf{p}_i \times \mathbf{n}_i$的旋转扭曲力.

### 采样策略
根据ICP约束分析, 计算每个点的约束贡献值, 采用贪心的策略, 在每个约束分量上采样s个点.
__在计算这些分量之前, 需要把点云的坐标系旋转到与车体坐标系一致的状态__, 这样可以更好地将平面对齐到$(X_v, Y_v, Z_v)$标架上.

PipeLine:
1. 首先, 假定里程计是准确的, 根据初始位姿, 滤除外点.
2. 基于range image, 快速计算每个点的coveriance matrix $M$, 并进行PCA, 得到法向量, 以及平面权值$a_{2D} = (\sigma_2 - \sigma_3)/\sigma_1$, $\sigma_i = \sqrt{\lambda_i}$, $\lambda_i$是$M$的特征值, 按大到小排列.
3. 计算如下几个值:
    * $a_{2D}^2(x_i \times n_i) \cdot X_v$
    * $-a_{2D}^2(x_i \times n_i) \cdot X_v$
    * $a_{2D}^2(x_i \times n_i) \cdot Y_v$
    * $-a_{2D}^2(x_i \times n_i) \cdot Y_v$
    * $a_{2D}^2(x_i \times n_i) \cdot Z_v$
    * $-a_{2D}^2(x_i \times n_i) \cdot Z_v$
    * $a_{2D}^2 |n_i \cdot X_v |$
    * $a_{2D}^2 |n_i \cdot Y_v |$
    * $a_{2D}^2 |n_i \cdot Z_v |$

    这里, 前6项是点$x_i$对未知旋转角度的约束贡献(这里有正有负, 应该是为了更加均匀地采集前后左右上下的数据). 后3项是对未知平移的约束贡献.

计算$n_i$和$a_{2D}$
采用boxfilter的策略, 可快速计算协方差矩阵M, 不过PCA分解还是需要计算量. [opencv中有实现可以参考](https://github.com/opencv/opencv_contrib/blob/master/modules/rgbd/src/normal.cpp)

### 实现
由于我们需要知道每个激光点的协方差矩阵$M$的奇异值(Eigen value), 因此先计算协方差矩阵$M$, 然后通过该协方差矩阵计算我们所需要的Eigen value和法向量.

$$
\begin{aligned}
M &= \frac{1}{k}\sum_{i=1}^k (p_i - \bar{p})(p_i - \bar{p})^T\\
 &= \frac{1}{k}\sum_{i=1}^k p_ip_i^T - \bar{p}\bar{p}^T
\end{aligned}
$$

参考[3], 在range image中寻找邻近点, 根据$p = rv$, 这里$r$是距离, $v=[\sin \theta \cos \phi \quad \sin \phi \quad \cos \theta \cos \phi ]^T$, 有:

$$
M = \frac{1}{k}\sum_{i=1}^k r^2 v_iv_i^T - \bar{p}\bar{p}^T
$$

快速近似计算(TO test):

$$
M = \frac{1}{k}\sum_{i=1}^k r^2 v_iv_i^T - \bar{r}^2\bar{v}\bar{v}^T
$$

这里$\phi$是仰角, $\theta$是航向角.

$$
v = \begin{bmatrix} \cos \phi \cos \theta\\ \cos \phi \sin \theta \\ \sin \phi \end{bmatrix}
$$

测试数据:
F:/data/3d-data/map_yaoxian/Node3DDir-20181011T131542/LASER3D_0_1029_3825.4.bin
可能是因为激光数据有穿透, 有些位置协方差矩阵计算不准确.

F:/data/3d-data/test_agv/map/LASER3D_0_5_1780.11.bin

## Reference
* `[1] IMLS-SLAM: scan-to-model matching based on 3D data Jean-Emmanuel`
* `[2] Geometrically Stable Sampling for the ICP Algorithm
Natasha`
* `[3] Fast and accurate computation of surface normals from range images`
* `[4] Dimensionality Based Scale Selection in 3d LIDAR Point Clouds`