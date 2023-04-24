---
tag: programming_language/python
---
## CUDA/cudnn/CUDA Toolkit/NVCC区别简介
refer to: [nvidia-gpu-stuff.md](nvidia-gpu-stuff.md)
* CUDA：为“GPU通用计算”构建的运算平台。
* CUDNN：为深度学习计算设计的软件库。
* CUDA Toolkit (nvidia)： CUDA完整的工具安装包，其中提供了 Nvidia 驱动程序、开发 CUDA 程序相关的开发工具包等可供安装的选项。包括 CUDA 程序的编译器、IDE、调试器等，CUDA 程序所对应的各式库文件以及它们的头文件.
* CUDA Toolkit (Pytorch)： CUDA不完整的工具安装包，其主要包含在使用 CUDA 相关的功能时所依赖的动态链接库。不会安装驱动程序。（NVCC 是CUDA的编译器，只是 CUDA Toolkit 中的一部分）。 可通过Anaconda安装.


## 注意事项

1. **tensors** **are mutable** **objects** therefore they are changeable **in-place**
	以下操作会改变函数外部tensor的值
	```python
	def func(tensor_a):
		tensor_a = 0
	```
	In programming, you have an **immutable object** if you can’t change the object’s [state](https://en.wikipedia.org/wiki/State_(computer_science)) after you’ve created it. In contrast, a **mutable object**allows you to modify its internal state after creation.
	
	 Objects of built-in type that are mutable are(containers):
	- Lists
	- Sets
	- Dictionaries
	- User-Defined Classes (It purely depends upon the user to define the characteristics)
	Objects of built-in type that are immutable are:
	- Numbers (Integer, Rational, Float, Decimal, Complex & Booleans)
	- Strings
	- Tuples
	- Frozen Sets
	- User-Defined Classes (It purely depends upon the user to define the characteristics)
	
	一般情况下, 自己定义的python object 都是mutable object, 除非通过`__setattr__`
	这种函数主动阻止其赋值.

## Reference
[一文讲清楚CUDA、CUDA toolkit、CUDNN、NVCC关系](https://blog.csdn.net/qq_41094058/article/details/116207333)
[Python's Mutable vs Immutable Types](https://realpython.com/python-mutable-vs-immutable-types/)