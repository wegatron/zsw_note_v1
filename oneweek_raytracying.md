---
tags:
  - cg/shading
  - cg/course_note
---
## Camera

## Hittable

## Material

## Monte Carlo

通过采样的方式, 利用概率统计计算一些复杂函数的值. 例如求PI.
![[rc/montecarlo.jpg]]
在求解函数时, 在分布空间中均匀采样时, 不可避免会有很多无效采样计算(ray tracying时最终无法到达光源, 或者反射的光特别弱). 通过修改采样分布, 来提高收敛速度.

### Probility Density Function

PDF(Probility Density Function): $p(x)$

需要注意的是, $p(x)$的值并不表示采样值为$x$的概率, 任意采样值的概率均为0.

CDF(Cumulative Distribution Function):

$$
P(x) = \int_{-\infty}^{x} p(x) dx
$$

$f(d)$, 一个单调递增, 并以[0,1] 之间均匀分布的随机值作为输入, 返回一个满足$P(x)$ 分布的采样分布值.

$$
\begin{aligned}
&f(P(x)) = x\\
&f(d) = P^{-1}(x)
\end{aligned}
$$

Monte Carlo Basics:

$$
\begin{aligned}
E_p[f(x)] &= \int_a^b f(x) p(x) dx\\
E_p\left[\frac{f(x)}{p(x)}\right] &= \int_a^b \frac{f(x)}{p(x)}p(x)dx\\
E_p\left[\frac{f(x)}{p(x)}\right] &\approx \frac{1}{N}\sum_{i=1}^{N} \frac{f(x_i)}{p(x_i)}\\
\Rightarrow \int_a^b f(x)dx &\approx \frac{1}{N}\sum_{i=1}^{N} \frac{f(x_i)}{p(x_i)}
\end{aligned}
$$

以计算积分$\int_{0}^{2} x^2 dx$为例(可以使用均匀采样, 也可以使用非均匀采样):

$$
\begin{aligned}
\lim_{N \to \infty} \mathrm{range}(x) \frac{1}{N}\sum_{i=1}^{N} x_i^2 \quad& \mathrm{uniform \; sampling \; x}\\
\lim_{N \to \infty}\frac{1}{N}\sum_{i=1}^{N} x_i^2\frac{1}{p(x)} \quad& \mathrm{nonuniform \; sampling \; x \; with \; PDF \;} p(x)
\end{aligned}
$$
```c++
#include <iostream>
#include <iomanip>
#include <math.h>
#include <random>

double random_double() {
    static std::default_random_engine e;
    static std::uniform_real_distribution<> dis(0, 1); // rage 0.0 - 1.0
    return dis(e);
}

double uniform_f(double d) {
    return 2.0 * d;
}

double uniform_pdf(double x) {
    return 0.5;
}

double uniform_calc() {
    int N = 1000000;
    auto sum = 0.0;
    for (int i = 0; i < N; i++) {
        auto x = uniform_f(random_double()); // random_double from [0,1]
        sum += x*x / uniform_pdf(x);
    }
    return sum/N;
}

double nonuniform_f(double d)
{
    return sqrt(4 * d);
}

double nonuniform_pdf(double x)
{
    return 0.5*x;
}

double nonuniform_calc() {
    int N = 1000000;
    auto sum = 0.0;
    for (int i = 0; i < N; i++) {
        auto x = nonuniform_f(random_double());
        sum += x*x / nonuniform_pdf(x);
    }
    return sum/N;
}

int main(int argc, char * argv[])
{
    double ur = uniform_calc();
    double non_ur = nonuniform_calc();
    double gt = 8.0 / 3.0;
    std::cout << std::fixed << std::setprecision(12);
    std::cout << "gt I=" << gt << std::endl;
    std::cout << "uniform I=" << ur << " err=" << gt - ur << std::endl;
    std::cout << "nonuniform I=" << non_ur << " err=" << gt-non_ur << std::endl;
    return 0;
}
```

