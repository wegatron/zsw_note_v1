---

excalidraw-plugin: parsed
tags: [cg]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Text Elements
ECS ^aemlwLa8

Job System ^0X6qjcum

Frame Graph ^fIQDKoCr

RHI ^Yo5otioh

Memory Management ^2A9O3eWJ

[面向数据编程](https://www.cnblogs.com/KillerAery/p/11746639.html#%E5%88%86%E9%85%8D%E9%A1%B5%E5%AF%B9%E9%BD%90%E7%9A%84%E5%86%85%E5%AD%98) ^7nAeXE8U

[Desc-简洁的ECS实现](https://zhuanlan.zhihu.com/p/372326175) ^FAyB1vgn

[ecs with code](https://zhuanlan.zhihu.com/p/618971664) ^UOoHCRtH

DataChunk ^TV59hukw

Archetype ^U5u9na2n

Archetype是components的某种特定组合所代表的类型.
包含了: 
该类型的SOA数据-DataChunk, 
该类型的hash,
以及该类型所拥有的的ComponentList类型 ^RmY0aTof

find_or_create_archetype ^2RQZSV7g

在给entity添加新的component时,
会搜索是否有合适的Archetype,
若没有, 则需要创建. ^tbBy9scw

然后在该Archetype所拥有的
DataChunk中申请一块存放该
entity component的空间. ^zfFGN27k

set_entity_archetype ^btCmy5eL

提升灵活性 + 内存局部性
在unity中, 逻辑也是组件 ^qZJKyjTH

build_component_list ^5y6NwLfh

find match ^hA74l2lv

else create new Archetype ^WpnaxnHg

return archetype ^nD4GpUIC

create_chunk_for_archetype ^JQq3kbnI

if entity is empty ^uuVkMslm

find free chunk and insert ^zlDBO5pr

move entity to Archetype ^HPGfQtit

get_entity_component ^Ceb0eMnT

获取entity所属的data chunk和在index.
在data chunk中获取该类型的component的内存offset,
配合index获取数据reference. ^mNfcyzt4

程序性能分析: perf, valgrind
缓存命中分析: cachegrind, perf mem ^9OhOOl5o

alignas: 只有在特殊情况下才需要. ^SuG1cFdW

c++ Pmr: 针对一些特定的应用场景 ^TYNx4xEf

[entt crash course](https://skypjack.github.io/entt/md_docs_md_entity.html) ^oweSLIxH

vulkan-samples:
1. 以scene_graph为主, 其中的node可以添加component. 主要的component是Mesh(包含材质==renderable)
2. scene_graph只存储数据, 由各个pass(system), 进行相关事务的处理.
3. 节点之间有明确的父子关系, 通过向上查找更新节点的world transform. ^mXUwRtws

filament:
1. filament中通过几个不同的Manager与entt::registry类似, 将entity分为几个大类: Renderable, Light, Camera 
2. 由FScene::prepare负责将scene中的entity转化为可渲染的集合数据mRenderableData
    主要处理light, renderable
3. filament中View来定义了一个场景的渲染配置. 比如: 相机、阴影、后处理等.
4. 在节点更新时同时更新其所有子节点. 通过child、next指针实现父子节点树(每个节点大小固定). ^okDtks7D

assimp

 ^g9nlQL6E


# Embedded files
2f4019311d325714a77e2978072fa603d7b99307: [[rc/Pasted Image 20230829173016_781.png]]

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
			"version": 59,
			"versionNonce": 1761980248,
			"isDeleted": false,
			"id": "lHuactsIvTT3wTdD0_LwZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -212.51007080078125,
			"y": -261.806640625,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 49,
			"height": 35,
			"seed": 351115901,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "aemlwLa8",
					"type": "text"
				}
			],
			"updated": 1691572064756,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 151,
			"versionNonce": 1458672168,
			"isDeleted": false,
			"id": "aemlwLa8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -207.27005004882812,
			"y": -256.806640625,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 38.51995849609375,
			"height": 25,
			"seed": 2115847715,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064756,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "ECS",
			"rawText": "ECS",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "lHuactsIvTT3wTdD0_LwZ",
			"originalText": "ECS",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 138,
			"versionNonce": 2017854552,
			"isDeleted": false,
			"id": "NyniRQOCHokLBVOgMlOJo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -209.90574245624714,
			"y": -491.01738324680866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122,
			"height": 35,
			"seed": 788571507,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "0X6qjcum",
					"type": "text"
				}
			],
			"updated": 1691572064756,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 213,
			"versionNonce": 441257256,
			"isDeleted": false,
			"id": "0X6qjcum",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -204.51568203144245,
			"y": -486.01738324680866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 111.21987915039062,
			"height": 25,
			"seed": 1052823725,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064757,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Job System",
			"rawText": "Job System",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "NyniRQOCHokLBVOgMlOJo",
			"originalText": "Job System",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 145,
			"versionNonce": 1902616584,
			"isDeleted": false,
			"id": "zJQclcUeAHhlluUUKWXAy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -211.0027111635245,
			"y": 144.86483771153644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 135,
			"height": 35,
			"seed": 1104670621,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "fIQDKoCr",
					"type": "text"
				}
			],
			"updated": 1692147977489,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 331,
			"versionNonce": 1919435896,
			"isDeleted": false,
			"id": "fIQDKoCr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -205.74264036274326,
			"y": 149.86483771153644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 124.4798583984375,
			"height": 25,
			"seed": 1119864141,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1692147977489,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Frame Graph",
			"rawText": "Frame Graph",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "zJQclcUeAHhlluUUKWXAy",
			"originalText": "Frame Graph",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 143,
			"versionNonce": 2055626504,
			"isDeleted": false,
			"id": "MRrBEKAzqAaS-CeROCSCU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -211.0027111635245,
			"y": 234.43417364903644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 46,
			"height": 35,
			"seed": 1769281107,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "Yo5otioh",
					"type": "text"
				}
			],
			"updated": 1692147977489,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 250,
			"versionNonce": 517535096,
			"isDeleted": false,
			"id": "Yo5otioh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -205.74269376850498,
			"y": 239.43417364903644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 35.47996520996094,
			"height": 25,
			"seed": 156353469,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1692147977489,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "RHI",
			"rawText": "RHI",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "MRrBEKAzqAaS-CeROCSCU",
			"originalText": "RHI",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 186,
			"versionNonce": 1676100440,
			"isDeleted": false,
			"id": "f21oWxVcZHZfIC1eokErr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -207.90574245624714,
			"y": -401.44804730930866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 205,
			"height": 35,
			"seed": 1553520829,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "2A9O3eWJ",
					"type": "text"
				}
			],
			"updated": 1691572064757,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 238,
			"versionNonce": 597900840,
			"isDeleted": false,
			"id": "2A9O3eWJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -202.6656454103487,
			"y": -396.44804730930866,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 194.51980590820312,
			"height": 25,
			"seed": 58580317,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064757,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Memory Management",
			"rawText": "Memory Management",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "f21oWxVcZHZfIC1eokErr",
			"originalText": "Memory Management",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 141,
			"versionNonce": 1238702168,
			"isDeleted": false,
			"id": "7nAeXE8U",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 35.98992919921875,
			"y": -273.66796875,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 185.70440673828125,
			"height": 25,
			"seed": 1438724563,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064757,
			"link": "https://www.cnblogs.com/KillerAery/p/11746639.html#%E5%88%86%E9%85%8D%E9%A1%B5%E5%AF%B9%E9%BD%90%E7%9A%84%E5%86%85%E5%AD%98",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[面向数据编程]]",
			"rawText": "[面向数据编程](https://www.cnblogs.com/KillerAery/p/11746639.html#%E5%88%86%E9%85%8D%E9%A1%B5%E5%AF%B9%E9%BD%90%E7%9A%84%E5%86%85%E5%AD%98)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[面向数据编程]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 157,
			"versionNonce": 1005140264,
			"isDeleted": false,
			"id": "FAyB1vgn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -574.0100708007812,
			"y": -267.16796875,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 259.8843078613281,
			"height": 25,
			"seed": 1300857971,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064757,
			"link": "https://zhuanlan.zhihu.com/p/372326175",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[Desc-简洁的ECS实现]]",
			"rawText": "[Desc-简洁的ECS实现](https://zhuanlan.zhihu.com/p/372326175)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[Desc-简洁的ECS实现]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 92,
			"versionNonce": 1027624280,
			"isDeleted": false,
			"id": "UOoHCRtH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 36.304377914549036,
			"y": -234.02582657874194,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 198.72425842285156,
			"height": 25,
			"seed": 552006931,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064758,
			"link": "https://zhuanlan.zhihu.com/p/618971664",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[ecs with code]]",
			"rawText": "[ecs with code](https://zhuanlan.zhihu.com/p/618971664)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[ecs with code]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 52,
			"versionNonce": 1874318376,
			"isDeleted": false,
			"id": "TV59hukw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -733.8179168701172,
			"y": -317.029296875,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 106.77989196777344,
			"height": 25,
			"seed": 1488113681,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064758,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "DataChunk",
			"rawText": "DataChunk",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "DataChunk",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 34,
			"versionNonce": 1736237656,
			"isDeleted": false,
			"id": "U5u9na2n",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -731.8179168701172,
			"y": -214.529296875,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 94.05990600585938,
			"height": 25,
			"seed": 1433975601,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064758,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Archetype",
			"rawText": "Archetype",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Archetype",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 244,
			"versionNonce": 83562280,
			"isDeleted": false,
			"id": "RmY0aTof",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -731.3179168701172,
			"y": -183.529296875,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 202.010009765625,
			"height": 52.03587840665959,
			"seed": 483571505,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064758,
			"link": null,
			"locked": false,
			"fontSize": 8.325740545065534,
			"fontFamily": 1,
			"text": "Archetype是components的某种特定组合所代表的类型.\n包含了: \n该类型的SOA数据-DataChunk, \n该类型的hash,\n以及该类型所拥有的的ComponentList类型",
			"rawText": "Archetype是components的某种特定组合所代表的类型.\n包含了: \n该类型的SOA数据-DataChunk, \n该类型的hash,\n以及该类型所拥有的的ComponentList类型",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Archetype是components的某种特定组合所代表的类型.\n包含了: \n该类型的SOA数据-DataChunk, \n该类型的hash,\n以及该类型所拥有的的ComponentList类型",
			"lineHeight": 1.25,
			"baseline": 49
		},
		{
			"type": "text",
			"version": 265,
			"versionNonce": 660526936,
			"isDeleted": false,
			"id": "2RQZSV7g",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1130.6832968818444,
			"y": -324.7495794911243,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 210.80047607421875,
			"height": 20,
			"seed": 1250273233,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064758,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "find_or_create_archetype",
			"rawText": "find_or_create_archetype",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "find_or_create_archetype",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 253,
			"versionNonce": 606005800,
			"isDeleted": false,
			"id": "tbBy9scw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1031.2707655554582,
			"y": -303.25365234672284,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 173.80494689941406,
			"height": 43.86122428405727,
			"seed": 1292879999,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064758,
			"link": null,
			"locked": false,
			"fontSize": 11.696326475748606,
			"fontFamily": 1,
			"text": "在给entity添加新的component时,\n会搜索是否有合适的Archetype,\n若没有, 则需要创建.",
			"rawText": "在给entity添加新的component时,\n会搜索是否有合适的Archetype,\n若没有, 则需要创建.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "在给entity添加新的component时,\n会搜索是否有合适的Archetype,\n若没有, 则需要创建.",
			"lineHeight": 1.25,
			"baseline": 39
		},
		{
			"type": "text",
			"version": 377,
			"versionNonce": 1393546792,
			"isDeleted": false,
			"id": "zfFGN27k",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -966.9715119181094,
			"y": 24.146348222826532,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 151.7308807373047,
			"height": 42.71048879213853,
			"seed": 1519292465,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572725251,
			"link": null,
			"locked": false,
			"fontSize": 11.389463677903608,
			"fontFamily": 1,
			"text": "然后在该Archetype所拥有的\nDataChunk中申请一块存放该\nentity component的空间.",
			"rawText": "然后在该Archetype所拥有的\nDataChunk中申请一块存放该\nentity component的空间.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "然后在该Archetype所拥有的\nDataChunk中申请一块存放该\nentity component的空间.",
			"lineHeight": 1.25,
			"baseline": 38
		},
		{
			"type": "text",
			"version": 181,
			"versionNonce": 679481432,
			"isDeleted": false,
			"id": "btCmy5eL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1032.531766807966,
			"y": -2.245365311072419,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 173.6483917236328,
			"height": 20,
			"seed": 1271234591,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572101970,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "set_entity_archetype",
			"rawText": "set_entity_archetype",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "set_entity_archetype",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 72,
			"versionNonce": 498995544,
			"isDeleted": false,
			"id": "qZJKyjTH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -258.06141933786506,
			"y": -217.4268252260337,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 186.0000457763672,
			"height": 40,
			"seed": 386041640,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691573093153,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "提升灵活性 + 内存局部性\n在unity中, 逻辑也是组件",
			"rawText": "提升灵活性 + 内存局部性\n在unity中, 逻辑也是组件",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "提升灵活性 + 内存局部性\n在unity中, 逻辑也是组件",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 438,
			"versionNonce": 1120101208,
			"isDeleted": false,
			"id": "5y6NwLfh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -953.295847552648,
			"y": -68.50464255685793,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 162.41635131835938,
			"height": 20,
			"seed": 734671960,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572186938,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "build_component_list",
			"rawText": "build_component_list",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "build_component_list",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 29,
			"versionNonce": 1336735320,
			"isDeleted": false,
			"id": "hA74l2lv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1023.46502498772,
			"y": -231.88064783414706,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 81.63218688964844,
			"height": 20,
			"seed": 1573348392,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064759,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "find match",
			"rawText": "find match",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "find match",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 117,
			"versionNonce": 1090726952,
			"isDeleted": false,
			"id": "U-2rG13cCfCAIZtL_C18v",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1056.9787640006577,
			"y": -301.33665767255434,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 29.6280881128871,
			"height": 82.08437526357227,
			"seed": 231873832,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572064759,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.4857063625063347
				],
				[
					0,
					1.457119087519004
				],
				[
					0,
					2.4285318125316735
				],
				[
					0,
					3.399944537544343
				],
				[
					0,
					4.371357262557069
				],
				[
					0,
					5.82847635007613
				],
				[
					0.4857063625063347,
					6.7998890750887995
				],
				[
					0.4857063625063347,
					7.771301800101469
				],
				[
					0.4857063625063347,
					9.22842088762053
				],
				[
					0.4857063625063347,
					10.68553997513959
				],
				[
					0.4857063625063347,
					11.65695270015226
				],
				[
					0.4857063625063347,
					13.599778150177599
				],
				[
					0.4857063625063347,
					15.05689723769666
				],
				[
					0.4857063625063347,
					16.028309962709386
				],
				[
					0.4857063625063347,
					19.42825450025373
				],
				[
					0.4857063625063347,
					21.856786312785516
				],
				[
					0.4857063625063347,
					23.799611762810855
				],
				[
					0.4857063625063347,
					26.228143575342585
				],
				[
					0.4857063625063347,
					28.17096902536798
				],
				[
					0.4857063625063347,
					29.628088112886985
				],
				[
					0.4857063625063347,
					31.57091356291238
				],
				[
					0.4857063625063347,
					33.513739012937776
				],
				[
					0.4857063625063347,
					34.97085810045678
				],
				[
					0.4857063625063347,
					36.913683550482176
				],
				[
					0.4857063625063347,
					38.37080263800124
				],
				[
					0.4857063625063347,
					39.82792172552024
				],
				[
					0.4857063625063347,
					42.742159900558306
				],
				[
					0.4857063625063347,
					43.71357262557103
				],
				[
					0.4857063625063347,
					45.17069171309004
				],
				[
					0.4857063625063347,
					47.59922352562177
				],
				[
					0.4857063625063347,
					49.0563426131408
				],
				[
					0.4857063625063347,
					50.99916806316617
				],
				[
					0.4857063625063347,
					52.94199351319156
				],
				[
					0.4857063625063347,
					54.399112600710595
				],
				[
					0.4857063625063347,
					55.85623168822963
				],
				[
					0.4857063625063347,
					57.799057138254994
				],
				[
					0.4857063625063347,
					59.74188258828039
				],
				[
					0.4857063625063347,
					61.19900167579942
				],
				[
					0.4857063625063347,
					62.656120763318455
				],
				[
					0.4857063625063347,
					64.11323985083749
				],
				[
					0.4857063625063347,
					65.57035893835652
				],
				[
					0.4857063625063347,
					67.51318438838192
				],
				[
					0.4857063625063347,
					68.97030347590095
				],
				[
					0.4857063625063347,
					70.42742256341998
				],
				[
					0.4857063625063347,
					71.88454165093901
				],
				[
					0.4857063625063347,
					72.85595437595171
				],
				[
					0.4857063625063347,
					73.82736710096438
				],
				[
					0.4857063625063347,
					74.79877982597708
				],
				[
					0.4857063625063347,
					75.28448618848341
				],
				[
					0.4857063625063347,
					75.77019255098978
				],
				[
					0.4857063625063347,
					76.25589891349611
				],
				[
					0.4857063625063347,
					76.74160527600245
				],
				[
					0.9714127250126694,
					77.22731163850881
				],
				[
					0.9714127250126694,
					77.71301800101514
				],
				[
					0.9714127250126694,
					78.19872436352148
				],
				[
					1.457119087519004,
					78.19872436352148
				],
				[
					1.9428254500253388,
					78.68443072602784
				],
				[
					2.4285318125316735,
					79.17013708853418
				],
				[
					3.399944537544343,
					80.14154981354687
				],
				[
					3.8856509000506776,
					80.62725617605321
				],
				[
					5.342769987569682,
					81.11296253855954
				],
				[
					6.3141827125825785,
					81.59866890106588
				],
				[
					7.285595437595248,
					82.08437526357227
				],
				[
					8.257008162607917,
					82.08437526357227
				],
				[
					9.714127250126921,
					82.08437526357227
				],
				[
					10.199833612633256,
					82.08437526357227
				],
				[
					10.68553997513959,
					82.08437526357227
				],
				[
					11.171246337645925,
					81.59866890106588
				],
				[
					12.62836542516493,
					81.59866890106588
				],
				[
					13.114071787671264,
					81.59866890106588
				],
				[
					14.085484512683934,
					81.11296253855954
				],
				[
					14.571190875190268,
					81.11296253855954
				],
				[
					16.028309962709272,
					81.11296253855954
				],
				[
					17.485429050228277,
					80.62725617605321
				],
				[
					18.456841775241173,
					80.62725617605321
				],
				[
					19.913960862760177,
					80.14154981354687
				],
				[
					20.399667225266512,
					80.14154981354687
				],
				[
					20.885373587772847,
					80.14154981354687
				],
				[
					21.37107995027918,
					80.14154981354687
				],
				[
					22.828199037798186,
					80.14154981354687
				],
				[
					24.28531812531719,
					80.62725617605321
				],
				[
					25.25673085032986,
					80.62725617605321
				],
				[
					26.22814357534253,
					81.11296253855954
				],
				[
					27.68526266286176,
					81.11296253855954
				],
				[
					28.170969025368095,
					81.59866890106588
				],
				[
					29.142381750380764,
					81.59866890106588
				],
				[
					29.6280881128871,
					82.08437526357227
				],
				[
					29.6280881128871,
					82.08437526357227
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "line",
			"version": 218,
			"versionNonce": 1776661336,
			"isDeleted": false,
			"id": "rRvk83a1J60um8OOj6bwd",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1056.9787640006577,
			"y": -231.3949414716407,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 20.885373587772847,
			"height": 243.8245939781851,
			"seed": 1638497320,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691572199231,
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
					-0.4857063625063347,
					214.19650586529806
				],
				[
					20.399667225266512,
					243.8245939781851
				]
			]
		},
		{
			"type": "line",
			"version": 182,
			"versionNonce": 1971737688,
			"isDeleted": false,
			"id": "qPiP6Nn65vhGzYD-su0g1",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1018.6079613626565,
			"y": -218.2808696839694,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.228143575342642,
			"height": 121.91229698909251,
			"seed": 1049330728,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691572064760,
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
					-3.8856509000507913,
					107.34110611390224
				],
				[
					22.34249267529185,
					121.91229698909251
				]
			]
		},
		{
			"type": "text",
			"version": 63,
			"versionNonce": 1695590232,
			"isDeleted": false,
			"id": "WpnaxnHg",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -990.9226986997949,
			"y": -107.05411267001648,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 207.74441528320312,
			"height": 20,
			"seed": 1796246104,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572184340,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "else create new Archetype",
			"rawText": "else create new Archetype",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "else create new Archetype",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "line",
			"version": 120,
			"versionNonce": 1157491752,
			"isDeleted": false,
			"id": "Qt86JgT0C22c-qDvrzpsp",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1021.0364931751883,
			"y": -178.4529479584491,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.71384993784909,
			"height": 11.171246337645925,
			"seed": 857200680,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691572076593,
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
					0.9714127250127831,
					11.171246337645925
				],
				[
					26.71384993784909,
					11.171246337645925
				]
			]
		},
		{
			"type": "text",
			"version": 27,
			"versionNonce": 70659416,
			"isDeleted": false,
			"id": "nD4GpUIC",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -988.0084605247569,
			"y": -177.48153523343643,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 131.53628540039062,
			"height": 20,
			"seed": 197289816,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572096367,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "return archetype",
			"rawText": "return archetype",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "return archetype",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "line",
			"version": 220,
			"versionNonce": 1278709800,
			"isDeleted": false,
			"id": "ZFJrjTTObNFznJONKArJ3",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -979.7514523621489,
			"y": -91.02580270730704,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 17.971135412734725,
			"height": 75.28448618848347,
			"seed": 604515160,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691572137449,
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
					1.457119087519004,
					69.94171620091362
				],
				[
					17.971135412734725,
					75.28448618848347
				]
			]
		},
		{
			"type": "line",
			"version": 75,
			"versionNonce": 1575860824,
			"isDeleted": false,
			"id": "tjhY4GHhetjW-mH5UVxlC",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -980.4473091290985,
			"y": -71.11184184454692,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 19.63840490469704,
			"height": 13.599778150177656,
			"seed": 257206824,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691572855973,
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
					3.124388579481206,
					13.599778150177656
				],
				[
					19.63840490469704,
					12.628365425164986
				]
			]
		},
		{
			"type": "text",
			"version": 15,
			"versionNonce": 810411352,
			"isDeleted": false,
			"id": "JQq3kbnI",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -957.8946660493634,
			"y": -28.855388306495,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 231.00851440429688,
			"height": 20,
			"seed": 1247984984,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572208822,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "create_chunk_for_archetype",
			"rawText": "create_chunk_for_archetype",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "create_chunk_for_archetype",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "line",
			"version": 122,
			"versionNonce": 1689676632,
			"isDeleted": false,
			"id": "CdmuH8nW6flSAsL8VHyc8",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1006.2366206213509,
			"y": 20.277365021649473,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 41.75140601696842,
			"height": 118.99150714835986,
			"seed": 33739048,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691572745168,
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
					-0.6958567669495324,
					109.2495124110672
				],
				[
					41.055549250018885,
					118.99150714835986
				]
			]
		},
		{
			"type": "text",
			"version": 118,
			"versionNonce": 211745576,
			"isDeleted": false,
			"id": "uuVkMslm",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -961.0059307696351,
			"y": 126.74345036491877,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 136.09629821777344,
			"height": 20,
			"seed": 2109540952,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572765100,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "if entity is empty",
			"rawText": "if entity is empty",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "if entity is empty",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "line",
			"version": 153,
			"versionNonce": 1728743512,
			"isDeleted": false,
			"id": "7inZkZLes1uOyUj94x-V5",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -944.3053683628477,
			"y": 144.83572630560514,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 37.57626541527145,
			"height": 46.622403385614575,
			"seed": 1296018264,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691572807280,
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
					4.175140601696853,
					41.05554925001877
				],
				[
					37.57626541527145,
					46.622403385614575
				]
			]
		},
		{
			"type": "text",
			"version": 47,
			"versionNonce": 864569128,
			"isDeleted": false,
			"id": "zlDBO5pr",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -902.5539623458794,
			"y": 181.02027818697763,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 203.88844299316406,
			"height": 20,
			"seed": 1245658920,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572800128,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "find free chunk and insert",
			"rawText": "find free chunk and insert",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "find free chunk and insert",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "line",
			"version": 101,
			"versionNonce": 1083892520,
			"isDeleted": false,
			"id": "ks6TYCGoUYXDxibZTv-C9",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -943.6095115958983,
			"y": 168.49485638188708,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 39.663835716119934,
			"height": 80.71938496613893,
			"seed": 1917304152,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691572863513,
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
					3.4792838347474344,
					74.4566740635936
				],
				[
					39.663835716119934,
					80.71938496613893
				]
			]
		},
		{
			"type": "text",
			"version": 35,
			"versionNonce": 840691800,
			"isDeleted": false,
			"id": "HPGfQtit",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -896.9871082102836,
			"y": 237.38467630988498,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 198.57640075683594,
			"height": 20,
			"seed": 1852129624,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572844532,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "move entity to Archetype",
			"rawText": "move entity to Archetype",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "move entity to Archetype",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 40,
			"versionNonce": 2133487192,
			"isDeleted": false,
			"id": "Ceb0eMnT",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1121.052987168014,
			"y": 286.79050676329723,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 174.0643768310547,
			"height": 20,
			"seed": 66844248,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691572926146,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "get_entity_component",
			"rawText": "get_entity_component",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "get_entity_component",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 130,
			"versionNonce": 292564776,
			"isDeleted": false,
			"id": "mNfcyzt4",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1090.4352894222372,
			"y": 313.2330639073772,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 305.35076904296875,
			"height": 46.374956297249696,
			"seed": 1005893720,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691573030562,
			"link": null,
			"locked": false,
			"fontSize": 12.366655012599919,
			"fontFamily": 1,
			"text": "获取entity所属的data chunk和在index.\n在data chunk中获取该类型的component的内存offset,\n配合index获取数据reference.",
			"rawText": "获取entity所属的data chunk和在index.\n在data chunk中获取该类型的component的内存offset,\n配合index获取数据reference.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "获取entity所属的data chunk和在index.\n在data chunk中获取该类型的component的内存offset,\n配合index获取数据reference.",
			"lineHeight": 1.25,
			"baseline": 41
		},
		{
			"type": "text",
			"version": 281,
			"versionNonce": 285240152,
			"isDeleted": false,
			"id": "9OhOOl5o",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 43.470932143248774,
			"y": -163.37591699948462,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 266.6563720703125,
			"height": 40,
			"seed": 1179319336,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691581870563,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "程序性能分析: perf, valgrind\n缓存命中分析: cachegrind, perf mem",
			"rawText": "程序性能分析: perf, valgrind\n缓存命中分析: cachegrind, perf mem",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "程序性能分析: perf, valgrind\n缓存命中分析: cachegrind, perf mem",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "line",
			"version": 30,
			"versionNonce": 420658008,
			"isDeleted": false,
			"id": "-7lRQ3nom3hK3FJ99AJ72",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -71.3280551121452,
			"y": -210.79288999627795,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 103.56865154562706,
			"height": 57.3994936276971,
			"seed": 1592496424,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1691581875325,
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
					103.56865154562706,
					57.3994936276971
				]
			]
		},
		{
			"type": "text",
			"version": 20,
			"versionNonce": 1913504600,
			"isDeleted": false,
			"id": "SuG1cFdW",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 54.670821712239444,
			"y": -431.3454129464943,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 245.4881591796875,
			"height": 20,
			"seed": 1901285416,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691585564192,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "alignas: 只有在特殊情况下才需要.",
			"rawText": "alignas: 只有在特殊情况下才需要.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "alignas: 只有在特殊情况下才需要.",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 33,
			"versionNonce": 900930088,
			"isDeleted": false,
			"id": "TYNx4xEf",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 55.64281782298747,
			"y": -373.0256463016111,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 251.48814392089844,
			"height": 20,
			"seed": 1405537624,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1691585596568,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "c++ Pmr: 针对一些特定的应用场景",
			"rawText": "c++ Pmr: 针对一些特定的应用场景",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c++ Pmr: 针对一些特定的应用场景",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 34,
			"versionNonce": 680839072,
			"isDeleted": false,
			"id": "oweSLIxH",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 54.124382470897785,
			"y": -113.18194661188602,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 195.34793090820312,
			"height": 20,
			"seed": 1522837088,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1692081288509,
			"link": "https://skypjack.github.io/entt/md_docs_md_entity.html",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[entt crash course]]",
			"rawText": "[entt crash course](https://skypjack.github.io/entt/md_docs_md_entity.html)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[entt crash course]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 208,
			"versionNonce": 54214008,
			"isDeleted": false,
			"id": "mXUwRtws",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 51.41724176109665,
			"y": -58.50974104490058,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 761.697021484375,
			"height": 80,
			"seed": 381941624,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1692152440856,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "vulkan-samples:\n1. 以scene_graph为主, 其中的node可以添加component. 主要的component是Mesh(包含材质==renderable)\n2. scene_graph只存储数据, 由各个pass(system), 进行相关事务的处理.\n3. 节点之间有明确的父子关系, 通过向上查找更新节点的world transform.",
			"rawText": "vulkan-samples:\n1. 以scene_graph为主, 其中的node可以添加component. 主要的component是Mesh(包含材质==renderable)\n2. scene_graph只存储数据, 由各个pass(system), 进行相关事务的处理.\n3. 节点之间有明确的父子关系, 通过向上查找更新节点的world transform.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "vulkan-samples:\n1. 以scene_graph为主, 其中的node可以添加component. 主要的component是Mesh(包含材质==renderable)\n2. scene_graph只存储数据, 由各个pass(system), 进行相关事务的处理.\n3. 节点之间有明确的父子关系, 通过向上查找更新节点的world transform.",
			"lineHeight": 1.25,
			"baseline": 74
		},
		{
			"type": "text",
			"version": 405,
			"versionNonce": 1183597944,
			"isDeleted": false,
			"id": "okDtks7D",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 55.04018949500289,
			"y": 55.089068478908985,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 812.8490600585938,
			"height": 120,
			"seed": 178033672,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1692152444676,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "filament:\n1. filament中通过几个不同的Manager与entt::registry类似, 将entity分为几个大类: Renderable, Light, Camera \n2. 由FScene::prepare负责将scene中的entity转化为可渲染的集合数据mRenderableData\n    主要处理light, renderable\n3. filament中View来定义了一个场景的渲染配置. 比如: 相机、阴影、后处理等.\n4. 在节点更新时同时更新其所有子节点. 通过child、next指针实现父子节点树(每个节点大小固定).",
			"rawText": "filament:\n1. filament中通过几个不同的Manager与entt::registry类似, 将entity分为几个大类: Renderable, Light, Camera \n2. 由FScene::prepare负责将scene中的entity转化为可渲染的集合数据mRenderableData\n    主要处理light, renderable\n3. filament中View来定义了一个场景的渲染配置. 比如: 相机、阴影、后处理等.\n4. 在节点更新时同时更新其所有子节点. 通过child、next指针实现父子节点树(每个节点大小固定).",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "filament:\n1. filament中通过几个不同的Manager与entt::registry类似, 将entity分为几个大类: Renderable, Light, Camera \n2. 由FScene::prepare负责将scene中的entity转化为可渲染的集合数据mRenderableData\n    主要处理light, renderable\n3. filament中View来定义了一个场景的渲染配置. 比如: 相机、阴影、后处理等.\n4. 在节点更新时同时更新其所有子节点. 通过child、next指针实现父子节点树(每个节点大小固定).",
			"lineHeight": 1.25,
			"baseline": 114
		},
		{
			"id": "g9nlQL6E",
			"type": "text",
			"x": -1029.2922487465155,
			"y": 502.2789421100987,
			"width": 49.568115234375,
			"height": 60,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 834085253,
			"version": 17,
			"versionNonce": 1867573925,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1693301422122,
			"link": null,
			"locked": false,
			"text": "assimp\n\n",
			"rawText": "assimp\n\n",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "left",
			"verticalAlign": "top",
			"baseline": 54,
			"containerId": null,
			"originalText": "assimp\n\n",
			"lineHeight": 1.25
		},
		{
			"id": "ioB3-rgMTjRPHbyglyiyT",
			"type": "image",
			"x": -1029.7360817122014,
			"y": 530.9119241590906,
			"width": 800,
			"height": 459,
			"angle": 0,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 1150848613,
			"version": 137,
			"versionNonce": 198042795,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1693301431617,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "2f4019311d325714a77e2978072fa603d7b99307",
			"scale": [
				1,
				1
			]
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#1e1e1e",
		"currentItemBackgroundColor": "transparent",
		"currentItemFillStyle": "hachure",
		"currentItemStrokeWidth": 2,
		"currentItemStrokeStyle": "solid",
		"currentItemRoughness": 0,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 16,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 1085.4416876864645,
		"scrollY": -306.58240630174106,
		"zoom": {
			"value": 1.7778908657561472
		},
		"currentItemRoundness": "round",
		"gridSize": null,
		"currentStrokeOptions": null,
		"previousGridSize": null
	},
	"files": {}
}
```
%%