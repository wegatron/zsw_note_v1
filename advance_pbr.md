#cg/shading 

## BSSRDF Subsurface Shading
对于像蜡、玉这样的材质, 光在其内部发生散射.

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

sss论文资料:
* [Approximate Reflectance Profiles for Efficient Subsurface Scattering](https://graphics.pixar.com/library/ApproxBSSRDF/paper.pdf)
* [Real-time subsurface scattering with single pass variance-guided adaptive importance sampling](https://thisistian.github.io/publication/spvg_xie_2020_I3D_small.pdf)
* [gpu gems sss](https://developer.nvidia.com/gpugems/gpugems/part-iii-materials/chapter-16-real-time-approximations-subsurface-scattering)