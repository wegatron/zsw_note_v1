## Spherical Harmonics
一组 __正交基__, 将lighting 数据往这组正交基上投影, 可以得到每项的系数. 一般到2~3阶SH来近似irradiance(单位面积上受到的辐射/光照量).
在重建时, 根据角度可得到每项的值, 再根据系数进行加权还原.

正交基积分性质:

$$
\int_{\theta=0}^{\pi} \int_{\varphi=0}^{2 \pi} Y_{\ell}^{m} Y_{\ell^{\prime}}^{m^{\prime} *} d \Omega=\delta_{\ell \ell^{\prime}} \delta_{m m^{\prime}}
$$

公式:

$$
Y_{l}^{m}(\theta,\phi)=\left\{\begin{array}
{l l}{\sqrt{2}K_{l}^{-m}P_{l}^{-m}(cos(\theta))\sin(-m\phi)}&{\mathrm{if}\;m<0}\\
{{K_{l}^{0}P_{l}^{0}(cos(\theta))}}&{\mathrm{if}\;m=0}\\
{\sqrt{2}K_{l}^{m}P_{l}^{m}(cos(\theta))cos(m\phi)}&{\mathrm{if}\;m>0}
\end{array}\right.
$$

这里, $\displaystyle K_{\it l}^{m}\,=\sqrt{\frac{(2l+1)}{4\pi}\,\frac{(l-m)!}{(l+m)!}}$是归一化系数. $P_l^m$ 计算起来相当复杂, 使用递归方式计算:

$$
\begin{aligned}
(l-m)P_l^m &= x(2l-1)P_{l-1}^m - (l+m-1)P_{l-2}^m \qquad &(1)\\
P_m^m &= (-1)^m(2m-1)!!(1-x^2)^{m/2} &(2)\\
P_{m+1}^m &= x(2m+1)P_m^m &(3)
\end{aligned}
$$

这里, $(2m-1)!!$——为双阶乘函数, 返回所有小于等于(2m-1)的奇数的乘积. 例如先根据(2)算出$P_2^2$, 根据(3)算出$P_2^1$, 根据$P_0^0, P_1^0$ 算出 $P_2^0$, 依次类推. 相关代码可以参考Numerical Methods in C: The Art of Scientific Computing”, Cambridge University Press, 1992, pp 252 254.

在实际应用中, SH 0 ~ 2阶参数如下:
* Order $l=0$
    $$
    Y_0^0 = \frac{1}{2}\sqrt{\frac{1}{\pi}}
    $$

* Order $l=1$
    $$
    \left\{
        \begin{array}{l l}
        Y_1^{-1} &=& \frac{1}{2}\sqrt{\frac{3}{\pi}}y &m=-1\\
        Y_1^0 &=& \frac{1}{2}\sqrt{\frac{3}{\pi}}z &m = 0\\
        Y_1^1 &=& \frac{1}{2}\sqrt{\frac{3}{\pi}}x &m = 1\\
        \end{array}
    \right.
    $$

* Order $l=2$
    $$
    \left\{
        \begin{array}{l l}
        Y_2^{-2} &=& \frac{1}{2}\sqrt{\frac{15}{\pi}}xy &m=-2\\
        Y_2^{-1} &=& \frac{1}{2}\sqrt{\frac{15}{\pi}}yz &m=-1\\
        Y_2^0 &=& \frac{1}{4}\sqrt{\frac{5}{\pi}}(3z^2-1) &m=0\\
        Y_2^1 &=& \frac{1}{2}\sqrt{\frac{15}{\pi}}xz &m=1\\
        Y_2^2 &=& \frac{1}{4}\sqrt{\frac{15}{\pi}}(x^2-y^2) &m=2\\
        \end{array}
    \right.
    $$

这里,

$$
\left\{
    \begin{array}{l l}
    x = \sin(\theta)\cos(\phi)\\
    y = \sin(\theta)\sin(\phi)\\
    z = \cos(\theta)
    \end{array}
\right.
$$

### Encoding, 根据采样积分计算SH系数

$$
C_i = \int_0^{2\pi}\int_0^\pi light(\theta, \phi)Y_i(\theta, \phi)\sin(\theta)d\theta d\phi
$$

使用数值的方法计算SH系数:

```c++
float EncodeSHCoeff( int l, int m ) {
   const int STEPS_PHI = 200;
   const int STEPS_THETA = 100;
   const float dPhi = 2*PI/STEPS_PHI;
   const float dTheta = PI/STEPS_THETA;
   float coeff = 0.0f;
   for ( int i=0; i < STEPS_PHI; i++ ) {
       float phi = i * dPhi;
       for ( int j=0; j < STEPS_THETA; j++ ) {
           float theta = (0.5f+j) * dTheta;
           float value = EstimateFunction( phi, theta );
           float SHvalue = EstimateSH( l, m, phi, theta )
           coeff += value * SHValue * sin( theta ) * dPhi * dTheta;
       }
   }
   return coeff;
}
```

在单位球面均匀采样，概率密度函数: $p(x_j) = \frac{1}{4\pi}$.

$$
\left\{
\begin{array}{l l l}
C_i &= \frac{4\pi}{N} \sum_{j=1}^N light(x_j)y_i(x_j)\\
\mathrm{pdf}(\theta) &= \frac{1}{2} \sin(\theta) &\theta \in [0, \pi]\\
P(\theta) &= \frac{1}{2}(1 - \cos(\theta)) = \sin^2(\frac{\theta}{2})\\
d &= \sin^2(\frac{\theta}{2}) &\Rightarrow \theta = 2 \arccos(\sqrt{1-d})\\
d &=\frac{1}{2}(1- \cos(\theta)) &\Rightarrow \theta = \arccos(1-2d)
\end{array}
\right.
$$

这里, d是$[0,1]$之间的均匀分布, 采样信息可以预计算:

```c++
struct sample_t {
   float3  direction;
   float   theta, phi;
   float*  Ylm;
};
// Fills an N*N*2 array with uniformly distributed
// samples across the phere using jittered stratification
void PreComputeSamples( int sqrt_n_samples, int n_bands, sample_t samples], float ) {
   int i = 0; // array index
   double oneoverN = 1.0 / sqrt_n_samples;
   for ( int a=0; a < sqrt_n_samples; a++ ) {
       for ( int b=0; b < sqrt_n_samples; b++ ) {
           // Generate unbiased distribution of spherical coords
           double x = (a + random()) * oneoverN;           // Do not reuse results
           double y = (b + random()) * oneoverN;           // Each sample must be random!
           double theta = 2.0 * acos( sqrt( 1.0 - x ) );   // Uniform sampling on theta
           double phi = 2.0 * PI * y;                      // Uniform sampling on phi
           // Convert spherical coords to unit vector
           samples[i].direction = float3( sin(theta)*cos(phi), sin(theta)*sin(phi), cos(theta) );
           samples[i].theta = theta;
           samples[i].phi = phi;
           // precompute all SH coefficients for this sample
           for ( int l=0; l < n_bands; ++l ) {
               for ( int m=-l; m<=l; ++m ) {
                   int index = l*(l+1)+m;
                   samples[i].Ylm[index] = EstimateSH( l, m, theta, phi );
               }
           }
           ++i;
       }
   }
}
```

然后，对任意函数, 使用预采样进行积分，求系数:

```c++
typedef double (*EstimateFunction)( double theta, double phi );

// Here, n_coeffs = n_bands*n_bands and n_samples = sqrt_n_samples*sqrt_n_samples
void SHProject( EstimateFunction estimator, int n_samples, 
    int n_coeffs, const sample_t samples[], double result[] ) {
   for ( i=0; i < n_coeff; ++i ) {
       result[i] = 0.0;
   // For each sample
   for ( int i=0; i < n_samples; ++i ) {
       double theta = samples[i].theta;
       double phi = samples[i].phi;
       for ( int n=0; n < n_coeff; ++n ) {
           result[n] += estimator( theta, phi ) * samples[i].Ylm[n];
       }
   }
   // Divide the result by weight and number of samples
   double factor = 4.0*PI / n_samples;
   for ( i=0; i < n_coeff; ++i ) {
       result[i] = result[i] * factor;
   }
} 
```

### 解码, 根据SH系数还原light

$$
light(\theta, \phi) = \sum_{l=0}^N \sum_{m=-l}^l C_l^mY_l^m(\theta, \phi) = \sum_{i=0}^n C_iY_i(\theta, \phi)
$$

### 应用

快速的计算近似球面积分, 将函数$\mathbf{A}(\omega_i), \mathbf{B}(\omega_i)$ encode 得到 SH系数 $a_l^m, b_l^m$, 由于SH是一组正交基, 从而:

$$
\int\limits_\Omega{A(\boldsymbol\omega_i) B(\boldsymbol\omega_i) \; \mathrm{d\omega_i}} \; = \; \displaystyle\sum_{l=0}^{\infty} \displaystyle\sum_{m=-l}^{l} a_l^m \, b_l^m
$$

1. Irradiance Estimate
    $$
    E(\mathbf n) = \int\limits_\Omega{L(\boldsymbol{\omega_i}) \lfloor (\boldsymbol\omega_i\cdot\mathbf n )\rfloor \; \mathrm{d\omega_i}}
    $$
    这里$L(\boldsymbol{\omega_i})$入射radiance, $E(\mathbf n)$是法向为$\mathbf n$的表面上受到的irradiance.

2. Radiance Estimate
    $$
    L(\boldsymbol{\omega_o}) = \int\limits_{\Omega^+}{L(\boldsymbol{\omega_i}) \, f_r( \boldsymbol{\omega_o}, \boldsymbol{\omega_i} ) \, (\boldsymbol\omega_i\cdot\mathbf n ) \; \mathrm{d\omega_i}}
    $$

### 参考
* [Explain to me like I am 5 : using Spherical Harmonics coefficients](https://www.reddit.com/r/GraphicsProgramming/comments/m19ith/explain_to_me_like_i_am_5_using_spherical/)
* https://patapom.com/blog/SHPortal/
* [Spherical Harmonics](https://orlandoaguilar.github.io/sh/spherical/harmonics/irradiance/map/2017/02/12/SphericalHarmonics.html)
* papers&books/papers/rendering/Green2003Spherical.pdf
* [Integral of spherical harmonics over sphere](https://math.stackexchange.com/questions/2377595/integral-of-spherical-harmonics-over-sphere)

* demo: https://github.com/diharaw/runtime-ibl