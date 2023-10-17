---
tag: algorithms
---
## 基本原理

### Abstract & Method
参考: [论文笔记：NeRF: Representing Scenes as Neural Radiance Fields for View Synthesis - 技术刘 (liuxiao.org)](http://www.liuxiao.org/2021/11/%E8%AE%BA%E6%96%87%E7%AC%94%E8%AE%B0%EF%BC%9Anerf-representing-scenes-as-neural-radiance-fields-for-view-synthesis/)
利用一个全连接网络$F_\Theta$来表示一个场景(如下图所示):

![[nerf_overview.svg|400]]

这里$x,y,z$表示场景中的一个点, $\theta, \phi$ 表示视线方向. $RGB$是输出颜色, $\sigma$ 表示3D位置(或者说是体素)的密度——可以被理解为，一条射线 $r$ 在经过 $(x,y,z)$ 处的一个无穷小的粒子时被终止的概率，这个概率是可微的.

有了该网络之后, 可以利用volume rendering的方式, 就可以生成不同角度的场景渲染结果.
![](https://uploads-ssl.webflow.com/51e0d73d83d06baa7a00000f/5e700ef6067b43821ed52768_pipeline_website-01.png)

$$
C(r) = \int_{t_n}^{t_f} T(t) \cdot \sigma(\mathbf{r}(t)) \cdot \mathbf{c}(\mathbf{r}(t), \mathbf{d}) dt, \quad T(t) = \exp(-\int_{t_n}^t \sigma(\mathbf{r}(s)) ds)
$$
这里, $T(t)$ 是射线从$t_n$到$t$这段路径上累积的透明度. $\mathbf{d}$是一个单位向量, 表示视线方向. $\mathbf{r}(t) = \mathbf{o} + t\mathbf{d}$ 表示该点的位置. [公式推导]([“图形学小白”友好的NeRF原理透彻讲解 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/574351707))

在实际应用中, 我们需要对该积分做离散化. 一个直观且很常用的思路是, 在需要求积的区域均匀地采样N个点进行近似计算. 但作者提出, 这样的方式会导致MLP只需要学习一系列离散点的信息, 最终会限制NeRF的分辨率, 使得最终生成的结果不够清晰. 作为替代, 作者提出了一种简单有效的方法, 如图所示, 首先将射线需要积分的区域分为N份, 然后在每一个小区域中进行均匀随机采样. 这样的方式能够在只采样离散点的前提下, 保证采样位置的连续性. 第i个采样点可以表示为:
$$
t_i = \mathbf{U} [t_n + \frac{i-1}{N}(t_f - t_n), t_n + \frac{i}{N}(t_f - t_n)]
$$
基于这些采样点, 离散化为:
$$
\hat{C} = \sum_i^N T_i \cdot (1 - \exp(-\sigma_i \delta_i)) \cdot c_i
$$
这里, $\delta_i = t_{i+1} - t_i$是两个邻近采样点之间的距离. $T_i = \exp (-\sum_{j=1}^{i-1} \sigma_j \delta_j)$

### 关键优化策略

1. 非均匀采样
	使用coarse to fine的策略, 同时训练coarse和fine两个网络. coarse均匀采样$N_c$个采样点(下图白色点), 而fine则使用类似importance sampling的思想. 根据coarse的采样结果, 先计算PDF(概率密度函数), 根据PDF非均匀采样$N_f$个点(右下图红色点).
	![[nerf_coarse_samplling.png|280]] ![[nerf_fine_samplling.png|370]]
	
2. position encoding
	尽管神经网络理论上可以逼近任何函数, 但是通过实验发现仅用MLP构成的$F(\Theta)$不能够很好地表示细节, 因为神经网络趋向于拟合低频信号. 《On the spectral bias of neural networks. In: ICML (2018)》证明了此结论, 并指出通过高频函数将低频信号映射到高频信号, 可以更好地拟合高频细节. 据此, 将$F(\Theta)$修改你为两个函数$F(\Theta)' \circ \gamma$, $\gamma$表示$\mathbb{R}$到$\mathbb{R}^{2L}$的编码函数. 在原文中, 使用如下编码函数:
	$$
	\gamma(p) = (\sin(2^0\pi p), \cos(2^0\pi p), ... , \sin(2^{L-1}\pi p), \cos(2^{L-1}\pi p)) 
	$$
### 损失函数
损失函数直接使用渲染结果的光度误差:
$$
\mathcal{L}=\sum_{\mathbf{r}\in\mathcal{R}}\left[\parallel\hat{C}_{c}(\mathbf{r})-C(\mathbf{r})\parallel_{2}^{2}+\parallel\hat{C}_{f}(\mathbf{r})-C(\mathbf{r})\parallel_{2}^{2}\right]
$$
* $\mathcal{R}$ 表示一个batch中的所有采样的射线集合
* $C(\mathbf{r})$ 表示真值的 RGB 颜色
* $\hat{C}_c(\mathbf{r})$ 表示coarse网络预测的颜色值
* $\hat{C}_f(\mathbf{r})$ 表示fine网络预测的颜色值

## 源码解析 - tiny_nerf
tiny_nerf中不考虑不同视线方向上每个点的输出不同、 Hierarchical Sampling. [源码](https://colab.research.google.com/drive/1fd-iAvRFXEe5ao_DNbH1Ki_BFuDRy7lw#scrollTo=wtXqR_0nOyGV)

1. 两个主要函数
```python
def run_one_iter_of_tinynerf(
	height, width, focal_length, tform_cam2world,
	near_thresh, far_thresh, depth_samples_per_ray,
	encoding_function, get_minibatches_function)
	r"""
	* 对空间进行均匀采样得到Radiance Field($(x,y,z) \to RGB\delta$)在该camera下的采样.
	* 将Radiance Field的采样作为输入, 进行volume rendering得到不同视角的image
	* 计算loss, 梯度反传更新网络
	"""
```
```python
def render_volume_density(
    radiance_field: torch.Tensor,
    depth_values: torch.Tensor)
    r"""
    对Radiance Field的采样, 进行一次可微渲染. 
Args:
  radiance_field (torch.Tensor): A "field" where, at each query location (X, Y, Z),
    we have an emitted (RGB) color and a volume density (denoted :math:`\sigma` in
    the paper) (shape: :math:`(width, height, num_samples, 4)`).
  depth_values (torch.Tensor): 深度值, 用来计算采样点之间的间距, 以获得不透明度
    (shape: :math:`(num_samples)`).

Returns:
  rgb_map (torch.Tensor): Rendered RGB image (shape: :math:`(width, height, 3)`).
  depth_map (torch.Tensor): Rendered depth image (shape: :math:`(width, height)`).
  acc_map (torch.Tensor): # TODO: Double-check (I think this is the accumulated
    transmittance map).
    """
```
## 源码实现解析 - nerf
参考: [pytorch3d nerf 源码解读](https://blog.csdn.net/g11d111/article/details/118959540)


## 参考列表

[初代NeRF理解](https://zhuanlan.zhihu.com/p/386127288)
	tinny nerf 比较简单(代码量少)

代码:

* [NeRF源码解读(pytorch实现)](https://zhuanlan.zhihu.com/p/598464999)
	MIT 大佬yenchenlin的实现

* [nerf 代码讲解](https://zhuanlan.zhihu.com/p/518655858)
	其中理论部分提到了yenchenlin的实现

* [pytorch3d nerf 源码解读](https://blog.csdn.net/g11d111/article/details/118959540)
	写得非常详细
	[pytorch3d nerf 源码](https://github.com/facebookresearch/pytorch3d/tree/main/projects/nerf)


