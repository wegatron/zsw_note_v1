---
tags:
  - cg/shading
---
## 辐射传输方程（Radiative Transfer Equation）

辐射在传播时, 通常会因被吸收、散射而衰减. 考虑来自$\omega$方向的光在介质内部$p$与粒子发生相互作用, 而后继续往$\omega$方向传播: 
$$
\begin{align} &\underset{ \text{光线辐射亮度的改变} }{ \underbrace{ \left( \omega \cdot \nabla \right) L_o\left(p,\, \omega \right) }} = -\underset{\text{光线被粒子吸收}}{\underbrace{\sigma_a\left(p,\, \omega\right) L_i\left( p,\,\omega \right)}} - \underset{ \text{光线被粒子散射到其它方向} }{\underbrace{{\sigma_s \left(p,\, \omega\right) L_i\left( p,\,\omega \right)}}} + \underset{ \text{粒子散射光线到当前方向} }{\underbrace{{ \sigma_s\left(p,\, \omega\right) \int_{S^2} f_p\left( p,\,\omega_i \to \omega \right) L_i\left( p,\,\omega \right) \, \mathrm{d} \omega_i }}} + \underset{ \text{粒子自发光} }{\underbrace{{ L_e \left(p,\, \omega \right) }}} \\ & \quad \quad \quad \quad \quad \quad \quad = -\sigma_t\left(p,\, \omega\right) L_i\left( p,\,\omega \right) + \sigma_s\left(p,\, \omega\right) \int_{S^2} f_p \left( p,\,\omega_i \to \omega \right) L_i\left( p,\,\omega \right) \, \mathrm{d} \omega_i + L_e \left(p,\, \omega \right) \end{align} 
$$
* $\left( \omega \cdot \nabla \right) L_o\left(p,\, \omega \right)$是辐射亮度沿$\omega$方向的导数, 是来自方向$\omega$的光线通过$p$点后辐射亮度的改变量
* $\sigma_a(p, \omega)$是吸收系数, 是来自方向$\omega$的光线传播单位长度而通过$p$点时被介质中粒子吸收的概率
* $\sigma_s(p, \omega)$是散射系数, 是来自方向$\omega$的光线传播单位长度而通过$p$点时被介质中粒子散射的概率
* $\sigma_t(p, \omega)$是衰减系数, 描述物质对进入该物质的电磁波能量衰减的特性
	* $\rho=\frac{\sigma_s}{\sigma_t}$是介质的反照率 albedo
	* $\ell=\frac{1}{\sigma_t}$ 被称为平均自由程, 是光线在介质内两次连续与粒子发生交互之间传播的平均距离
* $f_p \left( p,\,\omega_i \to \omega \right)$是相函数(phase function), 描述了$p$点处散射的空间分布. 表示$\omega_i$方向入射光线向某个方向的散射能量与所有方向$S^2$的比. 所有方向$S^2$对应一个单位球.

## 全光函数
任一时刻, 三维空间中任一点向任一个方向传播的光信息, 可以用全光函数进行描述:
$$
R\left(x,\,y,\,z,\,\theta,\,\phi,\,\lambda,\,t\right)
$$
其中, $(x,y,z)$是位置, $\theta, \phi$是方向, $\lambda$是波长, $t$是时间. 两个全光函数组合可以描述任一时刻三维空间中任一点向另一点传播的光信息:
$$
(x,y,z,t,\theta,\phi,\lambda)_{in} \to (x,y,z,t,\theta,\phi,\lambda)_{out}
$$
在实际应用中, 根据不同的场景, 可以做不同程度的简化.
1. 光的波长与时间无关, 没有磷光 (phosphorescence), 省略时间维度
2. 入射光和出射光的波长相同, 没有荧光 (fluorescence) 或 拉曼散射 (Raman scattering), 并且波长是离散的, 或者用RGB三个分量来表示, 省略波长维度
* BSSRDF(bidirectional subsurface scattering reflection distribution function)

3. 没有子面散射, 即光线的入射点和出射点相同
* BSDF = BRDF + BTDF, 一般情况下BRDF和BTDF结合成BSDF进行计算
* BRDF, 描述了沿空间任一方向入射到物体表面的光线, 经过物体表面的反射朝空间其他方向辐射的辐射亮度分布
* BTDF(bidirectional transmittance distribution function), 透明物体, 双向透射分布函数.

## BSSRDF(Bidirectional Subsurface Scattering Reflection Distribution Function)
BSDF只考虑了光在物体表面的散射, 无法准确地建模参与介质——例如蜡烛、玉这种材质. 一种方式是使用体渲染(烟雾、云), 或者使用开销更小但不那么准确的BSSRDF描述材质.
![](https://pic1.zhimg.com/v2-76ff47841edef2717dea8762fe6e4ac4_r.jpg)

BSSRDF, 是一个分布$S()$
![](https://pbr-book.org/4ed/Radiometry,_Spectra,_and_Color/pha04f11.svg)


BSSDF可以通过 reflectance profile R, two directional Fresnel transmission terms Ft, and a constant C组合计算得到:
$$
S(x_i,w_i;x_o,w_o)=CF_t(x_i,w_i)R(|x_o-x_i|)F_t(x_o,w_o)
$$
![[reflection_profile.png]]
在[blender cycles Subsurface Method](https://docs.blender.org/manual/en/latest/render/shader_nodes/shader/sss.html) 分为三种:
* Christensen-Burley 一种近似方法, 相比于Random Walk精度要差
* Random Walk (Fixed Radius) 
* Random Walk 相比与Fixed Radius精度更高


## 展望
近年, PBR的技术主要朝着更逼真、更复杂、效能更好的方向，或是结合若干种模型的综合性技术迈进。代表性技术有：

- PBR Diffuse for GGX + Smith (2017)
- MultiScattering Diffuse (2018)
- Layers Material（分层材质）
- Mixed Material（混合材质）
- Mixed BxDF（混合BxDF）
- Advanced Rendering（进阶渲染）

## Reference
* [UE Subsurface Shading](https://docs.unrealengine.com/5.3/en-US/subsurface-shading-model-in-unreal-engine/)
* [UE Material Inputs](https://docs.unrealengine.com/5.3/en-US/material-inputs-in-unreal-engine/) Unreal中的一些高级材质参数
* [creating-human-skin-in-unreal-engine](https://docs.unrealengine.com/5.3/en-US/creating-human-skin-in-unreal-engine/) unreal 中的皮肤渲染
* [《计算机图形学：真实感图像合成》记录](https://www.zhihu.com/column/c_1420873093510721536)
* [Note：UE5源码解析-数字人渲染篇](https://blog.csdn.net/weixin_44346103/article/details/129113466)
* https://pbr-book.org/4ed/Reflection_Models/BSDF_Representation
* [Rendering the Moana Island Scene](https://schuttejoe.github.io/post/disneybsdf/)
* [UCSD CSE 272: Advanced Image Synthesis](https://cseweb.ucsd.edu/~tzli/cse272/wi2023/) 比较好的课程

sss论文资料:
* [Approximate Reflectance Profiles for Efficient Subsurface Scattering](https://graphics.pixar.com/library/ApproxBSSRDF/paper.pdf)
* [Real-time subsurface scattering with single pass variance-guided adaptive importance sampling](https://thisistian.github.io/publication/spvg_xie_2020_I3D_small.pdf)
* [gpu gems sss](https://developer.nvidia.com/gpugems/gpugems/part-iii-materials/chapter-16-real-time-approximations-subsurface-scattering)