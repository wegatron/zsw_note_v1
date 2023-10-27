---
tags:
  - cg/shading
---
## 数学符号定义
* $\mathbf{n}$ surface normal
* $\mathbf{v}$ view direction
* $\mathbf{h}$ half vector
* $\mathbf{l}$ incident light direction
* $\mathbf{\omega_o}$ direction of out going light
* $\alpha$ roughness
* $\rho$ diffuse reflectance
* $\chi^{+}(a)$ Heaviside function: 1 if a > 0 and 0 if a <= 0
* $\langle\omega_1, \omega_2\rangle$ clamped dot product: 0 if $\omega_1 \cdot \omega_2 < 0$

## 经典光照模型
color = diffuse + ambient + specular

$$
    diffuse = \mathbf{l} \cdot \mathbf{n} \cdot albedo
$$

* Phone
    $$
        spec = (\mathbf{v} \cdot \mathbf{\omega_o})^{shiness}
    $$

* Blin-Phone
    $$
        spec = (\mathbf{n} \cdot \mathbf{h})^{shiness}
    $$
## BSDF
包含BRDF和BTDF

### BRDF
* energy conservation
* fresnel
* micro surface

general rendering equation:

$$
    {\cal L}_{o}(p,\omega_{o})={\cal L}_{e}(p,\omega_{o})+\int_{\Omega^{+}}{\cal L}_{i}(p,\omega_{i})f_{r}(p,\omega_{i},\omega_{o})(n\cdot\omega_{i})\,\mathrm{d}\omega_{i}    
$$

render equation in micro surface:
$$
    f_{d/r}(\mathbf{v})={\frac{1}{|\mathbf{n}\cdot\mathbf{v}||\mathbf{n}\cdot\mathbf{l}|}}\int_{\Omega}f_{m}(\mathbf{v},\mathbf{l},\mathbf{m})\;G(\mathbf{v},\mathbf{l},\mathbf{m})\;D(\mathbf{v},\mathbf{m})\,\langle\mathbf{v}\cdot\mathbf{m}\rangle\langle\mathbf{l}\cdot\mathbf{m}\rangle\,\mathrm{d}\mathbf{m}
$$
对于镜面发射$f_m$ 是Fresnel, 积分后为:
$$
    f_{r}(\mathbf{v})=\frac{F(\mathbf{v},\mathbf{h},f_{0},f_{90})\;G(\mathbf{v},\mathbf{l},\mathbf{\alpha})\;L\!\!\!\!D(\mathbf{h},\alpha)}{4\langle\mathbf{n}\cdot\mathbf{v}\rangle\langle\mathbf{n}\cdot\mathbf{l}\rangle}
$$
因为
$$
V(v,l,\alpha) = \frac{G(v, l, \alpha)}{4\langle\mathbf{n}\cdot\mathbf{v}\rangle\langle\mathbf{n}\cdot\mathbf{l}\rangle} = V_1(l,\alpha) V_1(v,\alpha)
$$
因此, 又可表示为:
$$
f_r(v)=F(\mathbf{v},\mathbf{h},f_{0},f_{90})\;V(\mathbf{v},\mathbf{l},\mathbf{\alpha})\;L\!\!\!\!D(\mathbf{h},\alpha)
$$
对于漫反射, 使用Lambertian模型, $f_m$是一个常量:
$$
f_{d}({\bf v})=\frac{\rho}{\pi}\frac{1}{|{\bf n}\cdot{\bf v}||{\bf n}\cdot{\bf l}|}\int_{\Omega}G({\bf v},{\bf l},{\bf m})~D({\bf m},\alpha)~\langle{\bf v}\cdot{\bf m}\rangle\langle{\bf l}\cdot{\bf m}\rangle\ \mathrm{d}{\bf m}
$$

这里$\rho$是漫反射的颜色, 上述积分没有解析解, 只能进行近似. 也可以采用简单的经验模型进行替代:

$$
f_{d}=\frac{\rho}{\pi}(1+F_{D90}(1-\langle{\bf n\cdot1}\rangle)^{5})(1+F_{D90}(1-\langle{\bf n\cdot v}\rangle)^{5})\mathrm{~where~}{F}_{D90}=0.5+\cos(\theta_{d})^{2}\alpha
$$

Normal Distrbution Function选择"long-tailed" GGX:

$$
\large
D_{GGX} =
\chi^+ (\vec n \cdot \vec h)
\frac
{ \alpha^2 }
{ \pi \left((\vec n \cdot \vec h)^2 *(\alpha^2 - 1) + 1\right)^2}
$$

Geometry Function, Smith visibility function能够精确地表示. 采用height-corrleated Smith function近似表示会更好:

$$
G(\mathbf{v}, \mathbf{h}, \alpha)=\frac{\chi^{+}({\bf v},{\bf h})\chi^{+}({\bf h})}{1+\Lambda({\bf v})+\Lambda({\bf h})}\ \mathrm{with}\ \Lambda({\bf m})=\frac{-1+\sqrt{1+\alpha^2\tan^2(\theta_m)}}{2}
$$
Fresnel using Schlick's approximation:
$$
	F = F_0 + (F_{90} - F_0)*(1 - (\vec n \cdot \vec v))^5
$$
### BRDF实现

为了保证能量守恒, 对diffuse进行修正.
    $$
    \int_\Omega (f_r(\mathbf{v}, \mathbf{l}) + f_d(\mathbf{v}, \mathbf{l})) \langle{} \mathbf{n} \cdot \mathbf{l} \rangle d\mathbf{l} \le 1
    $$

