---
tag: GameEngine
---
# Unity Visual Effect Graph

## Visual Effect Graph创建
1. 新建3D URP Project
    URP (Universal Render Pipleline) 通用管线流程, 轻量级渲染管线, 专注于性能.
    HDRP(High Definition Render Pipleline)高清管线流程, 专注于高端图形渲染, 针对高端硬件配置, 像PC、XBox 和Playstation，其面向高逼真度的游戏、图形demo和建筑渲染、超写实效果，以及所需的最佳图形效果.
    只有这两种支持Visual Effect Graph

2. 打开`window`->`Package Manager`, 选择`Unity Registry`, 安装`visual effect graph`.

3. 在`project`窗口下的scene中创建vfx. `create`->`visual effect`->`visual effect graph`. 然后将vfx拖入到Hierarchy窗口中.
![unity_create_vfx](rc/unity_create_vfx.png)

4. VFX无法正常显示(unity bug?)
    https://issuetracker.unity3d.com/issues/vfx-opengles3-error-when-compiling-shaders-unexpected-token-number-at-kernel-csmain
    >For now this bug can be fixed by going to:
    >C:\Program Files\Unity\Hub\Editor\2022.1.0b6\Editor\Data\Resources\PackageManager\BuiltInPackages\com.unity.visualeffectgraph\Shaders\VFXCommon.hlsl
    >
    >Then go and change CUBEARRAY to 0 instead of 1.
    ```c++
    #ifdef SHADER_STAGE_COMPUTE
    #define SHADER_AVAILABLE_CUBEARRAY 0
    #endif
    ```
    >I still have this in (at the time of writing newest version (2022.1.0b6)
    >Also in 2022.1.0b4.
    >It prevents building for Android.
    >No build is necessary to observe the issue.
    >The issue is in: VFXCommon.hlsl line: 136

    通过unity-hub定位unity安装位置. 修改完成后, 从新将vfx拖入Hierarchy, VFX可以正常显示.
    ![unity_create_vfx_suc](rc/unity_create_vfx_suc.png)

5. 双击VFX Assets, `visual effect graph`窗口, 可供设计粒子效果.
    ![unity_vfx_system](rc/unity_vfx_system.png)

另外, 在VFX Inspector 中可以看到VFX的shader代码:
![](rc/unity_vfx_inspector.png)

## VFX的设计
整个系统可分为横向和纵向两种逻辑:
* 纵向逻辑
    定义了visual effect的不同处理阶段, 每个阶段封装成了一个大的容器(如图中的`Spawn`、`Initialize`...)称之为`Contexts`. 大容器内可以添加多种不同的元素称之为`Blocks`(在不同的`Contexts`中能添加的`Blocks`不同). `Blocks`可以认为是对该`Contexts`中特定属性的操作, 多个`Blocks`之间按从上到下顺序执行.

* 横向逻辑
    通过横向逻辑(从左往右), 可以加入自定义数学计算与`Blocks`的Property Slots相连, 从而自定义visual effect行为(幻化).
    ![unity_vfx_horizontal_logic](rc/unity_vfx_horizontal_logic.png)


### 重要的概念

常用的`Contexts`:

* Spawn. If active, Unity calls this every Frame, and computes the amount of particles to spawn.

* Initialize. Unity calls this at the “birth” of every particle, This defines the initial state of the particle.

* Update. Unity calls this every frame for all particles, and uses this to perform simulations, for example Forces and Collisions.

* Output. Unity calls this every frame for every particle. This determines the shape of a particle, and performs pre-render transformations

三种`Systems`:
* A Spawn System consists of a single Spawn Context.
* A Particle System consists of a succession of an Initialize, then Update, then Output context.
* A Mesh Output System consists of a single Mesh Output Context.

`Blocks` `Context`中的操作, 定义了`Context`的行为, 通过它来更新`Context`的属性. 例如, 可以通过它来给粒子加一个力.

`Operators` 低级逻辑原语. 如Random, getAttribute, 颜色空间转换等等.


## 实例分析
### SMR-VFX
github地址: https://github.com/keijiro/Smrvfx

思考, 可能的实现方式: 在skined mesh表面沿着法向发射粒子, 粒子的速度与mesh上点的运动速度一致. 粒子经过一段时间后消失.


* 粒子发射
    这里, Rate指的是没秒钟发射的粒子数量. `Throttle`可以看做是UI滑动条吧.
    ![spwan](rc/unity_smr_vfx_spwan.png)

* 粒子初始化
    根据skined mesh初始化粒子的相关属性.
    ![init](rc/unity_smr_vfx_init0.png)

    在Smrvfx中, avata的animation已被打包成一个package:
    ![avata](rc/unity_smr_vfx_avata.png)
    
    source、sourceTransform是在particle effect的面板中设置的:
    ![particles_properties](rc/unity_smr_vfx_properties.png)

    这里`Transformed SMR`是一个子图:
    ![transformed_smr](rc/unity_smr_vfx_transformed_smr.png)
    这里最核心的是`Sample Skinned Mesh`——[Sample Mesh](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@14.0/manual/Operator-SampleMesh.html)节点(通过它来得到采样点信息: position、normal、texcoord...):

    ```c++
    // the code maybe like this
    class SampleMesh
    {
        public:
        vec3 getNormal(size_t index) { return normals[index%capacity];/* for wrap mode */ }
        ...
    }
    ```
    另外, `Render`节点是


__总结__:

### Simple Spawn System
Unity内置`simple spawn system`.
![](rc/simple-spawn-unity.png)

在球形表面发射粒子(arc定义了经度范围):
![](rc/unity_vfx_simple_spawn_init.png)

利用噪声, 来模拟粒子的运动. 参考[Unity VFX Turbulence](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@10.2/manual/Block-Turbulence.html)

![](rc/unity_vfx_simple_spawn_update.png)

|Input | Type | Description |
| ---- | ----- | ------ |
|Field Transform | Transform | The transform with which to position, rotate, or scale the turbulence field. |
|Intensity | Float | The intensity of the turbulence. Higher values result in an increased particle velocity. |
|Drag | Float | The drag coefficient. Higher drag leads to a stronger force influence over the particle velocity. This property only appears if you set Mode to Relative. |
|Frequency | Float | The period in which Unity samples the noise. A higher frequency results in more frequent noise change. |
|Octaves | Uint (Slider) | The number of layers of noise. More octaves create a more varied look but are also more resource-intensive to calculate. |
|Roughness | Float (Slider) | The scaling factor Unity applies to each octave. Unity only uses roughness when Octaves is set to a value higher than 1. |
|Lacunarity | Float | The rate of change of the frequency for each successive octave. A lacunarity value of 1 results in each octave having the same frequency. |


### Genine

关键词: 烟雾模拟

![smoke](rc/unity_vfx_smoke.png)


紫色条形烟雾:
* 发射
    发射频率: 100

* 初始化
    容量: 30000
    生命周期: random(4, 6)
    位置: 以葫口为中心的一个球形范围(radius=0.04)内初始化粒子
    ~~速度: random(0.85, 1.42) 方向(0, 0, 1) [更新时设置了position没有意义]~~
    初始大小: random(2, 2.67)
    初始alpha: random(0.6, 1)

* update 更新
    Flipbook Player 使用filpbook textures来创建粒子模拟效果(通过增加texture index来实现).
    利用Bezier曲线来控制粒子的位置, 通过加入一点随机值(0~0.1), 控制插值率(粒子生命结束时到达终点)

* 绘制
    粒子quad一直面朝camera
    flipbook像素大小的设置(其实是一张图片, 通过uv来获取不同帧的纹理)
    粒子quad大小与lifetime的关系曲线

彩色粒子:
![](rc/unity_genine_colorful_particles.png)

* 发射
* 初始化
    粒子的大小: 1
    粒子scale_x: random(0.001, 0.02)
    粒子scale_y: random(0.05, 0.5)
    [粒子direction与速度方向一致]
* update 更新
    Bezier曲线
    ![](rc/unity_genine_colorful_particles_bezrier.png)
    vector field扰动, 可以查看对应的3d纹理, unity assert中存放了3d纹理的数据.
    ```
    _typelessdata: 7c8388ff7b8389ff7b8289ff7b8188ff7a8188ff7b8187ff7c8188ff7b8189ff7b8089ff
    ```
    可以联系到saber效果类似

精灵形态粒子:

## 导出Android 应用

导出时出现错误
```
Win32Exception: ApplicationName='/home/wegatron/opt/unity/2021.3.7f1/Editor/Data/PlaybackEngines/AndroidPlayer/SDK/platform-tools/adb', CommandLine='devices', CurrentDirectory='/home/wegatron/opt/unity/2021.3.7f1/Editor/Data/PlaybackEngines/AndroidPlayer/SDK', Native error= Access denied
System.Diagnostics.Process.StartWithCreateProcess (System.Diagnostics.ProcessStartInfo startInfo) (at <d8e00e677f3d432e821feedd89e61106>:0)
System.Diagnostics.Process.Start () (at <d8e00e677f3d432e821feedd89e61106>:0)
(wrapper remoting-invoke-with-check) System.Diagnostics.Process.Start()
```
由于权限没有给到, 需要给与可执行权限.

## Reference
最基础的simple vfx解析(球体表面+perl ling noise field控制粒子速度, 根据粒子速度得到朝向和颜色): https://www.youtube.com/watch?v=FvZNVQuLDjI
根据人物模型表面发射粒子: https://www.youtube.com/watch?v=ePbeaYuMNK4

官方粒子系统的解析: 
    https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@10.2/manual/index.html
    all in 推广blog: https://blog.unity.com/technology/creating-explosive-visuals-with-the-visual-effect-graph
比较好的解释的blog: https://iamsleepingnow.github.io/2021/03/03/Unity/Unity%E5%A4%A9%E5%9D%91VFX/
更多VFX教程: https://www.youtube.com/watch?v=ePbeaYuMNK4