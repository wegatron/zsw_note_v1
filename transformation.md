---
tag: summary/basic_theory
---
# Transformations
* Rigid(Isometry) Transformation
* Affine Transformation
* Linear Transformation

## Linear Transformation
Definition A linear transformation is a transformation $T: \mathbf{R}^n \to \mathbf{R}^m$ satisfying 
$$
\begin{aligned}
T(u+v) &= T(u) + T(v)\\
T(cu) &= cT(u)
\end{aligned}
$$

for all vectors $u,v \in R^n$, and all scalars $c$.

性质:
* 变换前是直线, 变换后任然是直线(平行关系不变)
* 变换前是原点的，变换后依然是原点

常见的变换: 旋转、镜像、错切(推移)

## 仿射变换
性质:
* 平行关系不变

常见的变换: 平移、旋转、镜像、缩放、推移

## Reference
[Linear Transformations](https://textbooks.math.gatech.edu/ila/linear-transformations.html)
[基本图像变换：线性变换,仿射变换，投影变换](https://blog.csdn.net/andylei777/article/details/78333817)