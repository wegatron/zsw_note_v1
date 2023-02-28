---
tag: summary/basic_theory
---
> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [zhuanlan.zhihu.com](https://zhuanlan.zhihu.com/p/75521342)

在上一篇内容

我们将傅里叶级数推导为傅里叶变换，而傅里叶变换计算的时候因为是一个积分，计算机并不是很好计算，所以要把积分换成一种累加形式，也就是本文要讨论的 离散傅里叶变化 DFT。

我们取上一篇的公式（7）

![](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+f%28t%29%26%3D%5Cfrac%7B1%7D%7BT%7D%5Csum_%7Bn%3D-%5Cinfty%7D%5E%7B%2B%5Cinfty%7D%5Cint_%7B-%5Cinfty%7D%5E%7B%2B%5Cinfty%7Df%28t%29e%5E%7B-i%5Comega+_%7Bx%7Dt%7Ddt%5Ccdot+e%5E%7Bi%5Comega+_%7Bx%7D+t%7D%5C%5C+%26%3D%5Cfrac%7BN%7D%7B2%5Cpi%5Ccdot+T%7D+%5Ccdot+%5Csum_%7Bn%3D-%5Cinfty%7D%5E%7B%2B%5Cinfty%7D%7B%5B+F%28%5Comega_%7Bx%7D%29%5Ccdot+e%5E%7Bi%5Comega_%7Bx%7D+t%7D%5Ccdot%5Cfrac%7B2%5Cpi%7D%7BN%7D%5D%7D%5C%5C++%5C%5C+%5Cend%7Balign%7D+%5C%5C)

其中![](https://www.zhihu.com/equation?tex=F%28%5Comega_%7Bx%7D%29+%3D+%5Cint_%7Bt_%7B0%7D%7D%5E%7Bt_%7B0%7D%2BT%7Df%28t%29e%5E%7B-iw_%7Bx%7Dt%7Ddt++%5C%5C)

因为傅里叶变化令 ![](https://www.zhihu.com/equation?tex=%5Comega+_%7Bx%7D%5Crightarrow0) 从而使一个累加的式子变成了一个积分，而 DFT 中 ![](https://www.zhihu.com/equation?tex=%5Comega+_%7Bx%7D) 会根据输入的信号点数确定具体的值。具体计算公式为：

![](https://www.zhihu.com/equation?tex=%5Comega_%7Bx%7D%3D%5Cfrac%7B2%5Cpi+%5Ccdot+n%7D%7BN%7D+%5C%5C)

(注： ![](https://www.zhihu.com/equation?tex=2%5Cpi) 的计算方式是因为![](https://www.zhihu.com/equation?tex=e%5E%7Bi%5Comega+_%7Bx%7D%7D) 的一个周期是 ![](https://www.zhihu.com/equation?tex=2%5Cpi) ,N 为你采样的点数)

因此我们可以简化公式为

![](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+f%28t%29%26%3D%5Cfrac%7BN%7D%7B2%5Cpi%5Ccdot+T%7D+%5Csum_%7Bn%3D0%7D%5E%7BN%7D%7B%5BF%28n%29%5Ccdot+e%5E%7Bi%5Cfrac%7B2%5Cpi%5Ccdot+n%7D%7BN%7D+t%7D+%5Ccdot+%5Cfrac%7B2%5Cpi%7D%7BN%7D%5D%7D%5C%5C%26%3D+%5Cfrac%7B1%7D%7BT%7D+%5Csum_%7Bn%3D0%7D%5E%7BN%7D%5BF%28n%29%5Ccdot+e%5E%7Bi%5Cfrac%7B2%5Cpi%5Ccdot+n%7D%7BN%7D+t%7D%5D%5Cend%7Balign%7D%5C%5C)

因为标准化的傅里叶变化 ![](https://www.zhihu.com/equation?tex=T%5Cto+N) 有：

![](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+f%28t%29%26%3D%5Csum_%7Bn%3D0%7D%5E%7BN%7D%7B%5B%5Cfrac%7B1%7D%7BN%7D+%5Ccdot+F%28n%29%5Ccdot+e%5E%7Bi%5Cfrac%7B2%5Cpi%5Ccdot+n%7D%7BN%7D+t%7D%5D%7D%5C%5C++%5Cend%7Balign%7D%5Ctag%7B1%7D)

其中：

![](https://www.zhihu.com/equation?tex=F%28n%29%3D%5Csum_%7Bt%3D0%7D%5E%7BN%7Df%28t%29e%5E%7B-i%5Cfrac%7B2%5Cpi+%5Ccdot+n%7D%7BN%7D+t%7D++%5Ctag%7B2%7D)

其中 (1) 为离散傅里叶逆变换,(2)为离散傅里叶变化。

代码实现：

先定义一个复数的结构体

```
public struct complex//定义复数  
{
    public double real;
    public double imag;

    // 写个函数用于显示
    public void show()
    {
        if (Math.Abs(real) < 0.0001) real = 0;
        if (Math.Abs(imag) < 0.0001) imag = 0;
        if (imag > 0) Debug.Log(string.Format("{0} +{1}i", real, imag));
        else if (imag == 0) Debug.Log(string.Format("{0}", real));
        else Debug.Log(string.Format("{0} {1}i", real, imag));
    }
}


```

**注: t 为 f 数组的索引，n 为 F 数组的索引，理清楚了代码很好理解**

计算 DFT, 即已知一个 float 数组求频谱

```
public static complex[] calDFT(double[] f)  //(信号，信号长度)   
{
    int N = f.Length;
    complex[] F = new complex[N];
    for (int n = 0; n < N; n++)
    {
        // 声明
        F[n].real = 0;
        F[n].imag = 0;
        for (int t = 0; t < N; t++)
        {
            // 计算 exp(-i * 2PI * n / N * t)
            complex temp;
            // 欧拉公式 exp(ix) = cos(x) + isin(x)
            temp.real = Math.Cos(-2 * Math.PI / N * t * n) * f[t];
            temp.imag = Math.Sin(-2 * Math.PI / N * t * n) * f[t];

            F[n].real = F[n].real + temp.real;
            F[n].imag = F[n].imag + temp.imag;
        }
    }
    return F;
}


```

计算 IDFT, 即已知一个 float 数组求频谱

```
public static complex[] calIDFT(complex[] F)  //(频谱)   
{
    int N = F.Length;
    complex[] f = new complex[N];
    for (int t = 0; t < N; t++)
    {
        // 声明
        f[t].real = 0;
        f[t].imag = 0;
        for (int n = 0; n < N; n++)
        {
            // 计算 exp(i * 2PI * n / N * t)
            complex temp;
            // 欧拉公式 exp(ix) = cos(x) + isin(x)
            double real = Math.Cos(2 * Math.PI * n / N * t);
            double imag = Math.Sin(2 * Math.PI * n / N * t);
            // 复数乘法
            temp.real = F[n].real * real - F[n].imag * imag;
            temp.imag = F[n].real * imag + F[n].imag * real;

            f[t].real = f[t].real + temp.real;
            f[t].imag = f[t].imag + temp.imag;
        }
        f[t].real = f[t].real / N;
        f[t].imag = f[t].imag / N;
    }
    return f;
}


```

随便输入一个 float 的数组做一下实验

```
double[] signal = new double[] { 14,12,10,8,6,10};
Debug.Log("----------计算离散傅里叶变化-------------");
var rate = calDFT(signal);
foreach (var item in rate)
{
    item.show();
}
Debug.Log("----------计算反离散傅里叶变化------------");
var irate = calIDFT(rate);
foreach (var item in irate)
{
    item.show();
}


```

结果如下：

![](https://pic3.zhimg.com/v2-fce1a4ae686163b366835852ea94dabe_b.jpg)

学过线性代数的会觉得有点像是 某个 维数很高的向量乘以 一个对应的矩阵，然后在乘以一个逆矩阵... 转回来的过程。

我们记 ![](https://www.zhihu.com/equation?tex=W_%7Bt%7D%5E%7Bn%7D%3De%5E%7B-i%5Cfrac%7B2%5Cpi%5Ccdot+n%7D%7BN%7D+t%7D%5C%5C)

得到 DFT 的矩阵：![](https://www.zhihu.com/equation?tex=%5Cbegin%7Bbmatrix%7D+f%281%29%5C%5C+f%282%29%5C%5C+f%283%29%5C%5C.%5C%5C.%5C%5Cf%28N%29+%5Cend%7Bbmatrix%7D%5Cbegin%7Bbmatrix%7D+W_%7B1%7D%5E%7B1%7D+%26W_%7B2%7D%5E%7B1%7D+%26.%26.%26.%26W_%7BN%7D%5E%7B1%7D+%5C%5C+W_%7B1%7D%5E%7B2%7D+%26W_%7B2%7D%5E%7B2%7D+%26.%26.%26.%26W_%7BN%7D%5E%7B2%7D++%5C%5C+.%26.%26.%26.%26.%26.%5C%5C+.%26.%26.%26.%26.%26.%5C%5CW_%7B1%7D%5E%7BN%7D+%26W_%7B2%7D%5E%7BN%7D+%26.%26.%26.%26W_%7BN%7D%5E%7BN%7D++%5C%5C+%5Cend%7Bbmatrix%7D%3D+%5Cbegin%7Bbmatrix%7D+F%281%29%5C%5C+F%282%29%5C%5C+F%283%29%5C%5C.%5C%5C.%5C%5CF%28N%29+%5Cend%7Bbmatrix%7D%5C%5C)

以及 IDFT 的矩阵：

![](https://www.zhihu.com/equation?tex=%5Cfrac%7B1%7D%7BN%7D%5Cbegin%7Bbmatrix%7D+F%281%29%5C%5C+F%282%29%5C%5C+F%283%29%5C%5C.%5C%5C.%5C%5CF%28N%29+%5Cend%7Bbmatrix%7D%5Cbegin%7Bbmatrix%7D+W_%7B1%7D%5E%7B-1%7D+%26W_%7B1%7D%5E%7B-2%7D+%26.%26.%26.%26W_%7B1%7D%5E%7B-N%7D+%5C%5C+W_%7B2%7D%5E%7B-1%7D+%26W_%7B2%7D%5E%7B-2%7D+%26.%26.%26.%26W_%7B2%7D%5E%7B-N%7D++%5C%5C+.%26.%26.%26.%26.%26.%5C%5C+.%26.%26.%26.%26.%26.%5C%5CW_%7BN%7D%5E%7B-1%7D+%26W_%7BN%7D%5E%7B-2%7D+%26.%26.%26.%26W_%7BN%7D%5E%7B-N%7D++%5C%5C+%5Cend%7Bbmatrix%7D%3D+%5Cbegin%7Bbmatrix%7D+f%281%29%5C%5C+f%282%29%5C%5C+f%283%29%5C%5C.%5C%5C.%5C%5Cf%28N%29+%5Cend%7Bbmatrix%7D%5C%5C)