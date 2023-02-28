---
tag: summary/basic_theory
---
## Rotation Matrix
### Basic Rotation Matrix
$$
\begin{aligned} R_{x}(\theta) &=\left[\begin{array}{ccc}{1} & {0} & {0} \\ {0} & {\cos \theta} & {-\sin \theta} \\ {0} & {\sin \theta} & {\cos \theta}\end{array}\right] \\ R_{y}(\theta) &=\left[\begin{array}{ccc}{\cos \theta} & {0} & {\sin \theta} \\ {0} & {1} & {0} \\ {-\sin \theta} & {0} & {\cos \theta}\end{array}\right] \\ R_{z}(\theta) &=\left[\begin{array}{ccc}{\cos \theta} & {-\sin \theta} & {0} \\ {\cos \theta} & {\cos \theta} & {0} \\ {0} & {0} & {1}\end{array}\right] \end{aligned}
$$

### Rotation matrix from axis and angle
给定一个旋转轴(向量): $\mathbf{u} = (u_x, u_y, u_z)$, 这里$u_x^2 + u_y^2 + u_z^2 = 1$, 旋转角度为$\theta$, 则有:
$$
R=\left[\begin{array}{ccc}{\cos \theta+u_{x}^{2}(1-\cos \theta)} & {u_{x} u_{y}(1-\cos \theta)-u_{z} \sin \theta} & {u_{x} u_{z}(1-\cos \theta)+u_{y} \sin \theta} \\ {u_{y} u_{x}(1-\cos \theta)+u_{z} \sin \theta} & {\cos \theta+u_{y}^{2}(1-\cos \theta)} & {u_{y} u_{z}(1-\cos \theta)-u_{x} \sin \theta} \\ {u_{z} u_{x}(1-\cos \theta)-u_{y} \sin \theta} & {u_{z} u_{y}(1-\cos \theta)+u_{x} \sin \theta} & {\cos \theta+u_{z}^{2}(1-\cos \theta)}\end{array}\right]
$$

该矩阵可以通过先将z轴旋转到$(u_x, u_y, u_z)$, 然后绕z轴转$\theta$角, 然后再逆变换到全局坐标系.
根据上述矩阵, 我们有:
$$
\mathbf{tr}(R) = 1+2 \cos \theta
$$

#### Trace of matrix
$$
\mathbf{tr}(A) = \sum A_{ii}
$$

$\lambda$是矩阵$A$的特征值, trace有如下性质:
$$
\begin{aligned}
\mathbf{tr}(A) &= \sum \lambda_i\\
\mathbf{tr}(A^k) &= \sum \lambda_i^k
\end{aligned}
$$

## Reference
[trace的性质](https://en.wikipedia.org/wiki/Trace_(linear_algebra))
[Rotation Matrix](https://en.wikipedia.org/wiki/Rotation_matrix)