新的diffuse计算:  
$$
    {F}_{D90}=0.5\alpha+\cos(\theta_{d})^{2}\alpha
$$

代码(Moving Frostbite to Physically Based Rendering 3.0):
```hlsl
float Fr_DisneyDiffuse(float NdotV, float NdotL, float LdotH, float linearRoughness)
{
    float energyBias = lerp(0, 0.5, linearRoughness);
    float energyFactor = lerp(1.0, 1.0 / 1.51, linearRoughness);
    float fd90 = energyBias + 2.0 * LdotH*LdotH * linearRoughness;
    float3 f0 = float3 (1.0f, 1.0f, 1.0f);
    float lightScatter = F_Schlick(f0, fd90, NdotL).r;
    float viewScatter = F_Schlick(f0, fd90, NdotV).r;
    return lightScatter * viewScatter * energyFactor;
}

float3 F_Schlick (in float3 f0 , in float f90 , in float u)
{
    return f0 + (f90 - f0) * pow (1. f - u, 5.f);
}

float V_SmithGGXCorrelated ( float NdotL , float NdotV , float alphaG )
{
    // Original formulation of G_SmithGGX Correlated
    // lambda_v = (-1 + sqrt ( alphaG2 * (1 - NdotL2 ) / NdotL2 + 1)) * 0.5 f;
    // lambda_l = (-1 + sqrt ( alphaG2 * (1 - NdotV2 ) / NdotV2 + 1)) * 0.5 f;
    // G_SmithGGXCorrelated = 1 / (1 + lambda_v + lambda_l );
    // V_SmithGGXCorrelated = G_SmithGGXCorrelated / (4.0 f * NdotL * NdotV );

    // This is the optimize version
    float alphaG2 = alphaG * alphaG ;
    // Caution : the " NdotL *" and " NdotV *" are explicitely inversed , this is not a mistake .
    float Lambda_GGXV = NdotL * sqrt ((- NdotV * alphaG2 + NdotV ) * NdotV + alphaG2 );
    float Lambda_GGXL = NdotV * sqrt ((- NdotL * alphaG2 + NdotL ) * NdotL + alphaG2 );

    return 0.5 f / ( Lambda_GGXV + Lambda_GGXL );
}

float D_GGX ( float NdotH , float m)
{
    // Divide by PI is apply later
    float m2 = m * m;
    float f = ( NdotH * m2 - NdotH ) * NdotH + 1;
    return m2 / (f * f);
}

// This code is an example of call of previous functions
float NdotV = abs( dot (N, V)) + 1e -5f; // avoid artifact
float3 H = normalize (V + L);
float LdotH = saturate ( dot (L, H));
float NdotH = saturate ( dot (N, H));
float NdotL = saturate ( dot (N, L));

// Specular BRDF
float3 F = F_Schlick (f0 , f90 , LdotH );
float Vis = V_SmithGGXCorrelated (NdotV , NdotL , roughness );
float D = D_GGX (NdotH , roughness );
float Fr = D * F * Vis;

// Diffuse BRDF
float Fd = Fr_DisneyDiffuse (NdotV , NdotL , LdotH , linearRoughness ) / PI;
```

## Basic Material System
### SG(Specular Glossiness)
* Diffuse 漫反射光 RGB
* Specular 用来描述菲涅尔项 RGB, 当表达黄金这样的金属, 对于不同的色彩效果不一样
* Glossiness 光滑程度

缺点: Specular项不是很好设置, 设置不好会导致结果非常假. 代码参考上面shader code.

### Metallic Roughness
使用金属度 (metalic) 来关联diffuse和菲尼尔部分, 这样就避免了两个参数冲突问题. 本质上MR材质还是使用SG材质.
* base_color
* roughness
* metallic
metalic的意义: 如果一个物体的金属度非常低，则代表为非金属, 那么此时的base_color __无法用在diffuse和specular中进行计算__. 而如果金属度十分高, 则代表这个物体是金属, 那么你的base_color会被大量抽走并用在diffuse和specular的计算中.

```c++
SpecularGlossiness ConvertMetallicRoughnessToSpecularGlossiness(
	MetallicRoughness metallic_roughness)
{
    float3 base_color = metallic_roughness.base_color;
    float roughness = metallic_roughness.roughness;
    float metallic = metallic_roughness.metallic;

    float3 specular = lerp(dielectric_specular, base_color, metallic);
    float3 diffuse = base_color * (1.0f - metallic);

    SpecularGlossiness specular_glossiness;
    specular_glossiness.specular = specular;
    specular_glossiness.diffuse = diffuse;
    specular_glossiness.glossiness = 1.0f - roughness;

    return specular_glossiness;
}
```

### standard imp
在现在的引擎中, 基本上都用到以下标准材质(filament/UE):

|Parameter|Type and range|
|---|---|
|**BaseColor**|Linear RGB [0..1]|
|**Metallic**|Scalar [0..1]|
|**Roughness**|Scalar [0..1]|
|**Reflectance**|Scalar [0..1]|
|**Emissive**|Linear RGB [0..1] + exposure compensation|
|**Ambient occlusion**|Scalar [0..1]|


## Light
## 参考
* Moving Frostbite to Physically Based Rendering 3.0
* [Games-104 Game Engine 05:渲染光和材质的数学魔法](https://zhuanlan.zhihu.com/p/512998645)
* [【基于物理的渲染（PBR）白皮书】（五）几何函数相关总结](https://zhuanlan.zhihu.com/p/81708753)