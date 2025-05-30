## SH
一组正交基, 将lighting 数据往这组正交基上投影, 可以得到每项的系数. 一般到2~3阶SH来近似irradiance(单位面积上受到的辐射/光照量).
在重建时, 根据角度可得到每项的值, 再根据系数进行加权还原.

公式:

SH系数计算:


根据SH系数计算diffuse light:

参考:
* [Explain to me like I am 5 : using Spherical Harmonics coefficients](https://www.reddit.com/r/GraphicsProgramming/comments/m19ith/explain_to_me_like_i_am_5_using_spherical/)
* https://patapom.com/blog/SHPortal/
* [Spherical Harmonics](https://orlandoaguilar.github.io/sh/spherical/harmonics/irradiance/map/2017/02/12/SphericalHarmonics.html)
* papers&books/papers/rendering/Green2003Spherical.pdf

demo:
https://github.com/diharaw/runtime-ibl