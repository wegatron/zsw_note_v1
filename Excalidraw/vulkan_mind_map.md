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
    支持生命周期较长的command buffer, 录制一次重复使用, 且可以不释放, 从新录制内容. ^cxCokbfi

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


# Embedded files
a4d7f9b0a6abf8ba8c7940c3e6048d97538f9e28: [[mobile_vk_memory.png]]
041f50e40e110dde44f4b4b001dfe5495408a4b5: [[Pasted Image 20230717093641_521.png]]

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
			"version": 365,
			"versionNonce": 1132116811,
			"isDeleted": false,
			"id": "8vpI1tr9daG5itaHUvtNy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1035.2115509757155,
			"y": -203.54312936112126,
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
			"updated": 1689582523414,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 349,
			"versionNonce": 1394193125,
			"isDeleted": false,
			"id": "ZJ8jkhWK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1010.9015228995436,
			"y": -194.04312936112126,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 59.37994384765625,
			"height": 25,
			"seed": 75881611,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523414,
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
			"version": 864,
			"versionNonce": 1253775851,
			"isDeleted": false,
			"id": "sBOKEF0l7D0JdoTtUemVr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -779.1404509134337,
			"y": -500.62869521351547,
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
			"updated": 1689582523415,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 859,
			"versionNonce": 629935685,
			"isDeleted": false,
			"id": "lybhry6P",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -767.7803968973204,
			"y": -491.12869521351547,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 108.27989196777344,
			"height": 25,
			"seed": 1344605381,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523415,
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
			"version": 847,
			"versionNonce": 1404478603,
			"isDeleted": false,
			"id": "oDhN1X9Nuh_9DXCmvqfFK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1048.8856135192468,
			"y": 947.4030847410463,
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
			"updated": 1689582523415,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 764,
			"versionNonce": 1675361701,
			"isDeleted": false,
			"id": "VTcADaop",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1016.545571404989,
			"y": 958.4030847410463,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 68.31991577148438,
			"height": 25,
			"seed": 1555018187,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523415,
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
			"version": 1276,
			"versionNonce": 1445452587,
			"isDeleted": false,
			"id": "QmXFFWBgjIDxGjrZ0i2BY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1009.6169925025159,
			"y": 3358.8917877070467,
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
			"updated": 1689582523415,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 1225,
			"versionNonce": 1698103557,
			"isDeleted": false,
			"id": "sOf7Qxs6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -963.0769763281995,
			"y": 3372.3917877070467,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 40.91996765136719,
			"height": 25,
			"seed": 439093061,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523415,
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
			"version": 839,
			"versionNonce": 1853439435,
			"isDeleted": false,
			"id": "ug1bFnxXMH5RZHtenX_vz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1031.8856135192468,
			"y": 1619.5447023457382,
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
			"updated": 1689582523415,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 792,
			"versionNonce": 1058707557,
			"isDeleted": false,
			"id": "9FhasIQH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1009.175583917196,
			"y": 1629.0447023457382,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 53.57994079589844,
			"height": 25,
			"seed": 160057163,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523415,
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
			"version": 405,
			"versionNonce": 1204112491,
			"isDeleted": false,
			"id": "9MAw6mM-Gw_Hopv8W85Yo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -304.14380624696537,
			"y": -742.1343941454197,
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
			"updated": 1689582523415,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 364,
			"versionNonce": 2069119941,
			"isDeleted": false,
			"id": "jzUbNhC8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -288.4137647430591,
			"y": -732.6343941454197,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 79.5399169921875,
			"height": 25,
			"seed": 1723423272,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523415,
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
			"version": 604,
			"versionNonce": 1171687179,
			"isDeleted": false,
			"id": "6hmhRMdK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -137.7862340358982,
			"y": -323.53333224341094,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 204.13291931152344,
			"height": 25,
			"seed": 550190168,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523415,
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
			"version": 375,
			"versionNonce": 234980133,
			"isDeleted": false,
			"id": "qhvhnGiJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -110.07345283621237,
			"y": -890.7755557428319,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 103.2398681640625,
			"height": 25,
			"seed": 1282608984,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523416,
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
			"version": 573,
			"versionNonce": 1864854955,
			"isDeleted": false,
			"id": "oFXDNSqRq1sH8iGZ4gJ4R",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -339.5454721769238,
			"y": -265.79136192123786,
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
			"updated": 1689582523416,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 509,
			"versionNonce": 193975941,
			"isDeleted": false,
			"id": "HNUpNXg2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -312.22544196452145,
			"y": -260.79136192123786,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 62.35993957519531,
			"height": 25,
			"seed": 784387124,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523416,
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
			"version": 427,
			"versionNonce": 383942731,
			"isDeleted": false,
			"id": "PKQh0Jg5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -109.05112444710457,
			"y": -547.6685046726348,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 100.27989196777344,
			"height": 25,
			"seed": 1973251508,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523416,
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
			"version": 640,
			"versionNonce": 515685861,
			"isDeleted": false,
			"id": "5hnqsy3C",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 152.2145739811765,
			"y": -444.26874535232787,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 646.6885375976562,
			"height": 80,
			"seed": 1431936180,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523416,
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
			"version": 1346,
			"versionNonce": 1189232363,
			"isDeleted": false,
			"id": "F1xNj3sg9fcdHjjysXF8J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -554.84556066153,
			"y": -745.1343941454197,
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
			"updated": 1689582523416,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 933,
			"versionNonce": 1049999685,
			"isDeleted": false,
			"id": "7TRP2QJK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -549.84556066153,
			"y": -740.1343941454197,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 176,
			"height": 40,
			"seed": 2078708748,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523416,
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
			"version": 918,
			"versionNonce": 1773218187,
			"isDeleted": false,
			"id": "MTtZNUQ4Dzvt6bkGUNgdM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -126.23883900217692,
			"y": -825.479831919214,
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
			"updated": 1689582523416,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 545,
			"versionNonce": 611862693,
			"isDeleted": false,
			"id": "KybCi4Rb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -121.23883900217692,
			"y": -820.479831919214,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 379.6641845703125,
			"height": 220,
			"seed": 183872692,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523416,
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
			"version": 228,
			"versionNonce": 881442859,
			"isDeleted": false,
			"id": "u5OlwVJY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -100.15628634046996,
			"y": -140.46081206431847,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 89.84858703613281,
			"height": 25.82042154256527,
			"seed": 1518261777,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523417,
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
			"version": 310,
			"versionNonce": 34728965,
			"isDeleted": false,
			"id": "DxBEDXxsjTPUg3Z4eERVj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 6.93396151054327,
			"y": -168.03411602715607,
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
			"updated": 1689582523417,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 269,
			"versionNonce": 1364624075,
			"isDeleted": false,
			"id": "UdWEyZVY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 28.46582186210577,
			"y": -162.53411602715607,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 127.936279296875,
			"height": 20,
			"seed": 854760657,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523417,
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
			"version": 186,
			"versionNonce": 2002789221,
			"isDeleted": false,
			"id": "MOoly76F",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 339.02830306273427,
			"y": -833.5770295359061,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 228.7052001953125,
			"height": 20,
			"seed": 69352223,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523417,
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
			"version": 63,
			"versionNonce": 1219621227,
			"isDeleted": false,
			"id": "j7dsM5qC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 339.02830306273427,
			"y": -789.373339040744,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 296.14532470703125,
			"height": 20,
			"seed": 1256050097,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523417,
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
			"version": 87,
			"versionNonce": 1219522245,
			"isDeleted": false,
			"id": "HX0zHfLfgpkGhQt3zBB9r",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -191.72320290385983,
			"y": -722.57546097303,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 57.8947368421052,
			"height": 129.47368421052624,
			"seed": 588214109,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523417,
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
			"version": 70,
			"versionNonce": 736529419,
			"isDeleted": false,
			"id": "A69nWMw1SzB8VeANKtDRM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -189.61793974596515,
			"y": -721.5228293940825,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 50.52631578947364,
			"height": 9.473684210526244,
			"seed": 1952504019,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523418,
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
			"version": 116,
			"versionNonce": 1419791909,
			"isDeleted": false,
			"id": "h2o8NZvQrDWH8CcyO4AsA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -220.1601387730393,
			"y": -245.17877196551615,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 115.32319232482013,
			"height": 114.59200381053324,
			"seed": 1582369491,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523419,
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
			"version": 436,
			"versionNonce": 2129580715,
			"isDeleted": false,
			"id": "b1lmDQYkX5FjOao0zZIVR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -734.6034087823696,
			"y": 743.0338700516947,
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
			"updated": 1689582523419,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 408,
			"versionNonce": 1243431301,
			"isDeleted": false,
			"id": "p4bugCjR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -725.4533080743618,
			"y": 761.5338700516947,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 157.69979858398438,
			"height": 25,
			"seed": 1157736243,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523419,
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
			"version": 577,
			"versionNonce": 1651852619,
			"isDeleted": false,
			"id": "9bONTo82v2PJ_VnFKS-w-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -742.2904894816032,
			"y": 1062.3766049669873,
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
			"updated": 1689582523419,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 579,
			"versionNonce": 509921509,
			"isDeleted": false,
			"id": "Y2s3t9U2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -731.8103945719353,
			"y": 1080.8766049669873,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 155.03981018066406,
			"height": 25,
			"seed": 934963293,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523419,
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
			"version": 225,
			"versionNonce": 2111071211,
			"isDeleted": false,
			"id": "ChAZZmL0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 742.4113970909834,
			"y": 706.3653608126942,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 264.59307861328125,
			"height": 25,
			"seed": 1004614941,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523419,
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
			"version": 245,
			"versionNonce": 1124361285,
			"isDeleted": false,
			"id": "CUG15VR4Cn1eWqlutgOO7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 417.0780637576497,
			"y": 703.3653608126942,
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
			"updated": 1689582523419,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 230,
			"versionNonce": 689352331,
			"isDeleted": false,
			"id": "Ez8sDNeo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 458.79814127229815,
			"y": 736.8653608126942,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 132.55984497070312,
			"height": 25,
			"seed": 1177136083,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523419,
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
			"version": 263,
			"versionNonce": 467243941,
			"isDeleted": false,
			"id": "Mk5vIOvi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 742.4113970909834,
			"y": 761.0320274793607,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 400.752685546875,
			"height": 25,
			"seed": 915486397,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523419,
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
			"version": 74,
			"versionNonce": 1459004715,
			"isDeleted": false,
			"id": "cF7a9EhE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 849.0134306639322,
			"y": -602.2321891209741,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 678.8729248046875,
			"height": 25,
			"seed": 1927611859,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523419,
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
			"version": 452,
			"versionNonce": 890361605,
			"isDeleted": false,
			"id": "EsoRN7ez",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1133.07307616187,
			"y": -101.5892688359238,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 348.69281005859375,
			"height": 25,
			"seed": 470365917,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523420,
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
			"version": 326,
			"versionNonce": 1054787531,
			"isDeleted": false,
			"id": "0O1xdIGNq3fa0x2fV2yBc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1809.7009979480301,
			"y": -96.79042526480953,
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
			"updated": 1689582523420,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 377,
			"versionNonce": 959098469,
			"isDeleted": false,
			"id": "ARdgx1Yi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1794.7975250476395,
			"y": -63.79042526480953,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 327.19305419921875,
			"height": 25,
			"seed": 44515187,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523420,
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
			"version": 320,
			"versionNonce": 1189713515,
			"isDeleted": false,
			"id": "ysk_8VVB6QndbLThPjmFR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -387.85569703729516,
			"y": 492.83443127657324,
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
			"updated": 1689582523420,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 281,
			"versionNonce": 653367749,
			"isDeleted": false,
			"id": "I3eSwx7J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -367.695624710635,
			"y": 502.83443127657324,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 119.67985534667969,
			"height": 25,
			"seed": 350032432,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523420,
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
			"version": 1368,
			"versionNonce": 769757451,
			"isDeleted": false,
			"id": "BG0r7nN6iTBqMyiIh4Tuy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -391.3410162029777,
			"y": 576.2492343111514,
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
			"updated": 1689582523420,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 1497,
			"versionNonce": 1199839525,
			"isDeleted": false,
			"id": "TUqsVMtw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -386.3410162029777,
			"y": 581.2492343111514,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 556.879638671875,
			"height": 125,
			"seed": 1915653168,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523420,
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
			"version": 375,
			"versionNonce": 1967208363,
			"isDeleted": false,
			"id": "HqMsZjgtVTcZlnGxskMQC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -717.5272010899153,
			"y": 1403.5237109700668,
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
			"updated": 1689582523420,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 318,
			"versionNonce": 1682943109,
			"isDeleted": false,
			"id": "VUAZ78FG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -671.9571708775129,
			"y": 1421.5237109700668,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 57.85993957519531,
			"height": 25,
			"seed": 810781904,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523420,
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
			"version": 489,
			"versionNonce": 187894347,
			"isDeleted": false,
			"id": "ecoGQyUOPjZitOISe84Rq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -706.6166583540268,
			"y": 1985.4669603911914,
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
			"updated": 1689582523420,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 452,
			"versionNonce": 1024578533,
			"isDeleted": false,
			"id": "9amyTdkp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -661.0566226484603,
			"y": 2003.4669603911914,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 64.87992858886719,
			"height": 25,
			"seed": 428170800,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523420,
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
			"version": 783,
			"versionNonce": 881953003,
			"isDeleted": false,
			"id": "xZITBcKMISab2S6sSJXZB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -540.1231160942923,
			"y": 1580.1463775406335,
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
			"updated": 1689582523421,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 796,
			"versionNonce": 1037569861,
			"isDeleted": false,
			"id": "7lRVwubC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -524.8111654106985,
			"y": 1587.6463775406335,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 49.3760986328125,
			"height": 20,
			"seed": 1139334864,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523421,
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
			"version": 656,
			"versionNonce": 1872733413,
			"isDeleted": false,
			"id": "7N4WVheJ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -403.0100116728493,
			"y": 1556.0261559403566,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 532.4652099609375,
			"height": 80,
			"seed": 133468720,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582546887,
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
			"version": 495,
			"versionNonce": 1962925733,
			"isDeleted": false,
			"id": "1s0h_LZGw9uFdnBWx4wMj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -97.45833721864074,
			"y": 489.33443127657324,
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
			"updated": 1689582523421,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 489,
			"versionNonce": 1114540587,
			"isDeleted": false,
			"id": "Fp9OCP7y",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -86.53820934998839,
			"y": 502.83443127657324,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 242.1597442626953,
			"height": 25,
			"seed": 1486728529,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523421,
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
			"version": 342,
			"versionNonce": 1228325381,
			"isDeleted": false,
			"id": "ttZCYIlzn9L6J0XKtzqKs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 234.77427630123782,
			"y": 569.8481977167321,
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
			"updated": 1689582523421,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 345,
			"versionNonce": 470944971,
			"isDeleted": false,
			"id": "zu3TMxtZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 240.05438189205813,
			"y": 574.8481977167321,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 206.43978881835938,
			"height": 25,
			"seed": 846029937,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523421,
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
			"version": 672,
			"versionNonce": 1870281061,
			"isDeleted": false,
			"id": "0ba52DQEEdMgc6ohb6DRn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 227.02055701762026,
			"y": 338.20583411865846,
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
			"updated": 1689582523421,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 807,
			"versionNonce": 124533611,
			"isDeleted": false,
			"id": "YNSRZZiO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 237.1806751206476,
			"y": 343.20583411865846,
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
			"updated": 1689582523421,
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
			"version": 245,
			"versionNonce": 555205829,
			"isDeleted": false,
			"id": "eUdKzPG74aACuTDmS_sOR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 520.458789931925,
			"y": 295.5603780587619,
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
			"updated": 1689582523421,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 325,
			"versionNonce": 1892128267,
			"isDeleted": false,
			"id": "u9zqe9px",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 552.7089272610266,
			"y": 312.0603780587619,
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
			"updated": 1689582523421,
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
			"version": 346,
			"versionNonce": 296543269,
			"isDeleted": false,
			"id": "WwrjnYfvT8jZVpvlXvx6A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 230.81264865662422,
			"y": 473.4384875988558,
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
			"updated": 1689582523422,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 386,
			"versionNonce": 1461623979,
			"isDeleted": false,
			"id": "UtTZtJFf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 236.2827643182453,
			"y": 478.4384875988558,
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
			"updated": 1689582523422,
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
			"version": 170,
			"versionNonce": 623318917,
			"isDeleted": false,
			"id": "j_kWCgzDhFuxHkQxKuN-E",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 517.0210811270965,
			"y": 460.9384875988558,
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
			"updated": 1689582523422,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 336,
			"versionNonce": 1981534027,
			"isDeleted": false,
			"id": "kziOnwkc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 532.1012202872528,
			"y": 465.9384875988558,
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
			"updated": 1689582523422,
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
			"version": 650,
			"versionNonce": 1929617163,
			"isDeleted": false,
			"id": "mhUP4-Dlja3Wehs6M2VuT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 228.54271102773262,
			"y": 375.18992616358105,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 60.111888521613565,
			"height": 136.6122367928943,
			"seed": 2096431441,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1689589835559,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "0ba52DQEEdMgc6ohb6DRn",
				"gap": 1.9840920449225905,
				"focus": 0.8707640447988937
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
					136.6122367928943
				]
			]
		},
		{
			"type": "arrow",
			"version": 566,
			"versionNonce": 653362603,
			"isDeleted": false,
			"id": "bB8CUXU_h3TBNTMv0Qt0s",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 229.07052828486167,
			"y": 501.37353878686895,
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
			"updated": 1689589835562,
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
				"focus": 0.637551312413947
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
			"version": 355,
			"versionNonce": 596399563,
			"isDeleted": false,
			"id": "ajpUmjrIxEUM2AmiFo7gc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 234.92820174897724,
			"y": 584.5403468212542,
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
			"updated": 1689589835557,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "1s0h_LZGw9uFdnBWx4wMj",
				"gap": 1,
				"focus": -0.8991523072472104
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
			"version": 278,
			"versionNonce": 941799563,
			"isDeleted": false,
			"id": "6YpzTBoQlLAyCtxx_l8X0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -392.24445705211156,
			"y": 870.2901038811397,
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
			"updated": 1689582523422,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 292,
			"versionNonce": 1525361061,
			"isDeleted": false,
			"id": "yy8MByKT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -386.9243734339475,
			"y": 875.2901038811397,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 137.35983276367188,
			"height": 25,
			"seed": 1394410454,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523422,
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
			"version": 325,
			"versionNonce": 2079420203,
			"isDeleted": false,
			"id": "L-B8q6fiAtFK8i5TaExux",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -181.7181412626378,
			"y": 784.1959423383266,
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
			"updated": 1689582523422,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 372,
			"versionNonce": 159427845,
			"isDeleted": false,
			"id": "0ihgLmtf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -176.44806069623155,
			"y": 789.1959423383266,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 131.4598388671875,
			"height": 25,
			"seed": 1859981898,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523422,
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
			"version": 626,
			"versionNonce": 1128101445,
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
			"height": 246.54077350816942,
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
			"updated": 1689589835551,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "b1lmDQYkX5FjOao0zZIVR",
				"gap": 2.67765352741651,
				"focus": 0.8039330752064558
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
					-246.54077350816942
				]
			]
		},
		{
			"type": "text",
			"version": 167,
			"versionNonce": 89048165,
			"isDeleted": false,
			"id": "3dsmJS2e",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -541.7008263950477,
			"y": 621.8448228995055,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 138.43983459472656,
			"height": 50,
			"seed": 570630614,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523423,
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
			"version": 216,
			"versionNonce": 1329193067,
			"isDeleted": false,
			"id": "eCLhDJMIlbe_Yj2oJuoVu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -542.9318259144358,
			"y": 1281.9474932032379,
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
			"updated": 1689582523423,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 270,
			"versionNonce": 1109585861,
			"isDeleted": false,
			"id": "c41DXZmE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -528.4559042835764,
			"y": 1289.4474932032379,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 72.04815673828125,
			"height": 20,
			"seed": 1927307414,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523423,
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
			"version": 333,
			"versionNonce": 429431563,
			"isDeleted": false,
			"id": "O8vlGOcFctOyoto2jQ2qz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -540.1231160942923,
			"y": 1518.155638575986,
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
			"updated": 1689582523423,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 362,
			"versionNonce": 1578807077,
			"isDeleted": false,
			"id": "byfhFh2T",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -529.2311635796439,
			"y": 1525.655638575986,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 45.216094970703125,
			"height": 20,
			"seed": 1060645066,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523423,
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
			"version": 231,
			"versionNonce": 696713643,
			"isDeleted": false,
			"id": "uQBQahjhvqVdD7BaHb25E",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -541.527471004364,
			"y": 1413.836080973824,
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
			"updated": 1689582523423,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 388,
			"versionNonce": 1470333573,
			"isDeleted": false,
			"id": "m6n2RStp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -529.0395330771179,
			"y": 1421.336080973824,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 59.02412414550781,
			"height": 20,
			"seed": 619124630,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523423,
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
			"version": 295,
			"versionNonce": 137335883,
			"isDeleted": false,
			"id": "ElS3lvy_dTWzOhUGqNWuv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -542.9318259144358,
			"y": 1331.4103687658787,
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
			"updated": 1689582523423,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 342,
			"versionNonce": 58386917,
			"isDeleted": false,
			"id": "wDKOcw0Z",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -526.179918565803,
			"y": 1338.9103687658787,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 92.49618530273438,
			"height": 20,
			"seed": 946502998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523423,
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
			"version": 160,
			"versionNonce": 896324331,
			"isDeleted": false,
			"id": "qgh--5WsTvopN_2M3WfLD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -182.78995877304465,
			"y": 837.0645363606504,
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
				}
			],
			"updated": 1689582523423,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 277,
			"versionNonce": 1118725445,
			"isDeleted": false,
			"id": "2ADXoXmG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -177.66987210312277,
			"y": 842.0645363606504,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 146.75982666015625,
			"height": 25,
			"seed": 984016650,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 149,
			"versionNonce": 1372142987,
			"isDeleted": false,
			"id": "gSsz97ctHKWn5pR5OLPHN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -187.04993802109175,
			"y": 889.9331303829742,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 321,
			"versionNonce": 2023453861,
			"isDeleted": false,
			"id": "12zTYOXn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -182.04993802109175,
			"y": 894.9331303829742,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 195.27978515625,
			"height": 175,
			"seed": 1840151882,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 323,
			"versionNonce": 1691884261,
			"isDeleted": false,
			"id": "yOwd51MsUt1B1mBc6KVDI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -553.8837296534928,
			"y": 773.8804988040272,
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
			"updated": 1689589835547,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "b1lmDQYkX5FjOao0zZIVR",
				"gap": 4.719679128876805,
				"focus": -0.6918446395732875
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
			"version": 562,
			"versionNonce": 176674859,
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
			"height": 82.5849936977595,
			"seed": 1544695370,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1689589835566,
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
					-82.5849936977595
				]
			]
		},
		{
			"type": "arrow",
			"version": 578,
			"versionNonce": 1876007627,
			"isDeleted": false,
			"id": "QQkCkMj0ytdOxkdjAaOdh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -242.30478228507184,
			"y": 885.459446172448,
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
			"updated": 1689589835571,
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
			"version": 594,
			"versionNonce": 1283839685,
			"isDeleted": false,
			"id": "b_JG3sKm_2v_JgA5yJS5_",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -243.24445705211156,
			"y": 885.5063339056926,
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
			"updated": 1689589835572,
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
				"focus": 0.22805897950945023
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
			"version": 525,
			"versionNonce": 1673694053,
			"isDeleted": false,
			"id": "WxrfV_zM8Y84tUZviqbl8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -40.19951912717727,
			"y": 800.1962882777111,
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
			"updated": 1689589835571,
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
			"version": 181,
			"versionNonce": 353573573,
			"isDeleted": false,
			"id": "ao1bg9q4THmLUQFjyVe78",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -542.9318259144358,
			"y": 1228.917525728097,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 200,
			"versionNonce": 1297391627,
			"isDeleted": false,
			"id": "riC9Kydi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -531.1118872547678,
			"y": 1236.417525728097,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 53.36012268066406,
			"height": 20,
			"seed": 895385861,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 209,
			"versionNonce": 1473083941,
			"isDeleted": false,
			"id": "WUtwD51iGOgdSZ187zS8V",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -540.1231160942923,
			"y": 1463.9150736492995,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 219,
			"versionNonce": 1903847083,
			"isDeleted": false,
			"id": "c3oUdLzr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -530.4951635186087,
			"y": 1471.4150736492995,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 35.74409484863281,
			"height": 20,
			"seed": 1359726923,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 299,
			"versionNonce": 1187310981,
			"isDeleted": false,
			"id": "794f0xqB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -445.8736017338675,
			"y": 1461.6477936213644,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 251.53651428222656,
			"height": 40,
			"seed": 1995247371,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 236,
			"versionNonce": 644766027,
			"isDeleted": false,
			"id": "IN7mYDad",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 316.8168498565432,
			"y": 1470.6037578784901,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 189.13702392578125,
			"height": 20,
			"seed": 1520004613,
			"groupIds": [
				"U8o-g4tkiAbO8tsSRGd5s"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 324,
			"versionNonce": 20378853,
			"isDeleted": false,
			"id": "KZU8eWD6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 316.8168498565432,
			"y": 1433.02953172217,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 196.1930389404297,
			"height": 20,
			"seed": 560258507,
			"groupIds": [
				"U8o-g4tkiAbO8tsSRGd5s"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 319,
			"versionNonce": 160102379,
			"isDeleted": false,
			"id": "ibud4hes",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 316.8168498565432,
			"y": 1506.0274702536292,
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
			"updated": 1689582523424,
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
			"version": 60,
			"versionNonce": 1655771205,
			"isDeleted": false,
			"id": "3_ZVWQlrZZ-2Z8n7btPEc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -218.10174032617226,
			"y": -250.17127859986795,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 76.22594054627206,
			"height": 61.64358670263732,
			"seed": 988667935,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 115,
			"versionNonce": 685425291,
			"isDeleted": false,
			"id": "TyznES-dcOoBVwaD2hmg8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -189.59986690452268,
			"y": -718.1322701274164,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 72.91176921817322,
			"height": 186.91926290477136,
			"seed": 1304774897,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 248,
			"versionNonce": 2031140773,
			"isDeleted": false,
			"id": "sAR1D_X4TFmBgPGLEgjH5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -542.9318259144358,
			"y": 1131.9885364037184,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 272,
			"versionNonce": 1830304043,
			"isDeleted": false,
			"id": "2CrXkzGL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -524.1118719959787,
			"y": 1139.4885364037184,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 1923811761,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 250,
			"versionNonce": 981697285,
			"isDeleted": false,
			"id": "sOvTJZEV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -431.5056389591125,
			"y": 1139.1757422888243,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 360.01617431640625,
			"height": 20,
			"seed": 1814104319,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 231,
			"versionNonce": 1135467467,
			"isDeleted": false,
			"id": "k6390vwFDWTradiZjq2z2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -471.5734879366237,
			"y": 1960.9257972048456,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 252,
			"versionNonce": 2072435301,
			"isDeleted": false,
			"id": "0cdaV3Q5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -466.25353401816665,
			"y": 1965.9257972048456,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 1406860721,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 231,
			"versionNonce": 146156139,
			"isDeleted": false,
			"id": "tmgdqgy11iBeOJFKX31vp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -471.5734879366237,
			"y": 1999.714943567487,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 237,
			"versionNonce": 619201989,
			"isDeleted": false,
			"id": "jH0TkeeA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -466.1215226045924,
			"y": 2004.714943567487,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 30.0960693359375,
			"height": 20,
			"seed": 817665087,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 231,
			"versionNonce": 821798155,
			"isDeleted": false,
			"id": "_BBs0LjYWc_WR2f5WVY08",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -471.5734879366237,
			"y": 2040.2294918759999,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 244,
			"versionNonce": 700794149,
			"isDeleted": false,
			"id": "nvUxvbi3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -466.18153542197524,
			"y": 2045.2294918759999,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 45.216094970703125,
			"height": 20,
			"seed": 390984849,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 318,
			"versionNonce": 871943083,
			"isDeleted": false,
			"id": "83NxTTwftLloXWhlzMkFT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -540.1231160942923,
			"y": 1637.4811069843458,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 322,
			"versionNonce": 1032542341,
			"isDeleted": false,
			"id": "VwFYpY6i",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -534.6792226616751,
			"y": 1642.4811069843458,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 92.11221313476562,
			"height": 20,
			"seed": 1846214111,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 345,
			"versionNonce": 903355979,
			"isDeleted": false,
			"id": "kA_4DAq0ofI8jJZyGRWXu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -987.2352655281993,
			"y": 2378.002397171182,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 327,
			"versionNonce": 1240989669,
			"isDeleted": false,
			"id": "tRqPAOgm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -975.2252328743907,
			"y": 2394.502397171182,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 67.97993469238281,
			"height": 25,
			"seed": 1553808194,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 389,
			"versionNonce": 1903434987,
			"isDeleted": false,
			"id": "GCmHOzBaYfyQhbFQcXvDM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -706.6166583540268,
			"y": 2237.546535260798,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 412,
			"versionNonce": 622377797,
			"isDeleted": false,
			"id": "cCBNxDxs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -693.1865893843002,
			"y": 2256.046535260798,
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
			"updated": 1689582523424,
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
			"version": 379,
			"versionNonce": 1649887115,
			"isDeleted": false,
			"id": "1OyCXAVz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -706.6166583540268,
			"y": 2308.1730306464715,
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
			"updated": 1689582523424,
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
			"version": 390,
			"versionNonce": 122358437,
			"isDeleted": false,
			"id": "pizIAgCn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1060.4271999277419,
			"y": 2451.996745109034,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 300.91241455078125,
			"height": 140,
			"seed": 1168612674,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 539,
			"versionNonce": 784080427,
			"isDeleted": false,
			"id": "wEBmOGbWNalYO80OrC1tu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -669.5716545603394,
			"y": 2495.191445764806,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 560,
			"versionNonce": 1094479365,
			"isDeleted": false,
			"id": "Ik7txvTl",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -652.6915886423707,
			"y": 2513.191445764806,
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
			"updated": 1689582523424,
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
			"version": 279,
			"versionNonce": 1368203467,
			"isDeleted": false,
			"id": "7TYLK4Cw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -669.5716545603394,
			"y": 2570.641863111962,
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
			"updated": 1689582523424,
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
			"version": 172,
			"versionNonce": 837444965,
			"isDeleted": false,
			"id": "IqHKcMMCGVQ8tCgItJI8M",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -469.96200009243864,
			"y": 2475.2517936854465,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 287,
			"versionNonce": 73715563,
			"isDeleted": false,
			"id": "ndrTjBwt",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -464.59008236782927,
			"y": 2480.2517936854465,
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
			"updated": 1689582523424,
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
			"version": 183,
			"versionNonce": 2091020485,
			"isDeleted": false,
			"id": "GA9Zq0W8w6TfuNy2uRHBq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -469.96200009243864,
			"y": 2520.8012653348023,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 281,
			"versionNonce": 1770891787,
			"isDeleted": false,
			"id": "BPxOaXvg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -464.6941167916574,
			"y": 2525.8012653348023,
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
			"updated": 1689582523424,
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
			"version": 373,
			"versionNonce": 2130841637,
			"isDeleted": false,
			"id": "nYtDfCc6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -294.69233442853795,
			"y": 2443.1147884171887,
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
			"updated": 1689582523424,
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
			"version": 1001,
			"versionNonce": 159954469,
			"isDeleted": false,
			"id": "Rvf69EXBrnmHcD_okizP1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -353.5509842876641,
			"y": 2535.252084480111,
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
			"updated": 1689589835584,
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
			"version": 226,
			"versionNonce": 116835205,
			"isDeleted": false,
			"id": "B2eBRZea8hMueLG3XZ2_5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -499.31650930386445,
			"y": 2223.3375579026456,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 232,
			"versionNonce": 460120907,
			"isDeleted": false,
			"id": "fQJeZaem",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -493.8645439718332,
			"y": 2228.3375579026456,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 30.0960693359375,
			"height": 20,
			"seed": 248263902,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 226,
			"versionNonce": 1220414181,
			"isDeleted": false,
			"id": "6-rRDmhJJLQhYB5BwJtn0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -499.31650930386445,
			"y": 2267.346795886799,
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
			"updated": 1689582523424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 239,
			"versionNonce": 841499115,
			"isDeleted": false,
			"id": "jOMQsCZy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -493.9965553854074,
			"y": 2272.346795886799,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 838063582,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 289,
			"versionNonce": 350578245,
			"isDeleted": false,
			"id": "FJEExEwu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -375.55417576491277,
			"y": 2263.4365031436196,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 440.99273681640625,
			"height": 40,
			"seed": 1473862466,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 164,
			"versionNonce": 591318155,
			"isDeleted": false,
			"id": "zuB9weWX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1132.1658648532732,
			"y": -51.93073932185297,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 334.0929870605469,
			"height": 25,
			"seed": 456477278,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 713,
			"versionNonce": 1313494437,
			"isDeleted": false,
			"id": "r4nGhhI6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 571.4595355159746,
			"y": 2254.2227160505035,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 850.8507080078125,
			"height": 103.49026896400659,
			"seed": 1071444098,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523424,
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
			"version": 228,
			"versionNonce": 1382744875,
			"isDeleted": false,
			"id": "AnYY4Djk0lu7T2SLOP3f-",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 621.4864256071282,
			"y": 2299.555453023635,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 66.27050512845949,
			"height": 1.7672134700922015,
			"seed": 1485999998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 239,
			"versionNonce": 538597637,
			"isDeleted": false,
			"id": "7UwMfAjbJBUEsmyU7PE1a",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 574.2134652821604,
			"y": 2352.571857126403,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 22.0901683761532,
			"height": 56.55083104295227,
			"seed": 1557254142,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 254,
			"versionNonce": 1209492939,
			"isDeleted": false,
			"id": "QlrTGdCLIbzOQmfrhsqOD",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 577.563069823474,
			"y": 2366.2898272520424,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 254.28772232362564,
			"height": 239.93989076890716,
			"seed": 1084720482,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 606,
			"versionNonce": 1943203941,
			"isDeleted": false,
			"id": "vKKqy9QE",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 854.3678451153116,
			"y": 2366.1827867924244,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 896.4277954101562,
			"height": 243.23285710183524,
			"seed": 1210480930,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 28,
			"versionNonce": 459175019,
			"isDeleted": false,
			"id": "HUjyoagp",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1130.1550785761638,
			"y": -8.451300010694808,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 338.97015380859375,
			"height": 20.70821531768297,
			"seed": 1925876478,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 366,
			"versionNonce": 658611141,
			"isDeleted": false,
			"id": "uPsaHVGO",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -169.06368739294066,
			"y": 1938.1954704277803,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 697.9522705078125,
			"height": 80,
			"seed": 1896589970,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 159,
			"versionNonce": 470462219,
			"isDeleted": false,
			"id": "4q3O7ZHLK736VZazPMe0w",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -166.31698162980206,
			"y": 2055.9846735218002,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 472,
			"versionNonce": 42195749,
			"isDeleted": false,
			"id": "3DabKuFR",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -161.31698162980206,
			"y": 2060.9846735218002,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 909.7930908203125,
			"height": 100,
			"seed": 1247312782,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 365,
			"versionNonce": 1016501675,
			"isDeleted": false,
			"id": "5eLs6CsG_g4TiTDLzLd0t",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 379.3564120173876,
			"y": 2435.9084581325924,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 63.4748169758721,
			"height": 336.3442016459206,
			"seed": 901865742,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 311,
			"versionNonce": 1845964421,
			"isDeleted": false,
			"id": "ruRSMFaza-Qdpkthvxmed",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -641.0179321034348,
			"y": 2047.4450802780048,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 473.4197224896526,
			"height": 84.52912048884606,
			"seed": 987581774,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 183,
			"versionNonce": 1009559627,
			"isDeleted": false,
			"id": "oJ4yD1JEcaAFHcpaBC5l_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -182.51612607573384,
			"y": 2111.2344973936383,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 21.19914444593155,
			"height": 30.62098642190108,
			"seed": 501969998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 359,
			"versionNonce": 1753814501,
			"isDeleted": false,
			"id": "X0UCSbyf7z_vY9NFHNS98",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -664.8019089195018,
			"y": 2840.2259271437265,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 456,
			"versionNonce": 279406315,
			"isDeleted": false,
			"id": "Lu8LIEyu",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -644.1718582603221,
			"y": 2857.2259271437265,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 114.73989868164062,
			"height": 25,
			"seed": 244220370,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 290,
			"versionNonce": 1024921925,
			"isDeleted": false,
			"id": "NU9RnuGn5wFFPWybTAHpC",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -402.77685329537655,
			"y": 2852.2259271437265,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 372,
			"versionNonce": 277959051,
			"isDeleted": false,
			"id": "LNpVQV0I",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -397.5667321405914,
			"y": 2857.2259271437265,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 239.5797576904297,
			"height": 25,
			"seed": 1519995026,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 413,
			"versionNonce": 2031001765,
			"isDeleted": false,
			"id": "Hvkz-XlGZCjao51AC5XxI",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -399.8105319109525,
			"y": 3034.025590926098,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 478,
			"versionNonce": 1562699819,
			"isDeleted": false,
			"id": "IPDvLzB6",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -394.60044890314,
			"y": 3039.025590926098,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 171.579833984375,
			"height": 25,
			"seed": 1299113358,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 230,
			"versionNonce": 572343301,
			"isDeleted": false,
			"id": "HPLEJbzY8NAceUHQXzHyy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -404.7544008849926,
			"y": 2674.11192961598,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 274,
			"versionNonce": 206351051,
			"isDeleted": false,
			"id": "J505iaQi",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -399.6442629455395,
			"y": 2679.11192961598,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 251.77972412109375,
			"height": 25,
			"seed": 2139765074,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 441,
			"versionNonce": 742423397,
			"isDeleted": false,
			"id": "3XOHbWZo",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -187.1680350012682,
			"y": 3039.025590926098,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 66.25991821289062,
			"height": 25,
			"seed": 480004882,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 394,
			"versionNonce": 312678763,
			"isDeleted": false,
			"id": "6flRtbjl",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -394.8033151235576,
			"y": 2717.0792713152355,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 218.38446044921875,
			"height": 20,
			"seed": 1771424402,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 371,
			"versionNonce": 801490629,
			"isDeleted": false,
			"id": "aVBFJcA0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -107.07735762181846,
			"y": 2793.8096898137087,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 249.49974060058594,
			"height": 25,
			"seed": 601516302,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 363,
			"versionNonce": 1836233739,
			"isDeleted": false,
			"id": "0LPL7WcU",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -98.17839346854635,
			"y": 2937.181890060872,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 163.75982666015625,
			"height": 25,
			"seed": 1015928974,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 186,
			"versionNonce": 1598727717,
			"isDeleted": false,
			"id": "eOreXhh8",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 199.44251876866724,
			"y": 2743.3822262784993,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 824.559326171875,
			"height": 125,
			"seed": 873966478,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 227,
			"versionNonce": 213252779,
			"isDeleted": false,
			"id": "JwJc1sOI",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 117.37429379960145,
			"y": 2917.406414164711,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 486.17962646484375,
			"height": 75,
			"seed": 15053714,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 564,
			"versionNonce": 1035770245,
			"isDeleted": false,
			"id": "0005z0Cw",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -663.2329040310769,
			"y": 2910.7734654905903,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 324.7979736328125,
			"height": 29.949532625434667,
			"seed": 1310639506,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 490,
			"versionNonce": 2098687307,
			"isDeleted": false,
			"id": "8jGknsSWMuDWuyNJWpAvA",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -518.1660125449054,
			"y": -69.20436704455562,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 505,
			"versionNonce": 341385445,
			"isDeleted": false,
			"id": "229jIfKL",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -504.8459594443194,
			"y": -55.704367044555624,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 97.35989379882812,
			"height": 25,
			"seed": 2103513874,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 222,
			"versionNonce": 1374784491,
			"isDeleted": false,
			"id": "j4DxCTHEu4l5Z1Zvj7KJF",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -519.9237186497724,
			"y": -359.88386647945515,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 255,
			"versionNonce": 682474565,
			"isDeleted": false,
			"id": "pWRxdDov",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -497.00367470445985,
			"y": -344.88386647945515,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 76.159912109375,
			"height": 25,
			"seed": 1073137810,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 171,
			"versionNonce": 1330566795,
			"isDeleted": false,
			"id": "BqX4n9b0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -600.8910891613543,
			"y": -6.714890254769671,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 319.29986572265625,
			"height": 75,
			"seed": 1701051726,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 360,
			"versionNonce": 848817061,
			"isDeleted": false,
			"id": "YeIVvqdYIo1pVlFBCFH6H",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -548.5842141586272,
			"y": 378.25921673177527,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 394,
			"versionNonce": 1407831339,
			"isDeleted": false,
			"id": "MH8choYb",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -543.5341500717132,
			"y": 383.25921673177527,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 121.89987182617188,
			"height": 25,
			"seed": 1714242528,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 47,
			"versionNonce": 306523909,
			"isDeleted": false,
			"id": "yJa8vtbQ5sSLNmKOcJTNy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -717.6802064502374,
			"y": 1732.775453730838,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 86,
			"versionNonce": 53276619,
			"isDeleted": false,
			"id": "SeAUTOXR",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -701.5301591479913,
			"y": 1749.775453730838,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 95.69990539550781,
			"height": 25,
			"seed": 1129541600,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 44,
			"versionNonce": 1177749093,
			"isDeleted": false,
			"id": "poUmsZVrBlQqjmlX5T9pz",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -553.8695619698447,
			"y": 1684.5326637143166,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 71,
			"versionNonce": 791854699,
			"isDeleted": false,
			"id": "Got69oAO",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -548.5895174141806,
			"y": 1689.5326637143166,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 79.43991088867188,
			"height": 25,
			"seed": 265195488,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 38,
			"versionNonce": 556724677,
			"isDeleted": false,
			"id": "IsMqPuZmrL26jkzfifQEj",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -553.8695619698447,
			"y": 1735.6324961850185,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 68,
			"versionNonce": 46512395,
			"isDeleted": false,
			"id": "UA64n5sy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -548.7195222969931,
			"y": 1740.6324961850185,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 66.69992065429688,
			"height": 25,
			"seed": 1220726752,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 53,
			"versionNonce": 1079406885,
			"isDeleted": false,
			"id": "BjzPiZQAHs0DatIEeJ95f",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -553.8695619698447,
			"y": 1786.7323286557203,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 127,
			"versionNonce": 1801478059,
			"isDeleted": false,
			"id": "XUAEEFVt",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -548.6094606514853,
			"y": 1791.7323286557203,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 192.47979736328125,
			"height": 25,
			"seed": 1756994080,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 47,
			"versionNonce": 1092027525,
			"isDeleted": false,
			"id": "vnbePsvSqyitSGGFU0xAo",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -553.8695619698447,
			"y": 1837.832161126422,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 90,
			"versionNonce": 1127035467,
			"isDeleted": false,
			"id": "suIr5AZK",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -548.8694627877157,
			"y": 1842.832161126422,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 171.9998016357422,
			"height": 25,
			"seed": 2142583776,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 119,
			"versionNonce": 925772773,
			"isDeleted": false,
			"id": "BE14GDot",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -433.3940349795723,
			"y": 1691.7543955608694,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 221.73980712890625,
			"height": 25,
			"seed": 1758545440,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 29,
			"versionNonce": 990294251,
			"isDeleted": false,
			"id": "onnAr7D1kZURkPe7l7qNC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -542.9318259144358,
			"y": 1182.8968217091558,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 47,
			"versionNonce": 1655269189,
			"isDeleted": false,
			"id": "jIYiGhHs",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -530.1718008900217,
			"y": 1188.8968217091558,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 41.479949951171875,
			"height": 25,
			"seed": 2116276768,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 45,
			"versionNonce": 74931083,
			"isDeleted": false,
			"id": "MfLLndFx",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -450.0697889251934,
			"y": 1193.4511513255368,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 110.35990905761719,
			"height": 25,
			"seed": 1713180640,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 103,
			"versionNonce": 635844261,
			"isDeleted": false,
			"id": "nvfjLqsaSzbI5bgwm7Kcv",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -675.9389129852444,
			"y": 1468.9459002980157,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 63.319357626739134,
			"height": 252.16656458368038,
			"seed": 1197155296,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 52,
			"versionNonce": 1002025515,
			"isDeleted": false,
			"id": "nYolcpWDRhnViv15BT73b",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -709.7032094644201,
			"y": 1706.242935078912,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 39.99117323794053,
			"height": 33.32597769828362,
			"seed": 1337975776,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 281,
			"versionNonce": 999430661,
			"isDeleted": false,
			"id": "S64o4b2G3XeRPjf9e-vdV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -366.36313255996333,
			"y": 325.1004039740984,
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
			"updated": 1689582523425,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 350,
			"versionNonce": 297284811,
			"isDeleted": false,
			"id": "X6trqsMi",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -356.38306053847896,
			"y": 335.1004039740984,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 135.03985595703125,
			"height": 25,
			"seed": 1420691903,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523425,
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
			"version": 99,
			"versionNonce": 844312805,
			"isDeleted": false,
			"id": "cnNt3m8Fmt8aYs-oY1LHo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -415.5842141586272,
			"y": 391.5448313346674,
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
			"updated": 1689589835602,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "YeIVvqdYIo1pVlFBCFH6H",
				"gap": 1,
				"focus": 0.6936957650636256
			},
			"endBinding": {
				"elementId": "S64o4b2G3XeRPjf9e-vdV",
				"gap": 1.7020543546973386,
				"focus": 0.6534129210495888
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
			"version": 145,
			"versionNonce": 841989259,
			"isDeleted": false,
			"id": "Fq5w72AJyOO7dLTxaFRDc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -418.51161725431444,
			"y": 393.25486822558,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 41.428173031456254,
			"height": 97.39470627301893,
			"seed": 738694993,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1689589835551,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "ysk_8VVB6QndbLThPjmFR",
				"gap": 2.1848567779742893,
				"focus": -0.6556576647101973
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
					41.428173031456254,
					97.39470627301893
				]
			]
		},
		{
			"type": "arrow",
			"version": 502,
			"versionNonce": 387999141,
			"isDeleted": false,
			"id": "9UuEP5s2aAyxtS_VPijJb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -516.2102099178862,
			"y": -40.09680240544981,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 299.5478483726423,
			"height": 1473.2086041517596,
			"seed": 210355729,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1689589835554,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "HqMsZjgtVTcZlnGxskMQC",
				"gap": 1,
				"focus": -0.8220711072367789
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
					-202.31699117202902,
					1473.2086041517596
				]
			]
		},
		{
			"type": "rectangle",
			"version": 24,
			"versionNonce": 17022475,
			"isDeleted": false,
			"id": "eGEQeA7or1QKgUkDFoPAo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -543.731211952987,
			"y": 1370.4989365525678,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 62,
			"versionNonce": 1353137189,
			"isDeleted": false,
			"id": "T3Cnc8iS",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -538.5511353538659,
			"y": 1375.4989365525678,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 121.63984680175781,
			"height": 25,
			"seed": 778825482,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 180,
			"versionNonce": 1570096299,
			"isDeleted": false,
			"id": "h5JNVj01",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -401.4176688080363,
			"y": 1370.274984547173,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 563.2337646484375,
			"height": 40,
			"seed": 418439958,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 150,
			"versionNonce": 1125543813,
			"isDeleted": false,
			"id": "PC8Yj7qDvQ-S8ecWV0G85",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -785.4564620522377,
			"y": 3315.376565764038,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 158,
			"versionNonce": 1936586571,
			"isDeleted": false,
			"id": "yGE9c4U7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -780.0845214394448,
			"y": 3320.376565764038,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 58.25611877441406,
			"height": 20,
			"seed": 1103392458,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 176,
			"versionNonce": 1007171301,
			"isDeleted": false,
			"id": "QWETYi6G6VcTfj5TyAtYI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -783.8708077916938,
			"y": 3476.216980675874,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 207,
			"versionNonce": 283563499,
			"isDeleted": false,
			"id": "FYbDrICX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -778.6869164953071,
			"y": 3481.216980675874,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 95.63221740722656,
			"height": 20,
			"seed": 1281930518,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 461,
			"versionNonce": 1980371525,
			"isDeleted": false,
			"id": "Gzn0Btx2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -784.3605212486985,
			"y": 3385.3883904463414,
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
			"updated": 1689582523426,
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
			"version": 32,
			"versionNonce": 1426776203,
			"isDeleted": false,
			"id": "3UA1CARQ81x6lW7HK7GIG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -789.9674859508851,
			"y": 3169.447323636972,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 59,
			"versionNonce": 2113503653,
			"isDeleted": false,
			"id": "COyABzJc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -784.5995736584047,
			"y": 3174.447323636972,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 71.26417541503906,
			"height": 20,
			"seed": 2135982294,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 129,
			"versionNonce": 429168427,
			"isDeleted": false,
			"id": "zHqvDtLN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -653.8738363665739,
			"y": 3481.216980675874,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 96.25619506835938,
			"height": 20,
			"seed": 1807161162,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 86,
			"versionNonce": 1761871109,
			"isDeleted": false,
			"id": "IDiX2GLBmOfNw4pmW7mES",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -782.6375859693109,
			"y": 3553.8504632096888,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 108,
			"versionNonce": 485390795,
			"isDeleted": false,
			"id": "eKvMgTaU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -777.3776524976312,
			"y": 3558.8504632096888,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 60.480133056640625,
			"height": 20,
			"seed": 258218710,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 7,
			"versionNonce": 1252465765,
			"isDeleted": false,
			"id": "aTYvbIFk-vbsYCxh0Hzdu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -696.3710689017694,
			"y": 3313.3595670271843,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 39,
			"versionNonce": 1815283819,
			"isDeleted": false,
			"id": "iLO56kq8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -690.9312037894647,
			"y": 3318.3595670271843,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 127.12026977539062,
			"height": 20,
			"seed": 1970858186,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 7,
			"versionNonce": 1789937605,
			"isDeleted": false,
			"id": "VVw_rq1YV1Msequt9JuPm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -696.3710689017694,
			"y": 3350.8867178600585,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 47,
			"versionNonce": 221037323,
			"isDeleted": false,
			"id": "Aqz5ifri",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -690.9311809012811,
			"y": 3355.8867178600585,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 113.12022399902344,
			"height": 20,
			"seed": 127197002,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 440,
			"versionNonce": 993855269,
			"isDeleted": false,
			"id": "GvyZP1Ol",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -692.9567231623133,
			"y": 3254.9333966054232,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 82.237060546875,
			"height": 14.640784156251865,
			"seed": 1580730326,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 7,
			"versionNonce": 1750477227,
			"isDeleted": false,
			"id": "TYD2WxHdpOXmdRVfNRORh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -695.3139660614069,
			"y": 3280.5893789759416,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 30,
			"versionNonce": 247126661,
			"isDeleted": false,
			"id": "eh1l9kEQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -689.8261196868951,
			"y": 3285.5893789759416,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 145.02430725097656,
			"height": 20,
			"seed": 2143946454,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 245,
			"versionNonce": 1926872139,
			"isDeleted": false,
			"id": "UOrHDtiZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -566.1043823187945,
			"y": 3365.4006434233224,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 121.29859924316406,
			"height": 12.16554791459063,
			"seed": 1731197834,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 7,
			"versionNonce": 233259493,
			"isDeleted": false,
			"id": "_JBGln79SEmCm-_jBP_NF",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -993.4169670436766,
			"y": 3719.28705772645,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 64,
			"versionNonce": 412220139,
			"isDeleted": false,
			"id": "gYXqiGAb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -988.0970436427976,
			"y": 3724.28705772645,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.36015319824219,
			"height": 20,
			"seed": 2010305418,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 37,
			"versionNonce": 1842330949,
			"isDeleted": false,
			"id": "356e2Z7lUjN00hjnuinA-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -833.5773431388408,
			"y": 3691.0377677504925,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 51,
			"versionNonce": 1711891851,
			"isDeleted": false,
			"id": "oAmnIF2n",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -828.3934594718486,
			"y": 3696.0377677504925,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 121.63223266601562,
			"height": 20,
			"seed": 1745234506,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 260,
			"versionNonce": 1708248229,
			"isDeleted": false,
			"id": "RMNIyU0I_hl4lUxU7G9F8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -828.4769051458298,
			"y": 4228.11768157141,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 276,
			"versionNonce": 1920629803,
			"isDeleted": false,
			"id": "tA6HZ5rR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -823.2650292303025,
			"y": 4233.11768157141,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 126.57624816894531,
			"height": 20,
			"seed": 1781711190,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 9,
			"versionNonce": 1704652805,
			"isDeleted": false,
			"id": "UZJTYUQdz3e0ruLVEFicA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -329.2714832277628,
			"y": 3515.5365537786865,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 351,
			"versionNonce": 164609739,
			"isDeleted": false,
			"id": "iMPPEsA5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -324.1396015138956,
			"y": 3520.5365537786865,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 112.73623657226562,
			"height": 20,
			"seed": 459839766,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 139,
			"versionNonce": 88996773,
			"isDeleted": false,
			"id": "E_Hwqkj4jTvm_MnP-lNDg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -698.8590545509845,
			"y": 3701.5872132515774,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 368.5875713232217,
			"height": 156.58043443430097,
			"seed": 1676474826,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1689589835615,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "356e2Z7lUjN00hjnuinA-",
				"gap": 2.71828858785625,
				"focus": 0.574888112658659
			},
			"endBinding": {
				"elementId": "UZJTYUQdz3e0ruLVEFicA",
				"gap": 1,
				"focus": 0.29374469945930926
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
					-156.58043443430097
				]
			]
		},
		{
			"type": "arrow",
			"version": 245,
			"versionNonce": 1136213765,
			"isDeleted": false,
			"id": "10FCED_4qsLDyC9jfTu1S",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -332.59565147938997,
			"y": 3522.6175958415934,
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
			"updated": 1689589835615,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "UZJTYUQdz3e0ruLVEFicA",
				"gap": 3.3241682516271567,
				"focus": -0.5594581264614926
			},
			"endBinding": {
				"elementId": "Gzn0Btx2",
				"gap": 1.2364596986809602,
				"focus": -0.6288671413113079
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
			"version": 227,
			"versionNonce": 1489531589,
			"isDeleted": false,
			"id": "5d2D5HUQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 101.76975891515391,
			"y": 3315.113876357866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.057830810546875,
			"height": 16.142001299736243,
			"seed": 379011574,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 269,
			"versionNonce": 1279313931,
			"isDeleted": false,
			"id": "10awLCN4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 283.9432652999502,
			"y": 3315.113876357866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.929244995117188,
			"height": 16.142001299736243,
			"seed": 1055105194,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 243,
			"versionNonce": 722981413,
			"isDeleted": false,
			"id": "nR6RNCqp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 451.2705338610965,
			"y": 3315.113876357866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 49.14723205566406,
			"height": 16.142001299736243,
			"seed": 1684608246,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 267,
			"versionNonce": 279023275,
			"isDeleted": false,
			"id": "kQuwbtqJHGqGCnLLluAYh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 95.09672473319719,
			"y": 3393.875826134021,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 319,
			"versionNonce": 1862550917,
			"isDeleted": false,
			"id": "TSYvJrm9",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 100.60391925224016,
			"y": 3398.96969722348,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 91.98561096191406,
			"height": 15.812257821081223,
			"seed": 1392360234,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 275,
			"versionNonce": 644907339,
			"isDeleted": false,
			"id": "l3wsJ-a9ajQKgRvBMUNs3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 266.7980684182601,
			"y": 3393.875826134021,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 307,
			"versionNonce": 399199461,
			"isDeleted": false,
			"id": "bFK4QbB0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 271.9608644387679,
			"y": 3399.2067003487637,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 36.674407958984375,
			"height": 15.33825157051462,
			"seed": 1152965174,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 271,
			"versionNonce": 386408427,
			"isDeleted": false,
			"id": "TB2aliYDyt6VAkQ9W-1wU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 457.94414562139025,
			"y": 3393.875826134021,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 304,
			"versionNonce": 1425696837,
			"isDeleted": false,
			"id": "EeeeNCuu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 463.6926426306676,
			"y": 3399.340658636967,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.503005981445312,
			"height": 15.070334994107428,
			"seed": 1486600310,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 500,
			"versionNonce": 1551035019,
			"isDeleted": false,
			"id": "UUQSqJynxW5EjfZ_lASSd",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 218.00464078783642,
			"y": 3311.9293590462858,
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
			"updated": 1689582523426,
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
			"version": 378,
			"versionNonce": 141498277,
			"isDeleted": false,
			"id": "aY6bs7IIPJi8vdDaAfvBw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 385.9879289736995,
			"y": 3314.317747029971,
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
			"updated": 1689582523426,
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
			"version": 874,
			"versionNonce": 1893663173,
			"isDeleted": false,
			"id": "RD2IdSiknBlIi1cFFoGVs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 200.77384545428518,
			"y": 3408.2582099259807,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 63.347102242886905,
			"height": 0.7920452118028152,
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
			"updated": 1689589835618,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "kQuwbtqJHGqGCnLLluAYh",
				"gap": 2.677120721087988,
				"focus": 0.15096666475027803
			},
			"endBinding": {
				"elementId": "l3wsJ-a9ajQKgRvBMUNs3",
				"gap": 2.677120721087988,
				"focus": -0.019786572682303907
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
					63.347102242886905,
					-0.7920452118028152
				]
			]
		},
		{
			"type": "text",
			"version": 203,
			"versionNonce": 2086066949,
			"isDeleted": false,
			"id": "KzelzrFJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 278.8433775414012,
			"y": 3420.7914285381585,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 48.57611083984375,
			"height": 20,
			"seed": 1825563370,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 915,
			"versionNonce": 773340133,
			"isDeleted": false,
			"id": "hJItY2_Tp6sais0wQG57x",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 316.47518913934806,
			"y": 3408.260030330775,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 138.79183576095414,
			"height": 1.5864250880763393,
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
			"updated": 1689589835621,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "l3wsJ-a9ajQKgRvBMUNs3",
				"gap": 2.677120721087988,
				"focus": 0.12687196376473164
			},
			"endBinding": {
				"elementId": "TB2aliYDyt6VAkQ9W-1wU",
				"gap": 2.677120721088073,
				"focus": 0.0340462893633043
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
					138.79183576095414,
					-1.5864250880763393
				]
			]
		},
		{
			"type": "text",
			"version": 203,
			"versionNonce": 1496265317,
			"isDeleted": false,
			"id": "QPCeJSUf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 464.7962170447754,
			"y": 3420.2982249303086,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 57.47212219238281,
			"height": 20,
			"seed": 1303839414,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 329,
			"versionNonce": 2053067371,
			"isDeleted": false,
			"id": "zkSClAb3i4W-cD8Du3o8T",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 95.6491306051739,
			"y": 3467.0100169294515,
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
			"updated": 1689582523426,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 380,
			"versionNonce": 1539677637,
			"isDeleted": false,
			"id": "HgfqSqCa",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 101.15632512421686,
			"y": 3472.1038880189108,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 91.98561096191406,
			"height": 15.812257821081223,
			"seed": 204984042,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523426,
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
			"version": 753,
			"versionNonce": 1239109547,
			"isDeleted": false,
			"id": "8_uaNAPVAbYSvsqoMNnSW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 294.13955560023794,
			"y": 3420.875826134021,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 141.41751969979848,
			"height": 51.871657147072334,
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
			"updated": 1689589835619,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "l3wsJ-a9ajQKgRvBMUNs3",
				"gap": 1,
				"focus": -0.35339963301862776
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
					-14.036827236584879,
					29.580035966009785
				],
				[
					-126.29106246979161,
					24.803259998639316
				],
				[
					-141.41751969979848,
					51.871657147072334
				]
			]
		},
		{
			"type": "text",
			"version": 207,
			"versionNonce": 1261935909,
			"isDeleted": false,
			"id": "e4bjF9y4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 249.7217698301974,
			"y": 3470.6401143979406,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 81.74417114257812,
			"height": 20,
			"seed": 795573290,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 324,
			"versionNonce": 1534587819,
			"isDeleted": false,
			"id": "OTFfFmy5LuDi1CiZQjKMP",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 273.3214442494499,
			"y": 3467.0100169294515,
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
			"updated": 1689582523427,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 357,
			"versionNonce": 787656837,
			"isDeleted": false,
			"id": "8VoL2tpD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 278.4842402699577,
			"y": 3472.3408911441943,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 36.674407958984375,
			"height": 15.33825157051462,
			"seed": 134416694,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 1072,
			"versionNonce": 1435256485,
			"isDeleted": false,
			"id": "qw3SU5QS_ZPkXwzG2nUAd",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 485.1770644707816,
			"y": 3419.6920574765077,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 186.91863793161042,
			"height": 45.890261853529864,
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
			"updated": 1689589835625,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "OTFfFmy5LuDi1CiZQjKMP",
				"gap": 1.427697599413932,
				"focus": -0.3349636643770249
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
					-186.91863793161042,
					45.890261853529864
				]
			]
		},
		{
			"type": "text",
			"version": 223,
			"versionNonce": 1152669669,
			"isDeleted": false,
			"id": "SzQN6NCX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 438.57861652455165,
			"y": 3467.9887368730842,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 119.48826599121094,
			"height": 20,
			"seed": 879290026,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 331,
			"versionNonce": 1363756267,
			"isDeleted": false,
			"id": "4AQ_d_kVbUWEWP_oktEJk",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 454.562155042159,
			"y": 3467.0100169294515,
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
			"updated": 1689582523427,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 364,
			"versionNonce": 915018565,
			"isDeleted": false,
			"id": "7GOFzk7J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 460.31065205143636,
			"y": 3472.4748494323976,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.503005981445312,
			"height": 15.070334994107428,
			"seed": 63270250,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 522,
			"versionNonce": 369926501,
			"isDeleted": false,
			"id": "mt66qu0hBVB53mMu6gRRp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 319.1130654305122,
			"y": 3479.1165179042537,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 134.4490896116468,
			"height": 0.6988177104094575,
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
			"updated": 1689589835627,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "4AQ_d_kVbUWEWP_oktEJk",
				"gap": 1,
				"focus": 0.1294985272667542
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
					-0.6988177104094575
				]
			]
		},
		{
			"type": "text",
			"version": 206,
			"versionNonce": 282157733,
			"isDeleted": false,
			"id": "cD3r4g9O",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 465.7151255159587,
			"y": 3509.074874343326,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 57.47212219238281,
			"height": 20,
			"seed": 1615513834,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 761,
			"versionNonce": 737552901,
			"isDeleted": false,
			"id": "nPXhIT8ghuRbtiykwyW_R",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 201.53507077537705,
			"y": 3479.113630725489,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 70.51226619394276,
			"height": 0.7923256384942761,
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
			"updated": 1689589835625,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "zkSClAb3i4W-cD8Du3o8T",
				"gap": 2.8859401702031278,
				"focus": -0.021009175746965175
			},
			"endBinding": {
				"elementId": "OTFfFmy5LuDi1CiZQjKMP",
				"gap": 1.2741072801300675,
				"focus": 0.14830231681351055
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
					-0.7923256384942761
				]
			]
		},
		{
			"type": "text",
			"version": 204,
			"versionNonce": 2016921093,
			"isDeleted": false,
			"id": "MVGRMFVn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 284.22537103274203,
			"y": 3509.0748743433264,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 48.57611083984375,
			"height": 20,
			"seed": 532014506,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 225,
			"versionNonce": 479414475,
			"isDeleted": false,
			"id": "sNWadTjl",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 136.00332001464264,
			"y": 3538.0300881684902,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 10.608993530273438,
			"height": 16.142001299736243,
			"seed": 921934838,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 225,
			"versionNonce": 532331877,
			"isDeleted": false,
			"id": "3Xn4KC4e",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 303.19047887261047,
			"y": 3542.8068641358605,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 10.608993530273438,
			"height": 16.142001299736243,
			"seed": 1209751478,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 225,
			"versionNonce": 1550186347,
			"isDeleted": false,
			"id": "doVsCNVh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 444.10536991004057,
			"y": 3542.8068641358605,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 10.608993530273438,
			"height": 16.142001299736243,
			"seed": 1642572662,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 332,
			"versionNonce": 2124925125,
			"isDeleted": false,
			"id": "tuYYHMIwL0rCKAWSCEHVl",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 400.14768843676615,
			"y": 3656.1394888059335,
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
			"updated": 1689582523427,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 549,
			"versionNonce": 1999229451,
			"isDeleted": false,
			"id": "akCLXITe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 405.52837996508646,
			"y": 3661.462161492827,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 37.238616943359375,
			"height": 15.354654626213032,
			"seed": 1450414371,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 230,
			"versionNonce": 1184655397,
			"isDeleted": false,
			"id": "7h2dmONKSPiWd-buipLYz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 108.59980276571,
			"y": 3656.1394888059335,
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
			"updated": 1689582523427,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 290,
			"versionNonce": 1306089643,
			"isDeleted": false,
			"id": "3sxvoJ0A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 114.25564077840531,
			"y": 3661.275907441026,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 72.68832397460938,
			"height": 15.727162729815413,
			"seed": 2082122179,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 500,
			"versionNonce": 85649227,
			"isDeleted": false,
			"id": "7lAGucfDKWquQekel-snM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -63.698966746868905,
			"y": 3669.570099267557,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 168.3264410521139,
			"height": 2.6906930828986333,
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
			"updated": 1689589835632,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "7h2dmONKSPiWd-buipLYz",
				"gap": 3.9723284604650075,
				"focus": 0.21906723192752806
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
					168.3264410521139,
					-2.6906930828986333
				]
			]
		},
		{
			"type": "text",
			"version": 177,
			"versionNonce": 1042221899,
			"isDeleted": false,
			"id": "1xrR9tWe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 31.41940483740487,
			"y": 3742.586709255829,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 142.80030822753906,
			"height": 20,
			"seed": 1613441933,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 875,
			"versionNonce": 1064682987,
			"isDeleted": false,
			"id": "HmnQthZAACmeRNvy7rRNy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 193.61262034971315,
			"y": 3669.346304762905,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 203.287966234468,
			"height": 1.466623742433967,
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
			"updated": 1689589835632,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "7h2dmONKSPiWd-buipLYz",
				"gap": 1.0128175840031304,
				"focus": -0.0077802383358762115
			},
			"endBinding": {
				"elementId": "tuYYHMIwL0rCKAWSCEHVl",
				"gap": 3.24710185258499,
				"focus": -0.14195651893793068
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
					1.466623742433967
				]
			]
		},
		{
			"type": "text",
			"version": 216,
			"versionNonce": 206924267,
			"isDeleted": false,
			"id": "fjrYiMdP",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 225.5178925853504,
			"y": 3741.1962912473814,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 190.17642211914062,
			"height": 20,
			"seed": 1703460045,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 271,
			"versionNonce": 494845509,
			"isDeleted": false,
			"id": "DcbIUkWXocq2entYmOVNT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 667.0877003237722,
			"y": 3654.815379319112,
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
			"updated": 1689582523427,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 325,
			"versionNonce": 226948235,
			"isDeleted": false,
			"id": "hIiHdg2e",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 672.3619846865652,
			"y": 3660.076964764094,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 44.45143127441406,
			"height": 15.476829110035595,
			"seed": 767184323,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 859,
			"versionNonce": 876335243,
			"isDeleted": false,
			"id": "WmegkIDlfYAgKAQGydd3n",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 449.14768843676615,
			"y": 3667.674929799745,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 216.94001188700605,
			"height": 1.1548582472087219,
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
			"updated": 1689589835634,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "tuYYHMIwL0rCKAWSCEHVl",
				"gap": 1,
				"focus": -0.12169964754837109
			},
			"endBinding": {
				"elementId": "DcbIUkWXocq2entYmOVNT",
				"gap": 1,
				"focus": -0.08870308061034289
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
					216.94001188700605,
					1.1548582472087219
				]
			]
		},
		{
			"type": "text",
			"version": 206,
			"versionNonce": 292432683,
			"isDeleted": false,
			"id": "eKTjWpVI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 555.9883587675401,
			"y": 3744.227285863692,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 180.54440307617188,
			"height": 20,
			"seed": 318728419,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 375,
			"versionNonce": 608022789,
			"isDeleted": false,
			"id": "-fxIZW7kt5GqYdJkG68Xi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 426.2215433771468,
			"y": 3656.202660670402,
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
			"updated": 1689582523427,
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
			"version": 225,
			"versionNonce": 209030603,
			"isDeleted": false,
			"id": "WTBpdmfn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 532.5063633444397,
			"y": 3638.8186573564776,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 190.14442443847656,
			"height": 20,
			"seed": 1169668803,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 519,
			"versionNonce": 1238059109,
			"isDeleted": false,
			"id": "Fq3-WfdGvYkg8ylL18Rtc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 693.0296049717122,
			"y": 3676.359509931976,
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
			"updated": 1689582523427,
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
			"version": 259,
			"versionNonce": 28810347,
			"isDeleted": false,
			"id": "6mBBIv3t",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 518.3272192463871,
			"y": 3860.0078504610974,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 149.9102783203125,
			"height": 15.413487708645562,
			"seed": 1459135117,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 721,
			"versionNonce": 418545541,
			"isDeleted": false,
			"id": "Lsea2cBaVguQ6TJ6p1I7T",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 416.96094327722017,
			"y": 3654.8785511835813,
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
			"updated": 1689589835630,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "tuYYHMIwL0rCKAWSCEHVl",
				"gap": 1.2609376223526851,
				"focus": 0.05262219879054345
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
			"version": 260,
			"versionNonce": 754898699,
			"isDeleted": false,
			"id": "3H0iOVcC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 199.3768892238375,
			"y": 3646.6632104837254,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 117.42562866210938,
			"height": 15.413487708645556,
			"seed": 634651213,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 509,
			"versionNonce": 193306859,
			"isDeleted": false,
			"id": "UMZsKtkil3IrgHiWRzhvz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 317.07660882974204,
			"y": 3401.2743526893096,
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
			"updated": 1689589835622,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "l3wsJ-a9ajQKgRvBMUNs3",
				"gap": 3.27854041148197,
				"focus": 0.35016385313244813
			},
			"endBinding": {
				"elementId": "TB2aliYDyt6VAkQ9W-1wU",
				"gap": 2.3668372960593445,
				"focus": -0.19054597485170766
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
			"version": 120,
			"versionNonce": 1824898475,
			"isDeleted": false,
			"id": "bFbaoBsv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 435.17323523470543,
			"y": 3365.09754909463,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 119.48826599121094,
			"height": 20,
			"seed": 1623482115,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 517,
			"versionNonce": 395596651,
			"isDeleted": false,
			"id": "vC4PA04c0A-Yz9lfBSjU-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 321.71099203361786,
			"y": 3481.45603360546,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 131.85116300854122,
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
			"updated": 1689589835627,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "OTFfFmy5LuDi1CiZQjKMP",
				"gap": 1.3895477841679735,
				"focus": -0.5351022932199078
			},
			"endBinding": {
				"elementId": "4AQ_d_kVbUWEWP_oktEJk",
				"gap": 1,
				"focus": 0.3429090756245546
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
					131.85116300854122,
					1.148959015814853
				]
			]
		},
		{
			"type": "text",
			"version": 126,
			"versionNonce": 1815531595,
			"isDeleted": false,
			"id": "ZylNQp2B",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 426.15006389146174,
			"y": 3561.1464537341976,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 119.48826599121094,
			"height": 20,
			"seed": 1351819843,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 110,
			"versionNonce": 865431013,
			"isDeleted": false,
			"id": "UvnRMjRI739daXtcTImMJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -849.5131405342224,
			"y": 3879.406969798772,
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
			"updated": 1689582523427,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 130,
			"versionNonce": 221023979,
			"isDeleted": false,
			"id": "8hKZ5dqo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -834.6052425850037,
			"y": 3884.406969798772,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 107.1842041015625,
			"height": 20,
			"seed": 323960683,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 329,
			"versionNonce": 349727045,
			"isDeleted": false,
			"id": "Fu_9EAGqK9jbuXJOgPsuO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -253.59692152656237,
			"y": 4163.2846807899095,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 591.7975760161737,
			"height": 263.0211448960772,
			"seed": 1240279429,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 142,
			"versionNonce": 305232267,
			"isDeleted": false,
			"id": "TsNV1pQm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -676.8824366469521,
			"y": 4292.276324460705,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 56.144134521484375,
			"height": 20,
			"seed": 1784097317,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 145,
			"versionNonce": 2128935077,
			"isDeleted": false,
			"id": "UyH4KKEH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -676.8824366469521,
			"y": 4337.86649823916,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 77.00816345214844,
			"height": 20,
			"seed": 1745169355,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 605,
			"versionNonce": 1468643339,
			"isDeleted": false,
			"id": "c5GmHdcb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1186.2499889058113,
			"y": 3918.407728953297,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 515.1524658203125,
			"height": 200,
			"seed": 350465355,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689589838337,
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
			"version": 487,
			"versionNonce": 1265146885,
			"isDeleted": false,
			"id": "cxCokbfi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -558.5861562237208,
			"y": 3748.494301336601,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 657.5203857421875,
			"height": 80,
			"seed": 327354469,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "- VK_COMMAND_POOL_CREATE_TRANSIENT_BIT\n    支持动态command buffer(每帧都录制一个新的command buffer, 用完后free)\n- VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT\n    支持生命周期较长的command buffer, 录制一次重复使用, 且可以不释放, 从新录制内容.",
			"rawText": "- VK_COMMAND_POOL_CREATE_TRANSIENT_BIT\n    支持动态command buffer(每帧都录制一个新的command buffer, 用完后free)\n- VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT\n    支持生命周期较长的command buffer, 录制一次重复使用, 且可以不释放, 从新录制内容.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "- VK_COMMAND_POOL_CREATE_TRANSIENT_BIT\n    支持动态command buffer(每帧都录制一个新的command buffer, 用完后free)\n- VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT\n    支持生命周期较长的command buffer, 录制一次重复使用, 且可以不释放, 从新录制内容.",
			"lineHeight": 1.25,
			"baseline": 74
		},
		{
			"type": "text",
			"version": 122,
			"versionNonce": 1912787659,
			"isDeleted": false,
			"id": "ZAyYD5Xg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -561.5868681863742,
			"y": 3853.0154024669896,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132.65626525878906,
			"height": 20,
			"seed": 1011678795,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 83,
			"versionNonce": 1113641829,
			"isDeleted": false,
			"id": "J7Daqu5x",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -563.5997988064435,
			"y": 3724.1878427825495,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 285.8246154785156,
			"height": 20,
			"seed": 1398109995,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 2,
			"versionNonce": 794050923,
			"isDeleted": false,
			"id": "79O2u_Li3i1nYUSD_NhJT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -675.2851216701204,
			"y": 3813.7955819258086,
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
			"updated": 1689582523427,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 10,
			"versionNonce": 1343954629,
			"isDeleted": false,
			"id": "2ocLk6vr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -669.8491780666047,
			"y": 3818.7955819258086,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 52.12811279296875,
			"height": 20,
			"seed": 4573285,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523427,
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
			"version": 21,
			"versionNonce": 700374027,
			"isDeleted": false,
			"id": "Nf2d-E1v7TfvLN7e-Z2JZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -671.2592604299816,
			"y": 3945.642537540353,
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
			"updated": 1689582523427,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 59,
			"versionNonce": 2067070501,
			"isDeleted": false,
			"id": "ksyW1Q4i",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -665.8153059622082,
			"y": 3950.642537540353,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 42.112091064453125,
			"height": 20,
			"seed": 547377867,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523428,
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
			"version": 19,
			"versionNonce": 1027416747,
			"isDeleted": false,
			"id": "MbF9nmp7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -568.6321253566169,
			"y": 3936.5520231998667,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 253.3285369873047,
			"height": 20,
			"seed": 1135210059,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523428,
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
			"version": 142,
			"versionNonce": 446427525,
			"isDeleted": false,
			"id": "OJRlr9AS",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -557.5583456679733,
			"y": 3962.32072867067,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 365.287109375,
			"height": 28.84627899721783,
			"seed": 1669210213,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523428,
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
			"version": 120,
			"versionNonce": 1652135243,
			"isDeleted": false,
			"id": "TsRfTJHI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1082.2745544625502,
			"y": 20.476467208775375,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 193.1875,
			"height": 60.38445432518449,
			"seed": 808754219,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523428,
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
			"version": 164,
			"versionNonce": 1267562725,
			"isDeleted": false,
			"id": "WYhKRuk3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -707.620237809712,
			"y": 4001.753613079257,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 655.61669921875,
			"height": 40,
			"seed": 1314715717,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582523428,
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
			"version": 30,
			"versionNonce": 1401720549,
			"isDeleted": false,
			"id": "2BK6d-exocWMSGVkxkI5B",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -457.41865137003015,
			"y": 1596.2065769767241,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 44.52177348923334,
			"height": 6.360253355604982,
			"seed": 273088139,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582529662,
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
			"version": 22,
			"versionNonce": 327567365,
			"isDeleted": false,
			"id": "fQRr1J1FJrE2LY1hE8Mra",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -420.84719457530275,
			"y": 1584.2811019349651,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 11.925475041758887,
			"height": 12.72050671120951,
			"seed": 1685323243,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689582531021,
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
			"version": 217,
			"versionNonce": 1661490405,
			"isDeleted": false,
			"id": "ZOzWSc13",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -144.97120527594643,
			"y": 1616.082368712989,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 947.56982421875,
			"height": 60,
			"seed": 124400389,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689587296804,
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
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#1971c2",
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
		"scrollX": 1374.4876820812908,
		"scrollY": -3421.512333446444,
		"zoom": {
			"value": 1.2578115293080696
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