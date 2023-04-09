---
tag: paper_note/nerf
---
## 基本原理

### Abstract & Method

利用一个全连接网络$F_\Theta$来表示一个场景(如下图所示):

![](https://uploads-ssl.webflow.com/51e0d73d83d06baa7a00000f/5e700a025ff238947d682a1f_pipeline_website-03.svg)

这里$x,y,z$表示场景中的一个点, $\theta, \phi$ 表示视线方向. $RGB$是输出颜色, $\sigma$ 表示3D位置(或者说是体素)的密度——可以被理解为，一条射线 $r$ 在经过 $(x,y,z)$ 处的一个无穷小的粒子时被终止的概率，这个概率是可微的.

有了该网络之后, 可以利用volume rendering的方式, 就可以生成不同角度的场景渲染结果.
![](https://uploads-ssl.webflow.com/51e0d73d83d06baa7a00000f/5e700ef6067b43821ed52768_pipeline_website-01.png)

$$
C(r) = \int_{t_n}^{t_f} T(t) \cdot \sigma(\mathbf{r}(t)) \cdot \mathbf{c}(\mathbf{r}(t), \mathbf{d}) dt, \quad T(t) = \exp(-\int_{t_n}^t \sigma(\mathbf{r}(s)) ds)
$$
这里, $T(t)$ 是射线从$t_n$到$t$这段路径上累积的透明度. $\mathbf{d}$是一个单位向量, 表示视线方向. $\mathbf{r}(t) = \mathbf{o} + t\mathbf{d}$ 表示该点的位置. [volume rendering的推导](http://www.liuxiao.org/2021/11/%E8%AE%BA%E6%96%87%E7%AC%94%E8%AE%B0%EF%BC%9Anerf-representing-scenes-as-neural-radiance-fields-for-view-synthesis/).

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
	使用coarse to fine的策略, 同时训练coarse和fine两个网络. coarse均匀采样$N_c$个采样点, 而fine则使用类似importance sampling的思想. 根据coarse的采样结果, 先计算PDF(概率密度函数), 根据PDF进行采样.
	![[rc/nerf_coarse_samplling.jpg]]
	![[rc/nerf_fine_samplling.jpg]]
1. position encoding

### 损失函数

## 源码解析 - tiny_nerf

[source code](https://colab.research.google.com/drive/1fd-iAvRFXEe5ao_DNbH1Ki_BFuDRy7lw#scrollTo=wtXqR_0nOyGV)


## 源码解析 - nerf

## 参考资料

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


