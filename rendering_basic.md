---
tag: cg/graphics_api
---

## Coordinate
### 3d render basic
#### 坐标空间变换
	![[coordinate_transform.png]]
	(Vertex Shader) => Clip Space => (透视除法) => NDC => (视口变换>>是指将内容映射到窗口的哪个位置) => Window Space => (Fragment Shader)
	[opengl projection deduce](http://www.songho.ca/opengl/gl_projectionmatrix.html)
	right hand coordinate system(opengl)
	![[right_hand_coordinate.png]]
	 perspective projection:
	 ![[rc/projection_matrix.png]]
	glm perspective matrix for opengl depth[-1,1], $n, f$ 正数, $r,l,t,d$ 中包含负数. 一般r+l=0, t+d=0.
	注意glm中矩阵按列存储, 赋值时有点不直观.
	$$
	\begin{bmatrix}
\frac{2n}{r-l} & 0 & \frac{r+l}{r-l} & 0 \\
0 & \frac{2n}{t-b} & \frac{t+b}{t-b} & 0 \\
0 & 0 & -\frac{f+n}{f-n} & -\frac{2fn}{f-n} \\
0 & 0 & -1 & 0\end{bmatrix}
	$$
	for vulkan depth \[0, 1\]:
		$$
	\begin{bmatrix}
\frac{2n}{r-l} & 0 & \frac{r+l}{r-l} & 0 \\
0 & \frac{2n}{t-b} & \frac{t+b}{t-b} & 0 \\
0 & 0 & -\frac{f}{f-n} & -\frac{fn}{f-n} \\
0 & 0 & -1 & 0\end{bmatrix}
	$$
 ① 这里 $\frac{2n}{r-l}$, 是相机张角的tan值, 即斜率k. __在透视投影时, 在近平面上的投影值只与斜率相关__.
 ② 在view坐标系下z是负数, 因此第四行设置为[0, 0, -1, 0]
 ③ 第三行, 通过两个点[0,0, -f, 1], [0,0,-n,1]进行求取
 
 orthogonal projection:
$$
	\begin{bmatrix}
\frac{2}{r-l} & 0 & 0& -\frac{r+l}{r-l}  \\
0 & \frac{2}{t-b} & 0 & -\frac{t+b}{t-b}  \\
0 & 0 & -\frac{2}{f-n} & -\frac{f+n}{f-n} \\
0 & 0 & 0 & 1\end{bmatrix}
	$$
 for vulkan depth [0, 1] :	 		$$
	\begin{bmatrix}
\frac{2}{r-l} & 0 & 0& -\frac{r+l}{r-l}  \\
0 & \frac{2}{t-b} & 0 & -\frac{t+b}{t-b}  \\
0 & 0 & -\frac{1}{f-n} & -\frac{n}{f-n} \\
0 & 0 & 0 & 1\end{bmatrix}
	$$
 x,y, z值, 直接归一化: 减去中心点, 除以range

#### Pin hole camera
![[pin_hole_camera.png]]
参考: [The Pinhole Camera Matrix](https://staff.fnwi.uva.nl/r.vandenboomgaard/IPCV20162017/LectureNotes/CV/PinholeCamera/PinholeCamera.html)
![[rc/pin_hole_camera_proj.png]]

$$
\begin{bmatrix}
x\\
y\\
1\\
\end{bmatrix} \sim
\begin{bmatrix}
f & 0 & 0 & 0\\
0 & f & 0 & 0\\
0 & 0 & 1 & 0
\end{bmatrix} \cdot \begin{bmatrix}
X\\
Y\\
Z\\
1\\
\end{bmatrix}
$$

转换到像素坐标系下: $f_x = s_x f, f_y = s_y f$
$$
\begin{bmatrix}
x\\
y\\
1\\
\end{bmatrix} \sim
\begin{bmatrix}
f_x & 0 & c_x & 0\\
0 & f_y & c_y & 0\\
0 & 0 & 1 & 0
\end{bmatrix} \cdot \begin{bmatrix}
X\\
Y\\
Z\\
1\\
\end{bmatrix}
$$

针孔相机投影矩阵与perspective matrix for graphics原理是一样的. 针孔相机投影, 齐次坐标归一化后得到的是像素坐标, 而graphics api投影后得到的是clip坐标系下坐标, 归一化后得到的是NDC坐标.

__cv中的相机, 与Graphics API中的相机都是右手坐标系
但是, y,z轴朝向相反(像素坐标系y朝下, 而view/NDC坐标系y朝上).__
vulkan默认y向下, 但一般会对齐进行flip. 通过设置view port, y值为负值的方式.

给定针孔相机投影矩阵+照片w,h, 对应的graphics api中, 投影和view transform:
首先, graphics api的相机与针孔相机对齐, 而后再沿着自己的x轴旋转180度(此时graphics api相机与cv相机视角一致). 原投影矩阵变为:
$$
\begin{bmatrix}
f_x & 0 & -c_x\\
0 & -f_y & -c_y\\
0 & 0 & -1
\end{bmatrix} \cdot \begin{bmatrix}
X\\
-Y\\
-Z\\
\end{bmatrix}
$$
将x从[0, w]变换到[-1, 1], 将y从[0, h]变换为[1, -1].
cv相机在原点, z向前, y朝下<-->graphics api相机在原点, y朝上, z朝向后.
$$
\begin{bmatrix}
\frac{2f_x}{w} & 0 & -\frac{2c_x}{w} - 1 & 0\\
0 & \frac{2f_y}{h} & \frac{2c_y}{h} + 1 & 0\\
0 & 0 & A & B\\
0 & 0 & -1 & 0
\end{bmatrix}
$$

#### [graphics pipeline detail](Excalidraw/pipeline_overview)

### Coordinate of different graphics API


### obj file uv coordinate

uv (0,0) is in the left bottom.

```obj file
mtllib material.mtl
usemtl material_0

v 0 0 0
v 0 1 0
v 1 0 0
vt 0 0
vt 0 1
vt 1 0
f 1/1 2/2 3/3
```
![[obj_tri.png]]


### graphics api coordinate

refer to: https://github.com/gpuweb/gpuweb/issues/416

|    | NDC | Frame Buffer  | Texture Sampling | Texture Upload |
|  ----  | ----  | ---- | ---- | ---- |
| OpenGL  | +Y Up <br>bottom left=(-1,-1) <br>near2far=(-1, 1) | +Y Up <br>bottom left=(0,0) | +Y Up <br>bottom left=(0,0) | +Y Up <br>bottom left=(0,0) |
| Metal/D3D12  | +Y Up <br>bottom left=(-1,-1)<br>near2far=(0, 1)| +Y Down <br>top left=(0,0) | +Y Down <br>top left=(0,0) | +Y Down <br>top left=(0,0) |
| Vulkan | +Y Down <br>top left=(-1, -1)<br>near2far=(0,1) | +Y Down<br>top left=(0,0) | +Y Down<br>top left=(0,0) | +Y Down <br>top left=(0,0) |

__上传(Texture)和下载(从Frame Buffer)的第一个像素均为(0,0)坐标的像素点.__

texture memory:
opengl 
