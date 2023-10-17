---
tag: algorithms
---
# PoseMap
概要: 抽取点云的surfel特征, 并与其观察的位姿势相结合, 维护一个可以自更新的地图. 以在环境变化时, 实现精准可靠的定位. 
要解决的问题: 在环境变化时, 进行精准可靠的定位.
整篇论文可分为如下几个部分:
* Section I
    算法的介绍: 要解决的问题, 以及解决这个问题的思路策略.

* Section III
    需要用到的基础算法. C-SLAM, surfel特征, 以及由特征计算位姿的方法.

* Section IV
    PoseMap的介绍(main contribution)

KeyWords: C-SLAM, closest map node, overlap/change metric, visibility analysis.
重点: PoseMap的结构, update, 以及如何用来做Localization.
其他要点: C-SLAM点云匹配.

## C-SLAM 点云配准策略
点云匹配部分使用了Zebedee的算法. 利用surfels特征查找Correspondence和定义优化的能量.
关键点:
① surfel特征的定义和利用
② 配准约束的定义
③ 滑动窗口策略

### surfels特征和correspondence
first-order and second-order moments $\mu, S$ define as flows(hint: voxel without enough points are ignored):

$$
\begin{aligned}
\mu &= \frac{1}{N}\sum_{i=1}^N p_i \\
S &= \frac{1}{N}\sum_{i=1}^N (p_ip_i^T - \mu \mu^T)
\end{aligned}
$$

对S做Eigen分解, 得到三个特征值: $\lambda_1 \le \lambda_2 \le \lambda_3$. (其实这里就是PCA). Define `the plane-likeness` of the points which ranges from 0 to 1 as:

$$
p = 2 \frac{\lambda_2 - \lambda_1}{\lambda_1 + \lambda_2 + \lambda_3}
$$

定义一个6维向量: $(\alpha \mu, pv)$, $\mu$是点云的中心, $\alpha$是一个参数用来调节中心位置和形状的相对重要性. $v$是最小的eigen value对应的特征向量(即平面的法向, 为了一致性, 法向朝向传感器的中心). 在这个6维空间中利用knn寻找correspondence.

构建multi-resolution的surfels特征(类似图像金字塔), 用来寻找correspondence match.
> Form a pyramid of grids with increasing voxel cell sizes (ranging from 0.5m to 8m cubes) and various offsets, similar to the representation used by Ryde and Hu [5].

### 能量定义
在优化时, 这里将新进来的一帧和滑动窗口中的点云一起做优化(同时调整窗口中的所有帧的位姿).
1. surfels i和j之间的match error定义如下:

>Surfel match errors guide the trajectory to minimize the distances between surfel correspondences along a common surface normal.

$$
e_{ij} = \xi_{ij}n_{ij}^T(\mu_i(\delta T(\tau_i)) - \mu_j(\delta T(\tau_j)))
$$

这里, $n_{ij}$是$S_i + S_j$矩阵的最小eigen value对应的eigen vector.
>$n_{ij}$ is the eigen vector corresponding to the minimum eigen value $\lambda_1$ of the sum of the matched surfels’ moment matrices, and $\mu_i$ is the centroid of surfel $i$ (which depends on the trajectory correction at time $\tau_i$ ). The coefficient $\xi_{ij} = 1 / \sqrt{\sigma_r^2 + \lambda_1}$ is dependent on the sensor measurement noise $\sigma_r$ and the surfel thickness, captured by the
eigenvalue $\lambda_1$.

为了减小outlier对整个匹配的影响, 对match error添加如下权重:
$$
w_i = \frac{1}{1+(e_{match}/\bar{r})^2}
$$
$\bar{r}$是outlier的软(可变)阈值, 开始设置较大的$\bar{r}$, 然后慢慢减小, 可以获得较好的收敛效果.  
>$\bar{r}$ is a soft outlier threshold, We have observed that starting with a large outlier threshold which is decreased at each iteration leads to more reliable convergence of the optimization.

2. 利用IMU的信息, 添加路径平滑的能量:

