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

numpy write to csv

```python
import numpy
a = numpy.asarray([ [1,2,3], [4,5,6], [7,8,9] ])
numpy.savetxt("foo.csv", a, delimiter=",")
```

## Open3d

point cloud to pcd

```python

```