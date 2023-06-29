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

color/input... attachment reference ^kziOnwkc

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

一些特殊用法的标记 ^sOvTJZEV

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

VMA主要还是根据VmaAllocationCreateFlags
来选择memory type ^0005z0Cw


# Embedded files
a4d7f9b0a6abf8ba8c7940c3e6048d97538f9e28: [[rc/mobile_vk_memory.png]]

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
			"version": 359,
			"versionNonce": 1903865214,
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
			"updated": 1687916116869,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 343,
			"versionNonce": 2062512482,
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
			"updated": 1687916116870,
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
			"version": 858,
			"versionNonce": 50613694,
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
			"updated": 1687916116870,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 853,
			"versionNonce": 1484715298,
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
			"updated": 1687916116870,
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
			"version": 731,
			"versionNonce": 720365054,
			"isDeleted": false,
			"id": "oDhN1X9Nuh_9DXCmvqfFK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -833.6858389056798,
			"y": 445.2702773093898,
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
			"updated": 1687916116870,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 647,
			"versionNonce": 686293218,
			"isDeleted": false,
			"id": "VTcADaop",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -801.345796791422,
			"y": 456.2702773093898,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 68.31991577148438,
			"height": 25,
			"seed": 1555018187,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116870,
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
			"version": 1075,
			"versionNonce": 1928986194,
			"isDeleted": false,
			"id": "QmXFFWBgjIDxGjrZ0i2BY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -841.3902826035657,
			"y": 2616.7357265479936,
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
			"updated": 1688004268642,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 1023,
			"versionNonce": 1349076942,
			"isDeleted": false,
			"id": "sOf7Qxs6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -794.8502664292492,
			"y": 2630.2357265479936,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 40.91996765136719,
			"height": 25,
			"seed": 439093061,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004268642,
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
			"version": 724,
			"versionNonce": 969997950,
			"isDeleted": false,
			"id": "ug1bFnxXMH5RZHtenX_vz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -816.6858389056798,
			"y": 1117.4118949140818,
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
			"updated": 1687916116870,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 676,
			"versionNonce": 1185067106,
			"isDeleted": false,
			"id": "9FhasIQH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -793.975809303629,
			"y": 1126.9118949140818,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 53.57994079589844,
			"height": 25,
			"seed": 160057163,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116870,
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
			"version": 399,
			"versionNonce": 1852341950,
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
			"updated": 1687916116870,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 358,
			"versionNonce": 1769100322,
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
			"updated": 1687916116871,
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
			"version": 598,
			"versionNonce": 1554380542,
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
			"updated": 1687916116871,
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
			"version": 369,
			"versionNonce": 571965410,
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
			"updated": 1687916116871,
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
			"version": 567,
			"versionNonce": 1292527422,
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
			"updated": 1687916116871,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 503,
			"versionNonce": 748762018,
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
			"updated": 1687916116871,
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
			"version": 421,
			"versionNonce": 1341575038,
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
			"updated": 1687916116871,
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
			"version": 634,
			"versionNonce": 1799253858,
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
			"updated": 1687916116871,
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
			"version": 1340,
			"versionNonce": 1101803454,
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
			"updated": 1687916116871,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 927,
			"versionNonce": 574501666,
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
			"updated": 1687916116871,
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
			"version": 912,
			"versionNonce": 1313572862,
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
			"updated": 1687916116871,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 539,
			"versionNonce": 873430754,
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
			"updated": 1687916116872,
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
			"version": 222,
			"versionNonce": 1976948798,
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
			"updated": 1687916116872,
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
			"version": 304,
			"versionNonce": 1564562082,
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
			"updated": 1687916116872,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 263,
			"versionNonce": 271327358,
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
			"updated": 1687916116872,
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
			"version": 180,
			"versionNonce": 1887612514,
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
			"updated": 1687916116872,
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
			"version": 57,
			"versionNonce": 1359962302,
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
			"updated": 1687916116872,
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
			"version": 81,
			"versionNonce": 312644130,
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
			"updated": 1687916116872,
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
			"version": 64,
			"versionNonce": 1277204734,
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
			"updated": 1687916116872,
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
			"version": 110,
			"versionNonce": 1989148130,
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
			"updated": 1687916116872,
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
			"version": 320,
			"versionNonce": 2027997502,
			"isDeleted": false,
			"id": "b1lmDQYkX5FjOao0zZIVR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -519.4036341688025,
			"y": 240.90106262003832,
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
			"updated": 1687916116872,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 292,
			"versionNonce": 425324962,
			"isDeleted": false,
			"id": "p4bugCjR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -510.25353346079464,
			"y": 259.4010626200383,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 157.69979858398438,
			"height": 25,
			"seed": 1157736243,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116872,
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
			"version": 462,
			"versionNonce": 917565822,
			"isDeleted": false,
			"id": "9bONTo82v2PJ_VnFKS-w-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -527.0907148680361,
			"y": 560.2437975353309,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 464,
			"versionNonce": 2117037410,
			"isDeleted": false,
			"id": "Y2s3t9U2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -516.6106199583681,
			"y": 578.7437975353309,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 155.03981018066406,
			"height": 25,
			"seed": 934963293,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 109,
			"versionNonce": 1355944382,
			"isDeleted": false,
			"id": "ChAZZmL0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 957.6111717045505,
			"y": 204.23255338103786,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 264.59307861328125,
			"height": 25,
			"seed": 1004614941,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 129,
			"versionNonce": 1784639778,
			"isDeleted": false,
			"id": "CUG15VR4Cn1eWqlutgOO7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 632.2778383712168,
			"y": 201.23255338103786,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 114,
			"versionNonce": 40184318,
			"isDeleted": false,
			"id": "Ez8sDNeo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 673.9979158858653,
			"y": 234.73255338103786,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 132.55984497070312,
			"height": 25,
			"seed": 1177136083,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 146,
			"versionNonce": 559480034,
			"isDeleted": false,
			"id": "Mk5vIOvi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 968.2778383712166,
			"y": 258.8992200477044,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 400.752685546875,
			"height": 25,
			"seed": 915486397,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 68,
			"versionNonce": 2053847614,
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
			"updated": 1687916116873,
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
			"version": 445,
			"versionNonce": 548081826,
			"isDeleted": false,
			"id": "EsoRN7ez",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1133.07307616187,
			"y": -102.59017939932176,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 348.69281005859375,
			"height": 25,
			"seed": 470365917,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 173,
			"versionNonce": 1606763134,
			"isDeleted": false,
			"id": "0O1xdIGNq3fa0x2fV2yBc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1754.4127880649294,
			"y": -95.68466106714766,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 421,
			"height": 172,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 224,
			"versionNonce": 1543810146,
			"isDeleted": false,
			"id": "ARdgx1Yi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1707.5093151645387,
			"y": -22.18466106714766,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 327.19305419921875,
			"height": 25,
			"seed": 44515187,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 203,
			"versionNonce": 1429488318,
			"isDeleted": false,
			"id": "ysk_8VVB6QndbLThPjmFR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -172.65592242372804,
			"y": -9.298376155083133,
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
				}
			],
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 165,
			"versionNonce": 2033504290,
			"isDeleted": false,
			"id": "I3eSwx7J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -152.4958500970679,
			"y": 0.7016238449168668,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 119.67985534667969,
			"height": 25,
			"seed": 350032432,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 1252,
			"versionNonce": 2102999806,
			"isDeleted": false,
			"id": "BG0r7nN6iTBqMyiIh4Tuy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -176.14124158941058,
			"y": 74.11642687949495,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 1381,
			"versionNonce": 204110818,
			"isDeleted": false,
			"id": "TUqsVMtw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -171.14124158941058,
			"y": 79.11642687949495,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 556.879638671875,
			"height": 125,
			"seed": 1915653168,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 257,
			"versionNonce": 2125802302,
			"isDeleted": false,
			"id": "HqMsZjgtVTcZlnGxskMQC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -502.3274264763481,
			"y": 901.3909035384103,
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
					"id": "6hizYjAMSH8qf19HVq8IB",
					"type": "arrow"
				}
			],
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 202,
			"versionNonce": 1391767458,
			"isDeleted": false,
			"id": "VUAZ78FG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -456.75739626394574,
			"y": 919.3909035384103,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 57.85993957519531,
			"height": 25,
			"seed": 810781904,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 304,
			"versionNonce": 128521086,
			"isDeleted": false,
			"id": "ecoGQyUOPjZitOISe84Rq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -511.4065877989685,
			"y": 1281.7338636566342,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 267,
			"versionNonce": 1908566882,
			"isDeleted": false,
			"id": "9amyTdkp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -465.84655209340207,
			"y": 1299.7338636566342,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 64.87992858886719,
			"height": 25,
			"seed": 428170800,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 631,
			"versionNonce": 1383461822,
			"isDeleted": false,
			"id": "xZITBcKMISab2S6sSJXZB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -325.51031945431635,
			"y": 1054.1395366377576,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 644,
			"versionNonce": 786607906,
			"isDeleted": false,
			"id": "7lRVwubC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -310.1983687707226,
			"y": 1061.6395366377576,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 49.3760986328125,
			"height": 20,
			"seed": 1139334864,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 500,
			"versionNonce": 691850238,
			"isDeleted": false,
			"id": "7N4WVheJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -190.61894687942566,
			"y": 1030.0193150374807,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 532.4652099609375,
			"height": 80,
			"seed": 133468720,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 379,
			"versionNonce": 784628450,
			"isDeleted": false,
			"id": "1s0h_LZGw9uFdnBWx4wMj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 117.74143739492638,
			"y": -12.798376155083133,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 373,
			"versionNonce": 1778293822,
			"isDeleted": false,
			"id": "Fp9OCP7y",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 128.66156526357872,
			"y": 0.7016238449168668,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 242.1597442626953,
			"height": 25,
			"seed": 1486728529,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 226,
			"versionNonce": 804703906,
			"isDeleted": false,
			"id": "ttZCYIlzn9L6J0XKtzqKs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 449.97405091480493,
			"y": 67.71539028507561,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 229,
			"versionNonce": 178021502,
			"isDeleted": false,
			"id": "zu3TMxtZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 455.25415650562525,
			"y": 72.71539028507561,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 206.43978881835938,
			"height": 25,
			"seed": 846029937,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 556,
			"versionNonce": 1193847394,
			"isDeleted": false,
			"id": "0ba52DQEEdMgc6ohb6DRn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 442.2203316311874,
			"y": -163.92697331299797,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 691,
			"versionNonce": 483861694,
			"isDeleted": false,
			"id": "YNSRZZiO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 452.3804497342147,
			"y": -158.92697331299797,
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
			"updated": 1687916116873,
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
			"version": 129,
			"versionNonce": 455675426,
			"isDeleted": false,
			"id": "eUdKzPG74aACuTDmS_sOR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 735.6585645454921,
			"y": -206.57242937289453,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 209,
			"versionNonce": 1380965630,
			"isDeleted": false,
			"id": "u9zqe9px",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 767.9087018745937,
			"y": -190.07242937289453,
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
			"updated": 1687916116873,
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
			"version": 228,
			"versionNonce": 552008162,
			"isDeleted": false,
			"id": "WwrjnYfvT8jZVpvlXvx6A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 446.01242327019133,
			"y": -30.69614095959659,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 268,
			"versionNonce": 8883518,
			"isDeleted": false,
			"id": "UtTZtJFf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 451.4825389318124,
			"y": -25.69614095959659,
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
			"updated": 1687916116873,
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
			"version": 51,
			"versionNonce": 1467051426,
			"isDeleted": false,
			"id": "j_kWCgzDhFuxHkQxKuN-E",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 732.2208557406636,
			"y": -43.19614095959659,
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
				},
				{
					"id": "6hizYjAMSH8qf19HVq8IB",
					"type": "arrow"
				}
			],
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 189,
			"versionNonce": 618607998,
			"isDeleted": false,
			"id": "kziOnwkc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 759.1309967318746,
			"y": -38.19614095959659,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 252.17971801757812,
			"height": 50,
			"seed": 2124624209,
			"groupIds": [
				"Xq3-MNxKBqi7GRIetHA2F"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "color/input... attachment \nreference",
			"rawText": "color/input... attachment reference",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "j_kWCgzDhFuxHkQxKuN-E",
			"originalText": "color/input... attachment reference",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "arrow",
			"version": 206,
			"versionNonce": 775217742,
			"isDeleted": false,
			"id": "mhUP4-Dlja3Wehs6M2VuT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 443.7424856412997,
			"y": -126.94288126807538,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 60.11188852161354,
			"height": 136.6122367928943,
			"seed": 2096431441,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688004045925,
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
				"focus": 0.9225770858144929
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
					-60.11188852161354,
					136.6122367928943
				]
			]
		},
		{
			"type": "arrow",
			"version": 118,
			"versionNonce": 1782540430,
			"isDeleted": false,
			"id": "bB8CUXU_h3TBNTMv0Qt0s",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 444.2703028984288,
			"y": -2.024048377090889,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 55.20286589437251,
			"height": 15.905849525888256,
			"seed": 658085457,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688004045926,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "WwrjnYfvT8jZVpvlXvx6A",
				"gap": 1.742120371762553,
				"focus": 0.42058859738743315
			},
			"endBinding": {
				"elementId": "1s0h_LZGw9uFdnBWx4wMj",
				"gap": 7.3259996091298945,
				"focus": 0.6375513124139465
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
					15.905849525888256
				]
			]
		},
		{
			"type": "arrow",
			"version": 97,
			"versionNonce": 404454862,
			"isDeleted": false,
			"id": "ajpUmjrIxEUM2AmiFo7gc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 450.12797636254436,
			"y": 82.40753938959779,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 67.38653896761798,
			"height": 76.36507335011963,
			"seed": 218804415,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688004045924,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "1s0h_LZGw9uFdnBWx4wMj",
				"gap": 1,
				"focus": -0.8991523072472101
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
					-76.36507335011963
				]
			]
		},
		{
			"type": "rectangle",
			"version": 162,
			"versionNonce": 617770494,
			"isDeleted": false,
			"id": "6YpzTBoQlLAyCtxx_l8X0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -177.04468243854444,
			"y": 368.1572964494833,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 176,
			"versionNonce": 441579746,
			"isDeleted": false,
			"id": "yy8MByKT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -171.72459882038038,
			"y": 373.1572964494833,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 137.35983276367188,
			"height": 25,
			"seed": 1394410454,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 209,
			"versionNonce": 1720712766,
			"isDeleted": false,
			"id": "L-B8q6fiAtFK8i5TaExux",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 33.481633350929314,
			"y": 282.06313490667026,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 256,
			"versionNonce": 153390242,
			"isDeleted": false,
			"id": "0ihgLmtf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 38.751713917335564,
			"y": 287.06313490667026,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 131.4598388671875,
			"height": 25,
			"seed": 1859981898,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 182,
			"versionNonce": 168491342,
			"isDeleted": false,
			"id": "IaWKs7jQyGFdW4rRfbPqi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -340.72598064138595,
			"y": 267.37876082208373,
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
			"updated": 1688004045921,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "b1lmDQYkX5FjOao0zZIVR",
				"gap": 2.67765352741651,
				"focus": 0.8039330752064561
			},
			"endBinding": {
				"elementId": "ysk_8VVB6QndbLThPjmFR",
				"gap": 1.180365903120446,
				"focus": 0.7981777152085677
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
			"version": 51,
			"versionNonce": 1877911650,
			"isDeleted": false,
			"id": "3dsmJS2e",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -326.5010517814805,
			"y": 119.71201546784908,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 138.43983459472656,
			"height": 50,
			"seed": 570630614,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116873,
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
			"version": 99,
			"versionNonce": 1240991422,
			"isDeleted": false,
			"id": "eCLhDJMIlbe_Yj2oJuoVu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -325.51031945431635,
			"y": 779.8146857715815,
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
			"updated": 1687916116873,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 153,
			"versionNonce": 1988054050,
			"isDeleted": false,
			"id": "c41DXZmE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -311.03439782345697,
			"y": 787.3146857715815,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 72.04815673828125,
			"height": 20,
			"seed": 1927307414,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 181,
			"versionNonce": 755269374,
			"isDeleted": false,
			"id": "O8vlGOcFctOyoto2jQ2qz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -325.51031945431635,
			"y": 992.14879767311,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 210,
			"versionNonce": 1925543906,
			"isDeleted": false,
			"id": "byfhFh2T",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -314.6183669396679,
			"y": 999.64879767311,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 45.216094970703125,
			"height": 20,
			"seed": 1060645066,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 70,
			"versionNonce": 542633790,
			"isDeleted": false,
			"id": "uQBQahjhvqVdD7BaHb25E",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -325.51031945431635,
			"y": 882.9139978856969,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 227,
			"versionNonce": 617622434,
			"isDeleted": false,
			"id": "m6n2RStp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -313.02238152707025,
			"y": 890.4139978856969,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 59.02412414550781,
			"height": 20,
			"seed": 619124630,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 176,
			"versionNonce": 1884510078,
			"isDeleted": false,
			"id": "ElS3lvy_dTWzOhUGqNWuv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -322.9888358711843,
			"y": 829.2775613342222,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 223,
			"versionNonce": 1926129506,
			"isDeleted": false,
			"id": "wDKOcw0Z",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -306.23692852255147,
			"y": 836.7775613342222,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 92.49618530273438,
			"height": 20,
			"seed": 946502998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 44,
			"versionNonce": 892843966,
			"isDeleted": false,
			"id": "qgh--5WsTvopN_2M3WfLD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 32.40981584052247,
			"y": 334.93172892899406,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 161,
			"versionNonce": 621751074,
			"isDeleted": false,
			"id": "2ADXoXmG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 37.529902510444344,
			"y": 339.93172892899406,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 146.75982666015625,
			"height": 25,
			"seed": 984016650,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 33,
			"versionNonce": 1462112254,
			"isDeleted": false,
			"id": "gSsz97ctHKWn5pR5OLPHN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 28.149836592475367,
			"y": 387.80032295131787,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 205,
			"versionNonce": 570521314,
			"isDeleted": false,
			"id": "12zTYOXn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 33.14983659247537,
			"y": 392.80032295131787,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 195.27978515625,
			"height": 175,
			"seed": 1840151882,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 65,
			"versionNonce": 1314097934,
			"isDeleted": false,
			"id": "yOwd51MsUt1B1mBc6KVDI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -338.68395503992565,
			"y": 271.74769137237047,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 162.10526315789468,
			"height": 108.42105263157896,
			"seed": 1044136010,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688004045919,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "b1lmDQYkX5FjOao0zZIVR",
				"gap": 4.719679128876805,
				"focus": -0.6918446395732881
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
					108.42105263157896
				]
			]
		},
		{
			"type": "arrow",
			"version": 118,
			"versionNonce": 1235252818,
			"isDeleted": false,
			"id": "waxHs5jN13K71_JVsrL9d",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -27.105007671504723,
			"y": 387.537165056581,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 59.58664102243402,
			"height": 82.5849936977595,
			"seed": 1544695370,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688004045927,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "6YpzTBoQlLAyCtxx_l8X0",
				"gap": 1.939674767039719,
				"focus": 0.8922900295463881
			},
			"endBinding": {
				"elementId": "L-B8q6fiAtFK8i5TaExux",
				"gap": 1,
				"focus": 0.8144743695190155
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
					59.58664102243402,
					-82.5849936977595
				]
			]
		},
		{
			"type": "arrow",
			"version": 134,
			"versionNonce": 1721883666,
			"isDeleted": false,
			"id": "QQkCkMj0ytdOxkdjAaOdh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -27.10500767150471,
			"y": 383.3266387407915,
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
			"updated": 1688004045932,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "6YpzTBoQlLAyCtxx_l8X0",
				"gap": 1.939674767039719,
				"focus": 0.6879513434729471
			},
			"endBinding": {
				"elementId": "qgh--5WsTvopN_2M3WfLD",
				"gap": 2.6727182488692733,
				"focus": 0.7725719695236883
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
			"version": 150,
			"versionNonce": 177419342,
			"isDeleted": false,
			"id": "b_JG3sKm_2v_JgA5yJS5_",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -28.04468243854445,
			"y": 383.3735264740362,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 55.194519031019816,
			"height": 22.910932427970465,
			"seed": 386980106,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688004045932,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "6YpzTBoQlLAyCtxx_l8X0",
				"gap": 1,
				"focus": -0.6930306432004285
			},
			"endBinding": {
				"elementId": "gSsz97ctHKWn5pR5OLPHN",
				"gap": 1,
				"focus": 0.22805897950945067
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
					55.194519031019816,
					22.910932427970465
				]
			]
		},
		{
			"type": "arrow",
			"version": 267,
			"versionNonce": 839329294,
			"isDeleted": false,
			"id": "WxrfV_zM8Y84tUZviqbl8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 175.00025548638985,
			"y": 298.06348084605463,
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
			"updated": 1688004045932,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "qgh--5WsTvopN_2M3WfLD",
				"gap": 5.590439645867377,
				"focus": 0.25546228088018547
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
			"type": "arrow",
			"version": 1052,
			"versionNonce": 1781772114,
			"isDeleted": false,
			"id": "6hizYjAMSH8qf19HVq8IB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1042.1570474977104,
			"y": -18.712692192892973,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 2007.3034068718844,
			"height": 1177.3796784004885,
			"seed": 2099011429,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688004045926,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "j_kWCgzDhFuxHkQxKuN-E",
				"gap": 3.9361917570467995,
				"focus": -0.6942853598907514
			},
			"endBinding": {
				"elementId": "HqMsZjgtVTcZlnGxskMQC",
				"gap": 4.785669092906801,
				"focus": 0.43393148999491965
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
					529.6517593658127,
					159.92797814999966
				],
				[
					456.19455715181675,
					1001.5014328258056
				],
				[
					-1263.4961156833756,
					1177.3796784004885
				],
				[
					-1477.6516475060716,
					985.88926482421
				]
			]
		},
		{
			"type": "rectangle",
			"version": 64,
			"versionNonce": 1870078206,
			"isDeleted": false,
			"id": "ao1bg9q4THmLUQFjyVe78",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -325.51031945431635,
			"y": 726.7847182964406,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 83,
			"versionNonce": 1069938146,
			"isDeleted": false,
			"id": "riC9Kydi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -313.6903807946484,
			"y": 734.2847182964406,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 53.36012268066406,
			"height": 20,
			"seed": 895385861,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 57,
			"versionNonce": 2511166,
			"isDeleted": false,
			"id": "WUtwD51iGOgdSZ187zS8V",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -325.51031945431635,
			"y": 937.9082327464237,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 67,
			"versionNonce": 957409698,
			"isDeleted": false,
			"id": "c3oUdLzr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -315.88236687863275,
			"y": 945.4082327464237,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 35.74409484863281,
			"height": 20,
			"seed": 1359726923,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 149,
			"versionNonce": 1275427198,
			"isDeleted": false,
			"id": "794f0xqB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -233.48253694044382,
			"y": 935.6409527184885,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 251.53651428222656,
			"height": 40,
			"seed": 1995247371,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 120,
			"versionNonce": 2085053794,
			"isDeleted": false,
			"id": "IN7mYDad",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 532.0166244701103,
			"y": 968.4709504468336,
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
			"updated": 1687916116874,
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
			"version": 208,
			"versionNonce": 1515559358,
			"isDeleted": false,
			"id": "KZU8eWD6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 532.0166244701103,
			"y": 930.8967242905136,
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
			"updated": 1687916116874,
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
			"version": 204,
			"versionNonce": 1387817250,
			"isDeleted": false,
			"id": "ibud4hes",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 532.0166244701103,
			"y": 1003.8946628219728,
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
			"updated": 1687916116874,
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
			"version": 54,
			"versionNonce": 574075390,
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
			"updated": 1687916116874,
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
			"version": 109,
			"versionNonce": 64156898,
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
			"updated": 1687916116874,
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
			"version": 100,
			"versionNonce": 246202942,
			"isDeleted": false,
			"id": "sAR1D_X4TFmBgPGLEgjH5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -325.51031945431635,
			"y": 677.6229636729354,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 124,
			"versionNonce": 287705250,
			"isDeleted": false,
			"id": "2CrXkzGL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -306.6903655358593,
			"y": 685.1229636729354,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 1923811761,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 84,
			"versionNonce": 43371134,
			"isDeleted": false,
			"id": "sOvTJZEV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -214.08413249899309,
			"y": 684.8101695580411,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 144,
			"height": 20,
			"seed": 1814104319,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "一些特殊用法的标记",
			"rawText": "一些特殊用法的标记",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "一些特殊用法的标记",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 73,
			"versionNonce": 290979090,
			"isDeleted": false,
			"id": "k6390vwFDWTradiZjq2z2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -309.68939507984925,
			"y": 1260.5252982401166,
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
			"updated": 1688003443848,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 94,
			"versionNonce": 1308595470,
			"isDeleted": false,
			"id": "0cdaV3Q5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -304.3694411613922,
			"y": 1265.5252982401166,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 1406860721,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688003443848,
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
			"version": 73,
			"versionNonce": 1364314146,
			"isDeleted": false,
			"id": "tmgdqgy11iBeOJFKX31vp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -309.68939507984925,
			"y": 1299.314444602758,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 79,
			"versionNonce": 2074591998,
			"isDeleted": false,
			"id": "jH0TkeeA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -304.237429747818,
			"y": 1304.314444602758,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 30.0960693359375,
			"height": 20,
			"seed": 817665087,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 73,
			"versionNonce": 1172861922,
			"isDeleted": false,
			"id": "_BBs0LjYWc_WR2f5WVY08",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -309.68939507984925,
			"y": 1339.828992911271,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 86,
			"versionNonce": 1106424638,
			"isDeleted": false,
			"id": "nvUxvbi3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -304.2974425652008,
			"y": 1344.828992911271,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 45.216094970703125,
			"height": 20,
			"seed": 390984849,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 166,
			"versionNonce": 305375138,
			"isDeleted": false,
			"id": "83NxTTwftLloXWhlzMkFT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -325.51031945431635,
			"y": 1111.47426608147,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 170,
			"versionNonce": 435526526,
			"isDeleted": false,
			"id": "VwFYpY6i",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -320.06642602169916,
			"y": 1116.47426608147,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 92.11221313476562,
			"height": 20,
			"seed": 1846214111,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116874,
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
			"version": 187,
			"versionNonce": 1583506274,
			"isDeleted": false,
			"id": "kA_4DAq0ofI8jJZyGRWXu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -825.3511726714248,
			"y": 1677.6018982064531,
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
			"updated": 1687916116874,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 169,
			"versionNonce": 2045868990,
			"isDeleted": false,
			"id": "tRqPAOgm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -813.3411400176162,
			"y": 1694.1018982064531,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 67.97993469238281,
			"height": 25,
			"seed": 1553808194,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 215,
			"versionNonce": 1958979362,
			"isDeleted": false,
			"id": "GCmHOzBaYfyQhbFQcXvDM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -511.47777349890566,
			"y": 1543.3528210934396,
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
			"updated": 1687916116875,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 238,
			"versionNonce": 1745310718,
			"isDeleted": false,
			"id": "cCBNxDxs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -498.0477045291791,
			"y": 1561.8528210934396,
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
			"updated": 1687916116875,
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
			"version": 205,
			"versionNonce": 2110157538,
			"isDeleted": false,
			"id": "1OyCXAVz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -511.47777349890566,
			"y": 1613.9793164791129,
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
			"updated": 1687916116875,
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
			"version": 229,
			"versionNonce": 2117608510,
			"isDeleted": false,
			"id": "pizIAgCn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -898.5431070709674,
			"y": 1751.0244255297678,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 300.91241455078125,
			"height": 140,
			"seed": 1168612674,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 381,
			"versionNonce": 8391698,
			"isDeleted": false,
			"id": "wEBmOGbWNalYO80OrC1tu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -507.68756170356494,
			"y": 1794.7909468000769,
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
			"updated": 1688003254775,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 402,
			"versionNonce": 1348728334,
			"isDeleted": false,
			"id": "Ik7txvTl",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -490.8074957855962,
			"y": 1812.7909468000769,
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
			"updated": 1688003254775,
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
			"version": 121,
			"versionNonce": 1351137746,
			"isDeleted": false,
			"id": "7TYLK4Cw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -507.68756170356494,
			"y": 1870.2413641472328,
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
			"updated": 1688003254775,
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
			"version": 14,
			"versionNonce": 1691747406,
			"isDeleted": false,
			"id": "IqHKcMMCGVQ8tCgItJI8M",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -308.07790723566416,
			"y": 1774.8512947207178,
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
			"updated": 1688003254775,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 129,
			"versionNonce": 2125836178,
			"isDeleted": false,
			"id": "ndrTjBwt",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -302.7059895110548,
			"y": 1779.8512947207178,
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
			"updated": 1688003254775,
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
			"version": 25,
			"versionNonce": 879512206,
			"isDeleted": false,
			"id": "GA9Zq0W8w6TfuNy2uRHBq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -308.07790723566416,
			"y": 1820.4007663700734,
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
			"updated": 1688003254775,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 123,
			"versionNonce": 1038076110,
			"isDeleted": false,
			"id": "BPxOaXvg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -302.8100239348829,
			"y": 1825.4007663700734,
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
			"updated": 1688003254775,
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
			"version": 215,
			"versionNonce": 1735947026,
			"isDeleted": false,
			"id": "nYtDfCc6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -132.80824157176346,
			"y": 1742.7142894524595,
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
			"updated": 1688003254775,
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
			"version": 465,
			"versionNonce": 184777358,
			"isDeleted": false,
			"id": "Rvf69EXBrnmHcD_okizP1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -191.66689143088956,
			"y": 1834.8515855153817,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 54.654460583474076,
			"height": 22.10520795813136,
			"seed": 1294686530,
			"groupIds": [
				"8fy8w75ItUHWQU_wDN3hT"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688004045942,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "GA9Zq0W8w6TfuNy2uRHBq",
				"gap": 1.4110158047745927,
				"focus": 0.608467902344956
			},
			"endBinding": {
				"elementId": "nYtDfCc6",
				"gap": 4.20418927565197,
				"focus": 0.698684047103574
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
					54.654460583474076,
					-22.10520795813136
				]
			]
		},
		{
			"type": "rectangle",
			"version": 11,
			"versionNonce": 1008975230,
			"isDeleted": false,
			"id": "B2eBRZea8hMueLG3XZ2_5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -316.1520114275363,
			"y": 1532.690577905212,
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
			"updated": 1687916116875,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 17,
			"versionNonce": 1461674338,
			"isDeleted": false,
			"id": "fQJeZaem",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -310.70004609550506,
			"y": 1537.690577905212,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 30.0960693359375,
			"height": 20,
			"seed": 248263902,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 11,
			"versionNonce": 906714558,
			"isDeleted": false,
			"id": "6-rRDmhJJLQhYB5BwJtn0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -316.1520114275363,
			"y": 1576.6998158893655,
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
			"updated": 1687916116875,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 24,
			"versionNonce": 154199330,
			"isDeleted": false,
			"id": "jOMQsCZy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -310.8320575090793,
			"y": 1581.6998158893655,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 39.36009216308594,
			"height": 20,
			"seed": 838063582,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 116,
			"versionNonce": 177534462,
			"isDeleted": false,
			"id": "FJEExEwu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -203.02988039836146,
			"y": 1574.562890231149,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 440.99273681640625,
			"height": 40,
			"seed": 1473862466,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 158,
			"versionNonce": 1306259682,
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
			"updated": 1687916116875,
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
			"version": 555,
			"versionNonce": 46237246,
			"isDeleted": false,
			"id": "r4nGhhI6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 733.3436283727491,
			"y": 1553.8222170857746,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 850.8507080078125,
			"height": 103.49026896400659,
			"seed": 1071444098,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 70,
			"versionNonce": 682591394,
			"isDeleted": false,
			"id": "AnYY4Djk0lu7T2SLOP3f-",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 783.3705184639027,
			"y": 1599.154954058906,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 66.27050512845949,
			"height": 1.7672134700922015,
			"seed": 1485999998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 81,
			"versionNonce": 527568510,
			"isDeleted": false,
			"id": "7UwMfAjbJBUEsmyU7PE1a",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 736.0975581389349,
			"y": 1652.1713581616737,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 22.0901683761532,
			"height": 56.55083104295227,
			"seed": 1557254142,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 96,
			"versionNonce": 1398448226,
			"isDeleted": false,
			"id": "QlrTGdCLIbzOQmfrhsqOD",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 739.4471626802485,
			"y": 1665.8893282873134,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 254.28772232362564,
			"height": 239.93989076890716,
			"seed": 1084720482,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916116875,
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
			"version": 446,
			"versionNonce": 1514836606,
			"isDeleted": false,
			"id": "vKKqy9QE",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1016.2519379720861,
			"y": 1665.7822878276954,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 896.4277954101562,
			"height": 243.23285710183524,
			"seed": 1210480930,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687916730644,
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
			"version": 22,
			"versionNonce": 278320766,
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
			"updated": 1687916899974,
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
			"version": 208,
			"versionNonce": 933169938,
			"isDeleted": false,
			"id": "uPsaHVGO",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -7.179594536166178,
			"y": 1237.7949714630513,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 697.9522705078125,
			"height": 80,
			"seed": 1896589970,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687999627502,
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
			"version": 1,
			"versionNonce": 0,
			"isDeleted": false,
			"id": "4q3O7ZHLK736VZazPMe0w",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -4.432888773027571,
			"y": 1355.5841745570715,
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
			"updated": 1688000231050,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 314,
			"versionNonce": 987524690,
			"isDeleted": false,
			"id": "3DabKuFR",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 0.567111226972429,
			"y": 1360.5841745570715,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 909.7930908203125,
			"height": 100,
			"seed": 1247312782,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688000270674,
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
			"version": 207,
			"versionNonce": 1773763666,
			"isDeleted": false,
			"id": "5eLs6CsG_g4TiTDLzLd0t",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 541.2405048741621,
			"y": 1735.5079591678634,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 63.4748169758721,
			"height": 336.3442016459206,
			"seed": 901865742,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004304035,
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
			"version": 120,
			"versionNonce": 2108967378,
			"isDeleted": false,
			"id": "ruRSMFaza-Qdpkthvxmed",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -406.927554233712,
			"y": 1350.3771790831042,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 401.2134374767045,
			"height": 80.08565679574144,
			"seed": 987581774,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688000260438,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.7851534979974986
				],
				[
					0,
					2.3554604939924957
				],
				[
					-0.7851534979974986,
					4.710920987984764
				],
				[
					-0.7851534979974986,
					8.636688477972257
				],
				[
					-1.5703069959949403,
					12.562455967959522
				],
				[
					-3.1406139919898806,
					17.273376955944286
				],
				[
					-3.1406139919898806,
					21.19914444593155
				],
				[
					-3.9257674899873223,
					26.695218931913814
				],
				[
					-3.1406139919898806,
					31.40613991989858
				],
				[
					-0.7851534979974986,
					36.90221440588084
				],
				[
					0,
					39.25767489987334
				],
				[
					2.355460493992382,
					42.3982888918631
				],
				[
					3.9257674899873223,
					43.9685958878581
				],
				[
					9.421841975969528,
					47.894363377845366
				],
				[
					13.347609465956907,
					50.24982387183786
				],
				[
					17.27337695594423,
					51.82013086783263
				],
				[
					21.19914444593155,
					54.17559136182513
				],
				[
					29.050679425906196,
					56.53105185581762
				],
				[
					36.11706090788334,
					58.88651234980989
				],
				[
					42.3982888918631,
					61.24197284380216
				],
				[
					49.46467037384025,
					62.81227983979716
				],
				[
					57.316205353814894,
					65.16774033378965
				],
				[
					65.16774033378954,
					68.30835432577942
				],
				[
					78.5153497997465,
					71.44896831776941
				],
				[
					83.22627078773127,
					71.44896831776941
				],
				[
					96.57388025368817,
					73.01927531376441
				],
				[
					105.9957222296577,
					73.01927531376441
				],
				[
					112.27695021363746,
					73.01927531376441
				],
				[
					116.98787120162223,
					73.01927531376441
				],
				[
					125.62455967959437,
					73.01927531376441
				],
				[
					131.90578766357413,
					73.80442881176168
				],
				[
					138.97216914555128,
					75.37473580775668
				],
				[
					149.1791646195183,
					76.94504280375168
				],
				[
					158.60100659548783,
					77.73019630174895
				],
				[
					165.6673880774651,
					78.51534979974667
				],
				[
					171.94861606144474,
					78.51534979974667
				],
				[
					176.65953704942962,
					78.51534979974667
				],
				[
					179.80015104141938,
					78.51534979974667
				],
				[
					184.51107202940426,
					78.51534979974667
				],
				[
					190.00714651538652,
					78.51534979974667
				],
				[
					197.85868149536117,
					78.51534979974667
				],
				[
					208.0656769693282,
					78.51534979974667
				],
				[
					215.91721194930284,
					78.51534979974667
				],
				[
					222.98359343127998,
					78.51534979974667
				],
				[
					231.62028190925213,
					80.08565679574144
				],
				[
					236.3312028972369,
					80.08565679574144
				],
				[
					241.04212388522166,
					80.08565679574144
				],
				[
					244.96789137520904,
					80.08565679574144
				],
				[
					247.32335186920142,
					80.08565679574144
				],
				[
					249.6788123631938,
					80.08565679574144
				],
				[
					253.60457985318118,
					80.08565679574144
				],
				[
					259.1006543391633,
					80.08565679574144
				],
				[
					263.8115753271482,
					80.08565679574144
				],
				[
					272.44826380512023,
					80.08565679574144
				],
				[
					275.5888777971101,
					80.08565679574144
				],
				[
					280.2997987850949,
					80.08565679574144
				],
				[
					284.22556627508226,
					79.30050329774394
				],
				[
					287.36618026707214,
					79.30050329774394
				],
				[
					290.506794259062,
					79.30050329774394
				],
				[
					293.6474082510518,
					80.08565679574144
				],
				[
					297.57317574103917,
					80.08565679574144
				],
				[
					300.71378973302905,
					80.08565679574144
				],
				[
					304.6395572230163,
					80.08565679574144
				],
				[
					307.7801712150062,
					79.30050329774394
				],
				[
					311.70593870499357,
					80.08565679574144
				],
				[
					315.63170619498084,
					80.08565679574144
				],
				[
					320.3426271829656,
					80.08565679574144
				],
				[
					324.268394672953,
					80.08565679574144
				],
				[
					327.40900866494286,
					80.08565679574144
				],
				[
					328.97931566093774,
					80.08565679574144
				],
				[
					330.54962265693274,
					80.08565679574144
				],
				[
					331.3347761549301,
					80.08565679574144
				],
				[
					332.9050831509251,
					80.08565679574144
				],
				[
					333.6902366489225,
					80.08565679574144
				],
				[
					336.8308506409124,
					80.08565679574144
				],
				[
					339.18631113490477,
					80.08565679574144
				],
				[
					343.11207862489215,
					80.08565679574144
				],
				[
					344.68238562088703,
					80.08565679574144
				],
				[
					345.46753911888453,
					79.30050329774394
				],
				[
					347.0378461148794,
					79.30050329774394
				],
				[
					348.6081531108744,
					79.30050329774394
				],
				[
					350.1784601068693,
					78.51534979974667
				],
				[
					351.7487671028643,
					78.51534979974667
				],
				[
					353.3190740988592,
					78.51534979974667
				],
				[
					356.45968809084906,
					78.51534979974667
				],
				[
					358.02999508684394,
					78.51534979974667
				],
				[
					359.60030208283894,
					78.51534979974667
				],
				[
					360.3854555808363,
					78.51534979974667
				],
				[
					361.1706090788338,
					78.51534979974667
				],
				[
					363.5260695728262,
					78.51534979974667
				],
				[
					366.6666835648161,
					78.51534979974667
				],
				[
					369.02214405880846,
					78.51534979974667
				],
				[
					370.59245105480335,
					78.51534979974667
				],
				[
					371.37760455280085,
					78.51534979974667
				],
				[
					372.16275805079835,
					78.51534979974667
				],
				[
					372.94791154879584,
					78.51534979974667
				],
				[
					373.73306504679323,
					78.51534979974667
				],
				[
					374.5182185447907,
					78.51534979974667
				],
				[
					376.0885255407856,
					78.51534979974667
				],
				[
					377.6588325367806,
					78.51534979974667
				],
				[
					378.443986034778,
					78.51534979974667
				],
				[
					379.2291395327755,
					78.51534979974667
				],
				[
					380.014293030773,
					78.51534979974667
				],
				[
					380.7994465287705,
					78.51534979974667
				],
				[
					381.5846000267679,
					78.51534979974667
				],
				[
					383.15490702276287,
					78.51534979974667
				],
				[
					384.72521401875775,
					78.51534979974667
				],
				[
					386.29552101475264,
					78.51534979974667
				],
				[
					387.86582801074763,
					79.30050329774394
				],
				[
					388.65098150874513,
					79.30050329774394
				],
				[
					390.22128850474,
					79.30050329774394
				],
				[
					391.7915955007349,
					79.30050329774394
				],
				[
					392.5767489987324,
					79.30050329774394
				],
				[
					394.9322094927248,
					79.30050329774394
				],
				[
					395.7173629907223,
					79.30050329774394
				],
				[
					396.5025164887198,
					79.30050329774394
				],
				[
					397.28766998671716,
					79.30050329774394
				],
				[
					397.28766998671716,
					79.30050329774394
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 25,
			"versionNonce": 569585486,
			"isDeleted": false,
			"id": "oJ4yD1JEcaAFHcpaBC5l_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -20.63203321895935,
			"y": 1410.8339984289091,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 21.19914444593155,
			"height": 30.62098642190108,
			"seed": 501969998,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688000261638,
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
			"version": 201,
			"versionNonce": 834010126,
			"isDeleted": false,
			"id": "X0UCSbyf7z_vY9NFHNS98",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -502.9178160627273,
			"y": 2139.825428178998,
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
			"updated": 1688004258940,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 298,
			"versionNonce": 1774326738,
			"isDeleted": false,
			"id": "Lu8LIEyu",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -482.2877654035476,
			"y": 2156.825428178998,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 114.73989868164062,
			"height": 25,
			"seed": 244220370,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258940,
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
			"version": 132,
			"versionNonce": 435636814,
			"isDeleted": false,
			"id": "NU9RnuGn5wFFPWybTAHpC",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -240.89276043860207,
			"y": 2151.825428178998,
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
			"updated": 1688004258940,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 214,
			"versionNonce": 464767378,
			"isDeleted": false,
			"id": "LNpVQV0I",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -235.6826392838169,
			"y": 2156.825428178998,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 239.5797576904297,
			"height": 25,
			"seed": 1519995026,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258940,
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
			"version": 255,
			"versionNonce": 24432782,
			"isDeleted": false,
			"id": "Hvkz-XlGZCjao51AC5XxI",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -237.926439054178,
			"y": 2333.62509196137,
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
			"updated": 1688004258940,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 320,
			"versionNonce": 426297170,
			"isDeleted": false,
			"id": "IPDvLzB6",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -232.7163560463655,
			"y": 2338.62509196137,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 171.579833984375,
			"height": 25,
			"seed": 1299113358,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
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
			"version": 72,
			"versionNonce": 602377934,
			"isDeleted": false,
			"id": "HPLEJbzY8NAceUHQXzHyy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -242.87030802821812,
			"y": 1973.7114306512506,
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
			"updated": 1688004258941,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 116,
			"versionNonce": 456658194,
			"isDeleted": false,
			"id": "J505iaQi",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -237.760170088765,
			"y": 1978.7114306512506,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 251.77972412109375,
			"height": 25,
			"seed": 2139765074,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
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
			"version": 283,
			"versionNonce": 1575519502,
			"isDeleted": false,
			"id": "3XOHbWZo",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -25.28394214449372,
			"y": 2338.6250919613694,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 66.25991821289062,
			"height": 25,
			"seed": 480004882,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
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
			"version": 140,
			"versionNonce": 915970770,
			"isDeleted": false,
			"id": "6flRtbjl",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 41.9526759024518,
			"y": 1978.7114306512503,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 272.97967529296875,
			"height": 25,
			"seed": 1771424402,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "object create info in vulkan",
			"rawText": "object create info in vulkan",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "object create info in vulkan",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 213,
			"versionNonce": 284209998,
			"isDeleted": false,
			"id": "aVBFJcA0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 54.80673523495602,
			"y": 2093.40919084898,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 249.49974060058594,
			"height": 25,
			"seed": 601516302,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
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
			"version": 205,
			"versionNonce": 975270034,
			"isDeleted": false,
			"id": "0LPL7WcU",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 63.70569938822814,
			"y": 2236.7813910961436,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 163.75982666015625,
			"height": 25,
			"seed": 1015928974,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
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
			"version": 28,
			"versionNonce": 123279758,
			"isDeleted": false,
			"id": "eOreXhh8",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 361.3266116254417,
			"y": 2042.981727313771,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 824.559326171875,
			"height": 125,
			"seed": 873966478,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
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
			"version": 69,
			"versionNonce": 160009810,
			"isDeleted": false,
			"id": "JwJc1sOI",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 279.25838665637593,
			"y": 2217.005915199982,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 486.17962646484375,
			"height": 75,
			"seed": 15053714,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
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
			"version": 357,
			"versionNonce": 1482340302,
			"isDeleted": false,
			"id": "0005z0Cw",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -496.92904226791916,
			"y": 2208.1630820726696,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 244.33155822753906,
			"height": 29.949532625434667,
			"seed": 1310639506,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004258941,
			"link": null,
			"locked": false,
			"fontSize": 11.979813050173867,
			"fontFamily": 1,
			"text": "VMA主要还是根据VmaAllocationCreateFlags\n来选择memory type",
			"rawText": "VMA主要还是根据VmaAllocationCreateFlags\n来选择memory type",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "VMA主要还是根据VmaAllocationCreateFlags\n来选择memory type",
			"lineHeight": 1.25,
			"baseline": 25
		},
		{
			"type": "freedraw",
			"version": 19,
			"versionNonce": 1563113678,
			"isDeleted": true,
			"id": "4Sr_ncie6zaCRyb2uNaFq",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 422.194539651611,
			"y": 1465.7947432887318,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 10.206995473967027,
			"height": 21.98429794392905,
			"seed": 1759577742,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004293788,
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
					0.7851534979974986,
					3.1406139919899942
				],
				[
					2.355460493992382,
					5.496074485982263
				],
				[
					3.1406139919898806,
					7.06638148197726
				],
				[
					3.9257674899872654,
					9.421841975969528
				],
				[
					4.710920987984764,
					10.992148971964525
				],
				[
					5.496074485982263,
					12.562455967959522
				],
				[
					5.496074485982263,
					14.13276296395452
				],
				[
					6.281227983979647,
					15.70306995994929
				],
				[
					7.066381481977146,
					16.488223457946788
				],
				[
					7.066381481977146,
					18.843683951939056
				],
				[
					7.851534979974645,
					19.628837449936782
				],
				[
					8.636688477972143,
					21.19914444593155
				],
				[
					9.421841975969528,
					21.98429794392905
				],
				[
					10.206995473967027,
					21.98429794392905
				],
				[
					10.206995473967027,
					21.98429794392905
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 21,
			"versionNonce": 1160179470,
			"isDeleted": true,
			"id": "ggM-loKedhuKmElgEsRnk",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 416.69846516562876,
			"y": 1467.3650502847267,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 28.265525927908698,
			"height": 0.7851534979974986,
			"seed": 1821431502,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688004295565,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.7851534979974986,
					-0.7851534979974986
				],
				[
					1.5703069959948834,
					0
				],
				[
					2.355460493992382,
					-0.7851534979974986
				],
				[
					3.1406139919898806,
					-0.7851534979974986
				],
				[
					5.496074485982263,
					-0.7851534979974986
				],
				[
					7.851534979974645,
					-0.7851534979974986
				],
				[
					10.206995473967027,
					0
				],
				[
					12.562455967959409,
					0
				],
				[
					14.91791646195179,
					0
				],
				[
					16.488223457946788,
					0
				],
				[
					19.628837449936555,
					0
				],
				[
					21.19914444593155,
					0
				],
				[
					23.554604939923934,
					0
				],
				[
					24.339758437921432,
					0
				],
				[
					25.910065433916316,
					0
				],
				[
					27.480372429911313,
					0
				],
				[
					28.265525927908698,
					0
				],
				[
					28.265525927908698,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#5c940d",
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
		"scrollX": 742.5537157017998,
		"scrollY": -1086.4009675024113,
		"zoom": {
			"value": 1.2389431822279817
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