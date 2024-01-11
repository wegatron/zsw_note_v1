# Gaussian Splatting

Q: 3d gaussian如何表示一个场景(数据结构).

| name | type | description |
| --- | --- | --- |
| xyz | $n \times 3$ floats | position |
| feature_dc | $n \times 3$ floats | dc component of spherical harmonics(最低的信号分量-均值, RGB每个分量一个) |
| features_rest | $n \times 4$ | rest component of spherical harmonics. |
| scaling | $n \times 3$ floats | xyz方向上的scale |
| rotation | $n \times 4$ floats | 四元数表示的旋转 |
| opacity | $n \times 1$ floats | $\mathrm{inv\_sigmoid}(\alpha)$, $\alpha$是真正的透明度. |
| max_radii2D | $n \times 1$ floats | gaussian在屏幕(图片)上投影椭圆长轴半径(在优化时用来考虑是否拆分或者删除). |

Q: training过程
1. 初始化 `create_from_pcd`

Q: rendering过程

## Training

## Rendering

## Result and Evaluation

## Application
* 与传统3d渲染结合, 作为一个场景 —— 元象.
* [Relightable3DGaussian](https://github.com/NJU-3DV/Relightable3DGaussian)