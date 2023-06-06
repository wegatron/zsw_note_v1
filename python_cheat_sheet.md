---
tag: programming_language/python
---
## Cheat Sheet

int to string

```python
a = 10
str(a).zfill(5)
```

## 图像视频

```python
import opencv2 as cv
```

## Tensor

删除维度
```
a.squeeze()
```

tensor to numpy array
```
a = np.asarray(a.cpu())

import matplotlib.pyplot as plt
plt.plot(a)
plt.show()
```

tensor to image
```
torchvision.utils.save_image(uv_pverts_zsw, '/home/wegatron/tmp/tmpz.jpg')
```

## Numpy

numpy write to csv

```python
import numpy
a = numpy.asarray([ [1,2,3], [4,5,6], [7,8,9] ])
numpy.savetxt("foo.csv", a, delimiter=",")
```

numpy reshape
```python
import numpy as np
a = np.random((100), dtype=int)
np.reshape((20,5), order='C') # 按照C语言的标准进行解析.
np.reshape(-1, 5) #-1处的值会自动计算
```

numpy stack, 将shape相同的array叠起来, 变化后维度+1
```
np.stack([a,b], axis=0) # 横向叠
np.stack([a,b], axis=1) # 竖向叠

a = np.array([1, 2, 3])
b = np.array([4, 5, 6])
np.stack((a, b))
array([[1, 2, 3],
       [4, 5, 6]])

np.stack((a, b), axis=-1)
array([[1, 4],
       [2, 5],
       [3, 6]])
```

numpy concatenate, 根据某个维度, 连起来. 变化后维度数量不变
```
#a=mx3 , b=nx3 
np.concatenate([a,b], axis=0) # (m+n)x3
```

numpy matrix operation

```python
A_inv = np.linalg.inv(A)
# - If the second argument is 1-D, it is promoted to a matrix by appending a 1 to its dimensions. After matrix multiplication the appended 1 is removed.
C = np.matmul(A, B) # C = A X B
```

pytorch matrix mul
```python
C = torch.matmul(A, B)
```

numpy add dimension

```python
x = np.random.rand(10, 10)
y = np.expand_dims(x, axis=0)
```

numpy switch channels

```
np.random.rand(2,3,5)
np.transpose(2,0,1)
```

pytorch switch channels:
```python
x = torch.randn(2, 3, 5) 
y = x.permute(2,0,1)
```


## Open3d

point cloud to pcd

```python

```