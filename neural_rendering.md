---
tag: summary/paper_note
---
# Neural Rendering Survy

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

## 算法衍伸/变体
* [Mip-NeRF 360](https://link.zhihu.com/?target=https%3A//jonbarron.info/mipnerf360/)
	NeRF在小范围内渲染效果尚好，但它们在 "无界 "场景中却举步维艰。在这种情况下，原有的NeRF的模型往往会产生模糊或低分辨率的渲染，可能会表现出伪影。本文提出了 "mip-NeRF 360"（改进了mip-NeRF），它使用非线性场景参数化、在线蒸馏和一种新型的基于失真的正则器来克服无边界场景带来的挑战。与mip-NeRF相比，MSE减少了54%，并且能够为高度复杂、无边界的真实世界场景产生真实的合成视图和精准的深度图。

*  [Point-NeRF](https://link.zhihu.com/?target=https%3A//xharlie.github.io/projects/project_sites/pointnerf/index.html)
	像 NeRF 这样的体积神经渲染方法会生成高质量的视图合成结果，但会针对每个场景进行优化，从而导致重建时间过长。另一方面，深度多视图立体方法可以通过直接网络推理快速重建场景几何。Point-NeRF 结合了这两种方法的优点，通过使用具有相关神经特征的神经 3D 点云来模拟辐射场。Point-NeRF 可以通过在基于光线行进的渲染管道中聚合场景表面附近的神经点特征来有效地渲染。此外，Point-NeRF 可以通过直接推断预训练的深度网络来初始化，以生成神经点云；这个点云可以被微调以超过 NeRF 的视觉质量，训练时间快 30 倍。

* [Instant-ngp]()
    nvidia 
    
* [Mobile nerf]()

* Deformable Nerf
	* [nerfies](Nerfies: Deformable Neural Radiance Fields)
	* [Neural Scene Flow Fields for Space-Time View Synthesis of Dynamic Scenes](https://www.cs.cornell.edu/~zl548/NSFF/)
	* [Dynamic neural radiance fields for monocular 4d facial avatar reconstruction](https://github.com/gafniguy/4D-Facial-Avatars)
	* [AD-Nerf](https://github.com/YudongGuo/AD-NeRF)

* Human NeRF
	其可以在任何帧暂停视频并从任意新的摄像机视点甚至是针对该特定帧和身体姿势的完整 360 度摄像机路径渲染主体

* Raw NeRF
* Relight&Material Editting:




## Reference
[Advances in Neural Rendering]()
[Nerf project](https://www.matthewtancik.com/nerf)
[知乎-Nerf](https://zhuanlan.zhihu.com/p/380015071)
[CVPR 2022 NeRF(神经辐射场)大放送](https://zhuanlan.zhihu.com/p/476220544) <<<<
[Awesome Neural Radiance Fields](https://github.com/awesome-NeRF/awesome-NeRF)