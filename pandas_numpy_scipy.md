---
tag: programming_language/python
---
# Numpy Pandas Scipy
数据分析绝对绕不过的三个包是numpy、scipy和pandas。numpy是Python的数值计算扩展，专门用来处理矩阵，它的运算效率比列表更高效。scipy是基于numpy的科学计算包，包括统计、线性代数等工具。pandas是基于numpy的数据分析工具，能更方便的操作大型数据集。

## Numpy
numpy的数据结构是__n维__的数组，叫做ndarray。Python的list虽然也能表示，但是不高效，随着列表数据的增加，效率会降低。Numpy这个包主要提供了 __基础的数据结构__ `ndarray`, Pandas和Scipy都基于此. 当然也提供了一些基础运算: `ufunc`, `reshape`, `sort`, 一些基本的线性代数操作`Linear algebra (numpy.linalg)`等. 功能Refere to [numpy reference](https://docs.scipy.org/doc/numpy/reference/index.html).

__numpy__ 类比于C++中的Eigen, 包括构造, 访问, 等操作. 可以构建固定值的ndarray, 也可以以list作为输出参数构建. 类比于matlab的mat.

1. 基础的数据类型有哪些
    基础类型为ndarray
2. 以及围绕该基础类型的数据操作(基础运算和基本的线性代数操作)有哪些?
    去重, 排序, 取子集, 对整个数组进行数学操作(如sin, +x等)
    线性代数: 求eigen值, 求解$Ax=b$
3. 在Pandas和Scipy中如何使用这些操作?

## Scipy
__scipy__ 是一个基于numpy的数学算法库.
> SciPy is a collection of mathematical algorithms and convenience functions built on the NumPy extension of Python.

scipy refere to [scipy reference](https://docs.scipy.org/doc/scipy/reference/tutorial/general.html)

主要包含的算法包:
| Subpackage | Description |
| ---------- | ----------- |
| [cluster](https://docs.scipy.org/doc/scipy/reference/cluster.html#module-scipy.cluster) | Clustering algorithms |
| [constants](https://docs.scipy.org/doc/scipy/reference/constants.html#module-scipy.constants) | Physical and mathematical constants |
| [fftpack](https://docs.scipy.org/doc/scipy/reference/fftpack.html#module-scipy.fftpack) | Fast Fourier Transform routines |
| [integrate](https://docs.scipy.org/doc/scipy/reference/integrate.html#module-scipy.integrate) | Integration and ordinary differential equation solvers |
| [interpolate](https://docs.scipy.org/doc/scipy/reference/integrate.html#module-scipy.integrate) | Interpolation and smoothing splines |
| [io](https://docs.scipy.org/doc/scipy/reference/io.html#module-scipy.io) | Input and output |
| [linalg](https://docs.scipy.org/doc/scipy/reference/linalg.html#module-scipy.linalg) | Linear algebra |
| [ndimage](https://docs.scipy.org/doc/scipy/reference/ndimage.html#module-scipy.ndimage) | N-dimensional image processing |
| [odr](https://docs.scipy.org/doc/scipy/reference/odr.html#module-scipy.odr) | Orthogonal distance regression |
| [optimize](https://docs.scipy.org/doc/scipy/reference/optimize.html#module-scipy.optimize) | Optimization and root-finding routines |
| [signal](https://docs.scipy.org/doc/scipy/reference/signal.html#module-scipy.signal) | Signal processing |
| [sparse](https://docs.scipy.org/doc/scipy/reference/sparse.html#module-scipy.sparse) | Sparse matrix and associated routines |
| [spatial](https://docs.scipy.org/doc/scipy/reference/spatial.html#module-scipy.spatial) | Spatial structure and algorithms |
| [special](https://docs.scipy.org/doc/scipy/reference/special.html#module-scipy.special) | Special functions |
| [stats](https://docs.scipy.org/doc/scipy/reference/stats.html#module-scipy.stats) | Statistial distrubution and functions |


## pandas
pandas是一个更常用的包，在抽象概念上它更接近我们熟悉的excel和sql. 通过pandas可以对数据进行indexing, merge, join, group, visualization, 相当于sql的一些操作. pandas有两个主要的数据结构，Series和DataFrame.
以直观地方式, 处理有结构的数据.
>pandas is a Python package providing fast, flexible, and expressive data structures designed to make working with “relational” or “labeled” data both easy and intuitive.

数据分析和管理.
> goal of becoming the most powerful and flexible open source data analysis / manipulation tool available in any language. 

`Series`与ndarray不同的是它有一个索引, 索引的概念有点像SQL的主键，不过它的功能更强大，分析师能够很轻松的通过索引选取一个数据或者一组数据. Series对应DataFrame中的一行.
```python
s = pd.Series(array_data, name=['a', 'b', 'c', 'd'])
s[['a', 'c']] # s是Series
```

`DataFrame`是一个表格型的数据结构，它含有不同的列，每列都是不同的数据类型. 可以把DataFrame看作Series组成的字典，它既有行索引也有列索引。想象得更明白一点，它类似一张excel表格或者SQL，只是功能更强大。
pandas refere to [pandas reference](https://pandas.pydata.org/pandas-docs/stable/reference/frame.html).

## 常用样例代码
Numpy:
```python
# zeros(shape[, dtype, order])
# ones, eye, identity, ...
# order in 'C' C style row major, or 'F' Fortran style column major
np.zeros([3,4], dtype=np.float, order='C')

# construct from array
# array(object[, dtype, copy, order, subok, ndmin])
a = [1,2,3,4]
p = np.array(a, dtype=np.float)
# data type
print(np.dtype(p[0]))

# ndarray to matrix
mat_p = np.asmatrix(p)

# matrix transpose
mat_p.transpose()

# matrix multiply
mat_res = np.matmul(mat_p, mat_q)

# visualize matrix or ndarray
plt.imshow(mat_res, vmin=0.0, vmax=0.3, cmap='jet')
plt.colorbar()
plt.show()

# eigen
from numpy import linalg as LA
w, v = LA.eigh(A)

# read matrix data
def read_dump_mat(file_path):
    f = open(file_path, 'r')
    head_strs = f.readline().split()
    row = int(head_strs[0])
    col = int(head_strs[1])
    #cnd = int(head_strs[2])

    mat = np.empty((row, col))

    print('read {}, rows={} cols={}'.format(file_path, row, col))

    for r in range(row):
        line_strs = f.readline().split()
        assert(len(line_strs) == col)
        for c in range(col):
            mat[r, c] = float(line_strs[c])
    return mat
```

Pandas:
```python
immport pandas as pd
# header 用第几行来充当表头的, None表示不用任何行
# index_col 用第几列来充当列标签, None表示不用任何列
pd_frame = pd.read_csv([file_path], header=[int], index_col=[int])

pd_frame = pd.dataFrame(2d_array_data, column=['a', 'b', 'c'], index=[array] )

# s 是Series
pd_frame = pd_frame.append(s)

# 查看头尾
pd_frame.head(n)
pd_frame.tail(n)

# pandas 选取指定列
# series.loc[row_indexer]
# pd_frame.loc[row_indexer, column_indexer]
# 以 : 表示全选
# 还可以使用iloc来进行index range
```

```python
from matplotlib import pyplot as plt
plt.imshow(data, interpolation='nearest') # data is wxhx3, data type float (0,1)
plt.show()
```

## Reference
[numpy和pandas入门](https://zhuanlan.zhihu.com/p/27624814)
[numpy reference](https://docs.scipy.org/doc/numpy/reference/index.html)
[pandas reference](https://pandas.pydata.org/pandas-docs/stable/reference/frame.html)
[一个不错的数据分析师的博客, 介绍了numpy pandas等](https://ask.hellobi.com/blog/wangdawei/9160)