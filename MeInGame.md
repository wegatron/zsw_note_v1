## MeInGame Summary

### MeInGame 原代码 Pipeline
1. deepface重建bfm人脸
2. 使用RBF做Shape transfer
3. 使用光栅化器, 配合segmentation获取照片上的人脸像素
4. 使用 possion image editing进行纹理融合
5. 使用神经网络分离得到albedo

### MeInGame 改造后 Pipeline
1. 

### 积累
1. Radial Base Function Interpolation
2. skeletal animation
3. [blender](blender.md)
4. unreal & metahuman


### 遇到的问题和解决方法
1. 环境安装
    [nvidia-gpu-stuff](nvidia-gpu-stuff.md)

2. 代码思路的理清和改造
    例如: MeInGame的代码中, 用到了3份target mesh: target_mesh带眼球-不带纹理, target_mesh不带眼球-带纹理, target_mesh_std 与BFM Face 对齐的mesh. 前两个是为了进行数据保护, 最后一个是为了Radial Base Function Interpolation取得更好的结果.

3. 3d 数据准备、预处理
    对应点的选取
    软件或库在加载3d数据时, 默认可能会对mesh做处理(如[trimesh](https://trimsh.org/trimesh.html)), 需要注意参数设置, 防止其做处理, 以便后续顶点数据对应更新.
