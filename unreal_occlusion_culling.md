## UE Occlusion culling

主要的类: `Render/SceneVisibility.cpp` --> `FVisibilityViewPacket` 这里Packet表示任务包.

整体流程
LaunchVisibilityTasks

`FVisibilityViewPacket::BeginInitVisibility()`

```c++
CullOctree()
FrustumCull(...)
```

`FGPUOcclusionParallelPacket::OcclusionCullTask`

```c++
OcclusionCullPrimitive(...)
{
    HZBOcclusionTests.IsVisible(...)
}
```

## 参考
[[UE5] 遮挡剔除 源码阅读](https://zhuanlan.zhihu.com/p/666990648)