---
tag: work_alg
---
<!-- ## iOS Lidar 相关问题V1
1. [Improved Object Occlusion Rendering](https://developer.apple.com/augmented-reality/realitykit/)
    >Now, virtual objects can be placed under tables, behind walls, or around corners and you’ll see only the parts of the virtual object you’d expect to, with crisp definition of where the physical object hides part of the virtual one.

    ARKit + RealityKit 中有没有现实(包含动态的人和静态的背景)与虚拟物体的相互遮挡的预设方案(如果有, 需不需要做场景的预扫描, 还是即开即用).
    * 我们尝试了官网的Demo [Effecting People Occlusion in Custom Renderers](https://developer.apple.com/documentation/arkit/effecting_people_occlusion_in_custom_renderers), 该Demo将人与背景分离, 并得到了精度较高的人的深度信息, 但缺失了背景的深度信息.

    * 参考[Creating a Fog Effect Using Scene Depth](https://developer.apple.com/documentation/arkit/creating_a_fog_effect_using_scene_depth)这个Demo, 我们获取到的深度信息精度并不高, 有比较重的锯齿和边界抖动(帧与帧之间). ARKit + RealityKit 有没有既定的方案可以解决这两个问题.

2. 传感器数据的存储.
    Reality Composer可以录制传感器相关的数据, 然后在XCode上作为调试使用. 但我们没有找到公开的录制数据的API, 后续有没有计划提供这样的API接口.

3. RealityKit
    RealityKit提供了很多方便的AR接口, 比如物理模拟, 光照估计以及虚拟光源等. 这些功能是否必须结合ARView使用, 是否支持单独使用, 即在我们自己的Render是否可以使用这些功能? 如果可以, 能否提供一些相关资料, 或者这样的Demo. -->

## iOS Lidar 相关问题V2

1. [Improved Object Occlusion Rendering](https://developer.apple.com/augmented-reality/realitykit/)
    >Now, virtual objects can be placed under tables, behind walls, or around corners and you’ll see only the parts of the virtual object you’d expect to, with crisp definition of where the physical object hides part of the virtual one.

    对于音视频剪辑应用, 为了使我们的特效和用户体验更优. 我们希望获取到稳定精细的逐帧深度图. 在使用iOS Lidar时我们发现数据存在两个问题:
    * depth分辨率很低
    * depth具有较大的闪烁(稳定的时序一致性)
    
    请问对于这两个问题iOS上有没有原生的算法可以使结果得到改善, 或者后续会有计划在这方面做一些优化.

2. RealityKit
    RealityKit提供了很多方便的接口, 让开发者可以用几行代码就能够实现一个效果. 但对有一定历史沉淀的公司而言, 一般会有自己的一套渲染框架. 有没有方法可以在自己的渲染框架中使用这些特性, 能否提供一些案例.

3. MetalPerformanceShader
    使用MPSImageFilter高效且方便, 有没有方式可以自定义这个处理过程(比如可以自定义输入的image数量, 自定义输出的计算方式, 就像fragment shader一样). 另外对如何才能使自定义MPSImageFilter高效运行提供一些注意事项, 或者提供一些案例.
