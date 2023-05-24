---
tag: programming_language/python
---

* pytorch
	
* pytorch3d
	pytorch3d对pytorch和cuda的版本也有一定的要求. 不然可能会[报错](https://blog.csdn.net/qq_34769162/article/details/117772809)
	https://github.com/facebookresearch/pytorch3d/blob/main/INSTALL.md
	从源码安装, 从pip安装大概率会失败
	
* tensorflow
	[Tensorflow gpu cuda version reference](https://tensorflow.google.cn/install/source?hl=en)

* cuda tooklit
	conda install cudatoolkit=11.0 cudnn=8.0 -c anaconda -c conda-forge -c nvidia


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

[Python's Mutable vs Immutable Types](https://realpython.com/python-mutable-vs-immutable-types/)