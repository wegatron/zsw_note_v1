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

## Numpy & Pytorch

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

numpy switch matrix

```
np.random.rand(2,3,5)
np.transpose(2,0,1)
```

pytorch switch matrix:
```python
x = torch.randn(2, 3, 5) 
y = x.permute(2,0,1)
```

numpy bgr to rgb

```python
img_rgb = img_bgr[:, :, ::-1]
```


## pytorch3d

load & save obj:
```python
from pytorch3d.io import (
    load_obj,
    load_ply,
    load_objs_as_meshes,
    save_obj,
    save_ply
)

# only support one material
verts, faces, aux = load_obj('output/ffhq-uv/st/front.obj', load_textures=True, device='cuda')
# verts: nx3 tensor
# faces
#            - verts_idx: LongTensor of vertex indices, shape (F, 3).
#            - normals_idx: (optional) LongTensor of normal indices, shape (F, 3).
#            - textures_idx: (optional) LongTensor of texture indices, shape (F, 3).
# aux:
#            - texture_images dict['name', image tensor]
#            - verts_uvs
# list(aux.texture_images.values())[0].shape

save_obj('debug_output/dbg.obj', verts, faces.verts_idx, verts_uvs=aux.verts_uvs, faces_uvs=faces.textures_idx, texture_map=list(aux.texture_images.values())[0])

# '''
# save_obj(
# f: PathOrStr,
#     verts,
#     faces,
#     decimal_places: Optional[int] = None,
#     path_manager: Optional[PathManager] = None,
#     *,
#     normals: Optional[torch.Tensor] = None,
#     faces_normals_idx: Optional[torch.Tensor] = None,
#     verts_uvs: Optional[torch.Tensor] = None,
#     faces_uvs: Optional[torch.Tensor] = None,
#     texture_map: Optional[torch.Tensor] = None,)
#         normals: FloatTensor of shape (V, 3) giving normals for faces_normals_idx
#             to index into.
#         faces_normals_idx: LongTensor of shape (F, 3) giving the index into
#             normals for each vertex in the face.
#         verts_uvs: FloatTensor of shape (V, 2) giving the uv coordinate per vertex.
#         faces_uvs: LongTensor of shape (F, 3) giving the index into verts_uvs for
#             each vertex in the face.
#         texture_map: FloatTensor of shape (H, W, 3) representing the texture map
#             for the mesh which will be saved as an image. The values are expected
#             to be in the range [0, 1],
# '''
```
## Open3d

point cloud to pcd

```python

```