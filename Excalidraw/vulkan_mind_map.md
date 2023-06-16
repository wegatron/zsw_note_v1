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

[diff](https://stackoverflow.com/questions/53050182/vulkan-difference-between-instance-and-device-extensions) ^5hnqsy3C

用来查询物理设备的属性, 并创建物理设备. ^7TRP2QJK

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

[官方specification & reference](https://registry.khronos.org/vulkan/)
 ^EsoRN7ez

[王烁-图形渲染技术&职业生涯](http://geekfaner.com/shineengine/blog1_career.html) ^ARdgx1Yi

Render pass ^I3eSwx7J

render pass compatibility(for graphics pipeline):
attachment 数量相同(允许有VK_ATTACHMENT_UNUSED)
对应attachment的format、sample count一致

注: 允许attachment有不同的extend, load/store, layout ^TUqsVMtw

Image ^VUAZ78FG

Buffer ^9amyTdkp

Image layout ^7lRVwubC

COLOR_ATTACHMENT_OPTIMAL ^7N4WVheJ

VkRenderPassCreateInfo ^Fp9OCP7y

VkAttachmentDescription ^YNSRZZiO

VkSubpassDescription ^UtTZtJFf

VkSubpassDependency ^zu3TMxtZ

format, sample count
load/store
init/final image layout ^u9zqe9px

color/input... attachment reference ^kziOnwkc

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
			"version": 340,
			"versionNonce": 93968095,
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
			"updated": 1686907927448,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 324,
			"versionNonce": 448449169,
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
			"updated": 1686907927448,
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
			"version": 808,
			"versionNonce": 454664959,
			"isDeleted": false,
			"id": "sBOKEF0l7D0JdoTtUemVr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -782.4268619805003,
			"y": -536.7792169512485,
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
			"updated": 1686907927448,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 803,
			"versionNonce": 1996836977,
			"isDeleted": false,
			"id": "lybhry6P",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -771.0668079643871,
			"y": -527.2792169512485,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 108.27989196777344,
			"height": 25,
			"seed": 1344605381,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927448,
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
			"version": 579,
			"versionNonce": 1661659935,
			"isDeleted": false,
			"id": "oDhN1X9Nuh_9DXCmvqfFK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -782.4268619805003,
			"y": 231.88988499294544,
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
			"updated": 1686907927449,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 495,
			"versionNonce": 1472469585,
			"isDeleted": false,
			"id": "VTcADaop",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -750.0868198662425,
			"y": 242.88988499294544,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 68.31991577148438,
			"height": 25,
			"seed": 1555018187,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927449,
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
			"version": 621,
			"versionNonce": 165556031,
			"isDeleted": false,
			"id": "QmXFFWBgjIDxGjrZ0i2BY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -762.4268619805003,
			"y": 854.2603303370754,
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
			"updated": 1686907927449,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 569,
			"versionNonce": 768518193,
			"isDeleted": false,
			"id": "sOf7Qxs6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -715.8868458061839,
			"y": 867.7603303370754,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 40.91996765136719,
			"height": 25,
			"seed": 439093061,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927449,
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
			"version": 471,
			"versionNonce": 1509158751,
			"isDeleted": false,
			"id": "ug1bFnxXMH5RZHtenX_vz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -782.4268619805003,
			"y": 595.8635692034718,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 179,
			"height": 57,
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
			"updated": 1686907927449,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 423,
			"versionNonce": 1661762065,
			"isDeleted": false,
			"id": "9FhasIQH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -719.7168323784496,
			"y": 611.8635692034718,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 53.57994079589844,
			"height": 25,
			"seed": 160057163,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927449,
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
			"version": 379,
			"versionNonce": 2107419519,
			"isDeleted": false,
			"id": "9MAw6mM-Gw_Hopv8W85Yo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -304.14380624696537,
			"y": -742.6538802601231,
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
			"updated": 1686907927449,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 338,
			"versionNonce": 947195889,
			"isDeleted": false,
			"id": "jzUbNhC8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -288.4137647430591,
			"y": -733.1538802601231,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 79.5399169921875,
			"height": 25,
			"seed": 1723423272,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927449,
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
			"version": 418,
			"versionNonce": 18408351,
			"isDeleted": false,
			"id": "6hmhRMdK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -111.70549950117709,
			"y": -385.83975321166815,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 204.13291931152344,
			"height": 25,
			"seed": 550190168,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927449,
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
			"version": 350,
			"versionNonce": 1678764497,
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
			"updated": 1686907927449,
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
			"version": 548,
			"versionNonce": 345577407,
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
			"updated": 1686907927450,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 484,
			"versionNonce": 1861519281,
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
			"updated": 1686907927450,
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
			"version": 312,
			"versionNonce": 238929887,
			"isDeleted": false,
			"id": "PKQh0Jg5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -99.10861046280823,
			"y": -265.96394178423793,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 100.27989196777344,
			"height": 25,
			"seed": 1973251508,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927450,
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
			"version": 340,
			"versionNonce": 1397385617,
			"isDeleted": false,
			"id": "5hnqsy3C",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 214.52099494943366,
			"y": -324.80724047829267,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 99.79302978515625,
			"height": 25,
			"seed": 1431936180,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927450,
			"link": "https://stackoverflow.com/questions/53050182/vulkan-difference-between-instance-and-device-extensions",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[diff]]",
			"rawText": "[diff](https://stackoverflow.com/questions/53050182/vulkan-difference-between-instance-and-device-extensions)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[diff]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 1305,
			"versionNonce": 739734527,
			"isDeleted": false,
			"id": "F1xNj3sg9fcdHjjysXF8J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -560.148234786488,
			"y": -744.4715598797999,
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
			"updated": 1686907927450,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 871,
			"versionNonce": 1514737521,
			"isDeleted": false,
			"id": "7TRP2QJK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -555.148234786488,
			"y": -739.4715598797999,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 188.11203002929688,
			"height": 40,
			"seed": 2078708748,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927450,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "用来查询物理设备的属性, \n并创建物理设备.",
			"rawText": "用来查询物理设备的属性, 并创建物理设备.",
			"textAlign": "left",
			"verticalAlign": "middle",
			"containerId": "F1xNj3sg9fcdHjjysXF8J",
			"originalText": "用来查询物理设备的属性, 并创建物理设备.",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "rectangle",
			"version": 893,
			"versionNonce": 371629087,
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
			"updated": 1686907927450,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 520,
			"versionNonce": 976746833,
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
			"updated": 1686907927450,
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
			"version": 203,
			"versionNonce": 542883903,
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
			"updated": 1686907927450,
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
			"version": 285,
			"versionNonce": 1953408817,
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
			"updated": 1686907927450,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 244,
			"versionNonce": 1284989023,
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
			"updated": 1686907927450,
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
			"version": 161,
			"versionNonce": 1934924049,
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
			"updated": 1686907927451,
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
			"version": 38,
			"versionNonce": 212466815,
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
			"updated": 1686907927451,
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
			"version": 62,
			"versionNonce": 1751207665,
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
			"updated": 1686907927451,
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
			"version": 45,
			"versionNonce": 1146360991,
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
			"updated": 1686907927451,
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
			"version": 53,
			"versionNonce": 1780238545,
			"isDeleted": false,
			"id": "JjOtx2DtBJq4xyAv1OeVv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -223.30215027228087,
			"y": -248.89125044671414,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 106.31578947368416,
			"height": 112.63157894736844,
			"seed": 1437385747,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927451,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0526315789472847,
					-1.0526315789473983
				],
				[
					2.105263157894683,
					-2.105263157894683
				],
				[
					5.263157894736764,
					-4.21052631578948
				],
				[
					8.421052631578846,
					-7.368421052631561
				],
				[
					11.57894736842104,
					-11.57894736842104
				],
				[
					14.736842105263122,
					-20
				],
				[
					20,
					-31.57894736842104
				],
				[
					23.15789473684208,
					-37.8947368421052
				],
				[
					26.315789473684163,
					-44.21052631578948
				],
				[
					28.421052631578846,
					-49.47368421052636
				],
				[
					30.526315789473642,
					-53.68421052631584
				],
				[
					32.631578947368325,
					-56.84210526315792
				],
				[
					33.684210526315724,
					-58.9473684210526
				],
				[
					34.73684210526312,
					-61.0526315789474
				],
				[
					35.78947368421052,
					-63.15789473684208
				],
				[
					37.8947368421052,
					-66.31578947368416
				],
				[
					40,
					-69.47368421052636
				],
				[
					42.10526315789468,
					-71.57894736842104
				],
				[
					44.21052631578948,
					-73.68421052631572
				],
				[
					46.31578947368416,
					-75.78947368421052
				],
				[
					48.421052631578846,
					-77.8947368421052
				],
				[
					50.52631578947364,
					-80
				],
				[
					52.631578947368325,
					-83.15789473684208
				],
				[
					57.8947368421052,
					-86.31578947368416
				],
				[
					60,
					-88.42105263157896
				],
				[
					62.10526315789468,
					-89.47368421052636
				],
				[
					64.21052631578937,
					-91.57894736842104
				],
				[
					65.26315789473676,
					-91.57894736842104
				],
				[
					66.31578947368416,
					-92.63157894736844
				],
				[
					67.36842105263156,
					-92.63157894736844
				],
				[
					69.47368421052624,
					-93.68421052631572
				],
				[
					71.57894736842104,
					-94.73684210526312
				],
				[
					74.73684210526312,
					-95.78947368421052
				],
				[
					80,
					-97.8947368421052
				],
				[
					87.36842105263156,
					-100
				],
				[
					91.57894736842104,
					-102.10526315789468
				],
				[
					94.73684210526312,
					-105.26315789473688
				],
				[
					96.8421052631578,
					-106.31578947368416
				],
				[
					98.9473684210526,
					-107.36842105263156
				],
				[
					101.05263157894728,
					-108.42105263157896
				],
				[
					102.10526315789468,
					-109.47368421052636
				],
				[
					103.15789473684208,
					-110.52631578947364
				],
				[
					104.21052631578937,
					-111.57894736842104
				],
				[
					105.26315789473676,
					-112.63157894736844
				],
				[
					106.31578947368416,
					-112.63157894736844
				],
				[
					106.31578947368416,
					-111.57894736842104
				],
				[
					106.31578947368416,
					-111.57894736842104
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 47,
			"versionNonce": 189147327,
			"isDeleted": false,
			"id": "4BUHHhyQMLZqUcW_Pgiuv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dotted",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -221.1968871143862,
			"y": -250.99651360460882,
			"strokeColor": "#0d4896",
			"backgroundColor": "transparent",
			"width": 117.89473684210532,
			"height": 6.315789473684163,
			"seed": 989328285,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927451,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.1052631578947967,
					0
				],
				[
					7.368421052631561,
					1.0526315789472847
				],
				[
					11.57894736842104,
					2.105263157894683
				],
				[
					15.78947368421052,
					2.105263157894683
				],
				[
					20,
					2.105263157894683
				],
				[
					22.105263157894797,
					2.105263157894683
				],
				[
					26.315789473684163,
					2.105263157894683
				],
				[
					30.526315789473642,
					2.105263157894683
				],
				[
					35.78947368421052,
					2.105263157894683
				],
				[
					42.1052631578948,
					2.105263157894683
				],
				[
					46.31578947368416,
					2.105263157894683
				],
				[
					49.47368421052636,
					2.105263157894683
				],
				[
					51.57894736842104,
					2.105263157894683
				],
				[
					53.68421052631584,
					1.0526315789472847
				],
				[
					55.78947368421052,
					1.0526315789472847
				],
				[
					61.0526315789474,
					0
				],
				[
					64.21052631578948,
					-1.0526315789473983
				],
				[
					66.31578947368416,
					-1.0526315789473983
				],
				[
					68.42105263157896,
					-1.0526315789473983
				],
				[
					70.52631578947364,
					-1.0526315789473983
				],
				[
					72.63157894736844,
					-1.0526315789473983
				],
				[
					75.78947368421052,
					0
				],
				[
					78.9473684210526,
					0
				],
				[
					82.10526315789468,
					1.0526315789472847
				],
				[
					85.26315789473688,
					1.0526315789472847
				],
				[
					87.36842105263156,
					2.105263157894683
				],
				[
					89.47368421052636,
					2.105263157894683
				],
				[
					91.57894736842104,
					2.105263157894683
				],
				[
					92.63157894736844,
					2.105263157894683
				],
				[
					93.68421052631584,
					2.105263157894683
				],
				[
					94.73684210526312,
					2.105263157894683
				],
				[
					95.78947368421052,
					2.105263157894683
				],
				[
					95.78947368421052,
					3.1578947368420813
				],
				[
					97.89473684210532,
					3.1578947368420813
				],
				[
					103.15789473684208,
					4.21052631578948
				],
				[
					110.52631578947364,
					5.263157894736764
				],
				[
					115.78947368421052,
					5.263157894736764
				],
				[
					117.89473684210532,
					5.263157894736764
				],
				[
					116.84210526315792,
					5.263157894736764
				],
				[
					115.78947368421052,
					5.263157894736764
				],
				[
					115.78947368421052,
					5.263157894736764
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 91,
			"versionNonce": 1377633969,
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
			"updated": 1686907927451,
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
			"version": 233,
			"versionNonce": 432921041,
			"isDeleted": false,
			"id": "b1lmDQYkX5FjOao0zZIVR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -506.2908726298031,
			"y": 141.95931646213398,
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
				}
			],
			"updated": 1686907959010,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 207,
			"versionNonce": 2085876639,
			"isDeleted": false,
			"id": "p4bugCjR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -497.1407719217953,
			"y": 160.45931646213398,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 157.69979858398438,
			"height": 25,
			"seed": 1157736243,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907959010,
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
			"version": 331,
			"versionNonce": 393508785,
			"isDeleted": false,
			"id": "9bONTo82v2PJ_VnFKS-w-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -506.2908726298031,
			"y": 346.99414485973375,
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
			"updated": 1686907959010,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 333,
			"versionNonce": 368191423,
			"isDeleted": false,
			"id": "Y2s3t9U2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -495.81077772013515,
			"y": 365.49414485973375,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 155.03981018066406,
			"height": 25,
			"seed": 934963293,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907959010,
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
			"version": 90,
			"versionNonce": 499207455,
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
			"updated": 1686907927452,
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
			"version": 110,
			"versionNonce": 329046097,
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
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 95,
			"versionNonce": 595087679,
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
			"updated": 1686907927452,
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
			"version": 126,
			"versionNonce": 736077361,
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
			"updated": 1686907927452,
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
			"version": 5,
			"versionNonce": 1073336671,
			"isDeleted": false,
			"id": "cF7a9EhE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 507.2266796890021,
			"y": -487.2078017736419,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 678.8729248046875,
			"height": 25,
			"seed": 1927611859,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927452,
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
			"type": "rectangle",
			"version": 280,
			"versionNonce": 843954193,
			"isDeleted": false,
			"id": "S7GckqFIplGg-5Ijmm_0I",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1182.8518886046677,
			"y": -111.40114216041081,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 443,
			"height": 243,
			"seed": 1513219571,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "EsoRN7ez"
				}
			],
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 271,
			"versionNonce": 748047743,
			"isDeleted": false,
			"id": "EsoRN7ez",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1177.8518886046677,
			"y": -106.40114216041081,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 348.69281005859375,
			"height": 50,
			"seed": 470365917,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927452,
			"link": "https://registry.khronos.org/vulkan/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[官方specification & reference]]\n",
			"rawText": "[官方specification & reference](https://registry.khronos.org/vulkan/)\n",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": "S7GckqFIplGg-5Ijmm_0I",
			"originalText": "🌐[[官方specification & reference]]\n",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "rectangle",
			"version": 154,
			"versionNonce": 1222544881,
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
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 205,
			"versionNonce": 613303711,
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
			"updated": 1686907927452,
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
			"version": 182,
			"versionNonce": 1721346001,
			"isDeleted": false,
			"id": "ysk_8VVB6QndbLThPjmFR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -172.65592242372804,
			"y": -8.106306924265027,
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
				}
			],
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 145,
			"versionNonce": 655505855,
			"isDeleted": false,
			"id": "I3eSwx7J",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -152.4958500970679,
			"y": 1.8936930757349728,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 119.67985534667969,
			"height": 25,
			"seed": 350032432,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927452,
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
			"version": 1218,
			"versionNonce": 899057073,
			"isDeleted": false,
			"id": "BG0r7nN6iTBqMyiIh4Tuy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -180.909518512683,
			"y": 72.92435764867685,
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
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 1347,
			"versionNonce": 2034411999,
			"isDeleted": false,
			"id": "TUqsVMtw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -175.909518512683,
			"y": 77.92435764867685,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 556.879638671875,
			"height": 125,
			"seed": 1915653168,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927452,
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
			"version": 81,
			"versionNonce": 1179408785,
			"isDeleted": false,
			"id": "HqMsZjgtVTcZlnGxskMQC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -492.7908726298031,
			"y": 498.4715035218841,
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
				}
			],
			"updated": 1686907959010,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 35,
			"versionNonce": 569694175,
			"isDeleted": false,
			"id": "VUAZ78FG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -447.2208424174008,
			"y": 516.4715035218841,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 57.85993957519531,
			"height": 25,
			"seed": 810781904,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907959010,
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
			"version": 52,
			"versionNonce": 2005729137,
			"isDeleted": false,
			"id": "ecoGQyUOPjZitOISe84Rq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -496.2908726298031,
			"y": 611.8048368552173,
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
			"updated": 1686907959010,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 16,
			"versionNonce": 1449952255,
			"isDeleted": false,
			"id": "9amyTdkp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -450.7308369242367,
			"y": 629.8048368552173,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 64.87992858886719,
			"height": 25,
			"seed": 428170800,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907959010,
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
			"version": 152,
			"versionNonce": 586331985,
			"isDeleted": false,
			"id": "xZITBcKMISab2S6sSJXZB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -284.99491788885086,
			"y": 422.97150352188424,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 162,
			"height": 48,
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
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 128,
			"versionNonce": 1144250943,
			"isDeleted": false,
			"id": "7lRVwubC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -268.7848425104329,
			"y": 434.47150352188424,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 129.57984924316406,
			"height": 25,
			"seed": 1139334864,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Image layout",
			"rawText": "Image layout",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "xZITBcKMISab2S6sSJXZB",
			"originalText": "Image layout",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 93,
			"versionNonce": 857842993,
			"isDeleted": false,
			"id": "7N4WVheJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -100.22529065015544,
			"y": 410.5390184461104,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"width": 335.69976806640625,
			"height": 25,
			"seed": 133468720,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "COLOR_ATTACHMENT_OPTIMAL",
			"rawText": "COLOR_ATTACHMENT_OPTIMAL",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "COLOR_ATTACHMENT_OPTIMAL",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"id": "1s0h_LZGw9uFdnBWx4wMj",
			"type": "rectangle",
			"x": 126.08592201065312,
			"y": -11.606306924265027,
			"width": 264,
			"height": 52,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 2005856081,
			"version": 348,
			"versionNonce": 1387520959,
			"isDeleted": false,
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
				}
			],
			"updated": 1686907943638,
			"link": null,
			"locked": false
		},
		{
			"id": "Fp9OCP7y",
			"type": "text",
			"x": 137.00604987930546,
			"y": 1.8936930757349728,
			"width": 242.1597442626953,
			"height": 25,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 1486728529,
			"version": 343,
			"versionNonce": 519558929,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"text": "VkRenderPassCreateInfo",
			"rawText": "VkRenderPassCreateInfo",
			"fontSize": 20,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 18,
			"containerId": "1s0h_LZGw9uFdnBWx4wMj",
			"originalText": "VkRenderPassCreateInfo",
			"lineHeight": 1.25
		},
		{
			"id": "ttZCYIlzn9L6J0XKtzqKs",
			"type": "rectangle",
			"x": 449.97405091480493,
			"y": 67.71539028507561,
			"width": 217,
			"height": 35,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 1430371377,
			"version": 207,
			"versionNonce": 1315020415,
			"isDeleted": false,
			"boundElements": [
				{
					"id": "zu3TMxtZ",
					"type": "text"
				}
			],
			"updated": 1686907927452,
			"link": null,
			"locked": false
		},
		{
			"id": "zu3TMxtZ",
			"type": "text",
			"x": 455.25415650562525,
			"y": 72.71539028507561,
			"width": 206.43978881835938,
			"height": 25,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 846029937,
			"version": 210,
			"versionNonce": 2028784881,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"text": "VkSubpassDependency",
			"rawText": "VkSubpassDependency",
			"fontSize": 20,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 18,
			"containerId": "ttZCYIlzn9L6J0XKtzqKs",
			"originalText": "VkSubpassDependency",
			"lineHeight": 1.25
		},
		{
			"id": "0ba52DQEEdMgc6ohb6DRn",
			"type": "rectangle",
			"x": 442.2203316311874,
			"y": -163.92697331299797,
			"width": 260,
			"height": 35,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [
				"x-ji9gGxUHbajrUL1rrSf"
			],
			"roundness": null,
			"seed": 105524511,
			"version": 537,
			"versionNonce": 1925674655,
			"isDeleted": false,
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
			"updated": 1686907927452,
			"link": null,
			"locked": false
		},
		{
			"id": "YNSRZZiO",
			"type": "text",
			"x": 452.3804497342147,
			"y": -158.92697331299797,
			"width": 239.6797637939453,
			"height": 25,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [
				"x-ji9gGxUHbajrUL1rrSf"
			],
			"roundness": null,
			"seed": 174168287,
			"version": 672,
			"versionNonce": 411567825,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"text": "VkAttachmentDescription",
			"rawText": "VkAttachmentDescription",
			"fontSize": 20,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 18,
			"containerId": "0ba52DQEEdMgc6ohb6DRn",
			"originalText": "VkAttachmentDescription",
			"lineHeight": 1.25
		},
		{
			"id": "eUdKzPG74aACuTDmS_sOR",
			"type": "rectangle",
			"x": 735.6585645454921,
			"y": -206.57242937289453,
			"width": 279,
			"height": 108,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [
				"x-ji9gGxUHbajrUL1rrSf"
			],
			"roundness": {
				"type": 3
			},
			"seed": 2031686655,
			"version": 110,
			"versionNonce": 419252927,
			"isDeleted": false,
			"boundElements": [
				{
					"id": "u9zqe9px",
					"type": "text"
				}
			],
			"updated": 1686907927452,
			"link": null,
			"locked": false
		},
		{
			"id": "u9zqe9px",
			"type": "text",
			"x": 767.9087018745937,
			"y": -190.07242937289453,
			"width": 214.49972534179688,
			"height": 75,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [
				"x-ji9gGxUHbajrUL1rrSf"
			],
			"roundness": null,
			"seed": 673875423,
			"version": 190,
			"versionNonce": 2019624113,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"text": "format, sample count\nload/store\ninit/final image layout",
			"rawText": "format, sample count\nload/store\ninit/final image layout",
			"fontSize": 20,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 68,
			"containerId": "eUdKzPG74aACuTDmS_sOR",
			"originalText": "format, sample count\nload/store\ninit/final image layout",
			"lineHeight": 1.25
		},
		{
			"id": "WwrjnYfvT8jZVpvlXvx6A",
			"type": "rectangle",
			"x": 442.2203316311874,
			"y": -40.35207223034351,
			"width": 216,
			"height": 35,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [
				"9YVdHwIyArf-9MByonZvS"
			],
			"roundness": null,
			"seed": 1278984241,
			"version": 199,
			"versionNonce": 2107874015,
			"isDeleted": false,
			"boundElements": [
				{
					"id": "UtTZtJFf",
					"type": "text"
				}
			],
			"updated": 1686907927452,
			"link": null,
			"locked": false
		},
		{
			"id": "UtTZtJFf",
			"type": "text",
			"x": 447.69044729280847,
			"y": -35.35207223034351,
			"width": 205.0597686767578,
			"height": 25,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [
				"9YVdHwIyArf-9MByonZvS"
			],
			"roundness": null,
			"seed": 1034926239,
			"version": 240,
			"versionNonce": 1411335825,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686907927452,
			"link": null,
			"locked": false,
			"text": "VkSubpassDescription",
			"rawText": "VkSubpassDescription",
			"fontSize": 20,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 18,
			"containerId": "WwrjnYfvT8jZVpvlXvx6A",
			"originalText": "VkSubpassDescription",
			"lineHeight": 1.25
		},
		{
			"id": "j_kWCgzDhFuxHkQxKuN-E",
			"type": "rectangle",
			"x": 728.4287641016597,
			"y": -40.35207223034351,
			"width": 306,
			"height": 60,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [
				"9YVdHwIyArf-9MByonZvS"
			],
			"roundness": {
				"type": 3
			},
			"seed": 1295848863,
			"version": 21,
			"versionNonce": 250230993,
			"isDeleted": false,
			"boundElements": [
				{
					"id": "kziOnwkc",
					"type": "text"
				}
			],
			"updated": 1686911632609,
			"link": null,
			"locked": false
		},
		{
			"id": "kziOnwkc",
			"type": "text",
			"x": 755.3389050928706,
			"y": -35.35207223034351,
			"width": 252.17971801757812,
			"height": 50,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [
				"9YVdHwIyArf-9MByonZvS"
			],
			"roundness": null,
			"seed": 2124624209,
			"version": 162,
			"versionNonce": 767120639,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686911633295,
			"link": null,
			"locked": false,
			"text": "color/input... attachment \nreference",
			"rawText": "color/input... attachment reference",
			"fontSize": 20,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 43,
			"containerId": "j_kWCgzDhFuxHkQxKuN-E",
			"originalText": "color/input... attachment reference",
			"lineHeight": 1.25
		},
		{
			"id": "mhUP4-Dlja3Wehs6M2VuT",
			"type": "arrow",
			"x": 445.2819018102832,
			"y": -126.94288126807538,
			"width": 53.3068200748703,
			"height": 134.72087255285447,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"seed": 2096431441,
			"version": 93,
			"versionNonce": 1747404529,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686907937728,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-53.3068200748703,
					134.72087255285447
				]
			],
			"lastCommittedPoint": null,
			"startBinding": {
				"elementId": "0ba52DQEEdMgc6ohb6DRn",
				"focus": 0.8707640447988935,
				"gap": 1.9840920449225905
			},
			"endBinding": {
				"elementId": "1s0h_LZGw9uFdnBWx4wMj",
				"focus": 0.9225770858144929,
				"gap": 1.8891597247597929
			},
			"startArrowhead": null,
			"endArrowhead": "arrow"
		},
		{
			"id": "bB8CUXU_h3TBNTMv0Qt0s",
			"type": "arrow",
			"x": 442.3742570789268,
			"y": -9.667877103360354,
			"width": 53.30682007487053,
			"height": 19.384298209043834,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"seed": 658085457,
			"version": 35,
			"versionNonce": 1573757489,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686907931408,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-53.30682007487053,
					19.384298209043834
				]
			],
			"lastCommittedPoint": null,
			"startBinding": null,
			"endBinding": null,
			"startArrowhead": null,
			"endArrowhead": "arrow"
		},
		{
			"id": "ajpUmjrIxEUM2AmiFo7gc",
			"type": "arrow",
			"x": 450.12797636254436,
			"y": 82.40753938959779,
			"width": 59.12210953758381,
			"height": 73.6603331943665,
			"angle": 0,
			"strokeColor": "#5c940d",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"seed": 218804415,
			"version": 48,
			"versionNonce": 1506172369,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686907943638,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-59.12210953758381,
					-73.6603331943665
				]
			],
			"lastCommittedPoint": null,
			"startBinding": null,
			"endBinding": {
				"elementId": "1s0h_LZGw9uFdnBWx4wMj",
				"focus": -0.8991523072472101,
				"gap": 1
			},
			"startArrowhead": null,
			"endArrowhead": "arrow"
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#5c940d",
		"currentItemBackgroundColor": "transparent",
		"currentItemFillStyle": "hachure",
		"currentItemStrokeWidth": 1,
		"currentItemStrokeStyle": "dashed",
		"currentItemRoughness": 0,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 20,
		"currentItemTextAlign": "center",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 592.7472672840127,
		"scrollY": 485.6584060162168,
		"zoom": {
			"value": 1.0317629136900572
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