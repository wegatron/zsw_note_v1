## Coordinate
### 3d render basic
1. 坐标空间变换
	![[coordinate_transform.png]]
	(Vertex Shader) => Clip Space => (透视除法) => NDC => (视口变换>>是指将内容映射到窗口的哪个位置) => Window Space => (Fragment Shader)
	[opengl projection deduce](http://www.songho.ca/opengl/gl_projectionmatrix.html)
	right hand coordinate system(opengl)
	![[right_hand_coordinate.png]]
	 projection matrix:
	 ![[projection_matrix.png]]
	glm perspective matrix for opengl depth[-1,1], $n, f$ is positive.
	$$
	\begin{bmatrix}
\frac{2n}{r-l} & 0 & 0 & 0 \\
0 & \frac{2n}{t-b} & 0 & 0 \\
\frac{r+l}{r-l} & \frac{t+b}{t-b} & -\frac{f+n}{f-n} & -1 \\
0 & 0 & -\frac{2fn}{f-n} & 0\end{bmatrix}
	$$
 2. graphics pipeline detail
	 scissor testing, refer to vulkan programming language:ch7, ch10. 
![[rc/render_pipeline_detail.png]]



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
