---
tag: tools
---

# VTK File Format
## 自定义颜色的vtk文件样例
* 在Paraview中元素的着色要么依靠color map, 要么依靠lookup table. 为了给每个点着上特定的颜色, 自建了一个lookup table, 并指定每个点所对应的index.
```vtk
# vtk DataFile Version 4.2
zsw points
ASCII
DATASET UNSTRUCTURED_GRID
POINTS 10 float
9.63 8.67  8.9
8.67 9.63  8.9
9.63 9.63  8.9
8.67 8.67  9.7
9.63 8.67  9.7
8.67 9.63  9.7
9.63 9.63  9.7
9.63 8.67 10.5
8.67 9.63 10.5
9.63 9.63 10.5
CELLS 10 20
1 0
1 1
1 2
1 3
1 4
1 5
1 6
1 7
1 8
1 9
CELL_TYPES 10
1
1
1
1
1
1
1
1
1
1
POINT_DATA 10
SCALARS volume_scalars float 4
LOOKUP_TABLE default
1 0 0 1.0
1 0 0 1.0
1 0 0 1.0
1 0 0 1.0
1 0 0 1.0
1 0 0 1.0
1 0 0 1.0
1 0 0 1.0
1 0 0 1.0
1 0 0 1.0
```
* 对于一些其他属性, 可以使用color map做可视化
```vtk
# vtk DataFile Version 4.2
zsw points
ASCII
DATASET UNSTRUCTURED_GRID
POINTS 10 float
2.91 4.71  1.5
2.97 4.71  1.5
2.91 4.77  1.5
2.97 4.77  1.5
14.43  4.11   1.5
14.49  4.11   1.5
14.43  4.17   1.5
14.49  4.17   1.5
14.55  4.17   1.5
14.43  4.23   1.5
CELLS 10 20
1 0
1 1
1 2
1 3
1 4
1 5
1 6
1 7
1 8
1 9
CELL_TYPES 10
1
1
1
1
1
1
1
1
1
1
POINT_DATA 10
COLOR_SCALARS val 1
1
1
1
1
1
1
1
1
2
1
```

* volume data file


# Paraview Data Visualization
## paraview 点云列表文件
文件样例
```txt
x y z attr
0 0 0 0.5
1 0 0 0.5
1 1 0 0.1
0 1 0 0.2
0 0 1 0.5
1 0 1 0.5
1 1 1 0.1
0 1 1 0.2
```
* reading your data into ParaView. ParaView can read in delimited text files
* In the properties panel after you have opened the file, change the `Field Delimiter Characters` from a comma to a space. Also, check the box next to `Merge Consecutive Delimiters`.
* `Table To Points` or `Table To Structured Grid`

> reference: https://stackoverflow.com/questions/40510129/how-do-i-visualize-xyzfield-volume-data-stored-in-a-simple-table-in-paraview

## paraview 绘制LIDAR数据
可以使用`Eye-Dome Lighting`插件, 或者将点云设置成半透明显示. 
>reference: https://blog.kitware.com/point-and-smoothed-particle-hydrodynamics-sph-interpolation-in-paraview/

## paraview volumn rendering
![Image of paraview volume rendering](paraview_volume_rendering.png)
对于`STRUCTURED_POINTS`, `STRUCTURED_GRID`, `Rectilinear Grid`等带有结构的拓扑上的属性值可以进行volume rendering(volume rendering 需要插值). `STRUCTURED_POINTS`例子:
```vtk
# vtk DataFile Version 2.0
Volume example
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS 3 4 2
ASPECT_RATIO 1 1 1
ORIGIN 0 0 0
POINT_DATA 24
SCALARS volume_scalars float 1
LOOKUP_TABLE default
0
1
2
0
1
2
0
1
2
0
1
2
0
1
2
0
1
2
0
1
2
0
1
2
```
## paraview vector field rendering
![Image of paraview vector field rendering](paraview_vectorfield.png)
若属性是一个3d向量, 则可用paraview进行vector field的可视化. 使用`Glyph Filter`生成可视化的向量场.
example file:
```vtk
# vtk DataFile Version 2.0
Volume example
ASCII
DATASET STRUCTURED_POINTS
DIMENSIONS 3 4 2
ASPECT_RATIO 1 1 1
ORIGIN 0 0 0
POINT_DATA 24
SCALARS volume_scalars float 3
LOOKUP_TABLE default
0 1 2
1 1 2
2 1 2
0 2 2
1 2 2
2 2 2
0 3 2
1 3 2
2 3 2
0 4 2
1 4 2
2 4 2
0 1 3
1 1 3
2 1 3
0 2 3
1 2 3
2 2 3
0 3 3
1 3 3
2 3 3
0 4 3
1 4 3
2 4 3
```
1. load the vtk file
2. open `Glyph Filter`, Vectors select `volume_scalars`, apply

reference: http://www.bu.edu/tech/support/research/training-consulting/online-tutorials/paraview/#GLYPHS

向量场的可视化
Display points and normals from a plain text (x y z nx ny nz) file
Load the CSV data, use a TableToPoints filter
Use a Calculator filter to combine the last three fields to a vector (operation: "(iHat*Field 3)+(jHat*Field 4)+(kHat*Field 5)")
Apply a Glyph filter with Glyph type Arrow

## Paraview 显示图片

加载完成之后, 在Display->Map Scalars 取消勾选.
