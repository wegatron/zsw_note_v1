---
tag: summary/basic_theory
---
# Neural Rendering

在传统的计算机图形学中, 一般使用Mesh、点云等表示物体的几何, 使用光栅化、光线追踪等渲染算法来合成场景的图片. 计算机视觉中, 则尝试通过现实中拍摄的物体图片, 来重建得到物体的几何材质, 此所谓反向渲染. 神经渲染借鉴两者的思想, 衍生出了用神经网络来表示场景的方法, 其以现实中拍摄的图片作为输入, 利用机器学习训练得到场景的表示, 然后通过MLP推导, 合成出场景的图片.

对于一般任务Pipeline:

* Image/Video Preprocessing - select images and restore camera intrinsic and pose
* Training - reconstruct scene representation
* Infer - synthesizing image

当前, Neural Rendering主要应用在AR/VR, 较多集中在新视角下的场景图片的生成.

研究方向较多:

* Performance
* Non-Static Scene
* Deformable/Editing
* Relighting/Material Editing
* Large Scene

主要挑战: ①性能跟不上; ②相比与传统的表示, 不直观, 编辑难, 工具少.

## 一些Nerf算法体验

Performance:
* [Instant-ngp]()
    nvidia 
* [Plenoxels]()

* [Mobile nerf]()

Deformable:
* [nerfies](Nerfies: Deformable Neural Radiance Fields)
* [Neural Scene Flow Fields for Space-Time View Synthesis of Dynamic Scenes](https://www.cs.cornell.edu/~zl548/NSFF/)


在人体/人头/人脸 上研究也较为广泛(可以进行人脸/人体动作的编辑):
[Dynamic neural radiance fields for monocular 4d facial avatar reconstruction](https://github.com/gafniguy/4D-Facial-Avatars)
[AD-Nerf](https://github.com/YudongGuo/AD-NeRF)

Relight&Material Editting:



## Reference
[Advances in Neural Rendering]()
[Nerf project](https://www.matthewtancik.com/nerf)
[知乎-Nerf](https://zhuanlan.zhihu.com/p/380015071)