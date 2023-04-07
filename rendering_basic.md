### 3d render basic
1. 坐标空间变换
	![[rc/space_transform.png]]
	(Vertex Shader) => Clip Space => (透视除法) => NDC => (视口变换) => Window Space => (Fragment Shader)
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