$$
\begin{aligned}
e_a(\tau) &= \Sigma_a^{-\frac{1}{2}} (r(\tau)\oplus a(\tau) - \frac{d^2 t(\tau)}{d \tau^2} - g) \\
e_\omega(\tau) &= \Sigma_\omega^{-\frac{1}{2}} (\omega(\tau) - \frac{d r(\tau)}{d \tau})
\end{aligned}
$$

这里$\Sigma_a^{-\frac{1}{2}}$和$\Sigma_\omega^{-\frac{1}{2}}$是IMU测量的标准差的逆, $\oplus$表示将旋转或平移应用到目标. 这两个error metric, 表示的是计算值/估计值和imu观测值之间的差异.

3. 为了保持连续性, 添加初始化能量(惩罚窗口中前三帧的变动).
>The initial condition constraints enforce continuity with the previous trajectory segment by penalizing any changes to the first three trajectory correction samples in the current segment.

4. 为了减小滑动窗口间的累计误差(避免漂移), 从最近的一些帧中抽取一小部分组成一个fixed views集合(fixed views不在窗口中), 加入相关优化项, 但不允许改变这些固定的帧的位姿.
>To reduce the accumulation of drift errors over processing windows, the algorithm maintains a set of surfels from a small number of recent past views, called fixed views, from which match errors are also minimized.

从窗口的前端选取fixed views, 当角度或距离超过一定阈值之后, 则选取fixed views加入到集合中, 为了避免过多计算, 限制fixed views的数量(根据一定的规则将fixed views从集合中移除).
>A fixed view is taken to be the surfels from the first section of an optimized processing window (which has already been finalized), which is saved at predetermined distance and angle intervals along the trajectory (i.e., as the trajectory grows, fixed views are generated whenever the growth is larger than either of a predefined distance or angle threshold). A small constant number of fixed views is buffered in order to avoid unbounded growth in computation from generating and processing the additional surfel match error terms.

## 优化
优化部分该论文使用了`iterative re-weighted least squares in an M-estimator framework`. 对于此并不熟悉, 但猜测可以用通用的方法去求解这个`re-weighted leqst square optimization`问题.

## PoseMap(Main Contribution)
0. overlap/change metric的计算
用八叉树, 根据位置来索引surfel特征, 加快查询速度.

1. PoseMap的结构和初始化
初始化: 根据时间，将激光数据划分成不同区域，计算surfel特征, 并消除单个区域内以及区域之间的重复特征. 时间相邻的区域构成邻接关系.

2. Localization时, 对点云做了一个高效准确的筛选.
在定位时, 只选取离估计位置P最近的两的node的数据做匹配. 该方法可以看做事一个快速的visibility analysis, 减少了不可见的待选surfel特征, 既提高了搜索效率, 又提高了准确率.

3. 在线构图

4. 应对环境的变化
实验/经验结论: 系统对一定数量的环境变化足够鲁棒, 不需要更新地图.
给出的原因:
① 激光的可见范围广.
② 在优化时添加的约束提高了可靠性.
③ surfel特征的通用性, 提高了可靠性.
更新策略: 计算overlap/change metric, 当超过阈值$T_{change}$时, 则认为地图在此处可能发生了变化, 当多次再访问此地(根据时间或者次数)时, 若与潜在的改变一致, 则替换, 否则丢弃.

### C-SLAM 实时构图定位应用


### C-LOC 定位应用


## 收获&应用
1. surfel特征+整个配准策略 🔥
2. fast visibility analysis
3. 地图更新策略

## 扩展
surfel特征和LeGo-LOAM中的特征的对比
* surfel是平面特征, 一个特点是通用, 定量的描述, 更能够应对环境变化, 防止误匹配. 
* LeGo-LOAM用的特征主要是edge, 其次是平面. 是一个定性的分类.

so, 是否可以做一些结合提升呢?

surfel visualization
> http://www.parresianz.com/dem/ellipsoids-in-visit-and-paraview/

## Reference
* Continuous 3D Scan-Matching with a Spinning 2D Laser
* Zebedee: Design of a Spring-Mounted 3-D Range Sensor with Application to Mobile Mapping
* Real-Time Autonomous Ground Vehicle Navigation in Heterogeneous
Environments Using a 3D LiDAR
* PoseMap: Lifelong, Multi-Environment 3D LiDAR Localization



