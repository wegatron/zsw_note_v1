---
tag: tools
---
## 视角切换

通过左侧栏, 设置cursor location, `view` -> `align view` -> `center view to cursor` 设置视角中心.

通过小键盘进行控制: 46, 82. 上下左右, ctrl按住为平移, + 缩放视角.


## 快捷键
* `HOME` 将视角移动到场景中心
* `CTRL` + `H` hook
* `CRTL` + `G` group
* `F3` search command
* z 切换 renderd, wireframe, material view


## Camera

refer to: 
[blender camera](https://docs.blender.org/manual/en/latest/render/cameras.html)
[perspective projection](rendering_basic)

成像平面默认宽度: 36mm. 可以在Camera->camera中进行设置(可以fit horizontal, vertical).

投影到成像平面($f$是focal length):
$$
\begin{bmatrix}
f & 0 & 0\\
0 & f & 0\\
0 & 0 & 1
\end{bmatrix}
$$
投影到像素坐标系(sensor fit horizontal):
$$
\begin{bmatrix}
\frac{focal\_length \cdot res\_x}{sensor\_width} & 0 & 0.5*res\_x\\
0 & \frac{focal\_length \cdot res\_x}{sensor\_width} & 0.5*res\_y\\
0 & 0 & -1\\
\end{bmatrix}
$$

可以通过Focal Length/Field of View来调整相机透视投影相互之间的关系: $\tan(0.5fov) =\frac{0.5sensor\_size}{foca\_length}$

对应的投影矩阵:
$$
\begin{bmatrix}
\frac{f \cdot res_x}{9} & 0 & 0 & 0\\
0 & \frac{f \cdot res_y}{9} & 0 & 0\\
0 & 0 & -\frac{far}{far-near} & -\frac{far \cdot near}{far - near}\\
0 & 0 & -1 & 0\\
\end{bmatrix}
$$
## render output

blender 渲染相关设置
![[rc/blender_render_config.png|500]]

渲染输出的设置:
![](rc/blender_render_output.png)


## Blender python
### python console
![[blender_python_console.png]]

## Template Code
根据id选择顶点:
```python
import bpy
import bmesh
import numpy as np

index = 0 # here the index you want select please change 

obj = bpy.context.object
me = obj.data
bm = bmesh.from_edit_mesh(me)

lm_bfm = np.loadtxt('/home/wegatron/win-data/workspace/MeInGame/data/mesh/mine/lm.txt', dtype=np.int)[:,0]

for v in bm.verts:
    v.select = False
    
for ind in lm_bfm:
    bm.verts[ind].select = True

# update highlight the selected vertex
bmesh.update_edit_mesh(me)    
```

打印所有选中的顶点信息:
```python
import bpy
import bmesh
import numpy as np

ids = []
obj=bpy.context.object
if obj.mode == 'EDIT':
    bm=bmesh.from_edit_mesh(obj.data)
    for v in bm.verts:
        if v.select:
            ids.append(v.index)
    ids_n = np.array(ids, dtype=int)
    np.save('right_eye_mask_ids.npy', ids_n)
else:
    print("Object is not in edit mode.")
```
所有选中的face
```python
import bpy
import bmesh
import numpy as np

f_ids = []
obj=bpy.context.object
if obj.mode == 'EDIT':
    bm=bmesh.from_edit_mesh(obj.data)
    for f in bm.faces:
	    if f.select:
		    f_ids.append(f.index)
	f_ids_n = np.array(f_ids, dtype=int)
    np.save('removed_face_ids.npy', f_ids_n)
else:
    print("Object is not in edit mode.")
```

材质的link修改:
```python
mat_node_trees = bpy.data.meshes['bk_mesh'].materials['blinn1SG.001'].node_tree

mat_node_trees.links.new(mat_node_trees.node[''].outputs[0], mat_node_trees.node[].inputs[0])
```

## vscode blender plugin

`Ctrl` + `Shift` + `P`, `blender start` 而后可以用 `blender run script`执行一个脚本文件.

### python editor
相同的地方, 选择`Text Editor`, 可以进行python脚本编辑.

## Blender显示选中index
先开启`develop extras`: _Edit_ > Preferences > Interface > Display > Develop Extras
![[blender_show_index.png]]

## Blender install plugin
`Edit` -> `Preference` -> `Add ons`

Blender python install package
```python
import pip
pip.main(['install', 'tqdm', '--user'])
```
```

