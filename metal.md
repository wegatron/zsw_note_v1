---
tag: cg/graphics_api
---

## Metal中的同步
Metal 提供了二大资源管理机制, 一种是 tracked 的方式, 这是默认的资源管理模式, 与 OpenGL(ES) 类似;
另一种是完全由开发者控制的, 也就是 untracked 方式. tracked 模式下, 资源在使用的过程中对于资源的
依赖、修改、状态变更等都由 Metal Runtime 来跟踪和维护, 以保证资源使用的顺序以及在每个阶段都处
于正确的访问状态. 而 untracked 则是由开发人员自己维护, 可以减少 Metal Runtime 的开销, 提高性能.
[Metal Synchronization](https://developer.apple.com/documentation/metal/resource_synchronization?preferredLanguage=occ)

* Semaphore, 用于 CPU 和 GPU 之间的同步. 
    使用系统的semaphore, 事实上就是在commit之后添加一个callback, 设置semphore.
    
* MTLFence, 类似于VkEvents. 实现同一Queue中的同步. 通过updateFence和waitForFence来实现资源同步, 可以指定stage.
    与VkEvent有所不同的是, MTLFence更像是一个0-1的信号量, wait之后自动归零. 而VkEvent则可以更自由的控制状态set, reset.
    __tracked模式下无法使用MTLFence__

* MTLEvent, 作用与MTLFence类似, 可以进行同一device, 不同Queue间同步. 无法指定stage. 可以设置0-n的值(set必须递增), 来进行set和wait.
    __tracked模式下可以使用, iOS 12.0+__
    __在执行到wait时会阻滞整个command queue, 因此若是先wait, 再signal需要分散在两个command queue中__

* MTLSharedEvent, 不同device之间, CPU与GPU之间同步.




## Metal 相关资料
[🍇 The Metal Framework](http://metalkit.org/)
[🍋 Metal学习——基础概念与框架](https://hello-david.github.io/archives/98dc9fea.html)
[快速学习Metal API](https://www.zhihu.com/question/29070544)
[Metal2 研发笔录](https://zhuanlan.zhihu.com/c_1180576107602034688)
[小demo](https://www.jianshu.com/u/f141ef15ba07)
[Metal By Example](https://metalbyexample.com/the-book/)
[Metal By Tutorial](https://www.raywenderlich.com/books/metal-by-tutorials/v2.0/chapters/11-tessellation-terrains#toc-chapter-014-anchor-007)
[资深程序员的Metal入门教程总结](https://www.cnblogs.com/qcloud1001/p/9890961.html)

## 使用Metal kernel function 实现图像滤波
[Metal Filter](https://metalbyexample.com/fundamentals-of-image-processing)
[metal kernel function简单实例](https://avinashselvam.medium.com/hands-on-metal-image-processing-using-apples-gpu-framework-8e5306172765)
[MetalPetal kernel function Filters library](https://github.com/MetalPetal/MetalPetal/blob/master/Frameworks/MetalPetal/Kernels/MTIMPSKernel.m)
[🍒 Metal - 11 GPGPU 通用计算（Compute Shader）](https://www.uiimage.com/post/blog/metal/metal-11-generic-purpose-computing/)
[编译metallib](https://developer.apple.com/documentation/metal/libraries/building_a_library_with_metal_s_command-line_tools?language=objc)

## Metal的一些问题

1. 在metal中当纹理的存储数据type与纹理在mtlfunction中使用的type不完全一致时, 而外的开销有多大?
    比如新建纹理时所用的pixel format为:`MTLPixelFormatRGBA8Unorm`, 而在mtlfunction使用时可以为`texture2d<half, access::read>`或者`depth2d<float, access::read>`. 哪种方式效率更快?

2. 在texture2d不支持uint8为什么?
    参考《Metal Shading Language Specification》
    >For texture types (except depth texture types), T can be half, float, short, ushort, int, or uint. For depth texture types, T must be float.

3. 深度纹理不支持写入, 为什么?
    ```c++
    kernel void average_blur(depth2d<float, access::read> input [[texture(0)]],
                          depth2d<float, access::read_write> output [[texture(1)]],
                          uint2 id [[thread_position_in_grid]]);
    ```
    报错:
    ```
    "Depth textures must have access qualifier access::read or access::sample"
    ```