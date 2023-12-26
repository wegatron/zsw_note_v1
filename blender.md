---
tag: cg/tools
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
* g move
* s scale
* Render region: 在相机视角下 CTRL + B 选择绘制区域
* clear render region: 在需要的视角下 CTRL + ALT + B. 或者在view->view region中进行clear
* ALT + 鼠标中键 将中心定位到鼠标选择点
* edit mode P 可以将选中的face移动到新的mesh中

---

sculpt
* Brush Size F
* Brush Strength Shift + F

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

shapekey操作
```python
shape_keys = bpy.data.objects["CTRL_expressions_neutral"].data.shape_keys
drivers = shape_keys.animation_data.drivers

for dr in drivers:
    drivers.remove(dr)

blocks =  shape_keys.key_blocks
for i in range(1, len(lines)):    
    vals = [float(num_str) for num_str in lines[i][:-1].split(',')]
    for v_ind in range(len(names)):

#清除某一帧 
blocks[names[v_ind]].keyframe_delete(data_path="value", frame=i)
        blocks[names[v_ind]].value= vals[v_ind]
# add key frame
blocks[names[v_ind]].keyframe_insert(data_path="value", frame=i)

# 清除所有
obj = bpy.data.objects["CTRL_expressions_neutral"]
obj.animation_data_clear()
obj.data.shape_keys.animation_data_clear() 
```

add shape key
```python
import bpy
# remove shape key
tgt_mesh = bpy.data.objects['SK_FL0.001']
tgt_mesh.animation_data_clear()
tgt_mesh.data.shape_keys.animation_data_clear()

for blc in tgt_mesh.data.shape_keys.key_blocks:
    blc.value = 0.0
```

load all from blend file:
```python
import bpy

# Set the path to the blend file you want to import from
source_blend_file = "/home/wegatron/win-data/tmp/realistic-rendering1.blend"

# Append all data blocks from the source file
with bpy.data.libraries.load(source_blend_file) as (data_from, data_to):
    # Here, you can choose which types of data to import
    # For example, to import all objects, materials, and textures:
    data_to.objects = data_from.objects
    data_to.materials = data_from.materials
    data_to.textures = data_from.textures
    data_to.worlds = data_from.worlds
    # Add more lines as needed for other types of data

# Link/Append the data blocks to the current scene
for obj in data_to.objects:
    if obj is not None:
        bpy.context.collection.objects.link(obj)

for world in data_to.worlds:
    if world is not None:
        bpy.context.scene.world = world

# Optionally, update the scene to reflect the changes
bpy.context.view_layer.update()
```

## 添加Shape Key
选择mesh-data, add key, 转换到edit mode修改vertices position.
![[Pasted image 20231030160958.png]]

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

```bash
[python_path] -m pip install [package-name]
```