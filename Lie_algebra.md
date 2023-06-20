---
tag:summary/basic_theory
---
# 李代数
## 为何要引入李代数
在SLAM中, 我们经常会构建与位姿T(由SO(3)上的旋转矩阵或SE(3)上的变换矩阵)有关的函数, 然后讨论该函数关于位姿的导数, 以调整当前的估计值. 然而, SO(3), SE(3)上并没有良好定义的加法, 如果我们把T当成一个普通矩阵来处理优化, 那就必须对它加以约束. 从李代数的角度上, 该问题可以更方便解决.
## 李代数的引出
对于任意旋转矩阵$R$有$RR^T=I$, 我们说$R$随时间$t$连续变化, 则求导有:
$$
\dot{R}(t)R(t)^T + R(t)^T\dot{R}(t) = 0
$$
整理可得: $\dot{R}(t)R(t) = -(\dot{R}(t)R(t))^T$, 即$\dot{R}(t)R(t)^T$是一个反对称矩阵. 引入反对称符号$^\wedge$, 对于三维向量$a$有:
$$
a^\wedge = \begin{bmatrix}
    0 & -a_3 & a_2 \\
    a_3 & 0 & -a_1 \\
    -a_2 & a_1 & 0 
  \end{bmatrix}
$$
反对称符号有如下性质$a\times b = a^\wedge b$. 于是$\dot{R}(t)R(t)^T = \phi(t)^\wedge$, 即
$$
\dot{R}(t) = \phi(t)^\wedge R(t) = \begin{bmatrix}
    0 & -\phi_3 & \phi_2 \\
    \phi_3 & 0 & -\phi_1 \\
    -\phi_2 & \phi_1 & 0 
  \end{bmatrix} R(t)
