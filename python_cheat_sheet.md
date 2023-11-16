---
tag: programming
---
## Cheat Sheet

int to string

```python
a = 10
str(a).zfill(5)
```

for tqdm
```python
for i in tqdm(range(10)):
	print(i)
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

## matplotlib

```python
def plot_values(values, title, save_path):
    fig = plt.figure()
    ax = fig.add_subplot()
    ax.plot(values)
    ax.set_title(title)
    plt.savefig(save_path, dpi=300)
    plt.close()


def visualize_points(fp, img, in_points_np):
    '''
        inpoints has shape of 'N*3',
        where N is the points number
    '''
    fig = plt.figure()
    ax = fig.add_subplot()
    img = img[:,:,::-1]
    #ax.imshow(img/255)
    ax.scatter(in_points_np[:, 0], img.shape[1] - in_points_np[:, 1])
    for i in range(in_points_np.shape[0]):
        ax.text(in_points_np[i,0], img.shape[1] - in_points_np[i,1], str(i), color='red')
	plt.xlim([0, width])
	plt.ylim([height 0]) # flip y axis
	ax = plt.gca()
	ax.set_aspect('equal', adjustable='box')
    #plt.savefig(fp)
    plt.close()

def vis_3dpoints(points, color):
	
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

# texture map from file
texture_map = torch.from_numpy(imageio.v3.imread(args.image).astype(np.float32)/255)

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

```python
# s[i] X[i] R[i] + T[i] = Y[i]
Rt_3ddfa2hifi3d = corresponding_points_alignment(torch.from_numpy(pts_3ddfa), torch.from_numpy(pts_hifi3d), estimate_scale=True)

#debug
Rts_3ddfa2hifi3d_pth = Transform3d().scale(Rts_3ddfa2hifi3d.s).rotate(Rts_3ddfa2hifi3d.R).translate(Rts_3ddfa2hifi3d.T)
dbg_pts = Rts_3ddfa2hifi3d_pth.transform_points(torch.from_numpy(pts_3ddfa)[None, :])
np.savetxt('aligned_pts.txt', dbg_pts[0].numpy())
```

## Open3d

point cloud to pcd

```python

```

## google drive download

```bash
pip install gdown
```

需要下载的链接: `https://drive.google.com/file/d/1jUB5yD7DP97-EqqU2A9mmr61JpNwZBVK/view`, 这里标志符为:`1jUB5yD7DP97-EqqU2A9mmr61JpNwZBVK`.

```bash
gdown https://drive.google.com/uc?id=标识符
```


对于大文件可能会出错, 使用如下方式下载:
```python
gdown.download(
    "https://drive.google.com/uc?export=download&confirm=pbef&id=1ghvzYXdmiCuX5I757id73jWuRLMCzXAX",
    "ckpt/00000189-checkpoint.pth.tar"
)
```

对于带有`confirm=t`的文件, 可以使用(curl支持断点续传):
```bash
curl -L -o data/my-file.h5 'https://drive.google.com/uc?id=my-file-id-here&confirm=t
```

## colab debug

```python
!pip install ipdb

# in python file
## refere to https://xmfbit.github.io/2017/08/21/debugging-with-ipdb/
ipdb.set_trace()
```