# Multi-layer materials
多层的材质在现实中非常常见, 尤其是在标准的层上覆盖一层薄薄的半透明层.

## Clear Coat
![](rc/diagram_clear_coat.png)

在filament中: 仍旧使用BRDF模拟clear coat层, 只是改用Kelemen visibility function(一般clear coat比较光滑, 该近似具有更高性能).

$$
V(l, h) = \frac{1}{4(l \cdot h)^2}
$$

并使用固定的F0=0.04, 即IOR=1.5.

加入了Clear Coat层后:

$$
f(v, l) = (f_d(v, l) + f_r(v, l)) * (1 - F_c) + f_c(v, l)
$$

## Sheen