$$
我们看到$\phi$反映了$R$导数的性质. 假设在$t_0=0$时$R(0)=I$, 且在$t_0$附近, $\phi$保持为常数$\phi(t_0)=\phi_0$, 那么我们有微分方程:
$$
\left\{ \begin{array}{cc}
\dot{R}(t) &= \phi(t_0)^\wedge R(t) \\
R(0) &= I
\end{array}
\right.
$$
从而有:$R(t)=\exp(\phi_0^\wedge t)$
## 李代数基本知识
### 通用的李代数及其性质
李代数由一个集合$\mathbb{V}$, 一个数域$\mathbb{F}$和一个二元运算又称为李括号$[,]$组成. 性质:
1. 封闭性. $\forall X, Y \in \mathbb{V}, [X,Y]\in\mathbb{V}$
2. 双线性. $\forall X, Y, Z \in \mathbb{V}, a,b \in \mathbb{F}$有:
$$
[aX+bY, Z] = a[X,Z]+b[Y,Z], \: [Z, aX+bY] = a[Z,X]+b[Z,Y]
$$
3. 自反性. $\forall X \in \mathbb{V}, [X,X] = 0$
4. 雅克比等价. $\forall X, Y, Z \in \mathbb{V}, [X, [Y,Z]]+[Z, [Y,X]]+[Y, [Z,X]]=0$
### 李代数 
与$SO(3)$, $SE(3)$对应, 李代数有$\mathcal{SO}(3)$和$\mathcal{SE}(3)$. $\mathcal{SO}(3)$是一个3维向量组成的集合:
$$
\mathcal{SO}(3) = {\phi \in \mathbb{R}^3, \mathbf{\Phi}=\phi^\wedge \in \mathbb{R}^{3\times3}}
$$
每一个向量对应一个表示旋转矩阵导数的反对称矩阵. 有:
$$
R = \exp(\phi^\wedge)
$$
其李括号表示为:$[\phi_1, \phi_2] = (\Phi_1\Phi_2-\Phi_2\Phi_1)^\vee$.

$\mathcal{SE}(3)$是一个6维向量:
$$
\mathcal{SE}(3)=\left\{\xi = \begin{bmatrix}
  \rho \\
  \phi
  \end{bmatrix} \in \mathbb{R}^6, \rho \in \mathbb{R}^3, \phi \in \mathcal{SO}(3), \xi^\wedge = \begin{bmatrix}
  \phi^\wedge & \rho \\
  0^T & 0
  \end{bmatrix} \in \mathbb{R}^{4 \times 4}
  \right\}
$$
这里同样用符号$^\wedge$, 将一个6维向量转换成4维矩阵, 但不表示反对称. 其李括号表示为:
$[\xi_1,\xi_2]=(\xi_1^\wedge \xi_2^\wedge-\xi_2^\wedge \xi_1^\wedge)^\vee$.

$\mathcal{SO}(3)$上指数映射的计算:
$$
\exp(\phi^\wedge) = \sum_{n=0}^\infty\frac{1}{n!}(\phi^\wedge)^n
$$
对于3维向量$\phi$, 我们定义其模长和方向分别为$\theta$和$a$, 则可以得到:
$$
\exp(\theta a^\wedge) = \cos(\theta)I + (1-\cos(\theta)aa^T + \sin\theta a^\wedge )
$$
就是罗德里克斯公式: $\theta$表示的是旋转角度, $a$表示旋转轴. 因此, $\mathcal{SO}(3)$实际上也是旋转向量组成的空间, 我们也可以根据旋转矩阵去求得相应的李代数.

$\mathcal{SE}(3)$上指数映射的计算:
$$
\exp(\xi^\wedge) = \begin{bmatrix}
\sum_{n=0}^\infty\frac{1}{n!}(\phi^\wedge)^n & \sum_{n=0}^\infty\frac{1}{(n+1)!}(\phi^\wedge)^n \rho \\
0^T & 1
\end{bmatrix} = \begin{bmatrix}
R & J\rho \\
0^T & 1
\end{bmatrix} = T
$$
这里$J$可整理为($\phi=\theta a$):
$$
J = \frac{\sin \theta}{\theta}I + (1 - \frac{\sin \theta}{\theta})aa^T+\frac{1-\cos\theta}{\theta}a^\wedge
$$
同理, 我们可以根据变换矩阵中的$R$, $t$反求其李代数: 可通过$R$计算旋转向量, 从而得到$\phi$和$J$, 而$t$满足$t=J\rho$, 从而计算出$\rho$.
对应关系图:
![[rc/so_se_relation_ship.JPG]] 
## 李代数求导
使用李代数的一大动机是为了优化求导, 研究李代数指数映射的乘积形式:
$$
\ln(\exp(A)\exp(B)) \ne A + B
$$
Baker-Campbell-Hausdorff公式:
$$
\ln(\exp(A)\exp(B)) = A + B + \frac{1}{2}[A,B] + \frac{1}{12}[A, [A,B]] + \frac{1}{12}[B, [A,B]]+ \cdots
$$
特别的, 考虑$SO(3)$上的李代数$\ln(\exp(\phi_1^\wedge)\exp(\phi_2^\wedge))^\vee$, 当$\phi_1$或$\phi_2$为小量时, 小量二次以上的项可以被忽略, 有:
$$
\ln(\exp(\phi_1^\wedge)\exp(\phi_2^\wedge))^\vee \approx \left\{ \begin{array}{c}
  J_l(\phi_2)^{-1}\phi_1 + \phi_2 \: \: if \: \phi_1 \: is \: small\\
  J_r(\phi_1)^{-1}\phi_2 + \phi_1 \: \: if \: \phi_2 \: is \: small
  \end{array}
  \right.
$$

这里$J_l = J$, $J_l^{-1} = \frac{\theta}{2}\cot\frac{\theta}{2}I+(1-\frac{\theta}{2}\cot\frac{\theta}{2})aa^T - \frac{\theta}{2}a^\wedge$, $J_r=J_l(-\phi)$. 从而有:

$$
\begin{aligned}
&\exp(\Delta\phi^\wedge)\exp(\phi^\wedge) = \exp((J_l^{-1} \Delta \phi+ \phi)^\wedge) \\
&\exp((\Delta\phi+\phi)^\wedge) = \exp((J_l\Delta\phi)^\wedge)\exp(\phi^\wedge) = \exp(\phi^\wedge)\exp((J_r\Delta\phi)^\wedge)
\end{aligned}
$$

类似的, 对于$\mathcal{SE}(3)$上的李代数, 有:
$$
\begin{aligned}
&\exp(\Delta\xi^\wedge)\exp(\xi^\wedge) \approx \exp((\mathcal{J}_l^{-1} \Delta \xi+ \xi)^\wedge) \\
&\exp(\xi^\wedge)\exp(\Delta\xi^\wedge) \approx \exp((\mathcal{J}_r^{-1}\Delta\xi)^\wedge)\exp(\xi^\wedge)
\end{aligned}
$$

这里$\mathcal{J_l}$和$\mathcal{J_r}$的形式比较复杂(一般不用), 由此产生了李代数的两种求导方式. 这里只推导在$\mathcal{SO}(3)$上的情况, 然后直接给出在$\mathcal{SE}(3)$上的情况. 我们的目标:
$$
\frac{\partial Rp}{R} \Leftrightarrow \lim_{\Delta R \to 0} \frac{\Delta R R p}{\Delta R}
$$

一种方式认为$\Delta R R = \exp((\Delta \phi + \phi)^\wedge)$, 从而求:
$$
\lim_{\delta \phi \to 0} \frac{(\exp((\phi+\delta \phi)^\wedge) - \exp(\phi^\wedge))p}{\delta \phi} \Leftrightarrow \frac{\partial \exp(\phi^\wedge) p}{\partial \phi}
$$

另一种方式认为$\Delta R R = \exp(\varphi^\wedge)\exp(\phi^\wedge)$, 从而求:
$$
\lim_{\varphi \to 0} \frac{(\exp(\varphi^\wedge) \exp(\phi^\wedge) - \exp(\phi^\wedge))p}{\varphi} \Leftrightarrow \frac{\partial \exp(\phi^\wedge) p}{\partial \varphi}
$$

这里$\varphi$为$\Delta R$对应的李代数. 经过推导, 可以求得:
$$
\begin{aligned}
\frac{\partial \exp(\phi^\wedge) p}{\partial \phi} &= \lim_{\delta \phi \to 0} \frac{(\exp((\phi+\delta \phi)^\wedge) - \exp(\phi^\wedge))p}{\delta \phi} \\
&= \lim_{\delta \phi \to 0} \frac{(\exp((J_l\delta \phi)^\wedge)\exp(\phi^\wedge) - \exp(\phi^\wedge))p}{\delta \phi} \\
&= \lim_{\delta \phi \to 0} \frac{(I + (J_l\delta \phi)^\wedge)\exp(\phi^\wedge) - \exp(\phi^\wedge))p}{\delta \phi}\\
&= \lim_{\delta \phi \to 0} \frac{(J_l\delta \phi)^\wedge\exp(\phi^\wedge)p}{\delta \phi}\\
&= \lim_{\delta \phi \to 0} \frac{-(\exp(\phi^\wedge)p)^\wedge (J_l\delta \phi)}{\delta \phi}\\
&= -(R p)^\wedge J_l
\end{aligned}
$$

$$
\begin{aligned}
\frac{\partial \exp(\phi^\wedge) p}{\partial \varphi} &= \lim_{\varphi \to 0} \frac{(\exp(\varphi^\wedge) \exp(\phi^\wedge) - \exp(\phi^\wedge))p}{\varphi}\\
&= \lim_{\varphi \to 0} \frac{((I+\varphi^\wedge)\exp(\phi^\wedge) - \exp(\phi^\wedge))p}{\varphi}\\
&= \lim_{\varphi \to 0} \frac{\varphi^\wedge \exp(\phi^\wedge) p}{\varphi}\\
&= \lim_{\varphi \to 0} \frac{(-\exp(\phi^\wedge)p)^\wedge \varphi}{\varphi}\\
&= -(R p)^\wedge
\end{aligned}
$$

由于第二种方式去除了形式复杂的J, 我们一般采用第二种方式. 类似的, 在$\mathcal{SE}(3)$上, 设变换为$T$, $\Delta T = \exp(\delta \xi^\wedge)$, $\delta \xi = [\delta \rho, \delta \phi]$有:
$$
\begin{aligned}
\frac{\partial Tp}{\partial \delta \xi} &= \lim_{\delta \xi \to 0} \frac{\exp(\delta \xi^\wedge) \exp(\xi^\wedge)p - \exp(\xi^\wedge) p}{\delta \xi} \\
&\approx \lim_{\delta \xi \to 0} \frac{(I + \delta \xi^\wedge) \exp(\xi^\wedge)p - \exp(\xi^\wedge) p}{\delta \xi} \\
&= \lim_{\delta \xi \to 0} \frac{\delta \xi^\wedge \exp(\xi^\wedge)p}{\delta \xi} \\
&= \lim_{\delta \xi \to 0} \frac{
  \begin{bmatrix}
  \delta \phi^\wedge & \delta \rho \\
  0^T & 0
  \end{bmatrix} \begin{bmatrix}
  Rp + t\\
  1
  \end{bmatrix}
}{\delta \xi} \\
&= \lim_{\delta \xi \to 0} \frac{
  \begin{bmatrix}
  \delta \phi^\wedge(Rp+t)+\delta \rho\\
  0
  \end{bmatrix}
}{\delta \xi} \\
&= \begin{bmatrix}
I & -(Rp+t)^\wedge \\
0^T & 0^T
\end{bmatrix}\overset{\Delta}{=}(Tp)^\odot
\end{aligned}
$$

## 伴随
伴随的定义:
$$
\mathrm{Ad}(T) = \begin{bmatrix}
R & t^\wedge R\\
0 & R
\end{bmatrix}
$$

伴随的性质(左右扰动的关系, 这里用右扰动来表示左扰动):
$$
\begin{aligned}
T \exp(\xi^\wedge) T^{-1} = \exp((\mathrm{Ad}(T)\xi)^\wedge)\\
T \exp(\xi^\wedge) = \exp((\mathrm{Ad}(T)\xi)^\wedge) T
\end{aligned}
$$

简单证明:
$$
\begin{aligned}
&T \exp(\delta \xi_1^\wedge) = \exp(\delta \xi_2^\wedge) T\\
\begin{bmatrix}R & t\\0 & 1\end{bmatrix} &\begin{bmatrix} I+\delta \phi_1^\wedge & \delta \rho_1\\ 0 & 1\end{bmatrix} = \begin{bmatrix} I+\delta \phi_2^\wedge & \delta \rho_2\\ 0 & 1\end{bmatrix} \begin{bmatrix}R & t\\0 & 1\end{bmatrix}\\
\Rightarrow &\left\{ \begin{array}{ccc}
R(I + \delta \phi_1^\wedge) &=& (I+\delta \phi_2^\wedge)R\\
R\delta \rho_1 + t &=& (I+\delta \phi_2^\wedge)t + \delta \rho_2
\end{array}
\right.\\
\Rightarrow &\left\{ \begin{array}{ccc}
\delta \phi_2 &=& R \delta \phi_1\\
\delta \rho_2 &=& R \delta \rho_1 + t^\wedge R \delta \phi_1
\end{array}
\right.\\
\Rightarrow &\begin{bmatrix}\delta \rho_2\\\delta \phi_2\end{bmatrix} = \begin{bmatrix}R & t^\wedge R\\0 & R\end{bmatrix}\begin{bmatrix}\delta \rho_1\\\delta \phi_1\end{bmatrix}\\
\Rightarrow &\left\{\begin{array}{ccc}
\xi_2 &=& \mathrm{Ad}(T) \xi_1\\
\xi_1 &=& \mathrm{Ad}(T^{-1}) \xi_2
\end{array}\right.
\end{aligned}
$$

运用:
* 例如DSO中求相对位姿增量关于绝对位姿增量的导数
  $T_{th}$帧$t$和$h$之前的相对位姿, $T_{hw}$, $T_{tw}$绝对位姿. 对$T_{hw}$加扰动$\epsilon_{hw}$, 对应的$T_{th}$产生扰动$\epsilon_{hw}$.
  $$
  \begin{aligned}
  \exp(\epsilon_{th}^\wedge) T_{th} &= T_{tw} (\exp(\epsilon_{hw}^\wedge) T_{hw})^{-1}\\
  &= T_{tw} T_{hw}^{-1} \exp(-\epsilon_{hw}^\wedge)\\
  &= T_{th} \exp(-\epsilon_{hw}^\wedge)\\
  \Rightarrow \exp(\epsilon_{th}^\wedge) &= T_{th} \exp(-\epsilon_{hw}^\wedge) T_{th}^  {-1}\\
  &= \exp((-Ad(T_{th})\epsilon_{hw})^\wedge))\\
  \Rightarrow \epsilon_{th} &= -\mathrm{Ad}(T_{th})\epsilon_{hw}\\
  \Rightarrow \frac{\partial \epsilon_{th}}{\partial \epsilon_{hw}} &= -\mathrm{Ad}(T_  {th})
  \end{aligned}
  $$

## 李代数的性质总结

![[rc/li_algebra_property_0.png]]

![[rc/li_algebra_property_1.png]]