result:
```bash
gt I=2.666666666667
uniform I=2.668667287011 err=-0.002000620344
nonuniform I=2.667114339335 err=-0.000447672668
```

Importance Sampling: 采样的样本越多, 越能够抵抗噪声的干扰. 因此, 我们希望在噪声比较大(敏感-值比较不一致)的区域, 采更多的样本(PDF大), 在噪声比较小(不敏感-值比较一致)的区域少采一些样本(PDF小). 通过这种策略可以降低采样量并加速收敛.

任意的PDF都能够最终收敛到正确结果, 但最准确的PDF收敛最快.

## Light Scattering

一个表面的颜色可以通过以下积分公式进行计算:

$$
\operatorname{Color}_o(\mathbf{x}, \omega_o, \lambda) = \int_{\omega_i} A(\mathbf{x}, \omega_i, \omega_o, \lambda) \cdot \operatorname{pScatter}(\mathbf{x}, \omega_i, \omega_o, \lambda) \cdot \operatorname{Color}_i(\mathbf{x}, \omega_i, \lambda)
$$

这里, $\mathbf{x}=(x,y,z)$, $\omega_i$是入射光线方向, $\omega_o$是出射(视线)方向, $\lambda$是光的波长. 
$A(\mathbf{x}, \omega_i, \omega_o, \lambda)$ 是物体的Albedo.
$\mathrm{pScatter}(\mathbf{x}, \omega_i, \omega_o, \lambda)$是光线的概率密度函数, 该概率密度函数除了与出射方向相关外, 与入射方向(Fresnel效应), 与波长(三棱镜反射成彩虹), 反射位置相关.

根据Monte Carlo Basic, 有:

$$
\operatorname{Color}_o(\mathbf{x}, \omega_o, \lambda) \approx \sum \frac{A(\mathbf{x}, \omega_i, \omega_o, \lambda) \cdot \operatorname{pScatter}(\mathbf{x}, \omega_i, \omega_o, \lambda) \cdot \operatorname{Color}_i(\mathbf{x}, \omega_i, \lambda)}{p(\mathbf{x}, \omega_i, \omega_o, \lambda)}
$$
这里, $p(\mathbf{x}, \omega_i, \omega_o, \lambda)$是我们随机生成的出射方向的概率密度函数(这里有两个概率密度函数$pScatter()$和$p()$, 将分子看做是一个函数$f(x)$进行采样计算).
## Play with Importance Sampling

* random sphere sampling
	在单位球的极坐标上进行均匀采样, $\theta$表示纬度, $\phi$表示经度. 球面积为$4\pi$, 则有(曲面积分等于在曲线/圆环再进行积分):
	$$
	\int \int  r^2 \sin \theta d\phi d\theta
	$$
	经度$\phi$均匀分布, 维度$\theta$的分布与$\sin \theta$成正比例关系.
	$$
	\left.
	\begin{aligned}
	r_1 &= \int_0^\phi \frac{1}{2\pi} d\phi\\
	r_2 &= \int_0^\theta 2\pi \sin(\theta) d\theta
	\end{aligned}
	\right\} \Rightarrow \left\{
	\begin{aligned}
	\phi &= 2 \pi r_1\\
	cos(\theta) &= 1 - \frac{r_2}{2\pi}
	\end{aligned}
	\right.
	$$

* cosine sampling
	光在打到物体表面后, 在各个方向上的散射率/Intensity与$\cos \theta$成正比例关系(红色箭头). 在观察时, 倾斜角度上面积被压缩(除以$\cos \theta$), 所以对于[lambert漫反射而言, 各个角度上看到的强度相同](https://en.wikipedia.org/wiki/Lambertian_reflectance).
	![[Lambert6.gif]]

* Projection of light shape onto PDF
	$$
	d\omega = \frac{dA \cdot \cos(\theta)}{\operatorname{distance}^2(p,q)}
   $$
	![[rc/shape-onto-pdf.jpg]]
