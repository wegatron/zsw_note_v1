---

excalidraw-plugin: parsed
tags: [excalidraw]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Text Elements
Vulkan ^ZJ8jkhWK

Device Init ^lybhry6P

Pipeline ^VTcADaop

Sync ^sOf7Qxs6

Data ^9FhasIQH

instance ^jzUbNhC8

extensions [ref](https://registry.khronos.org/vulkan/specs/1.3-extensions/html/chap54.html) ^6hmhRMdK

api version ^qhvhnGiJ

Device ^HNUpNXg2

extensions ^PKQh0Jg5

[diff](https://stackoverflow.com/questions/53050182/vulkan-difference-between-instance-and-device-extensions)
instance extension和device extension之间的区别与instance和device之间的区别相关:
instance用来获取物理设备以及查询物理设备属性(device extension、feature的支持情况)
device则确定了设备的具体能力 ^5hnqsy3C

用来获取物理设备, 
以及查询物理设备的属性 ^7TRP2QJK

Layer 通过插入到命令调用中, 从而提供扩展功能: 调试、性能分析等这里需要SDK支持(vulkan没有内置)

* 根据规范检查参数值以检测误用。
* 跟踪对象的创建和销毁以发现资源泄漏。
* 通过跟踪调用源自的线程来检查线程安全。
* 将每个调用及其参数记录到标准输出。
* 跟踪 Vulkan 调用以进行分析和重放

相关的layer可以在系统中找到如
/usr/share/vulkan/explicit_layer.d ^KybCi4Rb

features ^u5OlwVJY

geometry shader ^UdWEyZVY

[vulkan validation layer](https://github.com/KhronosGroup/Vulkan-ValidationLayers) ^MOoly76F

[VK_LAYER_LUNARG_api_dump](https://vulkan.lunarg.com/doc/view/1.3.216.0/mac/api_dump_layer.html) ^j7dsM5qC

Graphics pipeline ^p4bugCjR

Compute pipeline ^Y2s3t9U2

[管线以及管线状态管理](https://zhuanlan.zhihu.com/p/55304721) ^ChAZZmL0

Pipeline cache ^Ez8sDNeo

[Robust pipeline cache serialization](https://zeux.io/2019/07/17/serializing-pipeline-cache/) ^Mk5vIOvi

另外[Vulkan Guide](https://vkguide.dev/docs/chapter-1/vulkan_init_code/) 教你一步一步如何搭建绘制流程, 对新手非常友好! ^cF7a9EhE

[官方specification & reference](https://registry.khronos.org/vulkan/) ^EsoRN7ez

[王烁-图形渲染技术&职业生涯](http://geekfaner.com/shineengine/blog1_career.html) ^ARdgx1Yi

Render pass ^I3eSwx7J

render pass compatibility(for graphics pipeline):
attachment 数量相同(允许有VK_ATTACHMENT_UNUSED)
对应attachment的format、sample count一致

注: 允许attachment有不同的extend, load/store, layout ^TUqsVMtw

Image ^VUAZ78FG

Buffer ^9amyTdkp

layout ^7lRVwubC

VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL
VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL
VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL
... ^7N4WVheJ

VkRenderPassCreateInfo ^Fp9OCP7y

VkAttachmentDescription ^YNSRZZiO

VkSubpassDescription ^UtTZtJFf

VkSubpassDependency ^zu3TMxtZ

format, sample count
load/store
init/final image layout ^u9zqe9px

color/input/depth_stencil... attachment reference(index) ^kziOnwkc

Pipeline State ^yy8MByKT

shader stage ^0ihgLmtf

sub pass
in render pass ^3dsmJS2e

extent3d ^c41DXZmE

usage ^byfhFh2T

samples ^m6n2RStp

mipmap level ^wDKOcw0Z

Pipeline Layout ^2ADXoXmG

vertex Input State
InputAssembly
Rasterization
Viewport
MultiSample
DepthStencil
Colorblend ^12zTYOXn

format ^riC9Kydi

tiling ^c3oUdLzr

VK_IMAGE_TILING_OPTIMAL
VK_IMAGE_TILING_LINEAR ^794f0xqB

[tiling和layout区别1](https://zhuanlan.zhihu.com/p/580655563) ^IN7mYDad

[tiling和layout区别2](https://www.reddit.com/r/vulkan/comments/48cvzq/image_layouts/) ^KZU8eWD6

tiling描述了像素在GPU上的内存排布方式
layout则是为了减少GPU内存带宽, GPU对不同的layout指定了不同且透明的压缩方式.
由于有些硬件模块只能访问特定数据块/数据格式, 因此在使用前需要进行layout转换 ^ibud4hes

flags ^2CrXkzGL

一些特殊用法的标记, 例如属于cube_map的哪个面 ^sOvTJZEV

flags ^0cdaV3Q5

size ^jH0TkeeA

usage ^nvUxvbi3

sharingMode ^VwFYpY6i

Memory ^tRqPAOgm

Memory Heap ^cCBNxDxs

Memory Type ^Ik7txvTl

memory heap代表一个具体的物理内存
显卡上的RAM, 或者系统内存 ^1OyCXAVz

在Vulkan中对内存进行
vkGetPhysicalDeviceMemoryProperties
获取memory heap 和 memory type的信息
参考:
[1](https://asawicki.info/news_1740_vulkan_memory_types_on_pc_and_how_to_use_them)
[2](https://www.youtube.com/watch?v=zSG6dPq57P8)
[3](https://stackoverflow.com/questions/51624650/vulkan-memoryheaps-and-their-memorytypes) ^pizIAgCn

memory type是某个memory heap带有特定
属性(VkMemoryPropertyFlags)的view ^7TYLK4Cw

heapIndex ^ndrTjBwt

propertyFlags ^BPxOaXvg

VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT
VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT 可以被map
VK_MEMORY_PROPERTY_HOST_COHERENT_BIT
VK_MEMORY_PROPERTY_HOST_CACHED_BIT 可以快速地进行随机访问; 否则, 随机访问很慢, 适合连续访问.
VK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT
VK_MEMORY_PROPERTY_PROTECTED_BIT ^nYtDfCc6

size ^fQJeZaem

flags ^jOMQsCZy

VK_MEMORY_HEAP_DEVICE_LOCAL_BIT 设备自带显存
VK_MEMORY_HEAP_MULTI_INSTANCE_BIT 基本没有 ^FJEExEwu

[各种设备/系统vulkan能力统计](http://vulkan.gpuinfo.org/) ^zuB9weWX

linux, rtx3060
 heap size 12884MB flags VK_MEMORY_HEAP_DEVICE_LOCAL_BIT
 heap size 25193MB flags 0
 heap size 257MB flags VK_MEMORY_HEAP_DEVICE_LOCAL_BIT
 heap index 1 memory property flags 0
 heap index 0 memory property flags VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT 
 heap index 1 memory property flags VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT 
 heap index 1 memory property flags VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT VK_MEMORY_PROPERTY_HOST_CACHED_BIT 
 heap index 2 memory property flags VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT  ^r4nGhhI6

[各类内存使用](https://zeux.io/2020/02/27/writing-an-efficient-vulkan-renderer/):
DEVICE_LOCAL_BIT 
    - rendertarget, gpu only resource, static resource(texture, geometry) 

DEVICE_LOCAL_BIT | HOST_VISIBLE_BIT ||| HOST_CACHE
    - 256MB in desktop gpu, full in mobile gpu. video memory that the CPU can write to directly
    - allocating reasonable amounts of data that is written by CPU every frame, such as uniform buffers or dynamic vertex/index buffers

HOST_VISIBLE_BIT | HOST_COHERENT_BIT
    - CPU memory that is directly visible from GPU
    - staging buffer
    - in absence of the previous memory type, use for ... 

DEVICE_LOCAL_BIT | LAZILY_ALLOCATED_BIT
    - GPU memory that might never need to be allocated for render targets on tiled architectures  ^vKKqy9QE

[Writing an efficient Vulkan renderer](https://zeux.io/2020/02/27/writing-an-efficient-vulkan-renderer/) ^HUjyoagp

vkCmdUpdateBuffer
适用于小量数据更新<65536bytes,
通过command buffer执行, 可以在一个pipeline中的特定点进行多次不同的数据更新.
例如在VR渲染时, 左右眼画面公用一个uniform buffer, 先更新左眼进行绘制, 再更新右眼进行绘制. ^uPsaHVGO

Map/UnMap
可以用于大数据更新, 要求Memory必须是HOST_VISIBLE. 中间不需要command buffer, 需要flush memory.

mapping需要一定的时间开销, persistent mapping可以减少临时mapping时间. 但在AMD/NVIDIA上HOST_VISIBLE VRAM有限,
可能会强制在system memory上申请有persistent mapping要求的memory. ^3DabKuFR

VMAllocator ^Lu8LIEyu

VmaAllocationCreateInfo ^LNpVQV0I

VmaAllocationInfo ^IPDvLzB6

Buffer/Image CreateInfo ^J505iaQi

output ^3XOHbWZo

object create info in vulkan ^6flRtbjl

VmaAllocationCreateFlags ^aVBFJcA0

VmaMemoryUsage ^0LPL7WcU

VMA_ALLOCATION_CREATE_MAPPED_BIT
VMA_ALLOCATION_CREATE_CAN_ALIAS_BIT
VMA_ALLOCATION_CREATE_HOST_ACCESS_SEQUENTIAL_WRITE_BIT
VMA_ALLOCATION_CREATE_HOST_ACCESS_RANDOM_BIT
VMA_ALLOCATION_CREATE_HOST_ACCESS_ALLOW_TRANSFER_INSTEAD_BIT ^eOreXhh8

VMA_MEMORY_USAGE_AUTO
VMA_MEMORY_USAGE_AUTO_PREFER_DEVICE
VMA_MEMORY_USAGE_AUTO_PREFER_HOST ^JwJc1sOI

根据VmaAllocationCreateFlags...来选择适合的memory type
内存管理, 申请大块内存返回部分 ^0005z0Cw

SwapChain ^229jIfKL

Surface ^pWRxdDov

随着swapchain 自动
创建swapchain images
但是需要自己创建和管理image view ^BqX4n9b0

FrameBuffer ^MH8choYb

ImageView ^SeAUTOXR

viewtype ^Got69oAO

format ^UA64n5sy

components_mapping ^XUAEEFVt

subresourceRange ^suIr5AZK

1D, 2D, Cube, ARRAY... ^BE14GDot

type ^jIYiGhHs

1D, 2D, 3D ^MfLLndFx

RenderTarget ^X6trqsMi

array layers ^T3Cnc8iS

 Images in Vulkan can actually be an array of images, called layers.
[example](https://github.com/SaschaWillems/Vulkan/blob/master/examples/texturecubemap/texturecubemap.cpp): cubemap image layers=6 ^h5JNVj01

VkFence ^yGE9c4U7

VkSemaphore ^FYbDrICX

gpu -> cpu sync
has two state: signaled and unsignaled
device to signal, and host to get/wait/reset ^Gzn0Btx2

VkBarrier ^COyABzJc

gpu-gpu sync ^zHqvDtLN

VkEvent ^eKvMgTaU

vkWaitForFences ^iLO56kq8

vkResetFences ^Aqz5ifri

host functions ^GvyZP1Ol

vkGetFenceStatus ^eh1l9kEQ

back to unsignaled state ^UOrHDtiZ

Commands ^gYXqiGAb

Command Queue ^oAmnIF2n

Command Buffer ^tA6HZ5rR

vkQueueSubmit ^iMPPEsA5

CPU ^5d2D5HUQ

GPU ^10awLCN4

Surface ^nR6RNCqp

fill cmd_buffer ^TSYvJrm9

render ^bFK4QbB0

show ^EeeeNCuu

submit ^KzelzrFJ

present ^QPCeJSUf

fill cmd_buffer ^HgfqSqCa

wait fence ^e4bjF9y4

render ^8VoL2tpD

wait semaphore ^SzQN6NCX

show ^7GOFzk7J

submit ^MVGRMFVn

present ^cD3r4g9O

... ^sNWadTjl

... ^3Xn4KC4e

... ^doVsCNVh

submit ^akCLXITe

record cmds ^3sxvoJ0A

wait render_fence ^1xrR9tWe

wait present_semaphore ^fjrYiMdP

present ^hIiHdg2e

wait render_semaphore ^eKTjWpVI

signal render_semaphore ^WTBpdmfn

signal present semaphore ^6mBBIv3t

signal render_fence ^3H0iOVcC

wait semaphore ^bFbaoBsv

wait semaphore ^ZylNQp2B

Command Pool ^8hKZ5dqo

Primary ^TsNV1pQm

Secondary ^UyH4KKEH

command buffer所需内存需要在command pool中申请, 
非线程安全, 多线程操作时需要加锁(每个线程设置一个专属
的command pool更好). 在某些情况下, 可以设置F*T个
command pool. F是frame count, T是CPU核心数量.

但是当draw call比较少时(比如<100), 就没有必要拆分
到多个线程中进行并行. command buffer的内容应该足
够多, 以保证GPU在执行时不空闲.

一般而言, 每帧提交次数限制在<10, 每帧的command buffers数量 <100. ^c5GmHdcb

- VK_COMMAND_POOL_CREATE_TRANSIENT_BIT
    支持动态command buffer(每帧都录制一个新的command buffer, 用完后free)
- VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT
    支持生命周期较长的command buffer, 录制一次重复使用, 且可以不释放, 从新录制内容.
    该标志将强制为池中的每个命令缓冲区使用单独的内部分配器, 与单个池重置相比, 这会增加CPU开销.
    若该标志不设置, 则command buffer free时, command pool不会回收其内存 ^cxCokbfi

queueFamilyIndex ^ZAyYD5Xg

flags: VkCommandPoolCreateFlagBits ^J7Daqu5x

create ^2ocLk6vr

reset ^ksyW1Q4i

flags: VkCommandPoolResetFlags ^MbF9nmp7

- VK_COMMAND_POOL_RESET_RELEASE_RESOURCES_BIT
    是否需要将内存页交还给系统, 否则内存仍保存在pool的free list中 ^OJRlr9AS

重要参考 ^TsRfTJHI

将所有由该command pool创建的command buffer设置为initial state, 并回收所有内存资源.
对于secondary command buffer状态变为invalid. ^WYhKRuk3

SRV: wrap textures in a format that the shaders can access them. (Read Only)
URV: provides similar functionality, but enables the reading and writing to the texture (or other resource) in any order.
URV访问比SRV要稍微慢一点 ^ZOzWSc13

PresentMode:
- IMMEDIATE  立即显示, 不进行垂直同步, 明显撕裂
- FIFO  队列排序, 垂直同步, 无撕裂
- FIFO RELAXED 当图像的显示时长超过一个vsync周期时，下一个图像不会再等待下一次vsync的到来，而是立刻显示. 此时会有撕裂
- MAILBOX 只使用单个元素的队列, 当有新的图像被生成时, 等待队列的图像将被替换. 进行vsync 
- SHARED_DEMAND_REFRESH 单Image队列, 只有收到present信号时才立即更新图像, 不进行vsync
- SHARED_CONTINUOUS_REFRESH 固定刷新率刷新, 当更新时间不对时也会撕裂 ^JCYP4D4Y

Allocate and free ^YxAiwNX1

Resetting individual command buffers ^T61wmSnt

Resetting the command pool ^GMJMKp5Q

[三种模式](https://arm-software.github.io/vulkan_best_practice_for_mobile_developers/samples/performance/command_buffer_usage/command_buffer_usage_tutorial.html#allocate-and-free) ^26qk2Xj9

性能最差, 频繁的申请和释放内存 ^yruG32VW

重用已经申请的内存, 但频繁地reset command buffer开销也不小 ^Rdz0ScbZ

[vulkan best practics](https://github.com/ARM-software/vulkan_best_practice_for_mobile_developers) ^HpS2foPy

reset command pool, 会自动reset该pool中的command buffers, 效率高 ^Miixsq10

CREATE_TRANSIENT_BIT ^TabObctS

CREATE_RESET_COMMAND_BUFFER_BIT ^J39Se4ne

CREATE_RESET_COMMAND_BUFFER_BIT ^dE8N1Ibn

DescriptorSet ^DTUh4UyG

DescriptorSetLayout ^YTKbUCoS

DescriptorPool ^2dUd1N8g

记录了某个DescriptorSet的规格信息:
有哪些绑定点, 每个绑定点上的数据类型, 长度等 ^8FF9hbLQ

set-0 用作 engine-global resource,
set-1 用作 per pass resource,
set-2 用作 material resource, 
set-3 用作 per-object resource.

在glsl中layout若不设置, set默认为0 ^HgQ1GmJu

atomic, push const ^6NMDmhtO

[vulkan shading language](https://github.com/KhronosGroup/GLSL/blob/master/extensions/khr/GL_KHR_vulkan_glsl.txt) ^cja7ABFB

descriptorpool在创建时, 需要指定最多可以创建多少个descriptor set.
以及可以创建的每种类型的descriptor的数量限制. ^H24Gyj0i

uniform buffer
<=64kb PC
<=16kb mobile ^w7FXOajY


# Embedded files
a4d7f9b0a6abf8ba8c7940c3e6048d97538f9e28: [[mobile_vk_memory.png]]
041f50e40e110dde44f4b4b001dfe5495408a4b5: [[Pasted Image 20230717093641_521.png]]
1b5769f209c6001345226c94f4037e3f53b34e65: [[Pasted Image 20230718100738_042.png]]
ee9f8bd697f18baf6b0d7281c956ab00f1a9ebd9: [[Pasted Image 20230718102034_985.png]]
fe09dfd03c933ac20bbf132e3b47ce866a0086b1: [[Pasted Image 20230718104556_147.png]]
ca47793fb1bfbaee29be188171f2dfd23d92cea5: [[Pasted Image 20230719091316_299.png]]
6d92fc749ee251bac9b4932443a94606beb9433b: [[Pasted Image 20230719091446_346.png]]

%%
# Drawing
```json
{
	"type": "excalidraw",
	"version": 2,
	"source": "https://github.com/zsviczian/obsidian-excalidraw-plugin/releases/tag/1.9.3",
	"elements": [
		{
			"type": "rectangle",
			"version": 374,
			"versionNonce": 2011986791,
			"isDeleted": false,
			"id": "8vpI1tr9daG5itaHUvtNy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1035.2115509757155,
			"y": -203.54312936112115,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 108,
			"height": 44,
			"seed": 811272901,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "ZJ8jkhWK"
				}
			],
			"updated": 1689733954221,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 358,
			"versionNonce": 666407561,
			"isDeleted": false,
			"id": "ZJ8jkhWK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1010.9015228995436,
			"y": -194.04312936112115,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 59.37994384765625,
			"height": 25,
			"seed": 75881611,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954221,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Vulkan",
			"rawText": "Vulkan",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "8vpI1tr9daG5itaHUvtNy",
			"originalText": "Vulkan",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 873,
			"versionNonce": 1001813639,
			"isDeleted": false,
			"id": "sBOKEF0l7D0JdoTtUemVr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -779.1404509134337,
			"y": -500.62869521351536,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 131,
			"height": 44,
			"seed": 1625798731,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "lybhry6P"
				}
			],
			"updated": 1689733954221,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 868,
			"versionNonce": 1509382505,
			"isDeleted": false,
			"id": "lybhry6P",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -767.7803968973204,
			"y": -491.12869521351536,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 108.27989196777344,
			"height": 25,
			"seed": 1344605381,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954221,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Device Init",
			"rawText": "Device Init",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "sBOKEF0l7D0JdoTtUemVr",
			"originalText": "Device Init",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 856,
			"versionNonce": 1725173159,
			"isDeleted": false,
			"id": "oDhN1X9Nuh_9DXCmvqfFK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1048.8856135192468,
			"y": 947.4030847410464,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 133,
			"height": 47,
			"seed": 21039013,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "VTcADaop"
				}
			],
			"updated": 1689733954221,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 773,
			"versionNonce": 712655945,
			"isDeleted": false,
			"id": "VTcADaop",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1016.545571404989,
			"y": 958.4030847410464,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 68.31991577148438,
			"height": 25,
			"seed": 1555018187,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954221,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Pipeline",
			"rawText": "Pipeline",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "oDhN1X9Nuh_9DXCmvqfFK",
			"originalText": "Pipeline",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 1445,
			"versionNonce": 74563783,
			"isDeleted": false,
			"id": "QmXFFWBgjIDxGjrZ0i2BY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -919.6169925025147,
			"y": 4288.891787707047,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 134,
			"height": 52,
			"seed": 1662455301,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "sOf7Qxs6"
				}
			],
			"updated": 1689733954221,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 1395,
			"versionNonce": 85775145,
			"isDeleted": false,
			"id": "sOf7Qxs6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -873.0769763281983,
			"y": 4302.391787707047,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 40.91996765136719,
			"height": 25,
			"seed": 439093061,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954221,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Sync",
			"rawText": "Sync",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "QmXFFWBgjIDxGjrZ0i2BY",
			"originalText": "Sync",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 1008,
			"versionNonce": 103550951,
			"isDeleted": false,
			"id": "ug1bFnxXMH5RZHtenX_vz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -941.8856135192455,
			"y": 2549.5447023457377,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 99,
			"height": 44,
			"seed": 160526539,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "9FhasIQH"
				}
			],
			"updated": 1689733954222,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 961,
			"versionNonce": 1313506825,
			"isDeleted": false,
			"id": "9FhasIQH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -919.1755839171947,
			"y": 2559.0447023457377,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 53.57994079589844,
			"height": 25,
			"seed": 160057163,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Data",
			"rawText": "Data",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ug1bFnxXMH5RZHtenX_vz",
			"originalText": "Data",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 414,
			"versionNonce": 1980726023,
			"isDeleted": false,
			"id": "9MAw6mM-Gw_Hopv8W85Yo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -304.14380624696537,
			"y": -742.1343941454196,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 111,
			"height": 44,
			"seed": 794764584,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "jzUbNhC8"
				}
			],
			"updated": 1689733954222,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 373,
			"versionNonce": 1358879977,
			"isDeleted": false,
			"id": "jzUbNhC8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -288.4137647430591,
			"y": -732.6343941454196,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 79.5399169921875,
			"height": 25,
			"seed": 1723423272,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "instance",
			"rawText": "instance",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "9MAw6mM-Gw_Hopv8W85Yo",
			"originalText": "instance",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 613,
			"versionNonce": 1754825255,
			"isDeleted": false,
			"id": "6hmhRMdK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -137.7862340358982,
			"y": -323.5333322434108,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 205.24424743652344,
			"height": 25,
			"seed": 550190168,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954222,
			"link": "https://registry.khronos.org/vulkan/specs/1.3-extensions/html/chap54.html",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐extensions [[ref]]",
			"rawText": "extensions [ref](https://registry.khronos.org/vulkan/specs/1.3-extensions/html/chap54.html)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐extensions [[ref]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 384,
			"versionNonce": 1824872393,
			"isDeleted": false,
			"id": "qhvhnGiJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -110.07345283621237,
			"y": -890.7755557428318,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 103.2398681640625,
			"height": 25,
			"seed": 1282608984,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "api version",
			"rawText": "api version",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "api version",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 582,
			"versionNonce": 783525191,
			"isDeleted": false,
			"id": "oFXDNSqRq1sH8iGZ4gJ4R",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -339.5454721769238,
			"y": -265.79136192123775,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 117,
			"height": 35,
			"seed": 12994700,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "HNUpNXg2"
				}
			],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 518,
			"versionNonce": 62486185,
			"isDeleted": false,
			"id": "HNUpNXg2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -312.22544196452145,
			"y": -260.79136192123775,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 62.35993957519531,
			"height": 25,
			"seed": 784387124,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Device",
			"rawText": "Device",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "oFXDNSqRq1sH8iGZ4gJ4R",
			"originalText": "Device",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 436,
			"versionNonce": 1203594343,
			"isDeleted": false,
			"id": "PKQh0Jg5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -109.05112444710457,
			"y": -547.6685046726346,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 100.27989196777344,
			"height": 25,
			"seed": 1973251508,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "extensions",
			"rawText": "extensions",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "extensions",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 649,
			"versionNonce": 679917961,
			"isDeleted": false,
			"id": "5hnqsy3C",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 152.2145739811765,
			"y": -444.26874535232776,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 646.6885375976562,
			"height": 80,
			"seed": 1431936180,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": "https://stackoverflow.com/questions/53050182/vulkan-difference-between-instance-and-device-extensions",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[diff]]\ninstance extension和device extension之间的区别与instance和device之间的区别相关:\ninstance用来获取物理设备以及查询物理设备属性(device extension、feature的支持情况)\ndevice则确定了设备的具体能力",
			"rawText": "[diff](https://stackoverflow.com/questions/53050182/vulkan-difference-between-instance-and-device-extensions)\ninstance extension和device extension之间的区别与instance和device之间的区别相关:\ninstance用来获取物理设备以及查询物理设备属性(device extension、feature的支持情况)\ndevice则确定了设备的具体能力",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[diff]]\ninstance extension和device extension之间的区别与instance和device之间的区别相关:\ninstance用来获取物理设备以及查询物理设备属性(device extension、feature的支持情况)\ndevice则确定了设备的具体能力",
			"lineHeight": 1.25,
			"baseline": 74
		},
		{
			"type": "rectangle",
			"version": 1355,
			"versionNonce": 327303047,
			"isDeleted": false,
			"id": "F1xNj3sg9fcdHjjysXF8J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -554.84556066153,
			"y": -745.1343941454196,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 212,
			"height": 50,
			"seed": 2076007948,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "7TRP2QJK"
				}
			],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 942,
			"versionNonce": 208183401,
			"isDeleted": false,
			"id": "7TRP2QJK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -549.84556066153,
			"y": -740.1343941454196,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 176,
			"height": 40,
			"seed": 2078708748,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "用来获取物理设备, \n以及查询物理设备的属性",
			"rawText": "用来获取物理设备, \n以及查询物理设备的属性",
			"textAlign": "left",
			"verticalAlign": "middle",
			"containerId": "F1xNj3sg9fcdHjjysXF8J",
			"originalText": "用来获取物理设备, \n以及查询物理设备的属性",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "rectangle",
			"version": 927,
			"versionNonce": 1144960679,
			"isDeleted": false,
			"id": "MTtZNUQ4Dzvt6bkGUNgdM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -126.23883900217692,
			"y": -825.4798319192139,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 425,
			"height": 230,
			"seed": 652945932,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "KybCi4Rb"
				}
			],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 554,
			"versionNonce": 757771081,
			"isDeleted": false,
			"id": "KybCi4Rb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -121.23883900217692,
			"y": -820.4798319192139,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 379.6641845703125,
			"height": 220,
			"seed": 183872692,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Layer 通过插入到命令调用中, 从而提供扩展功能: \n调试、性能分析等这里需要SDK支持(vulkan没有内置)\n\n* 根据规范检查参数值以检测误用。\n* 跟踪对象的创建和销毁以发现资源泄漏。\n* 通过跟踪调用源自的线程来检查线程安全。\n* 将每个调用及其参数记录到标准输出。\n* 跟踪 Vulkan 调用以进行分析和重放\n\n相关的layer可以在系统中找到如\n/usr/share/vulkan/explicit_layer.d",
			"rawText": "Layer 通过插入到命令调用中, 从而提供扩展功能: 调试、性能分析等这里需要SDK支持(vulkan没有内置)\n\n* 根据规范检查参数值以检测误用。\n* 跟踪对象的创建和销毁以发现资源泄漏。\n* 通过跟踪调用源自的线程来检查线程安全。\n* 将每个调用及其参数记录到标准输出。\n* 跟踪 Vulkan 调用以进行分析和重放\n\n相关的layer可以在系统中找到如\n/usr/share/vulkan/explicit_layer.d",
			"textAlign": "left",
			"verticalAlign": "middle",
			"containerId": "MTtZNUQ4Dzvt6bkGUNgdM",
			"originalText": "Layer 通过插入到命令调用中, 从而提供扩展功能: 调试、性能分析等这里需要SDK支持(vulkan没有内置)\n\n* 根据规范检查参数值以检测误用。\n* 跟踪对象的创建和销毁以发现资源泄漏。\n* 通过跟踪调用源自的线程来检查线程安全。\n* 将每个调用及其参数记录到标准输出。\n* 跟踪 Vulkan 调用以进行分析和重放\n\n相关的layer可以在系统中找到如\n/usr/share/vulkan/explicit_layer.d",
			"lineHeight": 1.25,
			"baseline": 214
		},
		{
			"type": "text",
			"version": 237,
			"versionNonce": 278874567,
			"isDeleted": false,
			"id": "u5OlwVJY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -100.15628634046996,
			"y": -140.46081206431836,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 89.84858703613281,
			"height": 25.82042154256527,
			"seed": 1518261777,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 20.656337234052216,
			"fontFamily": 1,
			"text": "features",
			"rawText": "features",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "features",
			"lineHeight": 1.25,
			"baseline": 17
		},
		{
			"type": "rectangle",
			"version": 319,
			"versionNonce": 1126717993,
			"isDeleted": false,
			"id": "DxBEDXxsjTPUg3Z4eERVj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 6.93396151054327,
			"y": -168.03411602715596,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 171,
			"height": 31,
			"seed": 1023911537,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "UdWEyZVY"
				}
			],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 278,
			"versionNonce": 633370855,
			"isDeleted": false,
			"id": "UdWEyZVY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 28.46582186210577,
			"y": -162.53411602715596,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 127.936279296875,
			"height": 20,
			"seed": 854760657,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "geometry shader",
			"rawText": "geometry shader",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "DxBEDXxsjTPUg3Z4eERVj",
			"originalText": "geometry shader",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 195,
			"versionNonce": 1867328777,
			"isDeleted": false,
			"id": "MOoly76F",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 339.02830306273427,
			"y": -833.577029535906,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 229.5880126953125,
			"height": 20,
			"seed": 69352223,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": "https://github.com/KhronosGroup/Vulkan-ValidationLayers",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[vulkan validation layer]]",
			"rawText": "[vulkan validation layer](https://github.com/KhronosGroup/Vulkan-ValidationLayers)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[vulkan validation layer]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 72,
			"versionNonce": 1496237063,
			"isDeleted": false,
			"id": "j7dsM5qC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 339.02830306273427,
			"y": -789.3733390407439,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 297.02813720703125,
			"height": 20,
			"seed": 1256050097,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": "https://vulkan.lunarg.com/doc/view/1.3.216.0/mac/api_dump_layer.html",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[VK_LAYER_LUNARG_api_dump]]",
			"rawText": "[VK_LAYER_LUNARG_api_dump](https://vulkan.lunarg.com/doc/view/1.3.216.0/mac/api_dump_layer.html)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[VK_LAYER_LUNARG_api_dump]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 96,
			"versionNonce": 689218537,
			"isDeleted": false,
			"id": "HX0zHfLfgpkGhQt3zBB9r",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -191.72320290385983,
			"y": -722.5754609730299,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 57.8947368421052,
			"height": 129.47368421052624,
			"seed": 588214109,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0526315789472847,
					-1.0526315789472847
				],
				[
					1.0526315789472847,
					-3.1578947368420813
				],
				[
					5.263157894736764,
					-10.526315789473529
				],
				[
					7.368421052631561,
					-16.842105263157805
				],
				[
					9.473684210526244,
					-22.10526315789457
				],
				[
					11.57894736842104,
					-27.368421052631447
				],
				[
					13.684210526315724,
					-32.631578947368325
				],
				[
					13.684210526315724,
					-34.73684210526312
				],
				[
					13.684210526315724,
					-36.842105263157805
				],
				[
					14.736842105263122,
					-38.94736842105249
				],
				[
					14.736842105263122,
					-41.052631578947285
				],
				[
					15.78947368421052,
					-44.210526315789366
				],
				[
					16.842105263157805,
					-46.31578947368416
				],
				[
					16.842105263157805,
					-49.473684210526244
				],
				[
					17.894736842105203,
					-53.684210526315724
				],
				[
					18.9473684210526,
					-55.78947368421041
				],
				[
					20,
					-57.8947368421052
				],
				[
					20,
					-59.999999999999886
				],
				[
					21.052631578947285,
					-65.26315789473676
				],
				[
					22.105263157894683,
					-69.47368421052624
				],
				[
					23.15789473684208,
					-72.63157894736833
				],
				[
					25.263157894736764,
					-78.94736842105249
				],
				[
					26.315789473684163,
					-81.05263157894728
				],
				[
					27.36842105263156,
					-84.21052631578937
				],
				[
					28.42105263157896,
					-87.36842105263145
				],
				[
					29.473684210526244,
					-89.47368421052624
				],
				[
					29.473684210526244,
					-91.57894736842093
				],
				[
					30.526315789473642,
					-93.68421052631572
				],
				[
					32.631578947368325,
					-95.7894736842104
				],
				[
					33.684210526315724,
					-98.94736842105249
				],
				[
					34.73684210526312,
					-101.05263157894728
				],
				[
					35.78947368421052,
					-102.10526315789468
				],
				[
					36.842105263157805,
					-104.21052631578937
				],
				[
					38.9473684210526,
					-107.36842105263145
				],
				[
					40,
					-108.42105263157885
				],
				[
					41.052631578947285,
					-110.52631578947353
				],
				[
					42.10526315789468,
					-111.57894736842093
				],
				[
					43.15789473684208,
					-112.63157894736833
				],
				[
					44.21052631578948,
					-114.73684210526312
				],
				[
					45.263157894736764,
					-115.7894736842104
				],
				[
					46.31578947368416,
					-116.8421052631578
				],
				[
					47.36842105263156,
					-117.8947368421052
				],
				[
					48.42105263157896,
					-119.99999999999989
				],
				[
					50.52631578947364,
					-122.10526315789468
				],
				[
					52.631578947368325,
					-123.15789473684208
				],
				[
					53.684210526315724,
					-124.21052631578937
				],
				[
					54.73684210526312,
					-125.26315789473676
				],
				[
					55.78947368421052,
					-126.31578947368416
				],
				[
					55.78947368421052,
					-127.36842105263145
				],
				[
					56.842105263157805,
					-128.42105263157885
				],
				[
					57.8947368421052,
					-128.42105263157885
				],
				[
					57.8947368421052,
					-129.47368421052624
				],
				[
					57.8947368421052,
					-129.47368421052624
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 79,
			"versionNonce": 451324711,
			"isDeleted": false,
			"id": "A69nWMw1SzB8VeANKtDRM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -189.61793974596515,
			"y": -721.5228293940824,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 50.52631578947364,
			"height": 9.473684210526244,
			"seed": 1952504019,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					1.0526315789472847
				],
				[
					1.0526315789473983,
					1.0526315789472847
				],
				[
					3.1578947368420813,
					2.105263157894683
				],
				[
					4.21052631578948,
					3.1578947368420813
				],
				[
					5.263157894736878,
					3.1578947368420813
				],
				[
					6.315789473684276,
					4.210526315789366
				],
				[
					8.42105263157896,
					4.210526315789366
				],
				[
					9.473684210526358,
					5.263157894736764
				],
				[
					11.57894736842104,
					5.263157894736764
				],
				[
					13.684210526315837,
					6.315789473684163
				],
				[
					15.78947368421052,
					7.368421052631447
				],
				[
					16.84210526315792,
					7.368421052631447
				],
				[
					17.894736842105317,
					7.368421052631447
				],
				[
					18.9473684210526,
					8.42105263157896
				],
				[
					21.0526315789474,
					8.42105263157896
				],
				[
					22.105263157894797,
					9.473684210526244
				],
				[
					23.15789473684208,
					9.473684210526244
				],
				[
					24.21052631578948,
					9.473684210526244
				],
				[
					26.315789473684276,
					9.473684210526244
				],
				[
					28.42105263157896,
					9.473684210526244
				],
				[
					29.473684210526358,
					9.473684210526244
				],
				[
					30.526315789473642,
					9.473684210526244
				],
				[
					31.57894736842104,
					9.473684210526244
				],
				[
					33.68421052631584,
					9.473684210526244
				],
				[
					36.84210526315792,
					9.473684210526244
				],
				[
					38.9473684210526,
					9.473684210526244
				],
				[
					40,
					9.473684210526244
				],
				[
					41.0526315789474,
					9.473684210526244
				],
				[
					42.1052631578948,
					9.473684210526244
				],
				[
					43.15789473684208,
					9.473684210526244
				],
				[
					46.315789473684276,
					9.473684210526244
				],
				[
					47.36842105263156,
					9.473684210526244
				],
				[
					48.42105263157896,
					9.473684210526244
				],
				[
					49.47368421052636,
					9.473684210526244
				],
				[
					50.52631578947364,
					9.473684210526244
				],
				[
					50.52631578947364,
					9.473684210526244
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 125,
			"versionNonce": 1820999369,
			"isDeleted": false,
			"id": "h2o8NZvQrDWH8CcyO4AsA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -220.1601387730393,
			"y": -245.17877196551603,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 115.32319232482013,
			"height": 114.59200381053324,
			"seed": 1582369491,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.402566506767024,
					9.450886912208945
				],
				[
					6.006416266917754,
					16.53905209636559
				],
				[
					9.610266027068356,
					23.627217280522363
				],
				[
					14.415399040602534,
					30.715382464679006
				],
				[
					20.42181530752016,
					40.16626937688795
				],
				[
					28.830798081205067,
					51.97987801714907
				],
				[
					37.239780854889844,
					60.249404065331866
				],
				[
					42.04491386842402,
					64.97484752143633
				],
				[
					44.44748037519105,
					68.51893011351478
				],
				[
					46.8500468819582,
					73.24437356961926
				],
				[
					51.655179895492374,
					77.9698170257236
				],
				[
					56.46031290902643,
					81.51389961780205
				],
				[
					62.46672917594418,
					86.23934307390653
				],
				[
					69.67442869624551,
					90.964786530011
				],
				[
					73.27827845639611,
					92.14614739403703
				],
				[
					74.47956170977969,
					93.32750825806318
				],
				[
					75.68084496316314,
					93.32750825806318
				],
				[
					75.68084496316314,
					94.50886912208932
				],
				[
					76.88212821654672,
					95.69022998611547
				],
				[
					78.08341146993028,
					96.8715908501415
				],
				[
					80.48597797669731,
					98.05295171416765
				],
				[
					82.88854448346447,
					100.41567344221981
				],
				[
					86.49239424361507,
					102.77839517027212
				],
				[
					91.29752725714924,
					105.14111689832428
				],
				[
					94.90137701729985,
					107.50383862637659
				],
				[
					98.50522677745045,
					108.68519949040274
				],
				[
					102.10907653760104,
					109.86656035442876
				],
				[
					103.31035979098462,
					109.86656035442876
				],
				[
					104.5116430443682,
					109.86656035442876
				],
				[
					104.5116430443682,
					111.04792121845492
				],
				[
					105.71292629775178,
					111.04792121845492
				],
				[
					108.1154928045188,
					111.04792121845492
				],
				[
					109.31677605790237,
					112.22928208248106
				],
				[
					111.7193425646694,
					112.22928208248106
				],
				[
					112.92062581805298,
					113.41064294650721
				],
				[
					114.12190907143656,
					113.41064294650721
				],
				[
					115.32319232482013,
					113.41064294650721
				],
				[
					115.32319232482013,
					114.59200381053324
				],
				[
					115.32319232482013,
					114.59200381053324
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "rectangle",
			"version": 445,
			"versionNonce": 659861063,
			"isDeleted": false,
			"id": "b1lmDQYkX5FjOao0zZIVR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -734.6034087823696,
			"y": 743.0338700516949,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 176,
			"height": 62,
			"seed": 518448893,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "p4bugCjR"
				},
				{
					"id": "IaWKs7jQyGFdW4rRfbPqi",
					"type": "arrow"
				},
				{
					"id": "yOwd51MsUt1B1mBc6KVDI",
					"type": "arrow"
				}
			],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 417,
			"versionNonce": 675904937,
			"isDeleted": false,
			"id": "p4bugCjR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -725.4533080743618,
			"y": 761.5338700516949,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 157.69979858398438,
			"height": 25,
			"seed": 1157736243,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Graphics pipeline",
			"rawText": "Graphics pipeline",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "b1lmDQYkX5FjOao0zZIVR",
			"originalText": "Graphics pipeline",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 794,
			"versionNonce": 2035633511,
			"isDeleted": false,
			"id": "9bONTo82v2PJ_VnFKS-w-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -722.2904894816019,
			"y": 1152.376604966987,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 176,
			"height": 62,
			"seed": 1461541459,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "Y2s3t9U2"
				}
			],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 796,
			"versionNonce": 1803411593,
			"isDeleted": false,
			"id": "Y2s3t9U2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -711.8103945719339,
			"y": 1170.876604966987,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 155.03981018066406,
			"height": 25,
			"seed": 934963293,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Compute pipeline",
			"rawText": "Compute pipeline",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "9bONTo82v2PJ_VnFKS-w-",
			"originalText": "Compute pipeline",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 234,
			"versionNonce": 2083850375,
			"isDeleted": false,
			"id": "ChAZZmL0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 742.4113970909834,
			"y": 706.3653608126943,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 265.70440673828125,
			"height": 25,
			"seed": 1004614941,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": "https://zhuanlan.zhihu.com/p/55304721",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[管线以及管线状态管理]]",
			"rawText": "[管线以及管线状态管理](https://zhuanlan.zhihu.com/p/55304721)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[管线以及管线状态管理]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 254,
			"versionNonce": 1407379305,
			"isDeleted": false,
			"id": "CUG15VR4Cn1eWqlutgOO7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 417.0780637576497,
			"y": 703.3653608126943,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 216,
			"height": 92,
			"seed": 1026848659,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "Ez8sDNeo"
				}
			],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 239,
			"versionNonce": 2108710823,
			"isDeleted": false,
			"id": "Ez8sDNeo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 458.79814127229815,
			"y": 736.8653608126943,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 132.55984497070312,
			"height": 25,
			"seed": 1177136083,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954223,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Pipeline cache",
			"rawText": "Pipeline cache",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "CUG15VR4Cn1eWqlutgOO7",
			"originalText": "Pipeline cache",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 273,
			"versionNonce": 1227832243,
			"isDeleted": false,
			"id": "Mk5vIOvi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 742.4113970909834,
			"y": 761.9844084317418,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 401.864013671875,
			"height": 25,
			"seed": 915486397,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689817363913,
			"link": "https://zeux.io/2019/07/17/serializing-pipeline-cache/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[Robust pipeline cache serialization]]",
			"rawText": "[Robust pipeline cache serialization](https://zeux.io/2019/07/17/serializing-pipeline-cache/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[Robust pipeline cache serialization]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 83,
			"versionNonce": 1609814727,
			"isDeleted": false,
			"id": "cF7a9EhE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 849.0134306639322,
			"y": -602.232189120974,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 679.9842529296875,
			"height": 25,
			"seed": 1927611859,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": "https://vkguide.dev/docs/chapter-1/vulkan_init_code/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐另外[[Vulkan Guide]] 教你一步一步如何搭建绘制流程, 对新手非常友好!",
			"rawText": "另外[Vulkan Guide](https://vkguide.dev/docs/chapter-1/vulkan_init_code/) 教你一步一步如何搭建绘制流程, 对新手非常友好!",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐另外[[Vulkan Guide]] 教你一步一步如何搭建绘制流程, 对新手非常友好!",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 461,
			"versionNonce": 670884137,
			"isDeleted": false,
			"id": "EsoRN7ez",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1133.07307616187,
			"y": -101.58926883592369,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 349.80413818359375,
			"height": 25,
			"seed": 470365917,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": "https://registry.khronos.org/vulkan/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[官方specification & reference]]",
			"rawText": "[官方specification & reference](https://registry.khronos.org/vulkan/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[官方specification & reference]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 335,
			"versionNonce": 194765287,
			"isDeleted": false,
			"id": "0O1xdIGNq3fa0x2fV2yBc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1809.7009979480301,
			"y": -96.79042526480941,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 357,
			"height": 91,
			"seed": 1371100285,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "ARdgx1Yi"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 388,
			"versionNonce": 1703006553,
			"isDeleted": false,
			"id": "ARdgx1Yi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1795.3531891101395,
			"y": -63.790425264809414,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 328.30438232421875,
			"height": 25,
			"seed": 44515187,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1690248911933,
			"link": "http://geekfaner.com/shineengine/blog1_career.html",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[王烁-图形渲染技术&职业生涯]]",
			"rawText": "[王烁-图形渲染技术&职业生涯](http://geekfaner.com/shineengine/blog1_career.html)",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "0O1xdIGNq3fa0x2fV2yBc",
			"originalText": "🌐[[王烁-图形渲染技术&职业生涯]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 329,
			"versionNonce": 565513479,
			"isDeleted": false,
			"id": "ysk_8VVB6QndbLThPjmFR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -387.85569703729516,
			"y": 492.83443127657335,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 160,
			"height": 45,
			"seed": 2008992976,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "I3eSwx7J"
				},
				{
					"id": "IaWKs7jQyGFdW4rRfbPqi",
					"type": "arrow"
				},
				{
					"id": "Fq5w72AJyOO7dLTxaFRDc",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 290,
			"versionNonce": 1236495081,
			"isDeleted": false,
			"id": "I3eSwx7J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -367.695624710635,
			"y": 502.83443127657335,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 119.67985534667969,
			"height": 25,
			"seed": 350032432,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Render pass",
			"rawText": "Render pass",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ysk_8VVB6QndbLThPjmFR",
			"originalText": "Render pass",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 1377,
			"versionNonce": 1841026087,
			"isDeleted": false,
			"id": "BG0r7nN6iTBqMyiIh4Tuy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -391.3410162029777,
			"y": 576.2492343111516,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 588,
			"height": 139,
			"seed": 1457353424,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "TUqsVMtw"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 1506,
			"versionNonce": 1001924041,
			"isDeleted": false,
			"id": "TUqsVMtw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -386.3410162029777,
			"y": 581.2492343111516,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 556.879638671875,
			"height": 125,
			"seed": 1915653168,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "render pass compatibility(for graphics pipeline):\nattachment 数量相同(允许有VK_ATTACHMENT_UNUSED)\n对应attachment的format、sample count一致\n\n注: 允许attachment有不同的extend, load/store, layout",
			"rawText": "render pass compatibility(for graphics pipeline):\nattachment 数量相同(允许有VK_ATTACHMENT_UNUSED)\n对应attachment的format、sample count一致\n\n注: 允许attachment有不同的extend, load/store, layout",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": "BG0r7nN6iTBqMyiIh4Tuy",
			"originalText": "render pass compatibility(for graphics pipeline):\nattachment 数量相同(允许有VK_ATTACHMENT_UNUSED)\n对应attachment的format、sample count一致\n\n注: 允许attachment有不同的extend, load/store, layout",
			"lineHeight": 1.25,
			"baseline": 118
		},
		{
			"type": "rectangle",
			"version": 544,
			"versionNonce": 396146503,
			"isDeleted": false,
			"id": "HqMsZjgtVTcZlnGxskMQC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -627.5272010899139,
			"y": 2333.5237109700665,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 149,
			"height": 61,
			"seed": 964823600,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "VUAZ78FG"
				},
				{
					"id": "9UuEP5s2aAyxtS_VPijJb",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 487,
			"versionNonce": 1193444521,
			"isDeleted": false,
			"id": "VUAZ78FG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -581.9571708775115,
			"y": 2351.5237109700665,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 57.85993957519531,
			"height": 25,
			"seed": 810781904,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Image",
			"rawText": "Image",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "HqMsZjgtVTcZlnGxskMQC",
			"originalText": "Image",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 658,
			"versionNonce": 364131943,
			"isDeleted": false,
			"id": "ecoGQyUOPjZitOISe84Rq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -616.6166583540254,
			"y": 2915.466960391191,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 156,
			"height": 61,
			"seed": 2073667280,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "9amyTdkp"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 621,
			"versionNonce": 2006845321,
			"isDeleted": false,
			"id": "9amyTdkp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -571.056622648459,
			"y": 2933.466960391191,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 64.87992858886719,
			"height": 25,
			"seed": 428170800,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Buffer",
			"rawText": "Buffer",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ecoGQyUOPjZitOISe84Rq",
			"originalText": "Buffer",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 952,
			"versionNonce": 1590612359,
			"isDeleted": false,
			"id": "xZITBcKMISab2S6sSJXZB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -450.12311609429094,
			"y": 2510.1463775406332,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 80,
			"height": 35,
			"seed": 1393964080,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "7lRVwubC"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 965,
			"versionNonce": 1466314345,
			"isDeleted": false,
			"id": "7lRVwubC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -434.8111654106972,
			"y": 2517.6463775406332,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 49.3760986328125,
			"height": 20,
			"seed": 1139334864,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "layout",
			"rawText": "layout",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "xZITBcKMISab2S6sSJXZB",
			"originalText": "layout",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 825,
			"versionNonce": 1546193063,
			"isDeleted": false,
			"id": "7N4WVheJ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -313.01001167284795,
			"y": 2486.0261559403566,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 532.4652099609375,
			"height": 80,
			"seed": 133468720,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL\nVK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL\nVK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL\n...",
			"rawText": "VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL\nVK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL\nVK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL\n...",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL\nVK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL\nVK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL\n...",
			"lineHeight": 1.25,
			"baseline": 74
		},
		{
			"type": "rectangle",
			"version": 504,
			"versionNonce": 491157833,
			"isDeleted": false,
			"id": "1s0h_LZGw9uFdnBWx4wMj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -97.45833721864074,
			"y": 489.33443127657335,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 264,
			"height": 52,
			"seed": 2005856081,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"type": "text",
					"id": "Fp9OCP7y"
				},
				{
					"id": "mhUP4-Dlja3Wehs6M2VuT",
					"type": "arrow"
				},
				{
					"id": "ajpUmjrIxEUM2AmiFo7gc",
					"type": "arrow"
				},
				{
					"id": "bB8CUXU_h3TBNTMv0Qt0s",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 498,
			"versionNonce": 460282823,
			"isDeleted": false,
			"id": "Fp9OCP7y",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -86.53820934998839,
			"y": 502.83443127657335,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 242.1597442626953,
			"height": 25,
			"seed": 1486728529,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VkRenderPassCreateInfo",
			"rawText": "VkRenderPassCreateInfo",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "1s0h_LZGw9uFdnBWx4wMj",
			"originalText": "VkRenderPassCreateInfo",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 351,
			"versionNonce": 446326825,
			"isDeleted": false,
			"id": "ttZCYIlzn9L6J0XKtzqKs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 234.77427630123782,
			"y": 569.8481977167322,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 217,
			"height": 35,
			"seed": 1430371377,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "zu3TMxtZ",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 354,
			"versionNonce": 1086212839,
			"isDeleted": false,
			"id": "zu3TMxtZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 240.05438189205813,
			"y": 574.8481977167322,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 206.43978881835938,
			"height": 25,
			"seed": 846029937,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VkSubpassDependency",
			"rawText": "VkSubpassDependency",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ttZCYIlzn9L6J0XKtzqKs",
			"originalText": "VkSubpassDependency",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 681,
			"versionNonce": 1766685449,
			"isDeleted": false,
			"id": "0ba52DQEEdMgc6ohb6DRn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 227.02055701762026,
			"y": 338.2058341186586,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 260,
			"height": 35,
			"seed": 105524511,
			"groupIds": [
				"x-ji9gGxUHbajrUL1rrSf"
			],
			"roundness": null,
			"boundElements": [
				{
					"id": "YNSRZZiO",
					"type": "text"
				},
				{
					"id": "mhUP4-Dlja3Wehs6M2VuT",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 816,
			"versionNonce": 950162951,
			"isDeleted": false,
			"id": "YNSRZZiO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 237.1806751206476,
			"y": 343.2058341186586,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 239.6797637939453,
			"height": 25,
			"seed": 174168287,
			"groupIds": [
				"x-ji9gGxUHbajrUL1rrSf"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VkAttachmentDescription",
			"rawText": "VkAttachmentDescription",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "0ba52DQEEdMgc6ohb6DRn",
			"originalText": "VkAttachmentDescription",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 254,
			"versionNonce": 1507537385,
			"isDeleted": false,
			"id": "eUdKzPG74aACuTDmS_sOR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 520.458789931925,
			"y": 295.560378058762,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 279,
			"height": 108,
			"seed": 2031686655,
			"groupIds": [
				"x-ji9gGxUHbajrUL1rrSf"
			],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "u9zqe9px",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 334,
			"versionNonce": 706215207,
			"isDeleted": false,
			"id": "u9zqe9px",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 552.7089272610266,
			"y": 312.060378058762,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 214.49972534179688,
			"height": 75,
			"seed": 673875423,
			"groupIds": [
				"x-ji9gGxUHbajrUL1rrSf"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "format, sample count\nload/store\ninit/final image layout",
			"rawText": "format, sample count\nload/store\ninit/final image layout",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "eUdKzPG74aACuTDmS_sOR",
			"originalText": "format, sample count\nload/store\ninit/final image layout",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "rectangle",
			"version": 355,
			"versionNonce": 558828745,
			"isDeleted": false,
			"id": "WwrjnYfvT8jZVpvlXvx6A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 230.81264865662422,
			"y": 473.4384875988559,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 216,
			"height": 35,
			"seed": 1278984241,
			"groupIds": [
				"Xq3-MNxKBqi7GRIetHA2F"
			],
			"roundness": null,
			"boundElements": [
				{
					"id": "UtTZtJFf",
					"type": "text"
				},
				{
					"id": "bB8CUXU_h3TBNTMv0Qt0s",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 395,
			"versionNonce": 680247367,
			"isDeleted": false,
			"id": "UtTZtJFf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 236.2827643182453,
			"y": 478.4384875988559,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 205.0597686767578,
			"height": 25,
			"seed": 1034926239,
			"groupIds": [
				"Xq3-MNxKBqi7GRIetHA2F"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VkSubpassDescription",
			"rawText": "VkSubpassDescription",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "WwrjnYfvT8jZVpvlXvx6A",
			"originalText": "VkSubpassDescription",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 179,
			"versionNonce": 1195674537,
			"isDeleted": false,
			"id": "j_kWCgzDhFuxHkQxKuN-E",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 517.0210811270965,
			"y": 460.9384875988559,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 306,
			"height": 60,
			"seed": 1295848863,
			"groupIds": [
				"Xq3-MNxKBqi7GRIetHA2F"
			],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "kziOnwkc",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 345,
			"versionNonce": 635051879,
			"isDeleted": false,
			"id": "kziOnwkc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 532.1012202872528,
			"y": 465.9384875988559,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 275.8397216796875,
			"height": 50,
			"seed": 2124624209,
			"groupIds": [
				"Xq3-MNxKBqi7GRIetHA2F"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "color/input/depth_stencil... \nattachment reference(index)",
			"rawText": "color/input/depth_stencil... attachment reference(index)",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "j_kWCgzDhFuxHkQxKuN-E",
			"originalText": "color/input/depth_stencil... attachment reference(index)",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "arrow",
			"version": 743,
			"versionNonce": 866613847,
			"isDeleted": false,
			"id": "mhUP4-Dlja3Wehs6M2VuT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 228.54271102773265,
			"y": 375.18992616358116,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 60.111888521613565,
			"height": 136.61223679289446,
			"seed": 2096431441,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911944,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "0ba52DQEEdMgc6ohb6DRn",
				"gap": 1.9840920449225905,
				"focus": 0.8707640447988935
			},
			"endBinding": {
				"elementId": "1s0h_LZGw9uFdnBWx4wMj",
				"gap": 1.8891597247597929,
				"focus": 0.9225770858144933
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-60.111888521613565,
					136.61223679289446
				]
			]
		},
		{
			"type": "arrow",
			"version": 659,
			"versionNonce": 932452215,
			"isDeleted": false,
			"id": "bB8CUXU_h3TBNTMv0Qt0s",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 229.07052828486167,
			"y": 501.37353878686906,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 55.20286589437251,
			"height": 15.273266918133345,
			"seed": 658085457,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911946,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "WwrjnYfvT8jZVpvlXvx6A",
				"gap": 1.742120371762553,
				"focus": 0.42058859738743337
			},
			"endBinding": {
				"elementId": "1s0h_LZGw9uFdnBWx4wMj",
				"gap": 7.3259996091298945,
				"focus": 0.6375513124139456
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-55.20286589437251,
					15.273266918133345
				]
			]
		},
		{
			"type": "arrow",
			"version": 386,
			"versionNonce": 1882870807,
			"isDeleted": false,
			"id": "ajpUmjrIxEUM2AmiFo7gc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 234.92820174897724,
			"y": 584.5403468212543,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 67.38653896761798,
			"height": 76.3650733501197,
			"seed": 218804415,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911941,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "1s0h_LZGw9uFdnBWx4wMj",
				"gap": 1,
				"focus": -0.8991523072472105
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-67.38653896761798,
					-76.3650733501197
				]
			]
		},
		{
			"type": "rectangle",
			"version": 287,
			"versionNonce": 682144167,
			"isDeleted": false,
			"id": "6YpzTBoQlLAyCtxx_l8X0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -392.24445705211156,
			"y": 870.2901038811398,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 148,
			"height": 35,
			"seed": 224969034,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "yy8MByKT",
					"type": "text"
				},
				{
					"id": "waxHs5jN13K71_JVsrL9d",
					"type": "arrow"
				},
				{
					"id": "QQkCkMj0ytdOxkdjAaOdh",
					"type": "arrow"
				},
				{
					"id": "b_JG3sKm_2v_JgA5yJS5_",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 301,
			"versionNonce": 414310473,
			"isDeleted": false,
			"id": "yy8MByKT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -386.9243734339475,
			"y": 875.2901038811398,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 137.35983276367188,
			"height": 25,
			"seed": 1394410454,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Pipeline State",
			"rawText": "Pipeline State",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "6YpzTBoQlLAyCtxx_l8X0",
			"originalText": "Pipeline State",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 334,
			"versionNonce": 1813112007,
			"isDeleted": false,
			"id": "L-B8q6fiAtFK8i5TaExux",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -181.7181412626378,
			"y": 784.1959423383267,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 142,
			"height": 35,
			"seed": 1105906122,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "0ihgLmtf",
					"type": "text"
				},
				{
					"id": "waxHs5jN13K71_JVsrL9d",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 381,
			"versionNonce": 33615657,
			"isDeleted": false,
			"id": "0ihgLmtf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -176.44806069623155,
			"y": 789.1959423383267,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 131.4598388671875,
			"height": 25,
			"seed": 1859981898,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "shader stage",
			"rawText": "shader stage",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "L-B8q6fiAtFK8i5TaExux",
			"originalText": "shader stage",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "arrow",
			"version": 719,
			"versionNonce": 533741113,
			"isDeleted": false,
			"id": "IaWKs7jQyGFdW4rRfbPqi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -555.9257552549531,
			"y": 769.5115682537403,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 166.88969231453746,
			"height": 246.5407735081693,
			"seed": 854483862,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "3dsmJS2e"
				}
			],
			"updated": 1690248911934,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "b1lmDQYkX5FjOao0zZIVR",
				"gap": 2.67765352741651,
				"focus": 0.8039330752064568
			},
			"endBinding": {
				"elementId": "ysk_8VVB6QndbLThPjmFR",
				"gap": 1.180365903120446,
				"focus": 0.7981777152085675
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					166.88969231453746,
					-246.5407735081693
				]
			]
		},
		{
			"type": "text",
			"version": 176,
			"versionNonce": 1347101193,
			"isDeleted": false,
			"id": "3dsmJS2e",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -541.7008263950477,
			"y": 621.8448228995056,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 138.43983459472656,
			"height": 50,
			"seed": 570630614,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "sub pass\nin render pass",
			"rawText": "sub pass\nin render pass",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "IaWKs7jQyGFdW4rRfbPqi",
			"originalText": "sub pass\nin render pass",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "rectangle",
			"version": 385,
			"versionNonce": 116825863,
			"isDeleted": false,
			"id": "eCLhDJMIlbe_Yj2oJuoVu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -452.9318259144344,
			"y": 2211.9474932032376,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 101,
			"height": 35,
			"seed": 2028783574,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "c41DXZmE",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 439,
			"versionNonce": 9173225,
			"isDeleted": false,
			"id": "c41DXZmE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -438.455904283575,
			"y": 2219.4474932032376,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 72.04815673828125,
			"height": 20,
			"seed": 1927307414,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "extent3d",
			"rawText": "extent3d",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "eCLhDJMIlbe_Yj2oJuoVu",
			"originalText": "extent3d",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 502,
			"versionNonce": 419112487,
			"isDeleted": false,
			"id": "O8vlGOcFctOyoto2jQ2qz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -450.12311609429094,
			"y": 2448.1556385759854,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 67,
			"height": 35,
			"seed": 556738378,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "byfhFh2T",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 531,
			"versionNonce": 1682895817,
			"isDeleted": false,
			"id": "byfhFh2T",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -439.2311635796425,
			"y": 2455.6556385759854,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 45.216094970703125,
			"height": 20,
			"seed": 1060645066,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "usage",
			"rawText": "usage",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "O8vlGOcFctOyoto2jQ2qz",
			"originalText": "usage",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 400,
			"versionNonce": 52545863,
			"isDeleted": false,
			"id": "uQBQahjhvqVdD7BaHb25E",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -451.5274710043626,
			"y": 2343.8360809738238,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 84,
			"height": 35,
			"seed": 455699237,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "m6n2RStp",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 557,
			"versionNonce": 263164585,
			"isDeleted": false,
			"id": "m6n2RStp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -439.0395330771165,
			"y": 2351.3360809738238,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 59.02412414550781,
			"height": 20,
			"seed": 619124630,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "samples",
			"rawText": "samples",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "uQBQahjhvqVdD7BaHb25E",
			"originalText": "samples",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 464,
			"versionNonce": 851904615,
			"isDeleted": false,
			"id": "ElS3lvy_dTWzOhUGqNWuv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -452.9318259144344,
			"y": 2261.4103687658785,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 126,
			"height": 35,
			"seed": 1491022730,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "wDKOcw0Z",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 511,
			"versionNonce": 123295113,
			"isDeleted": false,
			"id": "wDKOcw0Z",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -436.1799185658016,
			"y": 2268.9103687658785,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 92.49618530273438,
			"height": 20,
			"seed": 946502998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "mipmap level",
			"rawText": "mipmap level",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ElS3lvy_dTWzOhUGqNWuv",
			"originalText": "mipmap level",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 170,
			"versionNonce": 901211015,
			"isDeleted": false,
			"id": "qgh--5WsTvopN_2M3WfLD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -182.78995877304465,
			"y": 837.0645363606505,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 157,
			"height": 35,
			"seed": 749918922,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "2ADXoXmG",
					"type": "text"
				},
				{
					"id": "QQkCkMj0ytdOxkdjAaOdh",
					"type": "arrow"
				},
				{
					"id": "WxrfV_zM8Y84tUZviqbl8",
					"type": "arrow"
				},
				{
					"id": "W0OTPU3Micx4f6cUhpsAF",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 286,
			"versionNonce": 780647529,
			"isDeleted": false,
			"id": "2ADXoXmG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -177.66987210312277,
			"y": 842.0645363606505,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 146.75982666015625,
			"height": 25,
			"seed": 984016650,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Pipeline Layout",
			"rawText": "Pipeline Layout",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "qgh--5WsTvopN_2M3WfLD",
			"originalText": "Pipeline Layout",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 159,
			"versionNonce": 741300903,
			"isDeleted": false,
			"id": "gSsz97ctHKWn5pR5OLPHN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -187.04993802109175,
			"y": 889.9331303829745,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 206,
			"height": 185,
			"seed": 609322314,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "12zTYOXn",
					"type": "text"
				},
				{
					"id": "b_JG3sKm_2v_JgA5yJS5_",
					"type": "arrow"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 331,
			"versionNonce": 1963345737,
			"isDeleted": false,
			"id": "12zTYOXn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -182.04993802109175,
			"y": 894.9331303829745,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 195.27978515625,
			"height": 175,
			"seed": 1840151882,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "vertex Input State\nInputAssembly\nRasterization\nViewport\nMultiSample\nDepthStencil\nColorblend",
			"rawText": "vertex Input State\nInputAssembly\nRasterization\nViewport\nMultiSample\nDepthStencil\nColorblend",
			"textAlign": "left",
			"verticalAlign": "middle",
			"containerId": "gSsz97ctHKWn5pR5OLPHN",
			"originalText": "vertex Input State\nInputAssembly\nRasterization\nViewport\nMultiSample\nDepthStencil\nColorblend",
			"lineHeight": 1.25,
			"baseline": 168
		},
		{
			"type": "arrow",
			"version": 354,
			"versionNonce": 632244345,
			"isDeleted": false,
			"id": "yOwd51MsUt1B1mBc6KVDI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -553.8837296534928,
			"y": 773.8804988040273,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 162.10526315789468,
			"height": 108.42105263157873,
			"seed": 1044136010,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911929,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "b1lmDQYkX5FjOao0zZIVR",
				"gap": 4.719679128876805,
				"focus": -0.6918446395732845
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					162.10526315789468,
					108.42105263157873
				]
			]
		},
		{
			"type": "arrow",
			"version": 655,
			"versionNonce": 2019369975,
			"isDeleted": false,
			"id": "waxHs5jN13K71_JVsrL9d",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -242.30478228507184,
			"y": 889.6699724882374,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 59.58664102243404,
			"height": 82.58499369775939,
			"seed": 1544695370,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911951,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "6YpzTBoQlLAyCtxx_l8X0",
				"gap": 1.939674767039719,
				"focus": 0.8922900295463883
			},
			"endBinding": {
				"elementId": "L-B8q6fiAtFK8i5TaExux",
				"gap": 1,
				"focus": 0.8144743695190162
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					59.58664102243404,
					-82.58499369775939
				]
			]
		},
		{
			"type": "arrow",
			"version": 671,
			"versionNonce": 1461947671,
			"isDeleted": false,
			"id": "QQkCkMj0ytdOxkdjAaOdh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -242.30478228507184,
			"y": 885.4594461724481,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 56.84210526315792,
			"height": 32.63157894736844,
			"seed": 244870230,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911957,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "6YpzTBoQlLAyCtxx_l8X0",
				"gap": 1.939674767039719,
				"focus": 0.6879513434729491
			},
			"endBinding": {
				"elementId": "qgh--5WsTvopN_2M3WfLD",
				"gap": 2.6727182488692733,
				"focus": 0.7725719695236866
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					56.84210526315792,
					-32.63157894736844
				]
			]
		},
		{
			"type": "arrow",
			"version": 687,
			"versionNonce": 1515615063,
			"isDeleted": false,
			"id": "b_JG3sKm_2v_JgA5yJS5_",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -243.24445705211156,
			"y": 885.5063339056927,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 55.19451903101981,
			"height": 22.910932427970465,
			"seed": 386980106,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911958,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "6YpzTBoQlLAyCtxx_l8X0",
				"gap": 1,
				"focus": -0.693030643200428
			},
			"endBinding": {
				"elementId": "gSsz97ctHKWn5pR5OLPHN",
				"gap": 1,
				"focus": 0.22805897950945123
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					55.19451903101981,
					22.910932427970465
				]
			]
		},
		{
			"type": "arrow",
			"version": 556,
			"versionNonce": 1215869913,
			"isDeleted": false,
			"id": "WxrfV_zM8Y84tUZviqbl8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -40.19951912717727,
			"y": 800.1962882777112,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 109.47368421052647,
			"height": 55.789473684210634,
			"seed": 28175690,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911957,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "qgh--5WsTvopN_2M3WfLD",
				"gap": 5.590439645867377,
				"focus": 0.2554622808801908
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					109.47368421052647,
					0
				],
				[
					108.42105263157896,
					51.578947368421154
				],
				[
					20,
					55.789473684210634
				]
			]
		},
		{
			"type": "rectangle",
			"version": 350,
			"versionNonce": 1690681321,
			"isDeleted": false,
			"id": "ao1bg9q4THmLUQFjyVe78",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -452.9318259144344,
			"y": 2158.9175257280967,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 77,
			"height": 35,
			"seed": 118989669,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "riC9Kydi",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 369,
			"versionNonce": 56971047,
			"isDeleted": false,
			"id": "riC9Kydi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -441.11188725476643,
			"y": 2166.4175257280967,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 53.36012268066406,
			"height": 20,
			"seed": 895385861,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "format",
			"rawText": "format",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ao1bg9q4THmLUQFjyVe78",
			"originalText": "format",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 378,
			"versionNonce": 1270340297,
			"isDeleted": false,
			"id": "WUtwD51iGOgdSZ187zS8V",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -450.12311609429094,
			"y": 2393.9150736492993,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 55,
			"height": 35,
			"seed": 980445797,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "c3oUdLzr",
					"type": "text"
				}
			],
			"updated": 1689733954224,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 388,
			"versionNonce": 1348391495,
			"isDeleted": false,
			"id": "c3oUdLzr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -440.49516351860734,
			"y": 2401.4150736492993,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 35.74409484863281,
			"height": 20,
			"seed": 1359726923,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "tiling",
			"rawText": "tiling",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "WUtwD51iGOgdSZ187zS8V",
			"originalText": "tiling",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 468,
			"versionNonce": 123967913,
			"isDeleted": false,
			"id": "794f0xqB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -355.8736017338661,
			"y": 2391.647793621364,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 251.53651428222656,
			"height": 40,
			"seed": 1995247371,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "VK_IMAGE_TILING_OPTIMAL\nVK_IMAGE_TILING_LINEAR",
			"rawText": "VK_IMAGE_TILING_OPTIMAL\nVK_IMAGE_TILING_LINEAR",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VK_IMAGE_TILING_OPTIMAL\nVK_IMAGE_TILING_LINEAR",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 405,
			"versionNonce": 1165685095,
			"isDeleted": false,
			"id": "IN7mYDad",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 406.81684985654454,
			"y": 2400.60375787849,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 190.01983642578125,
			"height": 20,
			"seed": 1520004613,
			"groupIds": [
				"U8o-g4tkiAbO8tsSRGd5s"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": "https://zhuanlan.zhihu.com/p/580655563",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[tiling和layout区别1]]",
			"rawText": "[tiling和layout区别1](https://zhuanlan.zhihu.com/p/580655563)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[tiling和layout区别1]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 493,
			"versionNonce": 418675849,
			"isDeleted": false,
			"id": "KZU8eWD6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 406.81684985654454,
			"y": 2363.02953172217,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 197.0758514404297,
			"height": 20,
			"seed": 560258507,
			"groupIds": [
				"U8o-g4tkiAbO8tsSRGd5s"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": "https://www.reddit.com/r/vulkan/comments/48cvzq/image_layouts/",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[tiling和layout区别2]]",
			"rawText": "[tiling和layout区别2](https://www.reddit.com/r/vulkan/comments/48cvzq/image_layouts/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[tiling和layout区别2]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 488,
			"versionNonce": 2080779399,
			"isDeleted": false,
			"id": "ibud4hes",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 406.81684985654454,
			"y": 2436.027470253629,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 616.496337890625,
			"height": 60,
			"seed": 744102347,
			"groupIds": [
				"U8o-g4tkiAbO8tsSRGd5s"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "tiling描述了像素在GPU上的内存排布方式\nlayout则是为了减少GPU内存带宽, GPU对不同的layout指定了不同且透明的压缩方式.\n由于有些硬件模块只能访问特定数据块/数据格式, 因此在使用前需要进行layout转换",
			"rawText": "tiling描述了像素在GPU上的内存排布方式\nlayout则是为了减少GPU内存带宽, GPU对不同的layout指定了不同且透明的压缩方式.\n由于有些硬件模块只能访问特定数据块/数据格式, 因此在使用前需要进行layout转换",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "tiling描述了像素在GPU上的内存排布方式\nlayout则是为了减少GPU内存带宽, GPU对不同的layout指定了不同且透明的压缩方式.\n由于有些硬件模块只能访问特定数据块/数据格式, 因此在使用前需要进行layout转换",
			"lineHeight": 1.25,
			"baseline": 54
		},
		{
			"type": "freedraw",
			"version": 69,
			"versionNonce": 1344668521,
			"isDeleted": false,
			"id": "3_ZVWQlrZZ-2Z8n7btPEc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -218.10174032617226,
			"y": -250.17127859986783,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 76.22594054627206,
			"height": 61.64358670263732,
			"seed": 988667935,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6628342656197788,
					-0.6628342656197219
				],
				[
					2.651337062479058,
					-3.3141713280987233
				],
				[
					5.30267412495806,
					-9.279679718676562
				],
				[
					8.61684545305684,
					-16.570856640493844
				],
				[
					10.60534824991612,
					-21.87353076545196
				],
				[
					13.256685312395177,
					-27.176204890409963
				],
				[
					17.23369090611368,
					-31.153210484128522
				],
				[
					18.559359437353237,
					-32.47887901536808
				],
				[
					21.21069649983224,
					-35.13021607784708
				],
				[
					22.53636503107174,
					-35.7930503434668
				],
				[
					23.862033562311296,
					-36.45588460908664
				],
				[
					30.490376218508857,
					-40.43289020280508
				],
				[
					35.793050343466916,
					-43.0842272652842
				],
				[
					40.4328902028052,
					-45.07273006214348
				],
				[
					47.06123285900276,
					-49.04973565586192
				],
				[
					49.71256992148176,
					-49.71256992148176
				],
				[
					57.0037468432991,
					-53.68957551520032
				],
				[
					60.31791817139788,
					-55.67807831205948
				],
				[
					61.643586702637435,
					-56.34091257767932
				],
				[
					63.63208949949666,
					-57.66658110891876
				],
				[
					66.28342656197572,
					-58.3294153745386
				],
				[
					66.94626082759544,
					-58.99224964015832
				],
				[
					67.60909509321522,
					-58.99224964015832
				],
				[
					68.271929358835,
					-59.65508390577804
				],
				[
					68.271929358835,
					-60.31791817139788
				],
				[
					68.93476362445472,
					-60.31791817139788
				],
				[
					69.5975978900745,
					-60.31791817139788
				],
				[
					70.26043215569428,
					-60.31791817139788
				],
				[
					70.923266421314,
					-60.31791817139788
				],
				[
					71.58610068693378,
					-60.31791817139788
				],
				[
					72.91176921817328,
					-60.9807524370176
				],
				[
					74.23743774941278,
					-60.9807524370176
				],
				[
					75.56310628065228,
					-61.64358670263732
				],
				[
					76.22594054627206,
					-61.64358670263732
				],
				[
					76.22594054627206,
					-61.64358670263732
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 124,
			"versionNonce": 800916391,
			"isDeleted": false,
			"id": "TyznES-dcOoBVwaD2hmg8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -189.59986690452268,
			"y": -718.1322701274163,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 72.91176921817322,
			"height": 186.91926290477136,
			"seed": 1304774897,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954224,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.6628342656197219
				],
				[
					0,
					1.9885027968592794
				],
				[
					0.6628342656197219,
					3.977005593718559
				],
				[
					1.3256685312395007,
					7.291176921817282
				],
				[
					1.9885027968592226,
					13.919519578014842
				],
				[
					2.6513370624790014,
					21.87353076545196
				],
				[
					4.639839859338281,
					29.164707687269242
				],
				[
					6.62834265619756,
					37.11871887470636
				],
				[
					8.61684545305684,
					41.75855873404464
				],
				[
					9.94251398429634,
					45.7355643277632
				],
				[
					11.93101678115562,
					53.689575515200204
				],
				[
					13.9195195780149,
					60.9807524370176
				],
				[
					15.908022374874122,
					66.94626082759544
				],
				[
					17.23369090611368,
					70.92326642131388
				],
				[
					19.88502796859268,
					78.21444334313128
				],
				[
					19.88502796859268,
					80.20294613999056
				],
				[
					21.21069649983218,
					83.51711746808928
				],
				[
					21.87353076545196,
					86.83128879618812
				],
				[
					22.536365031071682,
					92.13396292114612
				],
				[
					22.536365031071682,
					96.7738027804844
				],
				[
					22.536365031071682,
					100.75080837420296
				],
				[
					22.536365031071682,
					104.72781396792152
				],
				[
					23.19919929669146,
					109.3676538272598
				],
				[
					23.86203356231124,
					113.34465942097836
				],
				[
					24.52486782793096,
					116.6588307490772
				],
				[
					25.18770209355074,
					120.63583634279576
				],
				[
					25.18770209355074,
					121.29867060841548
				],
				[
					25.85053635917052,
					123.28717340527476
				],
				[
					26.51337062479024,
					125.93851046775376
				],
				[
					27.17620489041002,
					127.92701326461304
				],
				[
					27.83903915602974,
					130.57835032709204
				],
				[
					28.50187342164952,
					132.56685312395132
				],
				[
					29.1647076872693,
					134.5553559208106
				],
				[
					29.82754195288902,
					136.54385871766988
				],
				[
					31.153210484128522,
					139.19519578014888
				],
				[
					31.8160447497483,
					141.846532842628
				],
				[
					31.8160447497483,
					143.83503563948716
				],
				[
					32.47887901536808,
					145.16070417072672
				],
				[
					33.1417132809878,
					147.149206967586
				],
				[
					33.80454754660758,
					149.800544030065
				],
				[
					35.13021607784708,
					152.451881092544
				],
				[
					35.79305034346686,
					154.4403838894034
				],
				[
					36.45588460908658,
					155.76605242064284
				],
				[
					36.45588460908658,
					157.75455521750212
				],
				[
					37.11871887470636,
					159.08022374874167
				],
				[
					37.78155314032614,
					160.40589227998112
				],
				[
					38.44438740594586,
					161.06872654560084
				],
				[
					39.10722167156564,
					161.73156081122056
				],
				[
					39.10722167156564,
					162.3943950768404
				],
				[
					39.77005593718536,
					163.05722934246023
				],
				[
					40.43289020280514,
					164.38289787369968
				],
				[
					41.09572446842492,
					165.70856640493912
				],
				[
					42.42139299966442,
					167.03423493617868
				],
				[
					43.0842272652842,
					168.35990346741823
				],
				[
					44.4098957965237,
					170.3484062642774
				],
				[
					45.7355643277632,
					171.01124052989724
				],
				[
					47.0612328590027,
					172.3369090611368
				],
				[
					47.72406712462248,
					172.99974332675652
				],
				[
					48.3869013902422,
					173.66257759237624
				],
				[
					49.04973565586198,
					173.66257759237624
				],
				[
					50.37540418710148,
					174.32541185799596
				],
				[
					51.03823845272126,
					174.32541185799596
				],
				[
					51.70107271834104,
					174.9882461236158
				],
				[
					53.02674124958054,
					175.65108038923552
				],
				[
					53.68957551520026,
					175.65108038923552
				],
				[
					53.68957551520026,
					176.31391465485535
				],
				[
					54.35240978082004,
					176.31391465485535
				],
				[
					55.01524404643982,
					176.31391465485535
				],
				[
					55.67807831205954,
					176.97674892047507
				],
				[
					56.34091257767932,
					177.6395831860948
				],
				[
					57.00374684329904,
					178.30241745171452
				],
				[
					57.66658110891882,
					178.30241745171452
				],
				[
					58.3294153745386,
					178.96525171733424
				],
				[
					58.99224964015832,
					179.62808598295408
				],
				[
					58.99224964015832,
					180.2909202485738
				],
				[
					59.6550839057781,
					180.95375451419363
				],
				[
					60.9807524370176,
					181.61658877981336
				],
				[
					61.64358670263738,
					182.27942304543308
				],
				[
					62.96925523387688,
					182.9422573110528
				],
				[
					63.63208949949666,
					183.60509157667263
				],
				[
					64.95775803073616,
					184.26792584229236
				],
				[
					65.62059229635588,
					184.26792584229236
				],
				[
					66.94626082759544,
					184.9307601079122
				],
				[
					68.27192935883494,
					184.9307601079122
				],
				[
					69.59759789007444,
					185.59359437353191
				],
				[
					70.92326642131394,
					186.25642863915164
				],
				[
					71.58610068693372,
					186.25642863915164
				],
				[
					72.2489349525535,
					186.25642863915164
				],
				[
					72.91176921817322,
					186.91926290477136
				],
				[
					72.91176921817322,
					186.91926290477136
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "rectangle",
			"version": 417,
			"versionNonce": 2034478665,
			"isDeleted": false,
			"id": "sAR1D_X4TFmBgPGLEgjH5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -452.9318259144344,
			"y": 2061.988536403718,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 77,
			"height": 35,
			"seed": 753839057,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "2CrXkzGL",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 441,
			"versionNonce": 1892415175,
			"isDeleted": false,
			"id": "2CrXkzGL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -434.11187199597737,
			"y": 2069.488536403718,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 1923811761,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "flags",
			"rawText": "flags",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "sAR1D_X4TFmBgPGLEgjH5",
			"originalText": "flags",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 419,
			"versionNonce": 1260977449,
			"isDeleted": false,
			"id": "sOvTJZEV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -341.50563895911114,
			"y": 2069.175742288824,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 360.01617431640625,
			"height": 20,
			"seed": 1814104319,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "一些特殊用法的标记, 例如属于cube_map的哪个面",
			"rawText": "一些特殊用法的标记, 例如属于cube_map的哪个面",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "一些特殊用法的标记, 例如属于cube_map的哪个面",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 445,
			"versionNonce": 153483945,
			"isDeleted": false,
			"id": "k6390vwFDWTradiZjq2z2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -408.6430019663535,
			"y": 2894.20695042057,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 50,
			"height": 30,
			"seed": 822041855,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "0cdaV3Q5",
					"type": "text"
				}
			],
			"updated": 1689761653845,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 467,
			"versionNonce": 4923495,
			"isDeleted": false,
			"id": "0cdaV3Q5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -403.32304804789646,
			"y": 2899.20695042057,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 1406860721,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689761653845,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "flags",
			"rawText": "flags",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "k6390vwFDWTradiZjq2z2",
			"originalText": "flags",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 445,
			"versionNonce": 1438825865,
			"isDeleted": false,
			"id": "tmgdqgy11iBeOJFKX31vp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -408.6430019663535,
			"y": 2932.996096783211,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 41,
			"height": 30,
			"seed": 358760529,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "jH0TkeeA",
					"type": "text"
				}
			],
			"updated": 1689761653845,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 451,
			"versionNonce": 1794669447,
			"isDeleted": false,
			"id": "jH0TkeeA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -403.19103663432224,
			"y": 2937.996096783211,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 30.0960693359375,
			"height": 20,
			"seed": 817665087,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689761653845,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "size",
			"rawText": "size",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "tmgdqgy11iBeOJFKX31vp",
			"originalText": "size",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 445,
			"versionNonce": 998515817,
			"isDeleted": false,
			"id": "_BBs0LjYWc_WR2f5WVY08",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -408.6430019663535,
			"y": 2973.5106450917247,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 56,
			"height": 30,
			"seed": 1899751775,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "nvUxvbi3",
					"type": "text"
				}
			],
			"updated": 1689761653845,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 458,
			"versionNonce": 1234006695,
			"isDeleted": false,
			"id": "nvUxvbi3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -403.25104945170506,
			"y": 2978.5106450917247,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 45.216094970703125,
			"height": 20,
			"seed": 390984849,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689761653845,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "usage",
			"rawText": "usage",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "_BBs0LjYWc_WR2f5WVY08",
			"originalText": "usage",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 487,
			"versionNonce": 960682823,
			"isDeleted": false,
			"id": "83NxTTwftLloXWhlzMkFT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -450.12311609429094,
			"y": 2567.481106984346,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 103,
			"height": 30,
			"seed": 1622996465,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "VwFYpY6i",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 491,
			"versionNonce": 358654121,
			"isDeleted": false,
			"id": "VwFYpY6i",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -444.67922266167375,
			"y": 2572.481106984346,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 92.11221313476562,
			"height": 20,
			"seed": 1846214111,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "sharingMode",
			"rawText": "sharingMode",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "83NxTTwftLloXWhlzMkFT",
			"originalText": "sharingMode",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 514,
			"versionNonce": 1727388263,
			"isDeleted": false,
			"id": "kA_4DAq0ofI8jJZyGRWXu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -897.2352655281979,
			"y": 3308.002397171182,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 92,
			"height": 58,
			"seed": 1759013982,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "tRqPAOgm"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 496,
			"versionNonce": 263758729,
			"isDeleted": false,
			"id": "tRqPAOgm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -885.2252328743893,
			"y": 3324.502397171182,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 67.97993469238281,
			"height": 25,
			"seed": 1553808194,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Memory",
			"rawText": "Memory",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "kA_4DAq0ofI8jJZyGRWXu",
			"originalText": "Memory",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 558,
			"versionNonce": 1614542215,
			"isDeleted": false,
			"id": "GCmHOzBaYfyQhbFQcXvDM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -616.6166583540254,
			"y": 3167.5465352607976,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 150,
			"height": 62,
			"seed": 1797004418,
			"groupIds": [
				"oGcnceeghgvxm5qAlrXCw"
			],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "cCBNxDxs",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 581,
			"versionNonce": 1238190697,
			"isDeleted": false,
			"id": "cCBNxDxs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -603.1865893842988,
			"y": 3186.0465352607976,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 123.13986206054688,
			"height": 25,
			"seed": 1296223006,
			"groupIds": [
				"oGcnceeghgvxm5qAlrXCw"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Memory Heap",
			"rawText": "Memory Heap",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "GCmHOzBaYfyQhbFQcXvDM",
			"originalText": "Memory Heap",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 548,
			"versionNonce": 2085727399,
			"isDeleted": false,
			"id": "1OyCXAVz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -616.6166583540254,
			"y": 3238.173030646471,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 271.4721984863281,
			"height": 40,
			"seed": 488042114,
			"groupIds": [
				"oGcnceeghgvxm5qAlrXCw"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "memory heap代表一个具体的物理内存\n显卡上的RAM, 或者系统内存",
			"rawText": "memory heap代表一个具体的物理内存\n显卡上的RAM, 或者系统内存",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "memory heap代表一个具体的物理内存\n显卡上的RAM, 或者系统内存",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 559,
			"versionNonce": 1818891593,
			"isDeleted": false,
			"id": "pizIAgCn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -970.4271999277405,
			"y": 3381.996745109034,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 300.91241455078125,
			"height": 140,
			"seed": 1168612674,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": "https://asawicki.info/news_1740_vulkan_memory_types_on_pc_and_how_to_use_them",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐在Vulkan中对内存进行\nvkGetPhysicalDeviceMemoryProperties\n获取memory heap 和 memory type的信息\n参考:\n[[1]]\n[[2]]\n[[3]]",
			"rawText": "在Vulkan中对内存进行\nvkGetPhysicalDeviceMemoryProperties\n获取memory heap 和 memory type的信息\n参考:\n[1](https://asawicki.info/news_1740_vulkan_memory_types_on_pc_and_how_to_use_them)\n[2](https://www.youtube.com/watch?v=zSG6dPq57P8)\n[3](https://stackoverflow.com/questions/51624650/vulkan-memoryheaps-and-their-memorytypes)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐在Vulkan中对内存进行\nvkGetPhysicalDeviceMemoryProperties\n获取memory heap 和 memory type的信息\n参考:\n[[1]]\n[[2]]\n[[3]]",
			"lineHeight": 1.25,
			"baseline": 134
		},
		{
			"type": "rectangle",
			"version": 708,
			"versionNonce": 1994620871,
			"isDeleted": false,
			"id": "wEBmOGbWNalYO80OrC1tu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -579.5716545603381,
			"y": 3425.191445764806,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 158,
			"height": 61,
			"seed": 1867063518,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "Ik7txvTl",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 729,
			"versionNonce": 2062189609,
			"isDeleted": false,
			"id": "Ik7txvTl",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -562.6915886423693,
			"y": 3443.191445764806,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 124.2398681640625,
			"height": 25,
			"seed": 323538462,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Memory Type",
			"rawText": "Memory Type",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "wEBmOGbWNalYO80OrC1tu",
			"originalText": "Memory Type",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 448,
			"versionNonce": 1645080295,
			"isDeleted": false,
			"id": "7TYLK4Cw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -579.5716545603381,
			"y": 3500.641863111962,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 300.9123840332031,
			"height": 40,
			"seed": 248253022,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "memory type是某个memory heap带有特定\n属性(VkMemoryPropertyFlags)的view",
			"rawText": "memory type是某个memory heap带有特定\n属性(VkMemoryPropertyFlags)的view",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "memory type是某个memory heap带有特定\n属性(VkMemoryPropertyFlags)的view",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "rectangle",
			"version": 341,
			"versionNonce": 20584201,
			"isDeleted": false,
			"id": "IqHKcMMCGVQ8tCgItJI8M",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -379.9620000924373,
			"y": 3405.251793685446,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 89,
			"height": 30,
			"seed": 564458434,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "ndrTjBwt",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 456,
			"versionNonce": 1482521095,
			"isDeleted": false,
			"id": "ndrTjBwt",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -374.5900823678279,
			"y": 3410.251793685446,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 78.25616455078125,
			"height": 20,
			"seed": 463615326,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "heapIndex",
			"rawText": "heapIndex",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "IqHKcMMCGVQ8tCgItJI8M",
			"originalText": "heapIndex",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 352,
			"versionNonce": 30690793,
			"isDeleted": false,
			"id": "GA9Zq0W8w6TfuNy2uRHBq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -379.9620000924373,
			"y": 3450.801265334802,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 115,
			"height": 30,
			"seed": 298239390,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "Rvf69EXBrnmHcD_okizP1",
					"type": "arrow"
				},
				{
					"id": "BPxOaXvg",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 450,
			"versionNonce": 1859035431,
			"isDeleted": false,
			"id": "BPxOaXvg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -374.69411679165603,
			"y": 3455.801265334802,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 104.4642333984375,
			"height": 20,
			"seed": 2092676482,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "propertyFlags",
			"rawText": "propertyFlags",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "GA9Zq0W8w6TfuNy2uRHBq",
			"originalText": "propertyFlags",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 542,
			"versionNonce": 600090825,
			"isDeleted": false,
			"id": "nYtDfCc6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -204.69233442853658,
			"y": 3373.1147884171883,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 824.704833984375,
			"height": 120,
			"seed": 2017166210,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": null,
			"boundElements": [
				{
					"id": "Rvf69EXBrnmHcD_okizP1",
					"type": "arrow"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT\nVK_MEMORY_PROPERTY_HOST_VISIBLE_BIT 可以被map\nVK_MEMORY_PROPERTY_HOST_COHERENT_BIT\nVK_MEMORY_PROPERTY_HOST_CACHED_BIT 可以快速地进行随机访问; 否则, 随机访问很慢, 适合连续访问.\nVK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT\nVK_MEMORY_PROPERTY_PROTECTED_BIT",
			"rawText": "VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT\nVK_MEMORY_PROPERTY_HOST_VISIBLE_BIT 可以被map\nVK_MEMORY_PROPERTY_HOST_COHERENT_BIT\nVK_MEMORY_PROPERTY_HOST_CACHED_BIT 可以快速地进行随机访问; 否则, 随机访问很慢, 适合连续访问.\nVK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT\nVK_MEMORY_PROPERTY_PROTECTED_BIT",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT\nVK_MEMORY_PROPERTY_HOST_VISIBLE_BIT 可以被map\nVK_MEMORY_PROPERTY_HOST_COHERENT_BIT\nVK_MEMORY_PROPERTY_HOST_CACHED_BIT 可以快速地进行随机访问; 否则, 随机访问很慢, 适合连续访问.\nVK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT\nVK_MEMORY_PROPERTY_PROTECTED_BIT",
			"lineHeight": 1.25,
			"baseline": 114
		},
		{
			"type": "arrow",
			"version": 1568,
			"versionNonce": 2147217527,
			"isDeleted": false,
			"id": "Rvf69EXBrnmHcD_okizP1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -263.55098428766274,
			"y": 3465.252084480111,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 54.65446058347419,
			"height": 22.105207958131814,
			"seed": 1294686530,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911971,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "GA9Zq0W8w6TfuNy2uRHBq",
				"gap": 1.4110158047745358,
				"focus": 0.6084679023449723
			},
			"endBinding": {
				"elementId": "nYtDfCc6",
				"gap": 4.20418927565197,
				"focus": 0.6986840471035795
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					54.65446058347419,
					-22.105207958131814
				]
			]
		},
		{
			"type": "rectangle",
			"version": 395,
			"versionNonce": 547792809,
			"isDeleted": false,
			"id": "B2eBRZea8hMueLG3XZ2_5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -409.3165093038631,
			"y": 3153.3375579026456,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 41,
			"height": 30,
			"seed": 2019831746,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "fQJeZaem",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 401,
			"versionNonce": 540525415,
			"isDeleted": false,
			"id": "fQJeZaem",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -403.86454397183184,
			"y": 3158.3375579026456,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 30.0960693359375,
			"height": 20,
			"seed": 248263902,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "size",
			"rawText": "size",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "B2eBRZea8hMueLG3XZ2_5",
			"originalText": "size",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 395,
			"versionNonce": 1923467913,
			"isDeleted": false,
			"id": "6-rRDmhJJLQhYB5BwJtn0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -409.3165093038631,
			"y": 3197.346795886799,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 50,
			"height": 30,
			"seed": 1069074846,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "jOMQsCZy",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 408,
			"versionNonce": 1264107143,
			"isDeleted": false,
			"id": "jOMQsCZy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -403.99655538540605,
			"y": 3202.346795886799,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 838063582,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "flags",
			"rawText": "flags",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "6-rRDmhJJLQhYB5BwJtn0",
			"originalText": "flags",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 458,
			"versionNonce": 1115525481,
			"isDeleted": false,
			"id": "FJEExEwu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -285.5541757649114,
			"y": 3193.4365031436196,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 440.99273681640625,
			"height": 40,
			"seed": 1473862466,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "VK_MEMORY_HEAP_DEVICE_LOCAL_BIT 设备自带显存\nVK_MEMORY_HEAP_MULTI_INSTANCE_BIT 基本没有",
			"rawText": "VK_MEMORY_HEAP_DEVICE_LOCAL_BIT 设备自带显存\nVK_MEMORY_HEAP_MULTI_INSTANCE_BIT 基本没有",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VK_MEMORY_HEAP_DEVICE_LOCAL_BIT 设备自带显存\nVK_MEMORY_HEAP_MULTI_INSTANCE_BIT 基本没有",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 174,
			"versionNonce": 959506045,
			"isDeleted": false,
			"id": "zuB9weWX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1132.1658648532732,
			"y": -50.97835836947189,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 335.2043151855469,
			"height": 25,
			"seed": 456477278,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689822463768,
			"link": "http://vulkan.gpuinfo.org/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[各种设备/系统vulkan能力统计]]",
			"rawText": "[各种设备/系统vulkan能力统计](http://vulkan.gpuinfo.org/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[各种设备/系统vulkan能力统计]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 882,
			"versionNonce": 360283209,
			"isDeleted": false,
			"id": "r4nGhhI6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 661.459535515976,
			"y": 3184.222716050503,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 850.8507080078125,
			"height": 103.49026896400659,
			"seed": 1071444098,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 9.199135019022808,
			"fontFamily": 1,
			"text": "linux, rtx3060\n heap size 12884MB flags VK_MEMORY_HEAP_DEVICE_LOCAL_BIT\n heap size 25193MB flags 0\n heap size 257MB flags VK_MEMORY_HEAP_DEVICE_LOCAL_BIT\n heap index 1 memory property flags 0\n heap index 0 memory property flags VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT \n heap index 1 memory property flags VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT \n heap index 1 memory property flags VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT VK_MEMORY_PROPERTY_HOST_CACHED_BIT \n heap index 2 memory property flags VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT ",
			"rawText": "linux, rtx3060\n heap size 12884MB flags VK_MEMORY_HEAP_DEVICE_LOCAL_BIT\n heap size 25193MB flags 0\n heap size 257MB flags VK_MEMORY_HEAP_DEVICE_LOCAL_BIT\n heap index 1 memory property flags 0\n heap index 0 memory property flags VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT \n heap index 1 memory property flags VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT \n heap index 1 memory property flags VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT VK_MEMORY_PROPERTY_HOST_CACHED_BIT \n heap index 2 memory property flags VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT ",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "linux, rtx3060\n heap size 12884MB flags VK_MEMORY_HEAP_DEVICE_LOCAL_BIT\n heap size 25193MB flags 0\n heap size 257MB flags VK_MEMORY_HEAP_DEVICE_LOCAL_BIT\n heap index 1 memory property flags 0\n heap index 0 memory property flags VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT \n heap index 1 memory property flags VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT \n heap index 1 memory property flags VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT VK_MEMORY_PROPERTY_HOST_CACHED_BIT \n heap index 2 memory property flags VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT VK_MEMORY_PROPERTY_HOST_COHERENT_BIT ",
			"lineHeight": 1.25,
			"baseline": 100
		},
		{
			"type": "freedraw",
			"version": 397,
			"versionNonce": 908200135,
			"isDeleted": false,
			"id": "AnYY4Djk0lu7T2SLOP3f-",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 711.4864256071296,
			"y": 3229.5554530236345,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 66.27050512845949,
			"height": 1.7672134700922015,
			"seed": 1485999998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.44180336752299354,
					0
				],
				[
					1.3254101025690943,
					0
				],
				[
					1.7672134700922015,
					0.4418033675231072
				],
				[
					3.0926235726614095,
					0.4418033675231072
				],
				[
					3.9762303077075103,
					0.8836067350459871
				],
				[
					5.743443777799712,
					0.8836067350459871
				],
				[
					7.952460615415134,
					1.3254101025690943
				],
				[
					9.719674085507336,
					1.7672134700922015
				],
				[
					11.045084188076544,
					1.7672134700922015
				],
				[
					13.254101025691853,
					1.7672134700922015
				],
				[
					15.021314495784054,
					1.7672134700922015
				],
				[
					16.346724598353262,
					1.3254101025690943
				],
				[
					17.67213470092247,
					1.3254101025690943
				],
				[
					18.555741435968685,
					1.3254101025690943
				],
				[
					18.997544803491678,
					1.3254101025690943
				],
				[
					19.88115153853778,
					1.3254101025690943
				],
				[
					21.206561641106987,
					1.3254101025690943
				],
				[
					22.531971743676195,
					1.3254101025690943
				],
				[
					24.299185213768396,
					1.3254101025690943
				],
				[
					25.18279194881461,
					1.3254101025690943
				],
				[
					25.624595316337604,
					0.8836067350459871
				],
				[
					26.06639868386071,
					0.8836067350459871
				],
				[
					26.508202051383705,
					0.8836067350459871
				],
				[
					27.39180878642992,
					0.8836067350459871
				],
				[
					28.717218888999014,
					0.8836067350459871
				],
				[
					29.60082562404523,
					0.8836067350459871
				],
				[
					30.48443235909133,
					0.8836067350459871
				],
				[
					31.809842461660537,
					0.8836067350459871
				],
				[
					32.251645829183644,
					0.8836067350459871
				],
				[
					33.57705593175274,
					0.8836067350459871
				],
				[
					34.46066266679895,
					0.8836067350459871
				],
				[
					35.78607276936805,
					0.8836067350459871
				],
				[
					36.66967950441426,
					0.8836067350459871
				],
				[
					37.995089606983356,
					0.8836067350459871
				],
				[
					39.320499709552564,
					0.8836067350459871
				],
				[
					40.204106444598665,
					0.8836067350459871
				],
				[
					41.08771317964488,
					0.8836067350459871
				],
				[
					42.413123282213974,
					0.8836067350459871
				],
				[
					44.18033675230629,
					0.8836067350459871
				],
				[
					45.5057468548755,
					0.8836067350459871
				],
				[
					46.831156957444705,
					0.8836067350459871
				],
				[
					47.2729603249677,
					0.8836067350459871
				],
				[
					47.714763692490806,
					0.8836067350459871
				],
				[
					48.15656706001391,
					0.8836067350459871
				],
				[
					49.48197716258301,
					0.8836067350459871
				],
				[
					50.807387265152215,
					0.8836067350459871
				],
				[
					52.13279736772142,
					0.8836067350459871
				],
				[
					53.016404102767524,
					0.8836067350459871
				],
				[
					53.900010837813625,
					0.8836067350459871
				],
				[
					54.78361757285984,
					0.8836067350459871
				],
				[
					55.22542094038283,
					0.8836067350459871
				],
				[
					56.55083104295204,
					0.8836067350459871
				],
				[
					57.434437777998255,
					0.8836067350459871
				],
				[
					58.31804451304424,
					0.8836067350459871
				],
				[
					60.08525798313656,
					0.8836067350459871
				],
				[
					61.85247145322887,
					0.8836067350459871
				],
				[
					63.17788155579797,
					0.8836067350459871
				],
				[
					63.619684923321074,
					0.8836067350459871
				],
				[
					64.06148829084418,
					0.8836067350459871
				],
				[
					64.50329165836717,
					0.8836067350459871
				],
				[
					64.94509502589028,
					0.8836067350459871
				],
				[
					65.38689839341328,
					0.8836067350459871
				],
				[
					65.82870176093638,
					0.8836067350459871
				],
				[
					66.27050512845949,
					0.8836067350459871
				],
				[
					65.82870176093638,
					0.8836067350459871
				],
				[
					65.82870176093638,
					0.8836067350459871
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 408,
			"versionNonce": 997526313,
			"isDeleted": false,
			"id": "7UwMfAjbJBUEsmyU7PE1a",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 664.2134652821618,
			"y": 3282.571857126403,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 22.0901683761532,
			"height": 56.55083104295227,
			"seed": 1557254142,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.4418033675231072,
					0
				],
				[
					-1.7672134700923152,
					-0.8836067350462145
				],
				[
					-3.5344269401845168,
					-1.767213470092429
				],
				[
					-5.301640410276718,
					-2.650820205138416
				],
				[
					-7.0688538803690335,
					-3.5344269401846304
				],
				[
					-8.836067350461235,
					-4.4180336752306175
				],
				[
					-9.719674085507336,
					-4.859837042753725
				],
				[
					-11.045084188076544,
					-5.743443777799939
				],
				[
					-12.370494290645752,
					-6.627050512845926
				],
				[
					-13.254101025691853,
					-7.0688538803690335
				],
				[
					-14.137707760738067,
					-7.952460615415248
				],
				[
					-15.021314495784168,
					-8.394263982938355
				],
				[
					-15.904921230830269,
					-9.277870717984342
				],
				[
					-16.346724598353376,
					-10.161477453030557
				],
				[
					-17.672134700922584,
					-11.928690923122758
				],
				[
					-18.113938068445577,
					-12.370494290645865
				],
				[
					-18.555741435968685,
					-12.812297658168973
				],
				[
					-19.439348171014785,
					-15.021314495784281
				],
				[
					-19.439348171014785,
					-15.463117863307389
				],
				[
					-19.881151538537893,
					-15.904921230830496
				],
				[
					-19.881151538537893,
					-17.23033133339959
				],
				[
					-20.764758273583993,
					-18.99754480349179
				],
				[
					-20.764758273583993,
					-20.764758273583993
				],
				[
					-21.206561641106987,
					-22.531971743676422
				],
				[
					-21.648365008630094,
					-23.857381846245516
				],
				[
					-21.648365008630094,
					-24.74098858129173
				],
				[
					-21.648365008630094,
					-26.066398683860825
				],
				[
					-22.0901683761532,
					-26.95000541890704
				],
				[
					-22.0901683761532,
					-28.71721888899924
				],
				[
					-22.0901683761532,
					-30.92623572661455
				],
				[
					-22.0901683761532,
					-32.251645829183644
				],
				[
					-22.0901683761532,
					-33.577055931752966
				],
				[
					-22.0901683761532,
					-34.46066266679895
				],
				[
					-22.0901683761532,
					-35.786072769368275
				],
				[
					-21.648365008630094,
					-37.11148287193737
				],
				[
					-21.648365008630094,
					-37.99508960698358
				],
				[
					-21.206561641106987,
					-39.762303077075785
				],
				[
					-21.206561641106987,
					-41.08771317964511
				],
				[
					-21.206561641106987,
					-42.4131232822142
				],
				[
					-20.764758273583993,
					-43.738533384783295
				],
				[
					-20.764758273583993,
					-45.06394348735262
				],
				[
					-20.322954906060886,
					-45.947550222398604
				],
				[
					-19.881151538537893,
					-47.272960324967926
				],
				[
					-19.881151538537893,
					-48.15656706001391
				],
				[
					-18.997544803491678,
					-49.92378053010634
				],
				[
					-18.997544803491678,
					-50.80738726515233
				],
				[
					-18.555741435968685,
					-51.69099400019854
				],
				[
					-18.113938068445577,
					-52.13279736772165
				],
				[
					-17.672134700922584,
					-52.57460073524453
				],
				[
					-17.230331333399477,
					-53.01640410276764
				],
				[
					-17.230331333399477,
					-53.458207470290745
				],
				[
					-16.78852796587637,
					-53.90001083781385
				],
				[
					-16.346724598353376,
					-54.34181420533696
				],
				[
					-15.463117863307275,
					-54.78361757285984
				],
				[
					-15.021314495784168,
					-55.225420940382946
				],
				[
					-14.137707760738067,
					-55.667224307906054
				],
				[
					-12.812297658168859,
					-56.10902767542916
				],
				[
					-12.370494290645752,
					-56.55083104295227
				],
				[
					-11.928690923122758,
					-56.55083104295227
				],
				[
					-11.486887555599651,
					-56.55083104295227
				],
				[
					-11.045084188076544,
					-56.55083104295227
				],
				[
					-10.60328082055355,
					-56.55083104295227
				],
				[
					-10.161477453030443,
					-56.55083104295227
				],
				[
					-9.277870717984342,
					-56.55083104295227
				],
				[
					-8.836067350461235,
					-56.55083104295227
				],
				[
					-7.952460615415134,
					-56.55083104295227
				],
				[
					-7.0688538803690335,
					-56.55083104295227
				],
				[
					-6.185247145322933,
					-56.55083104295227
				],
				[
					-5.7434437777998255,
					-56.10902767542916
				],
				[
					-4.859837042753725,
					-56.10902767542916
				],
				[
					-4.4180336752306175,
					-56.10902767542916
				],
				[
					-3.0926235726614095,
					-55.667224307906054
				],
				[
					-2.650820205138416,
					-55.667224307906054
				],
				[
					-1.7672134700923152,
					-55.667224307906054
				],
				[
					-1.325410102569208,
					-55.667224307906054
				],
				[
					-0.8836067350461008,
					-55.667224307906054
				],
				[
					-0.8836067350461008,
					-55.667224307906054
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "image",
			"version": 423,
			"versionNonce": 714299367,
			"isDeleted": false,
			"id": "QlrTGdCLIbzOQmfrhsqOD",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 667.5630698234754,
			"y": 3296.289827252042,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 254.28772232362564,
			"height": 239.93989076890716,
			"seed": 1084720482,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a4d7f9b0a6abf8ba8c7940c3e6048d97538f9e28",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 776,
			"versionNonce": 2094775817,
			"isDeleted": false,
			"id": "vKKqy9QE",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 944.367845115313,
			"y": 3296.6672885042067,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 896.4277954101562,
			"height": 243.23285710183524,
			"seed": 1210480930,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": "https://zeux.io/2020/02/27/writing-an-efficient-vulkan-renderer/",
			"locked": false,
			"fontSize": 12.972419045431211,
			"fontFamily": 1,
			"text": "🌐[[各类内存使用]]:\nDEVICE_LOCAL_BIT \n    - rendertarget, gpu only resource, static resource(texture, geometry) \n\nDEVICE_LOCAL_BIT | HOST_VISIBLE_BIT ||| HOST_CACHE\n    - 256MB in desktop gpu, full in mobile gpu. video memory that the CPU can write to directly\n    - allocating reasonable amounts of data that is written by CPU every frame, such as uniform buffers or dynamic vertex/index buffers\n\nHOST_VISIBLE_BIT | HOST_COHERENT_BIT\n    - CPU memory that is directly visible from GPU\n    - staging buffer\n    - in absence of the previous memory type, use for ... \n\nDEVICE_LOCAL_BIT | LAZILY_ALLOCATED_BIT\n    - GPU memory that might never need to be allocated for render targets on tiled architectures ",
			"rawText": "[各类内存使用](https://zeux.io/2020/02/27/writing-an-efficient-vulkan-renderer/):\nDEVICE_LOCAL_BIT \n    - rendertarget, gpu only resource, static resource(texture, geometry) \n\nDEVICE_LOCAL_BIT | HOST_VISIBLE_BIT ||| HOST_CACHE\n    - 256MB in desktop gpu, full in mobile gpu. video memory that the CPU can write to directly\n    - allocating reasonable amounts of data that is written by CPU every frame, such as uniform buffers or dynamic vertex/index buffers\n\nHOST_VISIBLE_BIT | HOST_COHERENT_BIT\n    - CPU memory that is directly visible from GPU\n    - staging buffer\n    - in absence of the previous memory type, use for ... \n\nDEVICE_LOCAL_BIT | LAZILY_ALLOCATED_BIT\n    - GPU memory that might never need to be allocated for render targets on tiled architectures ",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[各类内存使用]]:\nDEVICE_LOCAL_BIT \n    - rendertarget, gpu only resource, static resource(texture, geometry) \n\nDEVICE_LOCAL_BIT | HOST_VISIBLE_BIT ||| HOST_CACHE\n    - 256MB in desktop gpu, full in mobile gpu. video memory that the CPU can write to directly\n    - allocating reasonable amounts of data that is written by CPU every frame, such as uniform buffers or dynamic vertex/index buffers\n\nHOST_VISIBLE_BIT | HOST_COHERENT_BIT\n    - CPU memory that is directly visible from GPU\n    - staging buffer\n    - in absence of the previous memory type, use for ... \n\nDEVICE_LOCAL_BIT | LAZILY_ALLOCATED_BIT\n    - GPU memory that might never need to be allocated for render targets on tiled architectures ",
			"lineHeight": 1.25,
			"baseline": 238
		},
		{
			"type": "text",
			"version": 37,
			"versionNonce": 508412679,
			"isDeleted": false,
			"id": "HUjyoagp",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1130.1550785761638,
			"y": -8.451300010694695,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 339.878173828125,
			"height": 20.70821531768297,
			"seed": 1925876478,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": "https://zeux.io/2020/02/27/writing-an-efficient-vulkan-renderer/",
			"locked": false,
			"fontSize": 16.566572254146376,
			"fontFamily": 1,
			"text": "🌐[[Writing an efficient Vulkan renderer]]",
			"rawText": "[Writing an efficient Vulkan renderer](https://zeux.io/2020/02/27/writing-an-efficient-vulkan-renderer/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[Writing an efficient Vulkan renderer]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 535,
			"versionNonce": 145298665,
			"isDeleted": false,
			"id": "uPsaHVGO",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -79.0636873929393,
			"y": 2868.19547042778,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 697.9522705078125,
			"height": 80,
			"seed": 1896589970,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "vkCmdUpdateBuffer\n适用于小量数据更新<65536bytes,\n通过command buffer执行, 可以在一个pipeline中的特定点进行多次不同的数据更新.\n例如在VR渲染时, 左右眼画面公用一个uniform buffer, 先更新左眼进行绘制, 再更新右眼进行绘制.",
			"rawText": "vkCmdUpdateBuffer\n适用于小量数据更新<65536bytes,\n通过command buffer执行, 可以在一个pipeline中的特定点进行多次不同的数据更新.\n例如在VR渲染时, 左右眼画面公用一个uniform buffer, 先更新左眼进行绘制, 再更新右眼进行绘制.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "vkCmdUpdateBuffer\n适用于小量数据更新<65536bytes,\n通过command buffer执行, 可以在一个pipeline中的特定点进行多次不同的数据更新.\n例如在VR渲染时, 左右眼画面公用一个uniform buffer, 先更新左眼进行绘制, 再更新右眼进行绘制.",
			"lineHeight": 1.25,
			"baseline": 74
		},
		{
			"type": "rectangle",
			"version": 328,
			"versionNonce": 30263847,
			"isDeleted": false,
			"id": "4q3O7ZHLK736VZazPMe0w",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -76.3169816298007,
			"y": 2985.9846735218002,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 920,
			"height": 110,
			"seed": 848604302,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "3DabKuFR",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 641,
			"versionNonce": 577277897,
			"isDeleted": false,
			"id": "3DabKuFR",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -71.3169816298007,
			"y": 2990.9846735218002,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 909.7930908203125,
			"height": 100,
			"seed": 1247312782,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Map/UnMap\n可以用于大数据更新, 要求Memory必须是HOST_VISIBLE. 中间不需要command buffer, 需要flush memory.\n\nmapping需要一定的时间开销, persistent mapping可以减少临时mapping时间. 但在AMD/NVIDIA上HOST_VISIBLE VRAM有限,\n可能会强制在system memory上申请有persistent mapping要求的memory.",
			"rawText": "Map/UnMap\n可以用于大数据更新, 要求Memory必须是HOST_VISIBLE. 中间不需要command buffer, 需要flush memory.\n\nmapping需要一定的时间开销, persistent mapping可以减少临时mapping时间. 但在AMD/NVIDIA上HOST_VISIBLE VRAM有限,\n可能会强制在system memory上申请有persistent mapping要求的memory.",
			"textAlign": "left",
			"verticalAlign": "middle",
			"containerId": "4q3O7ZHLK736VZazPMe0w",
			"originalText": "Map/UnMap\n可以用于大数据更新, 要求Memory必须是HOST_VISIBLE. 中间不需要command buffer, 需要flush memory.\n\nmapping需要一定的时间开销, persistent mapping可以减少临时mapping时间. 但在AMD/NVIDIA上HOST_VISIBLE VRAM有限,\n可能会强制在system memory上申请有persistent mapping要求的memory.",
			"lineHeight": 1.25,
			"baseline": 94
		},
		{
			"type": "freedraw",
			"version": 534,
			"versionNonce": 33549639,
			"isDeleted": false,
			"id": "5eLs6CsG_g4TiTDLzLd0t",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 469.35641201738895,
			"y": 3365.908458132592,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 63.4748169758721,
			"height": 336.3442016459206,
			"seed": 901865742,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"points": [
				[
					-59.042255568536135,
					68.60685882878495
				],
				[
					-59.042255568536135,
					67.62051219639218
				],
				[
					-58.2488203563377,
					62.68877903442861
				],
				[
					-57.455385144139264,
					53.81165934289396
				],
				[
					-57.05866753804005,
					50.85261944571594
				],
				[
					-57.05866753804005,
					42.96184638657405
				],
				[
					-55.86851471974251,
					27.180300268290576
				],
				[
					-55.86851471974251,
					18.30318057675592
				],
				[
					-55.86851471974251,
					11.398754150006814
				],
				[
					-56.26523232584172,
					4.494327723257703
				],
				[
					-56.26523232584172,
					-4.382791968276954
				],
				[
					-57.455385144139264,
					-19.177991454167657
				],
				[
					-58.2488203563377,
					-27.068764513309826
				],
				[
					-58.64553796243692,
					-35.94588420484419
				],
				[
					-59.43897317463535,
					-43.836657263986076
				],
				[
					-60.23240838683379,
					-52.71377695552073
				],
				[
					-61.42256120513133,
					-62.577243279447856
				],
				[
					-63.4061492356273,
					-75.3997495005533
				],
				[
					-64.59630205392496,
					-84.27686919208796
				],
				[
					-65.78645487222249,
					-92.16764225122984
				],
				[
					-66.57989008442092,
					-98.0857220455862
				],
				[
					-67.37332529661937,
					-105.97649510472807
				],
				[
					-68.5634781149169,
					-112.88092153147717
				],
				[
					-70.15034853931377,
					-120.7716945906188
				],
				[
					-71.34050135761132,
					-126.68977438497541
				],
				[
					-72.92737178200818,
					-132.60785417933147
				],
				[
					-74.51424220640493,
					-137.53958734129532
				],
				[
					-75.70439502470256,
					-142.47132050325888
				],
				[
					-76.49783023690094,
					-146.41670703282966
				],
				[
					-77.29126544909937,
					-150.36209356240076
				],
				[
					-78.08470066129776,
					-154.30748009197183
				],
				[
					-80.06828869179378,
					-162.19825315111345
				],
				[
					-81.25844151009139,
					-167.129986313077
				],
				[
					-81.6551591161906,
					-169.10267957786255
				],
				[
					-82.44859432838898,
					-174.0344127398261
				],
				[
					-83.24202954058735,
					-176.99345263700442
				],
				[
					-84.0354647527858,
					-179.95249253418274
				],
				[
					-85.22561757108339,
					-183.89787906375355
				],
				[
					-86.41577038938098,
					-187.84326559332433
				],
				[
					-87.20920560157936,
					-191.78865212289543
				],
				[
					-88.39935841987696,
					-195.7340386524662
				],
				[
					-89.58951123817461,
					-198.69307854964455
				],
				[
					-90.38294645037298,
					-200.6657718144301
				],
				[
					-91.57309926867057,
					-204.61115834400087
				],
				[
					-92.76325208696818,
					-208.5565448735717
				],
				[
					-94.74684011746422,
					-213.48827803553525
				],
				[
					-95.93699293576181,
					-216.44731793271353
				],
				[
					-97.1271457540594,
					-218.42001119749878
				],
				[
					-97.92058096625777,
					-220.39270446228437
				],
				[
					-98.71401617845622,
					-224.33809099185544
				],
				[
					-99.90416899675381,
					-228.2834775214265
				],
				[
					-101.0943218150514,
					-233.2152106833901
				],
				[
					-102.28447463334899,
					-238.14694384535363
				],
				[
					-103.87134505774583,
					-242.09233037492447
				],
				[
					-104.6647802699442,
					-245.0513702721028
				],
				[
					-105.45821548214263,
					-247.02406353688832
				],
				[
					-105.8549330882418,
					-248.0104101692808
				],
				[
					-106.64836830044023,
					-249.98310343406632
				],
				[
					-107.04508590653944,
					-250.9694500664591
				],
				[
					-107.83852111873782,
					-251.95579669885186
				],
				[
					-109.02867393703542,
					-254.91483659602991
				],
				[
					-109.8221091492338,
					-255.90118322842267
				],
				[
					-110.21882675533301,
					-256.88752986081545
				],
				[
					-111.01226196753144,
					-257.87387649320823
				],
				[
					-111.80569717972983,
					-258.860223125601
				],
				[
					-112.59913239192821,
					-259.84656975799345
				],
				[
					-113.78928521022586,
					-260.8329163903865
				],
				[
					-114.58272042242425,
					-262.8056096551718
				],
				[
					-115.37615563462262,
					-263.7919562875645
				],
				[
					-116.56630845292021,
					-264.77830291995735
				],
				[
					-117.35974366511864,
					-265.76464955235014
				],
				[
					-118.54989648341623,
					-266.7509961847426
				],
				[
					-118.94661408951546,
					-266.7509961847426
				],
				[
					-119.34333169561461,
					-267.73734281713564
				],
				[
					-119.34333169561461,
					-267.73734281713564
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 480,
			"versionNonce": 271953577,
			"isDeleted": false,
			"id": "ruRSMFaza-Qdpkthvxmed",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -551.0179321034334,
			"y": 2977.4450802780043,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 473.4197224896526,
			"height": 84.52912048884606,
			"seed": 987581774,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"points": [
				[
					0.7065194228272809,
					0
				],
				[
					0.7065194228272809,
					0.8287168675377419
				],
				[
					0.7065194228272809,
					2.4861506026132254
				],
				[
					-0.2199379597356801,
					4.972301205226211
				],
				[
					-0.2199379597356801,
					9.11588554291492
				],
				[
					-1.146395342298574,
					13.259469880603389
				],
				[
					-2.999310107424429,
					18.2317710858296
				],
				[
					-2.999310107424429,
					22.37535542351807
				],
				[
					-3.9257674899873223,
					28.17637349628202
				],
				[
					-2.999310107424429,
					33.148674701508234
				],
				[
					-0.2199379597356801,
					38.94969277427219
				],
				[
					0.7065194228272809,
					41.43584337688541
				],
				[
					3.4858915705160296,
					44.75071084703614
				],
				[
					5.338806335641884,
					46.408144582111625
				],
				[
					11.824008013582276,
					50.55172891980009
				],
				[
					16.456294926396946,
					53.03787952241332
				],
				[
					21.08858183921155,
					54.695313257488564
				],
				[
					25.720868752026153,
					57.181463860101786
				],
				[
					34.98544257765536,
					59.667614462715015
				],
				[
					43.3235590207216,
					62.153765065327995
				],
				[
					50.73521808122503,
					64.63991566794098
				],
				[
					59.07333452429127,
					66.29734940301647
				],
				[
					68.33790834992048,
					68.78350000562969
				],
				[
					77.60248217554968,
					72.09836747578042
				],
				[
					93.35225767911942,
					75.41323494593139
				],
				[
					98.91100197449691,
					75.41323494593139
				],
				[
					114.66077747806658,
					77.07066868100686
				],
				[
					125.77826606882158,
					77.07066868100686
				],
				[
					133.189925129325,
					77.07066868100686
				],
				[
					138.74866942470248,
					77.07066868100686
				],
				[
					148.93970063289467,
					77.07066868100686
				],
				[
					156.35135969339808,
					77.89938554854437
				],
				[
					164.68947613646432,
					79.55681928361986
				],
				[
					176.73342210978228,
					81.21425301869535
				],
				[
					187.85091070053727,
					82.04296988623284
				],
				[
					196.18902714360365,
					82.87168675377082
				],
				[
					203.60068620410695,
					82.87168675377082
				],
				[
					209.15943049948459,
					82.87168675377082
				],
				[
					212.86526002973613,
					82.87168675377082
				],
				[
					218.42400432511377,
					82.87168675377082
				],
				[
					224.90920600305424,
					82.87168675377082
				],
				[
					234.17377982868345,
					82.87168675377082
				],
				[
					246.2177258020014,
					82.87168675377082
				],
				[
					255.4822996276306,
					82.87168675377082
				],
				[
					263.82041607069687,
					82.87168675377082
				],
				[
					274.011447278889,
					84.52912048884606
				],
				[
					279.5701915742665,
					84.52912048884606
				],
				[
					285.128935869644,
					84.52912048884606
				],
				[
					289.7612227824587,
					84.52912048884606
				],
				[
					292.54059493014745,
					84.52912048884606
				],
				[
					295.31996707783617,
					84.52912048884606
				],
				[
					299.95225399065083,
					84.52912048884606
				],
				[
					306.43745566859116,
					84.52912048884606
				],
				[
					311.9961999639688,
					84.52912048884606
				],
				[
					322.18723117216086,
					84.52912048884606
				],
				[
					325.8930607024125,
					84.52912048884606
				],
				[
					331.45180499779,
					84.52912048884606
				],
				[
					336.08409191060474,
					83.70040362130833
				],
				[
					339.7899214408564,
					83.70040362130833
				],
				[
					343.4957509711081,
					83.70040362130833
				],
				[
					347.20158050135973,
					84.52912048884606
				],
				[
					351.8338674141744,
					84.52912048884606
				],
				[
					355.5396969444261,
					84.52912048884606
				],
				[
					360.1719838572406,
					84.52912048884606
				],
				[
					363.8778133874923,
					83.70040362130833
				],
				[
					368.510100300307,
					84.52912048884606
				],
				[
					373.14238721312154,
					84.52912048884606
				],
				[
					378.70113150849903,
					84.52912048884606
				],
				[
					383.3334184213137,
					84.52912048884606
				],
				[
					387.0392479515654,
					84.52912048884606
				],
				[
					388.8921627166912,
					84.52912048884606
				],
				[
					390.74507748181713,
					84.52912048884606
				],
				[
					391.67153486437996,
					84.52912048884606
				],
				[
					393.5244496295059,
					84.52912048884606
				],
				[
					394.4509070120687,
					84.52912048884606
				],
				[
					398.1567365423204,
					84.52912048884606
				],
				[
					400.9361086900092,
					84.52912048884606
				],
				[
					405.56839560282384,
					84.52912048884606
				],
				[
					407.4213103679496,
					84.52912048884606
				],
				[
					408.34776775051256,
					83.70040362130833
				],
				[
					410.2006825156384,
					83.70040362130833
				],
				[
					412.0535972807643,
					83.70040362130833
				],
				[
					413.9065120458901,
					82.87168675377082
				],
				[
					415.759426811016,
					82.87168675377082
				],
				[
					417.6123415761418,
					82.87168675377082
				],
				[
					421.3181711063935,
					82.87168675377082
				],
				[
					423.17108587151927,
					82.87168675377082
				],
				[
					425.0240006366452,
					82.87168675377082
				],
				[
					425.95045801920804,
					82.87168675377082
				],
				[
					426.876915401771,
					82.87168675377082
				],
				[
					429.65628754945976,
					82.87168675377082
				],
				[
					433.3621170797115,
					82.87168675377082
				],
				[
					436.1414892274002,
					82.87168675377082
				],
				[
					437.994403992526,
					82.87168675377082
				],
				[
					438.920861375089,
					82.87168675377082
				],
				[
					439.8473187576519,
					82.87168675377082
				],
				[
					440.77377614021486,
					82.87168675377082
				],
				[
					441.7002335227777,
					82.87168675377082
				],
				[
					442.62669090534064,
					82.87168675377082
				],
				[
					444.47960567046647,
					82.87168675377082
				],
				[
					446.33252043559236,
					82.87168675377082
				],
				[
					447.2589778181552,
					82.87168675377082
				],
				[
					448.1854352007182,
					82.87168675377082
				],
				[
					449.11189258328113,
					82.87168675377082
				],
				[
					450.0383499658441,
					82.87168675377082
				],
				[
					450.9648073484069,
					82.87168675377082
				],
				[
					452.81772211353285,
					82.87168675377082
				],
				[
					454.6706368786586,
					82.87168675377082
				],
				[
					456.5235516437844,
					82.87168675377082
				],
				[
					458.37646640891035,
					83.70040362130833
				],
				[
					459.3029237914733,
					83.70040362130833
				],
				[
					461.15583855659906,
					83.70040362130833
				],
				[
					463.00875332172484,
					83.70040362130833
				],
				[
					463.93521070428784,
					83.70040362130833
				],
				[
					466.71458285197656,
					83.70040362130833
				],
				[
					467.64104023453956,
					83.70040362130833
				],
				[
					468.5674976171025,
					83.70040362130833
				],
				[
					469.49395499966533,
					83.70040362130833
				],
				[
					469.49395499966533,
					83.70040362130833
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 352,
			"versionNonce": 2051058791,
			"isDeleted": false,
			"id": "oJ4yD1JEcaAFHcpaBC5l_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -92.51612607573247,
			"y": 3041.2344973936383,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 21.19914444593155,
			"height": 30.62098642190108,
			"seed": 501969998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.7851534979974986,
					2.3554604939922683
				],
				[
					5.496074485982263,
					7.851534979974531
				],
				[
					9.421841975969642,
					12.562455967959522
				],
				[
					13.347609465956907,
					15.70306995994929
				],
				[
					14.917916461951904,
					17.27337695594406
				],
				[
					17.273376955944286,
					18.843683951939056
				],
				[
					18.84368395193917,
					19.628837449936555
				],
				[
					20.413990947934167,
					21.19914444593155
				],
				[
					21.19914444593155,
					21.19914444593155
				],
				[
					21.19914444593155,
					21.98429794392905
				],
				[
					20.413990947934167,
					21.98429794392905
				],
				[
					19.62883744993667,
					22.76945144192632
				],
				[
					18.058530453941785,
					22.76945144192632
				],
				[
					16.488223457946788,
					23.554604939924047
				],
				[
					10.992148971964525,
					24.33975843792132
				],
				[
					8.636688477972143,
					25.124911935918817
				],
				[
					5.496074485982263,
					25.910065433916316
				],
				[
					3.925767489987379,
					27.480372429911313
				],
				[
					2.3554604939924957,
					28.265525927908584
				],
				[
					1.5703069959949971,
					29.05067942590631
				],
				[
					1.5703069959949971,
					29.83583292390358
				],
				[
					1.5703069959949971,
					30.62098642190108
				],
				[
					1.5703069959949971,
					30.62098642190108
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "rectangle",
			"version": 528,
			"versionNonce": 1220276617,
			"isDeleted": false,
			"id": "X0UCSbyf7z_vY9NFHNS98",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -574.8019089195004,
			"y": 3770.2259271437265,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 156,
			"height": 59,
			"seed": 1088169234,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "Lu8LIEyu",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 625,
			"versionNonce": 643598215,
			"isDeleted": false,
			"id": "Lu8LIEyu",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -554.1718582603207,
			"y": 3787.2259271437265,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 114.73989868164062,
			"height": 25,
			"seed": 244220370,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VMAllocator",
			"rawText": "VMAllocator",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "X0UCSbyf7z_vY9NFHNS98",
			"originalText": "VMAllocator",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 459,
			"versionNonce": 1630984297,
			"isDeleted": false,
			"id": "NU9RnuGn5wFFPWybTAHpC",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -312.7768532953752,
			"y": 3782.2259271437265,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 250,
			"height": 35,
			"seed": 1577523086,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "LNpVQV0I",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 541,
			"versionNonce": 344981159,
			"isDeleted": false,
			"id": "LNpVQV0I",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -307.56673214059003,
			"y": 3787.2259271437265,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 239.5797576904297,
			"height": 25,
			"seed": 1519995026,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VmaAllocationCreateInfo",
			"rawText": "VmaAllocationCreateInfo",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "NU9RnuGn5wFFPWybTAHpC",
			"originalText": "VmaAllocationCreateInfo",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 582,
			"versionNonce": 997319497,
			"isDeleted": false,
			"id": "Hvkz-XlGZCjao51AC5XxI",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -309.8105319109511,
			"y": 3964.025590926098,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 182,
			"height": 35,
			"seed": 99915282,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "IPDvLzB6",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 647,
			"versionNonce": 1468502471,
			"isDeleted": false,
			"id": "IPDvLzB6",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -304.6004489031386,
			"y": 3969.025590926098,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 171.579833984375,
			"height": 25,
			"seed": 1299113358,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VmaAllocationInfo",
			"rawText": "VmaAllocationInfo",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Hvkz-XlGZCjao51AC5XxI",
			"originalText": "VmaAllocationInfo",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 399,
			"versionNonce": 1942524457,
			"isDeleted": false,
			"id": "HPLEJbzY8NAceUHQXzHyy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -314.75440088499124,
			"y": 3604.11192961598,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 262,
			"height": 35,
			"seed": 599022158,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "J505iaQi",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 443,
			"versionNonce": 2019541223,
			"isDeleted": false,
			"id": "J505iaQi",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -309.6442629455381,
			"y": 3609.11192961598,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 251.77972412109375,
			"height": 25,
			"seed": 2139765074,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Buffer/Image CreateInfo",
			"rawText": "Buffer/Image CreateInfo",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "HPLEJbzY8NAceUHQXzHyy",
			"originalText": "Buffer/Image CreateInfo",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 610,
			"versionNonce": 254174473,
			"isDeleted": false,
			"id": "3XOHbWZo",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -97.16803500126684,
			"y": 3969.025590926098,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 66.25991821289062,
			"height": 25,
			"seed": 480004882,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "output",
			"rawText": "output",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "output",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 563,
			"versionNonce": 681905159,
			"isDeleted": false,
			"id": "6flRtbjl",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -304.8033151235562,
			"y": 3647.0792713152355,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 218.38446044921875,
			"height": 20,
			"seed": 1771424402,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "object create info in vulkan",
			"rawText": "object create info in vulkan",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "object create info in vulkan",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 540,
			"versionNonce": 1762057193,
			"isDeleted": false,
			"id": "aVBFJcA0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -17.0773576218171,
			"y": 3723.8096898137087,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 249.49974060058594,
			"height": 25,
			"seed": 601516302,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VmaAllocationCreateFlags",
			"rawText": "VmaAllocationCreateFlags",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VmaAllocationCreateFlags",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 532,
			"versionNonce": 877916967,
			"isDeleted": false,
			"id": "0LPL7WcU",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -8.178393468544982,
			"y": 3867.181890060872,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 163.75982666015625,
			"height": 25,
			"seed": 1015928974,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VmaMemoryUsage",
			"rawText": "VmaMemoryUsage",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VmaMemoryUsage",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 355,
			"versionNonce": 1635088073,
			"isDeleted": false,
			"id": "eOreXhh8",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 289.4425187686686,
			"y": 3673.3822262784993,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 824.559326171875,
			"height": 125,
			"seed": 873966478,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VMA_ALLOCATION_CREATE_MAPPED_BIT\nVMA_ALLOCATION_CREATE_CAN_ALIAS_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_SEQUENTIAL_WRITE_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_RANDOM_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_ALLOW_TRANSFER_INSTEAD_BIT",
			"rawText": "VMA_ALLOCATION_CREATE_MAPPED_BIT\nVMA_ALLOCATION_CREATE_CAN_ALIAS_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_SEQUENTIAL_WRITE_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_RANDOM_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_ALLOW_TRANSFER_INSTEAD_BIT",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VMA_ALLOCATION_CREATE_MAPPED_BIT\nVMA_ALLOCATION_CREATE_CAN_ALIAS_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_SEQUENTIAL_WRITE_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_RANDOM_BIT\nVMA_ALLOCATION_CREATE_HOST_ACCESS_ALLOW_TRANSFER_INSTEAD_BIT",
			"lineHeight": 1.25,
			"baseline": 118
		},
		{
			"type": "text",
			"version": 396,
			"versionNonce": 869856839,
			"isDeleted": false,
			"id": "JwJc1sOI",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 207.3742937996028,
			"y": 3847.406414164711,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 486.17962646484375,
			"height": 75,
			"seed": 15053714,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "VMA_MEMORY_USAGE_AUTO\nVMA_MEMORY_USAGE_AUTO_PREFER_DEVICE\nVMA_MEMORY_USAGE_AUTO_PREFER_HOST",
			"rawText": "VMA_MEMORY_USAGE_AUTO\nVMA_MEMORY_USAGE_AUTO_PREFER_DEVICE\nVMA_MEMORY_USAGE_AUTO_PREFER_HOST",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VMA_MEMORY_USAGE_AUTO\nVMA_MEMORY_USAGE_AUTO_PREFER_DEVICE\nVMA_MEMORY_USAGE_AUTO_PREFER_HOST",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "text",
			"version": 733,
			"versionNonce": 1259189673,
			"isDeleted": false,
			"id": "0005z0Cw",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -573.2329040310756,
			"y": 3840.7734654905903,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 324.7979736328125,
			"height": 29.949532625434667,
			"seed": 1310639506,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 11.979813050173867,
			"fontFamily": 1,
			"text": "根据VmaAllocationCreateFlags...来选择适合的memory type\n内存管理, 申请大块内存返回部分",
			"rawText": "根据VmaAllocationCreateFlags...来选择适合的memory type\n内存管理, 申请大块内存返回部分",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "根据VmaAllocationCreateFlags...来选择适合的memory type\n内存管理, 申请大块内存返回部分",
			"lineHeight": 1.25,
			"baseline": 25
		},
		{
			"type": "rectangle",
			"version": 499,
			"versionNonce": 2115016039,
			"isDeleted": false,
			"id": "8jGknsSWMuDWuyNJWpAvA",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -518.1660125449054,
			"y": -69.20436704455551,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 124,
			"height": 52,
			"seed": 915913870,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "229jIfKL",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 514,
			"versionNonce": 419109001,
			"isDeleted": false,
			"id": "229jIfKL",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -504.8459594443194,
			"y": -55.70436704455551,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 97.35989379882812,
			"height": 25,
			"seed": 2103513874,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "SwapChain",
			"rawText": "SwapChain",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "8jGknsSWMuDWuyNJWpAvA",
			"originalText": "SwapChain",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 231,
			"versionNonce": 1514623111,
			"isDeleted": false,
			"id": "j4DxCTHEu4l5Z1Zvj7KJF",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -519.9237186497724,
			"y": -359.88386647945504,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 122,
			"height": 55,
			"seed": 296314254,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "pWRxdDov",
					"type": "text"
				}
			],
			"updated": 1689733954225,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 264,
			"versionNonce": 1291394921,
			"isDeleted": false,
			"id": "pWRxdDov",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -497.00367470445985,
			"y": -344.88386647945504,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 76.159912109375,
			"height": 25,
			"seed": 1073137810,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954225,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Surface",
			"rawText": "Surface",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "j4DxCTHEu4l5Z1Zvj7KJF",
			"originalText": "Surface",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 180,
			"versionNonce": 1916381095,
			"isDeleted": false,
			"id": "BqX4n9b0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -600.8910891613543,
			"y": -6.714890254769557,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 319.29986572265625,
			"height": 75,
			"seed": 1701051726,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "随着swapchain 自动\n创建swapchain images\n但是需要自己创建和管理image view",
			"rawText": "随着swapchain 自动\n创建swapchain images\n但是需要自己创建和管理image view",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "随着swapchain 自动\n创建swapchain images\n但是需要自己创建和管理image view",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "rectangle",
			"version": 369,
			"versionNonce": 626215497,
			"isDeleted": false,
			"id": "YeIVvqdYIo1pVlFBCFH6H",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -548.5842141586272,
			"y": 378.2592167317754,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 132,
			"height": 35,
			"seed": 727965216,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "MH8choYb",
					"type": "text"
				},
				{
					"id": "cnNt3m8Fmt8aYs-oY1LHo",
					"type": "arrow"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 403,
			"versionNonce": 68426439,
			"isDeleted": false,
			"id": "MH8choYb",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -543.5341500717132,
			"y": 383.2592167317754,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 121.89987182617188,
			"height": 25,
			"seed": 1714242528,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "FrameBuffer",
			"rawText": "FrameBuffer",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "YeIVvqdYIo1pVlFBCFH6H",
			"originalText": "FrameBuffer",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 216,
			"versionNonce": 182786345,
			"isDeleted": false,
			"id": "yJa8vtbQ5sSLNmKOcJTNy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -627.680206450236,
			"y": 2662.775453730838,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 128,
			"height": 59,
			"seed": 2112313312,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "SeAUTOXR",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 255,
			"versionNonce": 1416833511,
			"isDeleted": false,
			"id": "SeAUTOXR",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -611.5301591479899,
			"y": 2679.775453730838,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 95.69990539550781,
			"height": 25,
			"seed": 1129541600,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "ImageView",
			"rawText": "ImageView",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "yJa8vtbQ5sSLNmKOcJTNy",
			"originalText": "ImageView",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 213,
			"versionNonce": 1058671625,
			"isDeleted": false,
			"id": "poUmsZVrBlQqjmlX5T9pz",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -463.8695619698433,
			"y": 2614.5326637143166,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 90,
			"height": 35,
			"seed": 1135039456,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "Got69oAO",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 240,
			"versionNonce": 1617122567,
			"isDeleted": false,
			"id": "Got69oAO",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -458.5895174141792,
			"y": 2619.5326637143166,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 79.43991088867188,
			"height": 25,
			"seed": 265195488,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "viewtype",
			"rawText": "viewtype",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "poUmsZVrBlQqjmlX5T9pz",
			"originalText": "viewtype",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 207,
			"versionNonce": 1240310505,
			"isDeleted": false,
			"id": "IsMqPuZmrL26jkzfifQEj",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -463.8695619698433,
			"y": 2665.632496185018,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 77,
			"height": 35,
			"seed": 423630368,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "UA64n5sy",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 237,
			"versionNonce": 1331764263,
			"isDeleted": false,
			"id": "UA64n5sy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -458.7195222969917,
			"y": 2670.632496185018,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 66.69992065429688,
			"height": 25,
			"seed": 1220726752,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "format",
			"rawText": "format",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "IsMqPuZmrL26jkzfifQEj",
			"originalText": "format",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 222,
			"versionNonce": 669736393,
			"isDeleted": false,
			"id": "BjzPiZQAHs0DatIEeJ95f",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -463.8695619698433,
			"y": 2716.73232865572,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 203,
			"height": 35,
			"seed": 954556384,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "XUAEEFVt",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 296,
			"versionNonce": 626589511,
			"isDeleted": false,
			"id": "XUAEEFVt",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -458.6094606514839,
			"y": 2721.73232865572,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 192.47979736328125,
			"height": 25,
			"seed": 1756994080,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "components_mapping",
			"rawText": "components_mapping",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "BjzPiZQAHs0DatIEeJ95f",
			"originalText": "components_mapping",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 216,
			"versionNonce": 942587049,
			"isDeleted": false,
			"id": "vnbePsvSqyitSGGFU0xAo",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -463.8695619698433,
			"y": 2767.832161126422,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 182,
			"height": 35,
			"seed": 1048726048,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "suIr5AZK",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 259,
			"versionNonce": 883392103,
			"isDeleted": false,
			"id": "suIr5AZK",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -458.8694627877144,
			"y": 2772.832161126422,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 171.9998016357422,
			"height": 25,
			"seed": 2142583776,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "subresourceRange",
			"rawText": "subresourceRange",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "vnbePsvSqyitSGGFU0xAo",
			"originalText": "subresourceRange",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 288,
			"versionNonce": 1784889225,
			"isDeleted": false,
			"id": "BE14GDot",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -343.39403497957096,
			"y": 2621.754395560869,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 221.73980712890625,
			"height": 25,
			"seed": 1758545440,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "1D, 2D, Cube, ARRAY...",
			"rawText": "1D, 2D, Cube, ARRAY...",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "1D, 2D, Cube, ARRAY...",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 198,
			"versionNonce": 1343822215,
			"isDeleted": false,
			"id": "onnAr7D1kZURkPe7l7qNC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -452.9318259144344,
			"y": 2112.8968217091556,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 67,
			"height": 37,
			"seed": 1789504032,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "jIYiGhHs",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 216,
			"versionNonce": 751068777,
			"isDeleted": false,
			"id": "jIYiGhHs",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -440.17180089002034,
			"y": 2118.8968217091556,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 41.479949951171875,
			"height": 25,
			"seed": 2116276768,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "type",
			"rawText": "type",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "onnAr7D1kZURkPe7l7qNC",
			"originalText": "type",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 214,
			"versionNonce": 1021989031,
			"isDeleted": false,
			"id": "MfLLndFx",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -360.06978892519203,
			"y": 2123.4511513255366,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 110.35990905761719,
			"height": 25,
			"seed": 1713180640,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "1D, 2D, 3D",
			"rawText": "1D, 2D, 3D",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "1D, 2D, 3D",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "freedraw",
			"version": 272,
			"versionNonce": 438153545,
			"isDeleted": false,
			"id": "nvfjLqsaSzbI5bgwm7Kcv",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -585.9389129852431,
			"y": 2398.945900298015,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 63.319357626739134,
			"height": 252.16656458368038,
			"seed": 1197155296,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					1.110865923276151
				],
				[
					-1.1108659232760374,
					1.110865923276151
				],
				[
					-2.2217318465521885,
					3.3325977698284532
				],
				[
					-4.443463693104491,
					6.665195539656679
				],
				[
					-6.665195539656679,
					9.997793309485132
				],
				[
					-9.997793309485132,
					13.330391079313586
				],
				[
					-12.21952515603732,
					16.66298884914181
				],
				[
					-16.66298884914181,
					22.217318465522567
				],
				[
					-24.439050312074755,
					31.104245851731548
				],
				[
					-28.882514005179246,
					38.88030731466438
				],
				[
					-34.43684362155989,
					43.323771007768755
				],
				[
					-36.658575468112076,
					46.65636877759721
				],
				[
					-38.88030731466438,
					49.98896654742566
				],
				[
					-41.10203916121657,
					52.210698393977964
				],
				[
					-43.32377100776887,
					55.54329616380619
				],
				[
					-46.65636877759721,
					59.986759856910794
				],
				[
					-47.76723470087336,
					61.097625780186945
				],
				[
					-51.0998324707017,
					67.76282131984362
				],
				[
					-52.21069839397785,
					69.98455316639593
				],
				[
					-54.43243024053004,
					73.31715093622415
				],
				[
					-55.54329616380619,
					77.76061462932876
				],
				[
					-57.76502801035849,
					82.20407832243336
				],
				[
					-59.98675985691068,
					86.64754201553774
				],
				[
					-61.09762578018683,
					91.09100570864234
				],
				[
					-62.20849170346298,
					94.42360347847057
				],
				[
					-63.319357626739134,
					98.86706717157517
				],
				[
					-63.319357626739134,
					102.19966494140363
				],
				[
					-63.319357626739134,
					105.53226271123185
				],
				[
					-63.319357626739134,
					107.75399455778415
				],
				[
					-63.319357626739134,
					111.0865923276126
				],
				[
					-63.319357626739134,
					113.30832417416468
				],
				[
					-63.319357626739134,
					115.53005602071698
				],
				[
					-63.319357626739134,
					118.86265379054544
				],
				[
					-63.319357626739134,
					122.19525156037389
				],
				[
					-63.319357626739134,
					126.63871525347827
				],
				[
					-62.20849170346298,
					129.97131302330672
				],
				[
					-61.09762578018683,
					135.52564263968725
				],
				[
					-61.09762578018683,
					137.74737448623955
				],
				[
					-59.98675985691068,
					141.07997225606778
				],
				[
					-58.87589393363453,
					145.52343594917238
				],
				[
					-57.76502801035849,
					149.96689964227699
				],
				[
					-56.65416208708234,
					153.2994974121052
				],
				[
					-54.43243024053004,
					157.74296110520982
				],
				[
					-54.43243024053004,
					161.07555887503804
				],
				[
					-52.21069839397785,
					164.4081566448665
				],
				[
					-49.98896654742555,
					167.74075441469495
				],
				[
					-48.87810062414951,
					169.96248626124725
				],
				[
					-47.76723470087336,
					173.29508403107548
				],
				[
					-46.65636877759721,
					174.40594995435163
				],
				[
					-46.65636877759721,
					176.62768180090393
				],
				[
					-45.54550285432106,
					178.84941364745623
				],
				[
					-44.434636931044906,
					182.18201141728446
				],
				[
					-43.32377100776887,
					184.40374326383676
				],
				[
					-42.21290508449272,
					185.5146091871129
				],
				[
					-39.991173237940416,
					188.84720695694136
				],
				[
					-38.88030731466438,
					189.95807288021751
				],
				[
					-38.88030731466438,
					191.06893880349344
				],
				[
					-37.76944139138823,
					193.29067065004574
				],
				[
					-36.658575468112076,
					195.51240249659804
				],
				[
					-34.43684362155989,
					197.73413434315034
				],
				[
					-33.32597769828374,
					199.95586618970265
				],
				[
					-32.215111775007585,
					202.17759803625472
				],
				[
					-31.104245851731434,
					204.39932988280702
				],
				[
					-29.993379928455283,
					207.73192765263548
				],
				[
					-28.882514005179246,
					209.95365949918778
				],
				[
					-27.771648081903095,
					212.17539134574008
				],
				[
					-26.660782158626944,
					214.39712319229216
				],
				[
					-25.549916235350793,
					215.5079891155683
				],
				[
					-24.439050312074755,
					217.7297209621206
				],
				[
					-23.328184388798604,
					219.9514528086729
				],
				[
					-22.217318465522453,
					221.06231873194884
				],
				[
					-21.106452542246302,
					223.28405057850114
				],
				[
					-19.99558661897015,
					224.3949165017773
				],
				[
					-18.884720695694114,
					225.50578242505344
				],
				[
					-17.773854772417963,
					227.72751427160574
				],
				[
					-16.66298884914181,
					228.83838019488167
				],
				[
					-15.55212292586566,
					231.06011204143397
				],
				[
					-14.441257002589623,
					233.28184388798627
				],
				[
					-13.330391079313472,
					234.39270981126242
				],
				[
					-12.21952515603732,
					235.50357573453857
				],
				[
					-11.10865923276117,
					237.72530758109087
				],
				[
					-9.997793309485132,
					238.8361735043668
				],
				[
					-8.886927386208981,
					241.0579053509191
				],
				[
					-7.77606146293283,
					242.16877127419525
				],
				[
					-6.665195539656679,
					244.39050312074755
				],
				[
					-5.554329616380528,
					246.61223496729963
				],
				[
					-5.554329616380528,
					247.723100890576
				],
				[
					-4.443463693104491,
					248.83396681385193
				],
				[
					-3.3325977698283396,
					249.9448327371283
				],
				[
					-3.3325977698283396,
					251.05569866040423
				],
				[
					-2.2217318465521885,
					251.05569866040423
				],
				[
					-1.1108659232760374,
					251.05569866040423
				],
				[
					-1.1108659232760374,
					252.16656458368038
				],
				[
					-1.1108659232760374,
					252.16656458368038
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 221,
			"versionNonce": 1690805191,
			"isDeleted": false,
			"id": "nYolcpWDRhnViv15BT73b",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -619.7032094644187,
			"y": 2636.2429350789116,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 39.99117323794053,
			"height": 33.32597769828362,
			"seed": 1337975776,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.2217318465521885,
					2.221731846552075
				],
				[
					5.554329616380642,
					4.443463693104377
				],
				[
					9.997793309485132,
					7.77606146293283
				],
				[
					12.21952515603732,
					9.997793309485132
				],
				[
					16.66298884914181,
					12.219525156037207
				],
				[
					17.773854772417963,
					13.330391079313586
				],
				[
					21.106452542246302,
					15.552122925865888
				],
				[
					26.660782158626944,
					16.66298884914181
				],
				[
					29.993379928455397,
					16.66298884914181
				],
				[
					31.104245851731434,
					16.66298884914181
				],
				[
					32.215111775007585,
					16.66298884914181
				],
				[
					33.32597769828374,
					16.66298884914181
				],
				[
					35.54770954483604,
					15.552122925865888
				],
				[
					35.54770954483604,
					14.44125700258951
				],
				[
					36.658575468112076,
					13.330391079313586
				],
				[
					37.76944139138823,
					11.108659232761283
				],
				[
					37.76944139138823,
					8.886927386208981
				],
				[
					38.88030731466438,
					5.554329616380755
				],
				[
					38.88030731466438,
					1.110865923276151
				],
				[
					39.99117323794053,
					-2.221731846552302
				],
				[
					39.99117323794053,
					-6.665195539656679
				],
				[
					39.99117323794053,
					-9.997793309485132
				],
				[
					39.99117323794053,
					-14.44125700258951
				],
				[
					39.99117323794053,
					-15.552122925865888
				],
				[
					39.99117323794053,
					-16.66298884914181
				],
				[
					39.99117323794053,
					-16.66298884914181
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "rectangle",
			"version": 290,
			"versionNonce": 1741332521,
			"isDeleted": false,
			"id": "S64o4b2G3XeRPjf9e-vdV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -366.36313255996333,
			"y": 325.1004039740985,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 155,
			"height": 45,
			"seed": 179054449,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "X6trqsMi",
					"type": "text"
				},
				{
					"id": "cnNt3m8Fmt8aYs-oY1LHo",
					"type": "arrow"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 359,
			"versionNonce": 1204654823,
			"isDeleted": false,
			"id": "X6trqsMi",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -356.38306053847896,
			"y": 335.1004039740985,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 135.03985595703125,
			"height": 25,
			"seed": 1420691903,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "RenderTarget",
			"rawText": "RenderTarget",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "S64o4b2G3XeRPjf9e-vdV",
			"originalText": "RenderTarget",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "arrow",
			"version": 192,
			"versionNonce": 1177910967,
			"isDeleted": false,
			"id": "cnNt3m8Fmt8aYs-oY1LHo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -415.5842141586272,
			"y": 391.5448313346675,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 47.51902724396655,
			"height": 36.6292501672242,
			"seed": 1785821457,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911989,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "YeIVvqdYIo1pVlFBCFH6H",
				"gap": 1,
				"focus": 0.6936957650636261
			},
			"endBinding": {
				"elementId": "S64o4b2G3XeRPjf9e-vdV",
				"gap": 1.7020543546973386,
				"focus": 0.653412921049589
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					47.51902724396655,
					-36.6292501672242
				]
			]
		},
		{
			"type": "arrow",
			"version": 176,
			"versionNonce": 855940567,
			"isDeleted": false,
			"id": "Fq5w72AJyOO7dLTxaFRDc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -418.51161725431444,
			"y": 393.25486822558014,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 41.42817303145631,
			"height": 97.39470627301893,
			"seed": 738694993,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911935,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "ysk_8VVB6QndbLThPjmFR",
				"gap": 2.1848567779742893,
				"focus": -0.655657664710198
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					41.42817303145631,
					97.39470627301893
				]
			]
		},
		{
			"type": "arrow",
			"version": 708,
			"versionNonce": 1669205785,
			"isDeleted": false,
			"id": "9UuEP5s2aAyxtS_VPijJb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -516.2102099178862,
			"y": -40.096802405449694,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 299.5478483726423,
			"height": 2372.620513375516,
			"seed": 210355729,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911937,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "HqMsZjgtVTcZlnGxskMQC",
				"gap": 1,
				"focus": -0.8220711072367812
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-285.93203708297665,
					162.1519344496536
				],
				[
					-299.5478483726423,
					1295.977674570895
				],
				[
					-108.120035688558,
					2372.620513375516
				]
			]
		},
		{
			"type": "rectangle",
			"version": 193,
			"versionNonce": 469058855,
			"isDeleted": false,
			"id": "eGEQeA7or1QKgUkDFoPAo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -453.73121195298563,
			"y": 2300.4989365525676,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 132,
			"height": 35,
			"seed": 217494102,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "T3Cnc8iS",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 231,
			"versionNonce": 1019888841,
			"isDeleted": false,
			"id": "T3Cnc8iS",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -448.55113535386454,
			"y": 2305.4989365525676,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 121.63984680175781,
			"height": 25,
			"seed": 778825482,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "array layers",
			"rawText": "array layers",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "eGEQeA7or1QKgUkDFoPAo",
			"originalText": "array layers",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 349,
			"versionNonce": 2139097159,
			"isDeleted": false,
			"id": "h5JNVj01",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -311.41766880803493,
			"y": 2300.2749845471726,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 564.1165771484375,
			"height": 40,
			"seed": 418439958,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": "https://github.com/SaschaWillems/Vulkan/blob/master/examples/texturecubemap/texturecubemap.cpp",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐 Images in Vulkan can actually be an array of images, called layers.\n[[example]]: cubemap image layers=6",
			"rawText": " Images in Vulkan can actually be an array of images, called layers.\n[example](https://github.com/SaschaWillems/Vulkan/blob/master/examples/texturecubemap/texturecubemap.cpp): cubemap image layers=6",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐 Images in Vulkan can actually be an array of images, called layers.\n[[example]]: cubemap image layers=6",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "rectangle",
			"version": 319,
			"versionNonce": 1050198953,
			"isDeleted": false,
			"id": "PC8Yj7qDvQ-S8ecWV0G85",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -695.4564620522364,
			"y": 4245.376565764038,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 69,
			"height": 30,
			"seed": 66099222,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "yGE9c4U7",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 327,
			"versionNonce": 654665575,
			"isDeleted": false,
			"id": "yGE9c4U7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -690.0845214394434,
			"y": 4250.376565764038,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 58.25611877441406,
			"height": 20,
			"seed": 1103392458,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "VkFence",
			"rawText": "VkFence",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "PC8Yj7qDvQ-S8ecWV0G85",
			"originalText": "VkFence",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 345,
			"versionNonce": 1140090505,
			"isDeleted": false,
			"id": "QWETYi6G6VcTfj5TyAtYI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -693.8708077916924,
			"y": 4406.216980675873,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 106,
			"height": 30,
			"seed": 528417546,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "FYbDrICX",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 376,
			"versionNonce": 1892803207,
			"isDeleted": false,
			"id": "FYbDrICX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -688.6869164953057,
			"y": 4411.216980675873,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 95.63221740722656,
			"height": 20,
			"seed": 1281930518,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "VkSemaphore",
			"rawText": "VkSemaphore",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "QWETYi6G6VcTfj5TyAtYI",
			"originalText": "VkSemaphore",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 630,
			"versionNonce": 664317289,
			"isDeleted": false,
			"id": "Gzn0Btx2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -694.3605212486972,
			"y": 4315.388390446341,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 259.0725402832031,
			"height": 43.76867933496226,
			"seed": 1936114122,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "10FCED_4qsLDyC9jfTu1S",
					"type": "arrow"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 11.6716478226566,
			"fontFamily": 1,
			"text": "gpu -> cpu sync\nhas two state: signaled and unsignaled\ndevice to signal, and host to get/wait/reset",
			"rawText": "gpu -> cpu sync\nhas two state: signaled and unsignaled\ndevice to signal, and host to get/wait/reset",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "gpu -> cpu sync\nhas two state: signaled and unsignaled\ndevice to signal, and host to get/wait/reset",
			"lineHeight": 1.25,
			"baseline": 39
		},
		{
			"type": "rectangle",
			"version": 201,
			"versionNonce": 1034025383,
			"isDeleted": false,
			"id": "3UA1CARQ81x6lW7HK7GIG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -699.9674859508838,
			"y": 4099.447323636971,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 82,
			"height": 30,
			"seed": 900089354,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "COyABzJc",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 228,
			"versionNonce": 1624315977,
			"isDeleted": false,
			"id": "COyABzJc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -694.5995736584033,
			"y": 4104.447323636971,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 71.26417541503906,
			"height": 20,
			"seed": 2135982294,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "VkBarrier",
			"rawText": "VkBarrier",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "3UA1CARQ81x6lW7HK7GIG",
			"originalText": "VkBarrier",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 298,
			"versionNonce": 581053639,
			"isDeleted": false,
			"id": "zHqvDtLN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -563.8738363665725,
			"y": 4411.216980675873,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 96.25619506835938,
			"height": 20,
			"seed": 1807161162,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "gpu-gpu sync",
			"rawText": "gpu-gpu sync",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "gpu-gpu sync",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 255,
			"versionNonce": 1903765289,
			"isDeleted": false,
			"id": "IDiX2GLBmOfNw4pmW7mES",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -692.6375859693095,
			"y": 4483.850463209688,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 71,
			"height": 30,
			"seed": 1686106058,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "eKvMgTaU",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 277,
			"versionNonce": 1534000103,
			"isDeleted": false,
			"id": "eKvMgTaU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -687.3776524976298,
			"y": 4488.850463209688,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 60.480133056640625,
			"height": 20,
			"seed": 258218710,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "VkEvent",
			"rawText": "VkEvent",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "IDiX2GLBmOfNw4pmW7mES",
			"originalText": "VkEvent",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 176,
			"versionNonce": 335305225,
			"isDeleted": false,
			"id": "aTYvbIFk-vbsYCxh0Hzdu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -606.371068901768,
			"y": 4243.359567027184,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 138,
			"height": 30,
			"seed": 961533450,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "iLO56kq8",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 208,
			"versionNonce": 2081744647,
			"isDeleted": false,
			"id": "iLO56kq8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -600.9312037894633,
			"y": 4248.359567027184,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 127.12026977539062,
			"height": 20,
			"seed": 1970858186,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "vkWaitForFences",
			"rawText": "vkWaitForFences",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "aTYvbIFk-vbsYCxh0Hzdu",
			"originalText": "vkWaitForFences",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 176,
			"versionNonce": 693514473,
			"isDeleted": false,
			"id": "VVw_rq1YV1Msequt9JuPm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -606.371068901768,
			"y": 4280.886717860058,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 124,
			"height": 30,
			"seed": 299009238,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "Aqz5ifri",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 216,
			"versionNonce": 1662021159,
			"isDeleted": false,
			"id": "Aqz5ifri",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -600.9311809012797,
			"y": 4285.886717860058,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 113.12022399902344,
			"height": 20,
			"seed": 127197002,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "vkResetFences",
			"rawText": "vkResetFences",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "VVw_rq1YV1Msequt9JuPm",
			"originalText": "vkResetFences",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 609,
			"versionNonce": 1729244105,
			"isDeleted": false,
			"id": "GvyZP1Ol",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -602.956723162312,
			"y": 4184.933396605424,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 82.237060546875,
			"height": 14.640784156251865,
			"seed": 1580730326,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 11.712627325001492,
			"fontFamily": 1,
			"text": "host functions",
			"rawText": "host functions",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "host functions",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "rectangle",
			"version": 176,
			"versionNonce": 1800278343,
			"isDeleted": false,
			"id": "TYD2WxHdpOXmdRVfNRORh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -605.3139660614055,
			"y": 4210.589378975941,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 156,
			"height": 30,
			"seed": 1422219850,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "eh1l9kEQ",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 199,
			"versionNonce": 1162594985,
			"isDeleted": false,
			"id": "eh1l9kEQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -599.8261196868938,
			"y": 4215.589378975941,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 145.02430725097656,
			"height": 20,
			"seed": 2143946454,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "vkGetFenceStatus",
			"rawText": "vkGetFenceStatus",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "TYD2WxHdpOXmdRVfNRORh",
			"originalText": "vkGetFenceStatus",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 414,
			"versionNonce": 1579831399,
			"isDeleted": false,
			"id": "UOrHDtiZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -476.1043823187931,
			"y": 4295.4006434233215,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 121.29859924316406,
			"height": 12.16554791459063,
			"seed": 1731197834,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 9.732438331672503,
			"fontFamily": 1,
			"text": "back to unsignaled state",
			"rawText": "back to unsignaled state",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "back to unsignaled state",
			"lineHeight": 1.25,
			"baseline": 8
		},
		{
			"type": "rectangle",
			"version": 176,
			"versionNonce": 749637001,
			"isDeleted": false,
			"id": "_JBGln79SEmCm-_jBP_NF",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -903.4169670436752,
			"y": 4649.28705772645,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 86,
			"height": 30,
			"seed": 384750166,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "gYXqiGAb",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 233,
			"versionNonce": 628206471,
			"isDeleted": false,
			"id": "gYXqiGAb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -898.0970436427963,
			"y": 4654.28705772645,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.36015319824219,
			"height": 20,
			"seed": 2010305418,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Commands",
			"rawText": "Commands",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "_JBGln79SEmCm-_jBP_NF",
			"originalText": "Commands",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 217,
			"versionNonce": 1685451881,
			"isDeleted": false,
			"id": "356e2Z7lUjN00hjnuinA-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -743.5773431388394,
			"y": 4621.037767750494,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132,
			"height": 30,
			"seed": 170396950,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "oAmnIF2n",
					"type": "text"
				},
				{
					"id": "E_Hwqkj4jTvm_MnP-lNDg",
					"type": "arrow"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 232,
			"versionNonce": 1029743271,
			"isDeleted": false,
			"id": "oAmnIF2n",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -738.3934594718472,
			"y": 4626.037767750494,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 121.63223266601562,
			"height": 20,
			"seed": 1745234506,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Command Queue",
			"rawText": "Command Queue",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "356e2Z7lUjN00hjnuinA-",
			"originalText": "Command Queue",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 522,
			"versionNonce": 1080917833,
			"isDeleted": false,
			"id": "RMNIyU0I_hl4lUxU7G9F8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -725.6491638792844,
			"y": 5359.8630669452405,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 137,
			"height": 30,
			"seed": 2061630986,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "tA6HZ5rR",
					"type": "text"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 538,
			"versionNonce": 1722004935,
			"isDeleted": false,
			"id": "tA6HZ5rR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -720.4372879637571,
			"y": 5364.8630669452405,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 126.57624816894531,
			"height": 20,
			"seed": 1781711190,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Command Buffer",
			"rawText": "Command Buffer",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "RMNIyU0I_hl4lUxU7G9F8",
			"originalText": "Command Buffer",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 178,
			"versionNonce": 250654249,
			"isDeleted": false,
			"id": "UZJTYUQdz3e0ruLVEFicA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -239.27148322776145,
			"y": 4445.536553778687,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 123,
			"height": 30,
			"seed": 1266139222,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "iMPPEsA5",
					"type": "text"
				},
				{
					"id": "E_Hwqkj4jTvm_MnP-lNDg",
					"type": "arrow"
				},
				{
					"id": "10FCED_4qsLDyC9jfTu1S",
					"type": "arrow"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 521,
			"versionNonce": 408380647,
			"isDeleted": false,
			"id": "iMPPEsA5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -234.13960151389426,
			"y": 4450.536553778687,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 112.73623657226562,
			"height": 20,
			"seed": 459839766,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "vkQueueSubmit",
			"rawText": "vkQueueSubmit",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "UZJTYUQdz3e0ruLVEFicA",
			"originalText": "vkQueueSubmit",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 768,
			"versionNonce": 1435532535,
			"isDeleted": false,
			"id": "E_Hwqkj4jTvm_MnP-lNDg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -608.8590545509832,
			"y": 4631.587213251577,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 368.5875713232217,
			"height": 156.5804344343005,
			"seed": 1676474826,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248912002,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "356e2Z7lUjN00hjnuinA-",
				"gap": 2.71828858785625,
				"focus": 0.5748881126586156
			},
			"endBinding": {
				"elementId": "UZJTYUQdz3e0ruLVEFicA",
				"gap": 1,
				"focus": 0.29374469945932785
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					368.5875713232217,
					-156.5804344343005
				]
			]
		},
		{
			"type": "arrow",
			"version": 812,
			"versionNonce": 1183041047,
			"isDeleted": false,
			"id": "10FCED_4qsLDyC9jfTu1S",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -242.5956514793886,
			"y": 4452.6175958415915,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 191.4558697874245,
			"height": 102.66474177006785,
			"seed": 1925138826,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248912002,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "UZJTYUQdz3e0ruLVEFicA",
				"gap": 3.3241682516271567,
				"focus": -0.5594581264614358
			},
			"endBinding": {
				"elementId": "Gzn0Btx2",
				"gap": 1.2364596986809602,
				"focus": -0.6288671413113228
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-191.4558697874245,
					-102.66474177006785
				]
			]
		},
		{
			"type": "text",
			"version": 396,
			"versionNonce": 1977087977,
			"isDeleted": false,
			"id": "5d2D5HUQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 191.76975891515528,
			"y": 4245.113876357866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.057830810546875,
			"height": 16.142001299736243,
			"seed": 379011574,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 12.913601039788995,
			"fontFamily": 1,
			"text": "CPU",
			"rawText": "CPU",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "CPU",
			"lineHeight": 1.25,
			"baseline": 11
		},
		{
			"type": "text",
			"version": 438,
			"versionNonce": 1840420647,
			"isDeleted": false,
			"id": "10awLCN4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 373.9432652999516,
			"y": 4245.113876357866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.929244995117188,
			"height": 16.142001299736243,
			"seed": 1055105194,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 12.913601039788995,
			"fontFamily": 1,
			"text": "GPU",
			"rawText": "GPU",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "GPU",
			"lineHeight": 1.25,
			"baseline": 11
		},
		{
			"type": "text",
			"version": 412,
			"versionNonce": 1841500873,
			"isDeleted": false,
			"id": "nR6RNCqp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 541.2705338610979,
			"y": 4245.113876357866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 49.14723205566406,
			"height": 16.142001299736243,
			"seed": 1684608246,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 12.913601039788995,
			"fontFamily": 1,
			"text": "Surface",
			"rawText": "Surface",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Surface",
			"lineHeight": 1.25,
			"baseline": 11
		},
		{
			"type": "rectangle",
			"version": 437,
			"versionNonce": 297998919,
			"isDeleted": false,
			"id": "kQuwbtqJHGqGCnLLluAYh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 185.09672473319858,
			"y": 4323.875826134021,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 103,
			"height": 26,
			"seed": 732412842,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "TSYvJrm9",
					"type": "text"
				},
				{
					"id": "RD2IdSiknBlIi1cFFoGVs",
					"type": "arrow"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 489,
			"versionNonce": 860344745,
			"isDeleted": false,
			"id": "TSYvJrm9",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 190.60391925224155,
			"y": 4328.969697223481,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 91.98561096191406,
			"height": 15.812257821081223,
			"seed": 1392360234,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 12.649806256864979,
			"fontFamily": 1,
			"text": "fill cmd_buffer",
			"rawText": "fill cmd_buffer",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "kQuwbtqJHGqGCnLLluAYh",
			"originalText": "fill cmd_buffer",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "rectangle",
			"version": 444,
			"versionNonce": 1662400871,
			"isDeleted": false,
			"id": "l3wsJ-a9ajQKgRvBMUNs3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 356.79806841826144,
			"y": 4323.875826134021,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 47,
			"height": 26,
			"seed": 1450556726,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "bFK4QbB0",
					"type": "text"
				},
				{
					"id": "RD2IdSiknBlIi1cFFoGVs",
					"type": "arrow"
				},
				{
					"id": "hJItY2_Tp6sais0wQG57x",
					"type": "arrow"
				},
				{
					"id": "8_uaNAPVAbYSvsqoMNnSW",
					"type": "arrow"
				},
				{
					"id": "UMZsKtkil3IrgHiWRzhvz",
					"type": "arrow"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 477,
			"versionNonce": 730969225,
			"isDeleted": false,
			"id": "bFK4QbB0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 361.96086443876925,
			"y": 4329.206700348764,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 36.674407958984375,
			"height": 15.33825157051462,
			"seed": 1152965174,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 12.270601256411696,
			"fontFamily": 1,
			"text": "render",
			"rawText": "render",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "l3wsJ-a9ajQKgRvBMUNs3",
			"originalText": "render",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "rectangle",
			"version": 440,
			"versionNonce": 1459123335,
			"isDeleted": false,
			"id": "TB2aliYDyt6VAkQ9W-1wU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 547.9441456213916,
			"y": 4323.875826134021,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 38,
			"height": 26,
			"seed": 627549162,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "EeeeNCuu",
					"type": "text"
				},
				{
					"id": "hJItY2_Tp6sais0wQG57x",
					"type": "arrow"
				},
				{
					"id": "UMZsKtkil3IrgHiWRzhvz",
					"type": "arrow"
				}
			],
			"updated": 1689733954226,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 473,
			"versionNonce": 173816681,
			"isDeleted": false,
			"id": "EeeeNCuu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 553.692642630669,
			"y": 4329.340658636967,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.503005981445312,
			"height": 15.070334994107428,
			"seed": 1486600310,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"fontSize": 12.056267995285943,
			"fontFamily": 1,
			"text": "show",
			"rawText": "show",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "TB2aliYDyt6VAkQ9W-1wU",
			"originalText": "show",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "line",
			"version": 669,
			"versionNonce": 86395815,
			"isDeleted": false,
			"id": "UUQSqJynxW5EjfZ_lASSd",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 308.0046407878378,
			"y": 4241.929359046286,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 2.388387983685234,
			"height": 258.7420315659022,
			"seed": 1499239018,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1689733954226,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					2.388387983685234,
					258.7420315659022
				]
			]
		},
		{
			"type": "line",
			"version": 547,
			"versionNonce": 2146625097,
			"isDeleted": false,
			"id": "aY6bs7IIPJi8vdDaAfvBw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 475.9879289737009,
			"y": 4244.317747029971,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 3.98064663947539,
			"height": 261.13041954958817,
			"seed": 187742442,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					3.98064663947539,
					261.13041954958817
				]
			]
		},
		{
			"type": "arrow",
			"version": 1481,
			"versionNonce": 398224471,
			"isDeleted": false,
			"id": "RD2IdSiknBlIi1cFFoGVs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 290.7738454542865,
			"y": 4338.2582115204,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 63.34710224288693,
			"height": 0.792046334180668,
			"seed": 1196110186,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "KzelzrFJ"
				}
			],
			"updated": 1690248912005,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "kQuwbtqJHGqGCnLLluAYh",
				"gap": 2.677120721087917,
				"focus": 0.150966664750246
			},
			"endBinding": {
				"elementId": "l3wsJ-a9ajQKgRvBMUNs3",
				"gap": 2.677120721087988,
				"focus": -0.01978657268228851
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					63.34710224288693,
					-0.792046334180668
				]
			]
		},
		{
			"type": "text",
			"version": 372,
			"versionNonce": 657536297,
			"isDeleted": false,
			"id": "KzelzrFJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 368.84337754140256,
			"y": 4350.7914285381585,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 48.57611083984375,
			"height": 20,
			"seed": 1825563370,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "submit",
			"rawText": "submit",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "RD2IdSiknBlIi1cFFoGVs",
			"originalText": "submit",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 1522,
			"versionNonce": 357701559,
			"isDeleted": false,
			"id": "hJItY2_Tp6sais0wQG57x",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 406.4751891393495,
			"y": 4338.260029925732,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 138.7918357609541,
			"height": 1.5864247363306276,
			"seed": 2086170282,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "QPCeJSUf"
				}
			],
			"updated": 1690248912009,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "l3wsJ-a9ajQKgRvBMUNs3",
				"gap": 2.677120721087988,
				"focus": 0.12687196376476637
			},
			"endBinding": {
				"elementId": "TB2aliYDyt6VAkQ9W-1wU",
				"gap": 2.6771207210880448,
				"focus": 0.03404628936328033
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					138.7918357609541,
					-1.5864247363306276
				]
			]
		},
		{
			"type": "text",
			"version": 372,
			"versionNonce": 864200713,
			"isDeleted": false,
			"id": "QPCeJSUf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 554.7962170447768,
			"y": 4350.298224930309,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 57.47212219238281,
			"height": 20,
			"seed": 1303839414,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "present",
			"rawText": "present",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "hJItY2_Tp6sais0wQG57x",
			"originalText": "present",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 499,
			"versionNonce": 962754823,
			"isDeleted": false,
			"id": "zkSClAb3i4W-cD8Du3o8T",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 185.6491306051753,
			"y": 4397.010016929452,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 103,
			"height": 26,
			"seed": 854713386,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "HgfqSqCa",
					"type": "text"
				},
				{
					"id": "nPXhIT8ghuRbtiykwyW_R",
					"type": "arrow"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 550,
			"versionNonce": 1591918313,
			"isDeleted": false,
			"id": "HgfqSqCa",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 191.15632512421826,
			"y": 4402.103888018912,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 91.98561096191406,
			"height": 15.812257821081223,
			"seed": 204984042,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.649806256864979,
			"fontFamily": 1,
			"text": "fill cmd_buffer",
			"rawText": "fill cmd_buffer",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "zkSClAb3i4W-cD8Du3o8T",
			"originalText": "fill cmd_buffer",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "arrow",
			"version": 1121,
			"versionNonce": 1556737401,
			"isDeleted": false,
			"id": "8_uaNAPVAbYSvsqoMNnSW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 384.1395556002387,
			"y": 4350.875826134021,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 141.41751969979785,
			"height": 51.871657147071424,
			"seed": 833394038,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "e4bjF9y4"
				}
			],
			"updated": 1690248912006,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "l3wsJ-a9ajQKgRvBMUNs3",
				"gap": 1,
				"focus": -0.353399633018615
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-14.036827236584253,
					29.580035966008875
				],
				[
					-126.29106246979099,
					24.803259998638406
				],
				[
					-141.41751969979785,
					51.871657147071424
				]
			]
		},
		{
			"type": "text",
			"version": 376,
			"versionNonce": 400357833,
			"isDeleted": false,
			"id": "e4bjF9y4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 339.72176983019875,
			"y": 4400.640114397941,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 81.74417114257812,
			"height": 20,
			"seed": 795573290,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "wait fence",
			"rawText": "wait fence",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "8_uaNAPVAbYSvsqoMNnSW",
			"originalText": "wait fence",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 493,
			"versionNonce": 467608391,
			"isDeleted": false,
			"id": "OTFfFmy5LuDi1CiZQjKMP",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 363.32144424945125,
			"y": 4397.010016929452,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 47,
			"height": 26,
			"seed": 1556707318,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "8VoL2tpD",
					"type": "text"
				},
				{
					"id": "qw3SU5QS_ZPkXwzG2nUAd",
					"type": "arrow"
				},
				{
					"id": "nPXhIT8ghuRbtiykwyW_R",
					"type": "arrow"
				},
				{
					"id": "vC4PA04c0A-Yz9lfBSjU-",
					"type": "arrow"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 527,
			"versionNonce": 1871501481,
			"isDeleted": false,
			"id": "8VoL2tpD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 368.48424026995906,
			"y": 4402.340891144195,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 36.674407958984375,
			"height": 15.33825157051462,
			"seed": 134416694,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.270601256411696,
			"fontFamily": 1,
			"text": "render",
			"rawText": "render",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "OTFfFmy5LuDi1CiZQjKMP",
			"originalText": "render",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "arrow",
			"version": 1440,
			"versionNonce": 924505591,
			"isDeleted": false,
			"id": "qw3SU5QS_ZPkXwzG2nUAd",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 575.177064470783,
			"y": 4349.692057476507,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 186.91863793160996,
			"height": 45.89026185352941,
			"seed": 474614378,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "SzQN6NCX"
				}
			],
			"updated": 1690248912012,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "OTFfFmy5LuDi1CiZQjKMP",
				"gap": 1.4276975994152963,
				"focus": -0.33496366437707337
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-18.118018636267855,
					26.783157984047566
				],
				[
					-167.790332280544,
					25.19089932825741
				],
				[
					-186.91863793160996,
					45.89026185352941
				]
			]
		},
		{
			"type": "text",
			"version": 392,
			"versionNonce": 1201527689,
			"isDeleted": false,
			"id": "SzQN6NCX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 528.578616524553,
			"y": 4397.988736873084,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 119.48826599121094,
			"height": 20,
			"seed": 879290026,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "wait semaphore",
			"rawText": "wait semaphore",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "qw3SU5QS_ZPkXwzG2nUAd",
			"originalText": "wait semaphore",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 500,
			"versionNonce": 1852194183,
			"isDeleted": false,
			"id": "4AQ_d_kVbUWEWP_oktEJk",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 544.5621550421604,
			"y": 4397.010016929452,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 38,
			"height": 26,
			"seed": 1601262250,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "7GOFzk7J",
					"type": "text"
				},
				{
					"id": "mt66qu0hBVB53mMu6gRRp",
					"type": "arrow"
				},
				{
					"id": "vC4PA04c0A-Yz9lfBSjU-",
					"type": "arrow"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 534,
			"versionNonce": 1078690409,
			"isDeleted": false,
			"id": "7GOFzk7J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 550.3106520514377,
			"y": 4402.4748494323985,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.503005981445312,
			"height": 15.070334994107428,
			"seed": 63270250,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.056267995285943,
			"fontFamily": 1,
			"text": "show",
			"rawText": "show",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "4AQ_d_kVbUWEWP_oktEJk",
			"originalText": "show",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "arrow",
			"version": 890,
			"versionNonce": 200868919,
			"isDeleted": false,
			"id": "mt66qu0hBVB53mMu6gRRp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 409.1130654305136,
			"y": 4409.116517904254,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 134.4490896116468,
			"height": 0.698817710408548,
			"seed": 608221226,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "cD3r4g9O"
				}
			],
			"updated": 1690248912015,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "4AQ_d_kVbUWEWP_oktEJk",
				"gap": 1,
				"focus": 0.129498527266759
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					134.4490896116468,
					-0.698817710408548
				]
			]
		},
		{
			"type": "text",
			"version": 375,
			"versionNonce": 1717652809,
			"isDeleted": false,
			"id": "cD3r4g9O",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 555.71512551596,
			"y": 4439.074874343326,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 57.47212219238281,
			"height": 20,
			"seed": 1615513834,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "present",
			"rawText": "present",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "mt66qu0hBVB53mMu6gRRp",
			"originalText": "present",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 1368,
			"versionNonce": 391839511,
			"isDeleted": false,
			"id": "nPXhIT8ghuRbtiykwyW_R",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 291.5350707753784,
			"y": 4409.1136246570595,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 70.51226619394276,
			"height": 0.7923209773525741,
			"seed": 349694122,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "MVGRMFVn"
				}
			],
			"updated": 1690248912013,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "zkSClAb3i4W-cD8Du3o8T",
				"gap": 2.8859401702031136,
				"focus": -0.021009175746987546
			},
			"endBinding": {
				"elementId": "OTFfFmy5LuDi1CiZQjKMP",
				"gap": 1.2741072801300675,
				"focus": 0.14830231681345335
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					70.51226619394276,
					-0.7923209773525741
				]
			]
		},
		{
			"type": "text",
			"version": 373,
			"versionNonce": 557497385,
			"isDeleted": false,
			"id": "MVGRMFVn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 374.2253710327434,
			"y": 4439.074874343326,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 48.57611083984375,
			"height": 20,
			"seed": 532014506,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "submit",
			"rawText": "submit",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "nPXhIT8ghuRbtiykwyW_R",
			"originalText": "submit",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 394,
			"versionNonce": 838678247,
			"isDeleted": false,
			"id": "sNWadTjl",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 226.003320014644,
			"y": 4468.030088168491,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 10.608993530273438,
			"height": 16.142001299736243,
			"seed": 921934838,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.913601039788995,
			"fontFamily": 1,
			"text": "...",
			"rawText": "...",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "...",
			"lineHeight": 1.25,
			"baseline": 11
		},
		{
			"type": "text",
			"version": 394,
			"versionNonce": 1623412489,
			"isDeleted": false,
			"id": "3Xn4KC4e",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 393.19047887261183,
			"y": 4472.80686413586,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 10.608993530273438,
			"height": 16.142001299736243,
			"seed": 1209751478,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.913601039788995,
			"fontFamily": 1,
			"text": "...",
			"rawText": "...",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "...",
			"lineHeight": 1.25,
			"baseline": 11
		},
		{
			"type": "text",
			"version": 394,
			"versionNonce": 2065940999,
			"isDeleted": false,
			"id": "doVsCNVh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 534.1053699100419,
			"y": 4472.80686413586,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 10.608993530273438,
			"height": 16.142001299736243,
			"seed": 1642572662,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.913601039788995,
			"fontFamily": 1,
			"text": "...",
			"rawText": "...",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "...",
			"lineHeight": 1.25,
			"baseline": 11
		},
		{
			"type": "rectangle",
			"version": 502,
			"versionNonce": 192316905,
			"isDeleted": false,
			"id": "tuYYHMIwL0rCKAWSCEHVl",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 490.14768843676757,
			"y": 4586.139488805934,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 48,
			"height": 26,
			"seed": 777191427,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "akCLXITe",
					"type": "text"
				},
				{
					"id": "HmnQthZAACmeRNvy7rRNy",
					"type": "arrow"
				},
				{
					"id": "WmegkIDlfYAgKAQGydd3n",
					"type": "arrow"
				},
				{
					"id": "Lsea2cBaVguQ6TJ6p1I7T",
					"type": "arrow"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 719,
			"versionNonce": 1904994599,
			"isDeleted": false,
			"id": "akCLXITe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 495.5283799650879,
			"y": 4591.462161492827,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 37.238616943359375,
			"height": 15.354654626213032,
			"seed": 1450414371,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.283723700970425,
			"fontFamily": 1,
			"text": "submit",
			"rawText": "submit",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "tuYYHMIwL0rCKAWSCEHVl",
			"originalText": "submit",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "rectangle",
			"version": 400,
			"versionNonce": 744480969,
			"isDeleted": false,
			"id": "7h2dmONKSPiWd-buipLYz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 198.5998027657114,
			"y": 4586.139488805934,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 84,
			"height": 26,
			"seed": 391571917,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "7lAGucfDKWquQekel-snM",
					"type": "arrow"
				},
				{
					"id": "3sxvoJ0A",
					"type": "text"
				},
				{
					"id": "HmnQthZAACmeRNvy7rRNy",
					"type": "arrow"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 460,
			"versionNonce": 849488967,
			"isDeleted": false,
			"id": "3sxvoJ0A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 204.2556407784067,
			"y": 4591.275907441026,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 72.68832397460938,
			"height": 15.727162729815413,
			"seed": 2082122179,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.581730183852331,
			"fontFamily": 1,
			"text": "record cmds",
			"rawText": "record cmds",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "7h2dmONKSPiWd-buipLYz",
			"originalText": "record cmds",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "arrow",
			"version": 868,
			"versionNonce": 1903242585,
			"isDeleted": false,
			"id": "7lAGucfDKWquQekel-snM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 26.30103325313246,
			"y": 4599.5700992675565,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 168.32644105211392,
			"height": 2.6906930828981785,
			"seed": 964382381,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "1xrR9tWe"
				}
			],
			"updated": 1690248912020,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "7h2dmONKSPiWd-buipLYz",
				"gap": 3.9723284604650217,
				"focus": 0.2190672319275769
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					168.32644105211392,
					-2.6906930828981785
				]
			]
		},
		{
			"type": "text",
			"version": 346,
			"versionNonce": 2051214183,
			"isDeleted": false,
			"id": "1xrR9tWe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 121.41940483740623,
			"y": 4672.586709255828,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 142.80030822753906,
			"height": 20,
			"seed": 1613441933,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "wait render_fence",
			"rawText": "wait render_fence",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "7lAGucfDKWquQekel-snM",
			"originalText": "wait render_fence",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 1482,
			"versionNonce": 762583609,
			"isDeleted": false,
			"id": "HmnQthZAACmeRNvy7rRNy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 283.6126203497145,
			"y": 4599.3463047662135,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 203.287966234468,
			"height": 1.4666237394721975,
			"seed": 13513549,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "fjrYiMdP"
				}
			],
			"updated": 1690248912021,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "7h2dmONKSPiWd-buipLYz",
				"gap": 1.0128175840031162,
				"focus": -0.007780238335980573
			},
			"endBinding": {
				"elementId": "tuYYHMIwL0rCKAWSCEHVl",
				"gap": 3.2471018525850184,
				"focus": -0.1419565189378537
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					203.287966234468,
					1.4666237394721975
				]
			]
		},
		{
			"type": "text",
			"version": 385,
			"versionNonce": 1421543047,
			"isDeleted": false,
			"id": "fjrYiMdP",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 315.5178925853518,
			"y": 4671.196291247382,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 190.17642211914062,
			"height": 20,
			"seed": 1703460045,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "wait present_semaphore",
			"rawText": "wait present_semaphore",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "HmnQthZAACmeRNvy7rRNy",
			"originalText": "wait present_semaphore",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 440,
			"versionNonce": 759417193,
			"isDeleted": false,
			"id": "DcbIUkWXocq2entYmOVNT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 757.0877003237736,
			"y": 4584.815379319113,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 55,
			"height": 26,
			"seed": 810207341,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "hIiHdg2e",
					"type": "text"
				},
				{
					"id": "WmegkIDlfYAgKAQGydd3n",
					"type": "arrow"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 495,
			"versionNonce": 281451943,
			"isDeleted": false,
			"id": "hIiHdg2e",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 762.3619846865665,
			"y": 4590.0769647640955,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 44.45143127441406,
			"height": 15.476829110035595,
			"seed": 767184323,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.381463288028476,
			"fontFamily": 1,
			"text": "present",
			"rawText": "present",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "DcbIUkWXocq2entYmOVNT",
			"originalText": "present",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "arrow",
			"version": 1466,
			"versionNonce": 1212574489,
			"isDeleted": false,
			"id": "WmegkIDlfYAgKAQGydd3n",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 539.1476884367676,
			"y": 4597.674929822467,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 216.940011887006,
			"height": 1.154858226923352,
			"seed": 274420013,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "eKTjWpVI"
				}
			],
			"updated": 1690248912023,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "tuYYHMIwL0rCKAWSCEHVl",
				"gap": 1,
				"focus": -0.12169964754837108
			},
			"endBinding": {
				"elementId": "DcbIUkWXocq2entYmOVNT",
				"gap": 1,
				"focus": -0.08870308061023723
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					216.940011887006,
					1.154858226923352
				]
			]
		},
		{
			"type": "text",
			"version": 375,
			"versionNonce": 1905414343,
			"isDeleted": false,
			"id": "eKTjWpVI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 645.9883587675415,
			"y": 4674.2272858636925,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 180.54440307617188,
			"height": 20,
			"seed": 318728419,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "wait render_semaphore",
			"rawText": "wait render_semaphore",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "WmegkIDlfYAgKAQGydd3n",
			"originalText": "wait render_semaphore",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 544,
			"versionNonce": 1678590761,
			"isDeleted": false,
			"id": "-fxIZW7kt5GqYdJkG68Xi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 516.2215433771482,
			"y": 4586.202660670401,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 147.63820778061566,
			"height": 72.163967031781,
			"seed": 1669952067,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "WTBpdmfn"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					13.90314961162746,
					-60.90903639379614
				],
				[
					131.74889393875566,
					-65.5434195976724
				],
				[
					147.63820778061566,
					6.6205474341086115
				]
			]
		},
		{
			"type": "text",
			"version": 394,
			"versionNonce": 549101543,
			"isDeleted": false,
			"id": "WTBpdmfn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 622.5063633444411,
			"y": 4568.818657356479,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 190.14442443847656,
			"height": 20,
			"seed": 1169668803,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "signal render_semaphore",
			"rawText": "signal render_semaphore",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "-fxIZW7kt5GqYdJkG68Xi",
			"originalText": "signal render_semaphore",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 688,
			"versionNonce": 1437398537,
			"isDeleted": false,
			"id": "Fq3-WfdGvYkg8ylL18Rtc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 783.0296049717135,
			"y": 4606.359509931976,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 406.50161245425085,
			"height": 78.80673370877092,
			"seed": 994633357,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "6mBBIv3t"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-43.69561306511492,
					77.18741726270041
				],
				[
					-363.46805413254674,
					75.56810081662988
				],
				[
					-406.50161245425085,
					-1.619316446070525
				]
			]
		},
		{
			"type": "text",
			"version": 428,
			"versionNonce": 1615596295,
			"isDeleted": false,
			"id": "6mBBIv3t",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 608.3272192463885,
			"y": 4790.007850461098,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 149.9102783203125,
			"height": 15.413487708645562,
			"seed": 1459135117,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.330790166916449,
			"fontFamily": 1,
			"text": "signal present semaphore",
			"rawText": "signal present semaphore",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Fq3-WfdGvYkg8ylL18Rtc",
			"originalText": "signal present semaphore",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "arrow",
			"version": 1089,
			"versionNonce": 572734359,
			"isDeleted": false,
			"id": "Lsea2cBaVguQ6TJ6p1I7T",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 506.96094327722153,
			"y": 4584.878551183582,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 406.5097787620758,
			"height": 71.50191228836984,
			"seed": 1187903789,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "3H0iOVcC"
				}
			],
			"updated": 1690248912018,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "tuYYHMIwL0rCKAWSCEHVl",
				"gap": 1.2609376223517756,
				"focus": 0.05262219879052306
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-37.0832319388316,
					-59.584926906975745
				],
				[
					-366.12443941401506,
					-54.288488959689076
				],
				[
					-406.5097787620758,
					11.91698538139409
				]
			]
		},
		{
			"type": "text",
			"version": 429,
			"versionNonce": 2093158951,
			"isDeleted": false,
			"id": "3H0iOVcC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 289.3768892238389,
			"y": 4576.663210483725,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 117.42562866210938,
			"height": 15.413487708645556,
			"seed": 634651213,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.330790166916445,
			"fontFamily": 1,
			"text": "signal render_fence",
			"rawText": "signal render_fence",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Lsea2cBaVguQ6TJ6p1I7T",
			"originalText": "signal render_fence",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "arrow",
			"version": 1076,
			"versionNonce": 843424569,
			"isDeleted": false,
			"id": "UMZsKtkil3IrgHiWRzhvz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 407.0766088297434,
			"y": 4331.27435268931,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 138.5006994955889,
			"height": 38.36194334990625,
			"seed": 708913773,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "bFbaoBsv"
				}
			],
			"updated": 1690248912009,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "l3wsJ-a9ajQKgRvBMUNs3",
				"gap": 3.27854041148197,
				"focus": 0.35016385313248
			},
			"endBinding": {
				"elementId": "TB2aliYDyt6VAkQ9W-1wU",
				"gap": 2.366837296059316,
				"focus": -0.19054597485174035
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					70.08370468616572,
					-38.36194334990625
				],
				[
					138.5006994955889,
					-1.4864454355420094
				]
			]
		},
		{
			"type": "text",
			"version": 289,
			"versionNonce": 2131506503,
			"isDeleted": false,
			"id": "bFbaoBsv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 525.1732352347068,
			"y": 4295.097549094629,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 119.48826599121094,
			"height": 20,
			"seed": 1623482115,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "wait semaphore",
			"rawText": "wait semaphore",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "UMZsKtkil3IrgHiWRzhvz",
			"originalText": "wait semaphore",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 1084,
			"versionNonce": 254918329,
			"isDeleted": false,
			"id": "vC4PA04c0A-Yz9lfBSjU-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 411.7109920336192,
			"y": 4411.456033605459,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 131.85116300854116,
			"height": 39.68745940913182,
			"seed": 1182813197,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "ZylNQp2B"
				}
			],
			"updated": 1690248912015,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "OTFfFmy5LuDi1CiZQjKMP",
				"gap": 1.3895477841679735,
				"focus": -0.5351022932199443
			},
			"endBinding": {
				"elementId": "4AQ_d_kVbUWEWP_oktEJk",
				"gap": 1,
				"focus": 0.34290907562456835
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					58.1667193047708,
					39.68745940913182
				],
				[
					131.85116300854116,
					1.1489590158153078
				]
			]
		},
		{
			"type": "text",
			"version": 295,
			"versionNonce": 511964263,
			"isDeleted": false,
			"id": "ZylNQp2B",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 516.1500638914631,
			"y": 4491.146453734196,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 119.48826599121094,
			"height": 20,
			"seed": 1351819843,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "wait semaphore",
			"rawText": "wait semaphore",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "vC4PA04c0A-Yz9lfBSjU-",
			"originalText": "wait semaphore",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 373,
			"versionNonce": 1932601737,
			"isDeleted": false,
			"id": "UvnRMjRI739daXtcTImMJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -746.685399267677,
			"y": 5011.152355172601,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 137,
			"height": 30,
			"seed": 213327627,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "8hKZ5dqo",
					"type": "text"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 393,
			"versionNonce": 1928777607,
			"isDeleted": false,
			"id": "8hKZ5dqo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -731.7775013184582,
			"y": 5016.152355172601,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 107.1842041015625,
			"height": 20,
			"seed": 323960683,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Command Pool",
			"rawText": "Command Pool",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "UvnRMjRI739daXtcTImMJ",
			"originalText": "Command Pool",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 592,
			"versionNonce": 2017792105,
			"isDeleted": false,
			"id": "Fu_9EAGqK9jbuXJOgPsuO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -150.76918026001692,
			"y": 5295.898602550832,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 591.7975760161737,
			"height": 263.0211448960772,
			"seed": 1240279429,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "041f50e40e110dde44f4b4b001dfe5495408a4b5",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 404,
			"versionNonce": 1721845415,
			"isDeleted": false,
			"id": "TsNV1pQm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -574.0546953804067,
			"y": 5424.021709834536,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 56.144134521484375,
			"height": 20,
			"seed": 1784097317,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Primary",
			"rawText": "Primary",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Primary",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 407,
			"versionNonce": 1140398921,
			"isDeleted": false,
			"id": "UyH4KKEH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -574.0546953804067,
			"y": 5469.611883612991,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 77.00816345214844,
			"height": 20,
			"seed": 1745169355,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Secondary",
			"rawText": "Secondary",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Secondary",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 867,
			"versionNonce": 1747966407,
			"isDeleted": false,
			"id": "c5GmHdcb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1083.4222476392658,
			"y": 5050.153114327127,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 515.1524658203125,
			"height": 200,
			"seed": 350465355,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "command buffer所需内存需要在command pool中申请, \n非线程安全, 多线程操作时需要加锁(每个线程设置一个专属\n的command pool更好). 在某些情况下, 可以设置F*T个\ncommand pool. F是frame count, T是CPU核心数量.\n\n但是当draw call比较少时(比如<100), 就没有必要拆分\n到多个线程中进行并行. command buffer的内容应该足\n够多, 以保证GPU在执行时不空闲.\n\n一般而言, 每帧提交次数限制在<10, 每帧的command buffers数量 <100.",
			"rawText": "command buffer所需内存需要在command pool中申请, \n非线程安全, 多线程操作时需要加锁(每个线程设置一个专属\n的command pool更好). 在某些情况下, 可以设置F*T个\ncommand pool. F是frame count, T是CPU核心数量.\n\n但是当draw call比较少时(比如<100), 就没有必要拆分\n到多个线程中进行并行. command buffer的内容应该足\n够多, 以保证GPU在执行时不空闲.\n\n一般而言, 每帧提交次数限制在<10, 每帧的command buffers数量 <100.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "command buffer所需内存需要在command pool中申请, \n非线程安全, 多线程操作时需要加锁(每个线程设置一个专属\n的command pool更好). 在某些情况下, 可以设置F*T个\ncommand pool. F是frame count, T是CPU核心数量.\n\n但是当draw call比较少时(比如<100), 就没有必要拆分\n到多个线程中进行并行. command buffer的内容应该足\n够多, 以保证GPU在执行时不空闲.\n\n一般而言, 每帧提交次数限制在<10, 每帧的command buffers数量 <100.",
			"lineHeight": 1.25,
			"baseline": 194
		},
		{
			"type": "text",
			"version": 883,
			"versionNonce": 1453902377,
			"isDeleted": false,
			"id": "cxCokbfi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -462.7553647389266,
			"y": 4870.096046512396,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 600.4459838867188,
			"height": 96.3393991745981,
			"seed": 327354469,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 12.845253223279748,
			"fontFamily": 1,
			"text": "- VK_COMMAND_POOL_CREATE_TRANSIENT_BIT\n    支持动态command buffer(每帧都录制一个新的command buffer, 用完后free)\n- VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT\n    支持生命周期较长的command buffer, 录制一次重复使用, 且可以不释放, 从新录制内容.\n    该标志将强制为池中的每个命令缓冲区使用单独的内部分配器, 与单个池重置相比, 这会增加CPU开销.\n    若该标志不设置, 则command buffer free时, command pool不会回收其内存",
			"rawText": "- VK_COMMAND_POOL_CREATE_TRANSIENT_BIT\n    支持动态command buffer(每帧都录制一个新的command buffer, 用完后free)\n- VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT\n    支持生命周期较长的command buffer, 录制一次重复使用, 且可以不释放, 从新录制内容.\n    该标志将强制为池中的每个命令缓冲区使用单独的内部分配器, 与单个池重置相比, 这会增加CPU开销.\n    若该标志不设置, 则command buffer free时, command pool不会回收其内存",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "- VK_COMMAND_POOL_CREATE_TRANSIENT_BIT\n    支持动态command buffer(每帧都录制一个新的command buffer, 用完后free)\n- VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT\n    支持生命周期较长的command buffer, 录制一次重复使用, 且可以不释放, 从新录制内容.\n    该标志将强制为池中的每个命令缓冲区使用单独的内部分配器, 与单个池重置相比, 这会增加CPU开销.\n    若该标志不设置, 则command buffer free时, command pool不会回收其内存",
			"lineHeight": 1.25,
			"baseline": 91
		},
		{
			"type": "text",
			"version": 478,
			"versionNonce": 1556023527,
			"isDeleted": false,
			"id": "ZAyYD5Xg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -465.3315160379958,
			"y": 4973.806805977206,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132.65626525878906,
			"height": 20,
			"seed": 1011678795,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "queueFamilyIndex",
			"rawText": "queueFamilyIndex",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "queueFamilyIndex",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 299,
			"versionNonce": 423599369,
			"isDeleted": false,
			"id": "J7Daqu5x",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -467.76900732164927,
			"y": 4850.102436671586,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 285.8246154785156,
			"height": 20,
			"seed": 1398109995,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "flags: VkCommandPoolCreateFlagBits",
			"rawText": "flags: VkCommandPoolCreateFlagBits",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "flags: VkCommandPoolCreateFlagBits",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 278,
			"versionNonce": 1373328391,
			"isDeleted": false,
			"id": "79O2u_Li3i1nYUSD_NhJT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -571.9096813103944,
			"y": 4915.417517174704,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 63,
			"height": 30,
			"seed": 249171691,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "2ocLk6vr",
					"type": "text"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 286,
			"versionNonce": 1262031849,
			"isDeleted": false,
			"id": "2ocLk6vr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -566.4737377068788,
			"y": 4920.417517174704,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 52.12811279296875,
			"height": 20,
			"seed": 4573285,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "create",
			"rawText": "create",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "79O2u_Li3i1nYUSD_NhJT",
			"originalText": "create",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 283,
			"versionNonce": 1870740263,
			"isDeleted": false,
			"id": "Nf2d-E1v7TfvLN7e-Z2JZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -568.4315191634362,
			"y": 5077.387922914183,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 53,
			"height": 30,
			"seed": 1900482277,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "ksyW1Q4i",
					"type": "text"
				}
			],
			"updated": 1689733954227,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 321,
			"versionNonce": 815836873,
			"isDeleted": false,
			"id": "ksyW1Q4i",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -562.9875646956627,
			"y": 5082.387922914183,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 42.112091064453125,
			"height": 20,
			"seed": 547377867,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "reset",
			"rawText": "reset",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Nf2d-E1v7TfvLN7e-Z2JZ",
			"originalText": "reset",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 281,
			"versionNonce": 706559559,
			"isDeleted": false,
			"id": "MbF9nmp7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -465.8043840900715,
			"y": 5068.297408573696,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 253.3285369873047,
			"height": 20,
			"seed": 1135210059,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "flags: VkCommandPoolResetFlags",
			"rawText": "flags: VkCommandPoolResetFlags",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "flags: VkCommandPoolResetFlags",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 404,
			"versionNonce": 1174953,
			"isDeleted": false,
			"id": "OJRlr9AS",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -454.73060440142785,
			"y": 5094.0661140445,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 365.287109375,
			"height": 28.84627899721783,
			"seed": 1669210213,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 11.538511598887132,
			"fontFamily": 1,
			"text": "- VK_COMMAND_POOL_RESET_RELEASE_RESOURCES_BIT\n    是否需要将内存页交还给系统, 否则内存仍保存在pool的free list中",
			"rawText": "- VK_COMMAND_POOL_RESET_RELEASE_RESOURCES_BIT\n    是否需要将内存页交还给系统, 否则内存仍保存在pool的free list中",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "- VK_COMMAND_POOL_RESET_RELEASE_RESOURCES_BIT\n    是否需要将内存页交还给系统, 否则内存仍保存在pool的free list中",
			"lineHeight": 1.25,
			"baseline": 24
		},
		{
			"type": "text",
			"version": 294,
			"versionNonce": 1006720615,
			"isDeleted": false,
			"id": "TsRfTJHI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1113.2231477294454,
			"y": 92.98711948396988,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 193.1875,
			"height": 60.38445432518449,
			"seed": 808754219,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689734005541,
			"link": null,
			"locked": false,
			"fontSize": 48.30756346014759,
			"fontFamily": 1,
			"text": "重要参考",
			"rawText": "重要参考",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "重要参考",
			"lineHeight": 1.25,
			"baseline": 42
		},
		{
			"type": "text",
			"version": 427,
			"versionNonce": 280514697,
			"isDeleted": false,
			"id": "WYhKRuk3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -604.7924965431665,
			"y": 5134.294600552989,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 655.61669921875,
			"height": 40,
			"seed": 1314715717,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954227,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "将所有由该command pool创建的command buffer设置为initial state, 并回收所有内存资源.\n对于secondary command buffer状态变为invalid.",
			"rawText": "将所有由该command pool创建的command buffer设置为initial state, 并回收所有内存资源.\n对于secondary command buffer状态变为invalid.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "将所有由该command pool创建的command buffer设置为initial state, 并回收所有内存资源.\n对于secondary command buffer状态变为invalid.",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "freedraw",
			"version": 199,
			"versionNonce": 840538247,
			"isDeleted": false,
			"id": "2BK6d-exocWMSGVkxkI5B",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -367.4186513700288,
			"y": 2526.2065769767237,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 44.52177348923334,
			"height": 6.360253355604982,
			"seed": 273088139,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.7950316694506228,
					0
				],
				[
					3.975158347253,
					0
				],
				[
					7.950316694505943,
					0
				],
				[
					9.540380033407132,
					0
				],
				[
					13.515538380660132,
					-0.7950316694507364
				],
				[
					15.900633389011887,
					-1.5900633389012455
				],
				[
					16.69566505846251,
					-1.5900633389012455
				],
				[
					19.080760066814264,
					-2.385095008351982
				],
				[
					22.26088674461664,
					-3.180126677802491
				],
				[
					26.23604509186964,
					-3.975158347253
				],
				[
					28.621140100221453,
					-3.975158347253
				],
				[
					29.41617176967202,
					-3.975158347253
				],
				[
					29.41617176967202,
					-4.770190016703509
				],
				[
					30.21120343912264,
					-4.770190016703509
				],
				[
					32.596298447474396,
					-4.770190016703509
				],
				[
					34.186361786375585,
					-4.770190016703509
				],
				[
					34.98139345582621,
					-5.565221686154246
				],
				[
					36.571456794727396,
					-4.770190016703509
				],
				[
					37.36648846417796,
					-5.565221686154246
				],
				[
					38.161520133628585,
					-5.565221686154246
				],
				[
					39.751583472529774,
					-5.565221686154246
				],
				[
					40.54661514198034,
					-5.565221686154246
				],
				[
					41.34164681143096,
					-5.565221686154246
				],
				[
					42.13667848088153,
					-6.360253355604982
				],
				[
					42.93171015033215,
					-6.360253355604982
				],
				[
					43.72674181978272,
					-6.360253355604982
				],
				[
					44.52177348923334,
					-6.360253355604982
				],
				[
					44.52177348923334,
					-6.360253355604982
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 191,
			"versionNonce": 1213159273,
			"isDeleted": false,
			"id": "fQRr1J1FJrE2LY1hE8Mra",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -330.8471945753014,
			"y": 2514.281101934965,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 11.925475041758887,
			"height": 12.72050671120951,
			"seed": 1685323243,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.5900633389011887,
					0
				],
				[
					3.9751583472529433,
					0
				],
				[
					5.565221686154132,
					0.7950316694505091
				],
				[
					8.74534836395651,
					1.5900633389010181
				],
				[
					10.335411702857698,
					1.5900633389010181
				],
				[
					10.335411702857698,
					2.3850950083517546
				],
				[
					9.540380033407132,
					2.3850950083517546
				],
				[
					11.13044337230832,
					3.180126677802491
				],
				[
					11.925475041758887,
					3.975158347253
				],
				[
					11.13044337230832,
					3.975158347253
				],
				[
					10.335411702857698,
					4.770190016703509
				],
				[
					8.74534836395651,
					6.360253355604755
				],
				[
					7.950316694505943,
					7.155285025055491
				],
				[
					7.155285025055321,
					8.74534836395651
				],
				[
					5.565221686154132,
					10.335411702857755
				],
				[
					4.770190016703566,
					11.130443372308264
				],
				[
					4.770190016703566,
					11.925475041759
				],
				[
					3.9751583472529433,
					11.925475041759
				],
				[
					3.9751583472529433,
					12.72050671120951
				],
				[
					3.9751583472529433,
					12.72050671120951
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 386,
			"versionNonce": 679669671,
			"isDeleted": false,
			"id": "ZOzWSc13",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -54.97120527594507,
			"y": 2546.0823687129887,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 947.56982421875,
			"height": 60,
			"seed": 124400389,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "SRV: wrap textures in a format that the shaders can access them. (Read Only)\nURV: provides similar functionality, but enables the reading and writing to the texture (or other resource) in any order.\nURV访问比SRV要稍微慢一点",
			"rawText": "SRV: wrap textures in a format that the shaders can access them. (Read Only)\nURV: provides similar functionality, but enables the reading and writing to the texture (or other resource) in any order.\nURV访问比SRV要稍微慢一点",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "SRV: wrap textures in a format that the shaders can access them. (Read Only)\nURV: provides similar functionality, but enables the reading and writing to the texture (or other resource) in any order.\nURV访问比SRV要稍微慢一点",
			"lineHeight": 1.25,
			"baseline": 54
		},
		{
			"type": "text",
			"version": 309,
			"versionNonce": 1226998345,
			"isDeleted": false,
			"id": "JCYP4D4Y",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -236.9552276967429,
			"y": -74.54942303539917,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 956.33642578125,
			"height": 140,
			"seed": 585633719,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "PresentMode:\n- IMMEDIATE  立即显示, 不进行垂直同步, 明显撕裂\n- FIFO  队列排序, 垂直同步, 无撕裂\n- FIFO RELAXED 当图像的显示时长超过一个vsync周期时，下一个图像不会再等待下一次vsync的到来，而是立刻显示. 此时会有撕裂\n- MAILBOX 只使用单个元素的队列, 当有新的图像被生成时, 等待队列的图像将被替换. 进行vsync \n- SHARED_DEMAND_REFRESH 单Image队列, 只有收到present信号时才立即更新图像, 不进行vsync\n- SHARED_CONTINUOUS_REFRESH 固定刷新率刷新, 当更新时间不对时也会撕裂",
			"rawText": "PresentMode:\n- IMMEDIATE  立即显示, 不进行垂直同步, 明显撕裂\n- FIFO  队列排序, 垂直同步, 无撕裂\n- FIFO RELAXED 当图像的显示时长超过一个vsync周期时，下一个图像不会再等待下一次vsync的到来，而是立刻显示. 此时会有撕裂\n- MAILBOX 只使用单个元素的队列, 当有新的图像被生成时, 等待队列的图像将被替换. 进行vsync \n- SHARED_DEMAND_REFRESH 单Image队列, 只有收到present信号时才立即更新图像, 不进行vsync\n- SHARED_CONTINUOUS_REFRESH 固定刷新率刷新, 当更新时间不对时也会撕裂",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "PresentMode:\n- IMMEDIATE  立即显示, 不进行垂直同步, 明显撕裂\n- FIFO  队列排序, 垂直同步, 无撕裂\n- FIFO RELAXED 当图像的显示时长超过一个vsync周期时，下一个图像不会再等待下一次vsync的到来，而是立刻显示. 此时会有撕裂\n- MAILBOX 只使用单个元素的队列, 当有新的图像被生成时, 等待队列的图像将被替换. 进行vsync \n- SHARED_DEMAND_REFRESH 单Image队列, 只有收到present信号时才立即更新图像, 不进行vsync\n- SHARED_CONTINUOUS_REFRESH 固定刷新率刷新, 当更新时间不对时也会撕裂",
			"lineHeight": 1.25,
			"baseline": 134
		},
		{
			"type": "image",
			"version": 472,
			"versionNonce": 838099655,
			"isDeleted": false,
			"id": "lKhwmYwdHE62WX5mC-CnQ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1984.0327100265308,
			"y": -692.353950622544,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 838.5714285714287,
			"height": 472.39523809523814,
			"seed": 117813369,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "1b5769f209c6001345226c94f4037e3f53b34e65",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 301,
			"versionNonce": 1611485481,
			"isDeleted": false,
			"id": "J6k7Hk6q0-cVBLLaTSS48",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 859.7537750195811,
			"y": 4146.448699509741,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 758.8657115119134,
			"height": 424.33241035374493,
			"seed": 1004878937,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "ee9f8bd697f18baf6b0d7281c956ab00f1a9ebd9",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 319,
			"versionNonce": 1862955495,
			"isDeleted": false,
			"id": "IZ9Ny9QUjcsQdTzJ8cESx",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 383.4366575608626,
			"y": 5056.715470198681,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 150,
			"height": 30,
			"seed": 1080035767,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "YxAiwNX1",
					"type": "text"
				}
			],
			"updated": 1689733954228,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 344,
			"versionNonce": 846939145,
			"isDeleted": false,
			"id": "YxAiwNX1",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 388.5965162644759,
			"y": 5061.715470198681,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 139.68028259277344,
			"height": 20,
			"seed": 1900264151,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Allocate and free",
			"rawText": "Allocate and free",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "IZ9Ny9QUjcsQdTzJ8cESx",
			"originalText": "Allocate and free",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 300,
			"versionNonce": 953261319,
			"isDeleted": false,
			"id": "WTSCddfK61DLMpXPyH7g3",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 381.7935602813204,
			"y": 5127.916352312158,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 299,
			"height": 30,
			"seed": 1758742519,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "T61wmSnt",
					"type": "text"
				}
			],
			"updated": 1689733954228,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 356,
			"versionNonce": 745003753,
			"isDeleted": false,
			"id": "T61wmSnt",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 387.22925974421105,
			"y": 5132.916352312158,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 288.12860107421875,
			"height": 20,
			"seed": 1964388631,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Resetting individual command buffers",
			"rawText": "Resetting individual command buffers",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "WTSCddfK61DLMpXPyH7g3",
			"originalText": "Resetting individual command buffers",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 300,
			"versionNonce": 314991655,
			"isDeleted": false,
			"id": "IUXNwewel-2_x5u93fQLb",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 385.6274539335848,
			"y": 5192.544845307469,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 229,
			"height": 30,
			"seed": 796784183,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "GMJMKp5Q",
					"type": "text"
				}
			],
			"updated": 1689733954228,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 348,
			"versionNonce": 777950665,
			"isDeleted": false,
			"id": "GMJMKp5Q",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 391.1112262114168,
			"y": 5197.544845307469,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 218.03245544433594,
			"height": 20,
			"seed": 250615639,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Resetting the command pool",
			"rawText": "Resetting the command pool",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "IUXNwewel-2_x5u93fQLb",
			"originalText": "Resetting the command pool",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 228,
			"versionNonce": 1557481287,
			"isDeleted": false,
			"id": "26qk2Xj9",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 202.40025482637122,
			"y": 5134.42701636786,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 116.56362915039062,
			"height": 20,
			"seed": 1694703193,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": "https://arm-software.github.io/vulkan_best_practice_for_mobile_developers/samples/performance/command_buffer_usage/command_buffer_usage_tutorial.html#allocate-and-free",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[三种模式]]",
			"rawText": "[三种模式](https://arm-software.github.io/vulkan_best_practice_for_mobile_developers/samples/performance/command_buffer_usage/command_buffer_usage_tutorial.html#allocate-and-free)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[三种模式]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 178,
			"versionNonce": 2071655593,
			"isDeleted": false,
			"id": "yruG32VW",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 550.7368780892313,
			"y": 5061.583036974841,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 236.11203002929688,
			"height": 20,
			"seed": 2073161847,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "性能最差, 频繁的申请和释放内存",
			"rawText": "性能最差, 频繁的申请和释放内存",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "性能最差, 频繁的申请和释放内存",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 209,
			"versionNonce": 1163576935,
			"isDeleted": false,
			"id": "Rdz0ScbZ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 704.6403232729791,
			"y": 5139.904007299666,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 471.02435302734375,
			"height": 20,
			"seed": 33981079,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "重用已经申请的内存, 但频繁地reset command buffer开销也不小",
			"rawText": "重用已经申请的内存, 但频繁地reset command buffer开销也不小",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "重用已经申请的内存, 但频繁地reset command buffer开销也不小",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 70,
			"versionNonce": 1734899593,
			"isDeleted": false,
			"id": "HpS2foPy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1130.206842728712,
			"y": 30.262420236320395,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 213.5079803466797,
			"height": 20,
			"seed": 1815074967,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": "https://github.com/ARM-software/vulkan_best_practice_for_mobile_developers",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[vulkan best practics]]",
			"rawText": "[vulkan best practics](https://github.com/ARM-software/vulkan_best_practice_for_mobile_developers)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[vulkan best practics]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 252,
			"versionNonce": 2065916295,
			"isDeleted": false,
			"id": "Miixsq10",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 642.9709450665596,
			"y": 5198.621151345681,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 472.5390625,
			"height": 18.120811684446853,
			"seed": 1424081305,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 14.496649347557483,
			"fontFamily": 1,
			"text": "reset command pool, 会自动reset该pool中的command buffers, 效率高",
			"rawText": "reset command pool, 会自动reset该pool中的command buffers, 效率高",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "reset command pool, 会自动reset该pool中的command buffers, 效率高",
			"lineHeight": 1.25,
			"baseline": 13
		},
		{
			"type": "image",
			"version": 590,
			"versionNonce": 1147313769,
			"isDeleted": false,
			"id": "RjQB2kJnU1fpPAp6svAfS",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 592.6035135455259,
			"y": 5233.3897857114325,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 549.0282544176604,
			"height": 112.7733711776816,
			"seed": 693096121,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "fe09dfd03c933ac20bbf132e3b47ce866a0086b1",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 327,
			"versionNonce": 527145127,
			"isDeleted": false,
			"id": "TabObctS",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 409.73728705318626,
			"y": 5228.400033672525,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 149.5870819091797,
			"height": 13.446199990016751,
			"seed": 212496281,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 10.756959992013401,
			"fontFamily": 1,
			"text": "CREATE_TRANSIENT_BIT",
			"rawText": "CREATE_TRANSIENT_BIT",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "CREATE_TRANSIENT_BIT",
			"lineHeight": 1.25,
			"baseline": 9
		},
		{
			"type": "text",
			"version": 237,
			"versionNonce": 288680265,
			"isDeleted": false,
			"id": "J39Se4ne",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 414.9485053757477,
			"y": 5163.25980464051,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 227.25099182128906,
			"height": 13.000813751138658,
			"seed": 920061303,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 10.400651000910926,
			"fontFamily": 1,
			"text": "CREATE_RESET_COMMAND_BUFFER_BIT",
			"rawText": "CREATE_RESET_COMMAND_BUFFER_BIT",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "CREATE_RESET_COMMAND_BUFFER_BIT",
			"lineHeight": 1.25,
			"baseline": 9
		},
		{
			"type": "text",
			"version": 292,
			"versionNonce": 2011163591,
			"isDeleted": false,
			"id": "dE8N1Ibn",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 413.25313081184754,
			"y": 5091.619168732924,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 227.25099182128906,
			"height": 13.000813751138658,
			"seed": 1354180377,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 10.400651000910926,
			"fontFamily": 1,
			"text": "CREATE_RESET_COMMAND_BUFFER_BIT",
			"rawText": "CREATE_RESET_COMMAND_BUFFER_BIT",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "CREATE_RESET_COMMAND_BUFFER_BIT",
			"lineHeight": 1.25,
			"baseline": 9
		},
		{
			"type": "image",
			"version": 259,
			"versionNonce": 1731909673,
			"isDeleted": false,
			"id": "Ahr8aMbHmZnMQk1ZLoHDz",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1183.7351563044485,
			"y": 351.99218605372863,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 695.6483516483513,
			"height": 546.6666666666663,
			"seed": 772167943,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "ca47793fb1bfbaee29be188171f2dfd23d92cea5",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 641,
			"versionNonce": 1620892391,
			"isDeleted": false,
			"id": "Xl_bfk7Tz8jSaOFC4_Yd_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -142.91061833375034,
			"y": 1216.3816657800112,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 637.6958648296101,
			"height": 344.09006039764375,
			"seed": 1212555879,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "6d92fc749ee251bac9b4932443a94606beb9433b",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 246,
			"versionNonce": 677374729,
			"isDeleted": false,
			"id": "tS9AX1G7iYKSMMrFTZF0d",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -712.8957423138907,
			"y": 1481.5814847542065,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 148,
			"height": 56,
			"seed": 1670505129,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "DTUh4UyG",
					"type": "text"
				}
			],
			"updated": 1689733954228,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 265,
			"versionNonce": 2117002759,
			"isDeleted": false,
			"id": "DTUh4UyG",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -693.159864323168,
			"y": 1499.5814847542065,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 108.52824401855469,
			"height": 20,
			"seed": 693196519,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "DescriptorSet",
			"rawText": "DescriptorSet",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "tS9AX1G7iYKSMMrFTZF0d",
			"originalText": "DescriptorSet",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 95,
			"versionNonce": 1830789609,
			"isDeleted": false,
			"id": "6xqucXNAWiX2NxnZJAmu2",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -717.6016246668318,
			"y": 1304.3197519439036,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 192,
			"height": 63,
			"seed": 185340807,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "YTKbUCoS",
					"type": "text"
				}
			],
			"updated": 1689733954228,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 138,
			"versionNonce": 798133543,
			"isDeleted": false,
			"id": "YTKbUCoS",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -703.2417995325544,
			"y": 1325.8197519439036,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 163.2803497314453,
			"height": 20,
			"seed": 21681673,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "DescriptorSetLayout",
			"rawText": "DescriptorSetLayout",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "6xqucXNAWiX2NxnZJAmu2",
			"originalText": "DescriptorSetLayout",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 350,
			"versionNonce": 528470583,
			"isDeleted": false,
			"id": "W0OTPU3Micx4f6cUhpsAF",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -525.9349580001652,
			"y": 1332.9798826628582,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 893.0718954248363,
			"height": 479.737095459712,
			"seed": 900232617,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1690248911957,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "qgh--5WsTvopN_2M3WfLD",
				"gap": 1,
				"focus": -0.7011424586313071
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					893.0718954248363,
					-304.31372549019625
				],
				[
					501.1449992271206,
					-479.737095459712
				]
			]
		},
		{
			"type": "rectangle",
			"version": 215,
			"versionNonce": 1077170247,
			"isDeleted": false,
			"id": "FHO0XmvCKPNrwz4dp-qPc",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -716.4251540785965,
			"y": 1592.7511244929237,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 166,
			"height": 49,
			"seed": 302987689,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "2dUd1N8g",
					"type": "text"
				}
			],
			"updated": 1689733954228,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 265,
			"versionNonce": 1210907561,
			"isDeleted": false,
			"id": "2dUd1N8g",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -690.185270655745,
			"y": 1607.2511244929237,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 113.52023315429688,
			"height": 20,
			"seed": 1571228393,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "DescriptorPool",
			"rawText": "DescriptorPool",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "FHO0XmvCKPNrwz4dp-qPc",
			"originalText": "DescriptorPool",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 70,
			"versionNonce": 1508945767,
			"isDeleted": false,
			"id": "8FF9hbLQ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -786.5660571955895,
			"y": 1379.1750273874145,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 344.22406005859375,
			"height": 40,
			"seed": 162713609,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689733954228,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "记录了某个DescriptorSet的规格信息:\n有哪些绑定点, 每个绑定点上的数据类型, 长度等",
			"rawText": "记录了某个DescriptorSet的规格信息:\n有哪些绑定点, 每个绑定点上的数据类型, 长度等",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "记录了某个DescriptorSet的规格信息:\n有哪些绑定点, 每个绑定点上的数据类型, 长度等",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 578,
			"versionNonce": 1758059817,
			"isDeleted": false,
			"id": "HgQ1GmJu",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -476.18593260907835,
			"y": 1466.6005075915855,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 268.09625244140625,
			"height": 120,
			"seed": 1267863623,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689734257430,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "set-0 用作 engine-global resource,\nset-1 用作 per pass resource,\nset-2 用作 material resource, \nset-3 用作 per-object resource.\n\n在glsl中layout若不设置, set默认为0",
			"rawText": "set-0 用作 engine-global resource,\nset-1 用作 per pass resource,\nset-2 用作 material resource, \nset-3 用作 per-object resource.\n\n在glsl中layout若不设置, set默认为0",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "set-0 用作 engine-global resource,\nset-1 用作 per pass resource,\nset-2 用作 material resource, \nset-3 用作 per-object resource.\n\n在glsl中layout若不设置, set默认为0",
			"lineHeight": 1.25,
			"baseline": 114
		},
		{
			"type": "text",
			"version": 122,
			"versionNonce": 2065068393,
			"isDeleted": false,
			"id": "6NMDmhtO",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -447.18639122055015,
			"y": 1617.4591748452965,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 146.0163116455078,
			"height": 20,
			"seed": 1940988265,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689734271672,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "atomic, push const",
			"rawText": "atomic, push const",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "atomic, push const",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 153,
			"versionNonce": 871834697,
			"isDeleted": false,
			"id": "cja7ABFB",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1128.820949164417,
			"y": 63.014254051394175,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 238.4200439453125,
			"height": 20,
			"seed": 1660056775,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689734003771,
			"link": "https://github.com/KhronosGroup/GLSL/blob/master/extensions/khr/GL_KHR_vulkan_glsl.txt",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[vulkan shading language]]",
			"rawText": "[vulkan shading language](https://github.com/KhronosGroup/GLSL/blob/master/extensions/khr/GL_KHR_vulkan_glsl.txt)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[vulkan shading language]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 146,
			"versionNonce": 858183977,
			"isDeleted": false,
			"id": "H24Gyj0i",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -716.0292085309903,
			"y": 1652.774515149212,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 508.06451416015625,
			"height": 40,
			"seed": 1289200743,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689761534361,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "descriptorpool在创建时, 需要指定最多可以创建多少个descriptor set.\n以及可以创建的每种类型的descriptor的数量限制.",
			"rawText": "descriptorpool在创建时, 需要指定最多可以创建多少个descriptor set.\n以及可以创建的每种类型的descriptor的数量限制.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "descriptorpool在创建时, 需要指定最多可以创建多少个descriptor set.\n以及可以创建的每种类型的descriptor的数量限制.",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 58,
			"versionNonce": 1560365897,
			"isDeleted": false,
			"id": "w7FXOajY",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -303.774002797893,
			"y": 2965.997223915145,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 110.11222839355469,
			"height": 60,
			"seed": 1437007879,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689761724213,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "uniform buffer\n<=64kb PC\n<=16kb mobile",
			"rawText": "uniform buffer\n<=64kb PC\n<=16kb mobile",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "uniform buffer\n<=64kb PC\n<=16kb mobile",
			"lineHeight": 1.25,
			"baseline": 54
		},
		{
			"id": "nD2Lat6Y",
			"type": "text",
			"x": -716.8409896765049,
			"y": 5603.951223766091,
			"width": 8.000015258789062,
			"height": 20,
			"angle": 0,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 1982945017,
			"version": 52,
			"versionNonce": 2004517175,
			"isDeleted": true,
			"boundElements": null,
			"updated": 1690251239876,
			"link": null,
			"locked": false,
			"text": "",
			"rawText": "",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "left",
			"verticalAlign": "top",
			"baseline": 14,
			"containerId": null,
			"originalText": "",
			"lineHeight": 1.25
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#2f9e44",
		"currentItemBackgroundColor": "transparent",
		"currentItemFillStyle": "hachure",
		"currentItemStrokeWidth": 0.5,
		"currentItemStrokeStyle": "solid",
		"currentItemRoughness": 0,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 16,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 1170.076905885663,
		"scrollY": -4705.143388243796,
		"zoom": {
			"value": 0.8990902649735021
		},
		"currentItemRoundness": "round",
		"gridSize": null,
		"colorPalette": {},
		"currentStrokeOptions": null,
		"previousGridSize": null
	},
	"files": {}
}
```
%%