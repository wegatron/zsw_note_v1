### 3d render basic
1. 坐标空间变换
	![[coordinate_transform.png]]
	(Vertex Shader) => Clip Space => (透视除法) => NDC => (视口变换>>是指将内容映射到窗口的哪个位置) => Window Space => (Fragment Shader)
	[opengl projection deduce](http://www.songho.ca/opengl/gl_projectionmatrix.html)
	right hand coordinate system(opengl)
	![[right_hand_coordinate.png]]
	 perspective projection:
	 ![[projection_matrix.png]]
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
 ① 这里 $\frac{2n}{r-l}$, 是相机张角的tan值, 即斜率k. 在透视投影时, 在近平面上的投影只与斜率相关.
 ② 在view 坐标系下z是负数, 因此第四行设置为[0, 0, -1, 0]
 ③ 第三行, 通过两个点[0,0, -f, 1], [0,0,-n,1]进行求取
 
 orthogonal projection:
		$$
	\begin{bmatrix}
\frac{2}{r-l} & 0 & 0& -\frac{r+l}{r-l}  \\
0 & \frac{2}{t-b} & 0 & -\frac{t+b}{t-b}  \\
0 & 0 & -\frac{2}{f-n} & -\frac{f+n}{f-n} \\
0 & 0 & 0 & 1\end{bmatrix}
	$$
 for vulkan depth [0, 1] :
	 		$$
	\begin{bmatrix}
\frac{2}{r-l} & 0 & 0& -\frac{r+l}{r-l}  \\
0 & \frac{2}{t-b} & 0 & -\frac{t+b}{t-b}  \\
0 & 0 & -\frac{1}{f-n} & -\frac{n}{f-n} \\
0 & 0 & 0 & 1\end{bmatrix}
	$$
 x,y, z值, 直接归一化: 减去中心点, 除以range

 2. [graphics pipeline detail](Excalidraw/pipeline_overview)

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

|    | NDC | Frame Buffer  | Texture Sampling | Texture Upload |
|  ----  | ----  | ---- | ---- | ---- |
| OpenGL  | +Y Up <br>bottom left=(-1,-1) <br>near2far=(-1, 1) | +Y Up <br>bottom left=(0,0) | +Y Up <br>bottom left=(0,0) | +Y Up <br>bottom left=(0,0) |
| Metal/D3D12  | +Y Up <br>bottom left=(-1,-1)<br>near2far=(0, 1)| +Y Down <br>top left=(0,0) | +Y Down <br>top left=(0,0) | +Y Down <br>top left=(0,0) |
| Vulkan | +Y Down <br>top left=(-1, -1)<br>near2far=(0,1) | +Y Down<br>top left=(0,0) | +Y Down<br>top left=(0,0) | +Y Down <br>top left=(0,0) |

__上传(Texture)和下载(从Frame Buffer)的第一个像素均为(0,0)坐标的像素点.__

texture memory:
