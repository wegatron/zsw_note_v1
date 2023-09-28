
## 基本操作

* 添加骨骼动画
	`Object mode` -> `Add` -> `Armature`

* 增加骨骼
	`Edit mode` -> 选中一个骨骼的节点 -> `e`

* 将骨骼显示到最前面
	`Object mode` ->  `Object data properties` 右侧边栏小人 -> `view display` -> `in front`
	![[blender_display_front.png]]

* 自动weight: `Object mode` -> 选中mesh, shift, 选中bone -> `ctrl + P` -> `With Automatic weight`

* weight paint
	在`Object mode`中选中骨骼 + mesh -> `weight paint mode`
	若要继续切换bone, 可以 `ctrl` + 鼠标左键选取其他的 bone
	
	在`edit mode`下可以查看每个顶点与其相连的bone的weight
	![[blender_vertex_weight.png]]

* 骨骼动画预览: `Object mode` -> 选中骨骼 -> `Pose mode` -> 选中骨骼点 -> 拖动

* 自动 IK
	![[blender_auto_ik.png]]

* 骨骼动画关键帧

## Auto rig
[brignet](https://github.com/pKrime/brignet)


## Reference

[Character Rigging 101 Armatures, Bones, & IK](https://www.youtube.com/watch?v=iZBLtooU2Cs)