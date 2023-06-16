---

excalidraw-plugin: parsed
tags: [excalidraw]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Text Elements
view Frustum裁剪 ^dUgMyajs

输入装配器(Input Assembler, IA)阶段会从显卡存储中读取几何数据(顶点和索引), 再将它们依据图元拓扑(Primitive Topology)装配为几何图元(Geometric Primitive), 送入后续的阶段.

待图元被装配完毕后, 其顶点就会被送入顶点着色器阶段(Vertex Shader Stage), 顶点着色器对数据的处理是逐顶点的, 在这一阶段我们要完成顶点的坐标变换和数据传递, 使所有顶点处于齐次裁剪空间中, 由硬件完成透视除法(齐次除法)后, 所有的顶点都位于规范化设备坐标(Normalized Device Coordinates, NDC)空间中. 

曲面细分阶段(Tessellation Stage, 可选阶段)是利用镶嵌化处理技术对网格中的三角形进行细分(subdivide), 以此来增加物体表面上的三角形面数量. 再将这些新增的三角形偏移到适当的位置, 使网格表现出更加细腻的细节. 

几何着色器阶段(Geometry Shader, 可选阶段)对数据的处理是逐图元的, 处理类型由图元拓扑而定, 可以根据自己的需求创建和销毁几何体之后将数据输出. 

裁剪阶段, 为了优化, 在这个阶段中所有位于视锥体(Viewing Frustum)外的几何体和几何体部分将会被裁剪(clip)和丢弃. 

Rasterization Stage, 对几何着色器的输出进行光栅化, 转化为像素数据, 交给像素着色器去计算颜色. 内容包括: 视口变换(同时执行透视除法), 背面剔除(依据三角形的绕序对背面三角形进行剔除, 使需要处理的三角形数量减少为原来的一半), 顶点属性插值, 透视校正插值(根据三角形顶点的属性值计算出其内部像素的属性值, 透视校正插值确保了这个属性是线性的). 

像素着色器阶段(Pixel Shader Stage, 或者按Khronos的说法叫片元着色器, Fragment Shader)对数据的处理是逐像素的, 它会针对每一个像素片元(pixel fragment)进行处理, 计算出对应的像素颜色. 在此阶段实现光照, 反射, 阴影等复杂效果. 

在最后的输出合并阶段(Output Merger Stage, OM), 一些像素片元可能会被丢失(例如未通过深度测试或者模板测试), 然后, 剩下的像素片元会被写入后台缓冲区中, 颜色混合(blend)操作就是在这阶段实现的, 可用于实现透明效果. 

rerer to: https://zhuanlan.zhihu.com/p/536049700 ^n14VrVMb

深度、模板测试在什么阶段完成? 与GPU是否相关, TBDR ^NHlbjbmQ

Alpha Test
depth test
alpha test ^H0hZ3wuH

[reference](http://geekfaner.com/shineengine/blog20_Vulkanv1.2_6.html) ^QLh42c9O


# Embedded files
ef0d69d76a169f0bdaf0023a551060eafb2460e1: [[render_pipeline_detail.png]]
54b05288950c5d3ba66548a426dc441864988990: [[coordinate_transform.png]]
0c37acad4a3ea9580f10635b47a29b98789a0ccd: [[Pasted Image 20230615102930_080.png]]

%%
# Drawing
```json
{
	"type": "excalidraw",
	"version": 2,
	"source": "https://excalidraw.com",
	"elements": [
		{
			"type": "image",
			"version": 192,
			"versionNonce": 311882384,
			"isDeleted": false,
			"id": "jWZmnsX_z8cm6V_zfa8T-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -644.75,
			"y": -418.9453125,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 403.00000000000006,
			"height": 643,
			"seed": 1304789648,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1684978632502,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "ef0d69d76a169f0bdaf0023a551060eafb2460e1",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 495,
			"versionNonce": 556119152,
			"isDeleted": false,
			"id": "fhw7aatmwpQ_VACu7A6JA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -340.44264279943013,
			"y": 289.6326158982903,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 759,
			"height": 328.447789275635,
			"seed": 1739349104,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1684978641616,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "54b05288950c5d3ba66548a426dc441864988990",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 463,
			"versionNonce": 1715085456,
			"isDeleted": false,
			"id": "yAJe4W3oov7mTEM1MEUpk",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -862.2597410497864,
			"y": -76.27702232503555,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 191,
			"height": 47,
			"seed": 18379920,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "dUgMyajs"
				}
			],
			"updated": 1684978632502,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 439,
			"versionNonce": 814130205,
			"isDeleted": false,
			"id": "dUgMyajs",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -833.7597410497864,
			"y": -62.777022325035546,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 134,
			"height": 20,
			"seed": 943816304,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686796065523,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "view Frustum裁剪",
			"rawText": "view Frustum裁剪",
			"baseline": 14,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "yAJe4W3oov7mTEM1MEUpk",
			"originalText": "view Frustum裁剪"
		},
		{
			"type": "rectangle",
			"version": 870,
			"versionNonce": 1644349040,
			"isDeleted": false,
			"id": "DR6mjzwd4gLEWcM8MA9-t",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -342.25,
			"y": -392.4453125,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 816,
			"height": 632,
			"seed": 853963920,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "n14VrVMb"
				}
			],
			"updated": 1684978644875,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 749,
			"versionNonce": 2075850803,
			"isDeleted": false,
			"id": "n14VrVMb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -337.25,
			"y": -386.4453125,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 806,
			"height": 620,
			"seed": 88869520,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1686796065531,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "输入装配器(Input Assembler, IA)阶段会从显卡存储中读取几何数据(顶点和索引), \n再将它们依据图元拓扑(Primitive Topology)装配为几何图元(Geometric Primitive), 送入后续的阶段.\n\n待图元被装配完毕后, 其顶点就会被送入顶点着色器阶段(Vertex Shader Stage), \n顶点着色器对数据的处理是逐顶点的, 在这一阶段我们要完成顶点的坐标变换和数据传递, \n使所有顶点处于齐次裁剪空间中, 由硬件完成透视除法(齐次除法)后, \n所有的顶点都位于规范化设备坐标(Normalized Device Coordinates, NDC)空间中. \n\n曲面细分阶段(Tessellation Stage, 可选阶段)是利用镶嵌化处理技术对网格中的三角形进行细分(subdivide), \n以此来增加物体表面上的三角形面数量. 再将这些新增的三角形偏移到适当的位置, 使网格表现出更加细腻的细节. \n\n几何着色器阶段(Geometry Shader, 可选阶段)对数据的处理是逐图元的, 处理类型由图元拓扑而定, \n可以根据自己的需求创建和销毁几何体之后将数据输出. \n\n裁剪阶段, 为了优化, 在这个阶段中所有位于视锥体(Viewing \nFrustum)外的几何体和几何体部分将会被裁剪(clip)和丢弃. \n\nRasterization Stage, 对几何着色器的输出进行光栅化, 转化为像素数据, 交给像素着色器去计算颜色. \n内容包括: 视口变换(同时执行透视除法), 背面剔除(依据三角形的绕序对背面三角形进行剔除, \n使需要处理的三角形数量减少为原来的一半), 顶点属性插值, \n透视校正插值(根据三角形顶点的属性值计算出其内部像素的属性值, 透视校正插值确保了这个属性是线性的). \n\n像素着色器阶段(Pixel Shader Stage, 或者按Khronos的说法叫片元着色器, Fragment \nShader)对数据的处理是逐像素的, 它会针对每一个像素片元(pixel fragment)进行处理, 计算出对应的像素颜色. \n在此阶段实现光照, 反射, 阴影等复杂效果. \n\n在最后的输出合并阶段(Output Merger Stage, OM), \n一些像素片元可能会被丢失(例如未通过深度测试或者模板测试), 然后, 剩下的像素片元会被写入后台缓冲区中, \n颜色混合(blend)操作就是在这阶段实现的, 可用于实现透明效果. \n\nrerer to: https://zhuanlan.zhihu.com/p/536049700",
			"rawText": "输入装配器(Input Assembler, IA)阶段会从显卡存储中读取几何数据(顶点和索引), 再将它们依据图元拓扑(Primitive Topology)装配为几何图元(Geometric Primitive), 送入后续的阶段.\n\n待图元被装配完毕后, 其顶点就会被送入顶点着色器阶段(Vertex Shader Stage), 顶点着色器对数据的处理是逐顶点的, 在这一阶段我们要完成顶点的坐标变换和数据传递, 使所有顶点处于齐次裁剪空间中, 由硬件完成透视除法(齐次除法)后, 所有的顶点都位于规范化设备坐标(Normalized Device Coordinates, NDC)空间中. \n\n曲面细分阶段(Tessellation Stage, 可选阶段)是利用镶嵌化处理技术对网格中的三角形进行细分(subdivide), 以此来增加物体表面上的三角形面数量. 再将这些新增的三角形偏移到适当的位置, 使网格表现出更加细腻的细节. \n\n几何着色器阶段(Geometry Shader, 可选阶段)对数据的处理是逐图元的, 处理类型由图元拓扑而定, 可以根据自己的需求创建和销毁几何体之后将数据输出. \n\n裁剪阶段, 为了优化, 在这个阶段中所有位于视锥体(Viewing Frustum)外的几何体和几何体部分将会被裁剪(clip)和丢弃. \n\nRasterization Stage, 对几何着色器的输出进行光栅化, 转化为像素数据, 交给像素着色器去计算颜色. 内容包括: 视口变换(同时执行透视除法), 背面剔除(依据三角形的绕序对背面三角形进行剔除, 使需要处理的三角形数量减少为原来的一半), 顶点属性插值, 透视校正插值(根据三角形顶点的属性值计算出其内部像素的属性值, 透视校正插值确保了这个属性是线性的). \n\n像素着色器阶段(Pixel Shader Stage, 或者按Khronos的说法叫片元着色器, Fragment Shader)对数据的处理是逐像素的, 它会针对每一个像素片元(pixel fragment)进行处理, 计算出对应的像素颜色. 在此阶段实现光照, 反射, 阴影等复杂效果. \n\n在最后的输出合并阶段(Output Merger Stage, OM), 一些像素片元可能会被丢失(例如未通过深度测试或者模板测试), 然后, 剩下的像素片元会被写入后台缓冲区中, 颜色混合(blend)操作就是在这阶段实现的, 可用于实现透明效果. \n\nrerer to: https://zhuanlan.zhihu.com/p/536049700",
			"baseline": 614,
			"textAlign": "left",
			"verticalAlign": "middle",
			"containerId": "DR6mjzwd4gLEWcM8MA9-t",
			"originalText": "输入装配器(Input Assembler, IA)阶段会从显卡存储中读取几何数据(顶点和索引), 再将它们依据图元拓扑(Primitive Topology)装配为几何图元(Geometric Primitive), 送入后续的阶段.\n\n待图元被装配完毕后, 其顶点就会被送入顶点着色器阶段(Vertex Shader Stage), 顶点着色器对数据的处理是逐顶点的, 在这一阶段我们要完成顶点的坐标变换和数据传递, 使所有顶点处于齐次裁剪空间中, 由硬件完成透视除法(齐次除法)后, 所有的顶点都位于规范化设备坐标(Normalized Device Coordinates, NDC)空间中. \n\n曲面细分阶段(Tessellation Stage, 可选阶段)是利用镶嵌化处理技术对网格中的三角形进行细分(subdivide), 以此来增加物体表面上的三角形面数量. 再将这些新增的三角形偏移到适当的位置, 使网格表现出更加细腻的细节. \n\n几何着色器阶段(Geometry Shader, 可选阶段)对数据的处理是逐图元的, 处理类型由图元拓扑而定, 可以根据自己的需求创建和销毁几何体之后将数据输出. \n\n裁剪阶段, 为了优化, 在这个阶段中所有位于视锥体(Viewing Frustum)外的几何体和几何体部分将会被裁剪(clip)和丢弃. \n\nRasterization Stage, 对几何着色器的输出进行光栅化, 转化为像素数据, 交给像素着色器去计算颜色. 内容包括: 视口变换(同时执行透视除法), 背面剔除(依据三角形的绕序对背面三角形进行剔除, 使需要处理的三角形数量减少为原来的一半), 顶点属性插值, 透视校正插值(根据三角形顶点的属性值计算出其内部像素的属性值, 透视校正插值确保了这个属性是线性的). \n\n像素着色器阶段(Pixel Shader Stage, 或者按Khronos的说法叫片元着色器, Fragment Shader)对数据的处理是逐像素的, 它会针对每一个像素片元(pixel fragment)进行处理, 计算出对应的像素颜色. 在此阶段实现光照, 反射, 阴影等复杂效果. \n\n在最后的输出合并阶段(Output Merger Stage, OM), 一些像素片元可能会被丢失(例如未通过深度测试或者模板测试), 然后, 剩下的像素片元会被写入后台缓冲区中, 颜色混合(blend)操作就是在这阶段实现的, 可用于实现透明效果. \n\nrerer to: https://zhuanlan.zhihu.com/p/536049700"
		},
		{
			"type": "text",
			"version": 37,
			"versionNonce": 754484336,
			"isDeleted": false,
			"id": "NHlbjbmQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -624.7454503189177,
			"y": 716.6190042655696,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 416,
			"height": 21,
			"seed": 849753232,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1684979564989,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "深度、模板测试在什么阶段完成? 与GPU是否相关, TBDR",
			"rawText": "深度、模板测试在什么阶段完成? 与GPU是否相关, TBDR",
			"baseline": 15,
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "深度、模板测试在什么阶段完成? 与GPU是否相关, TBDR"
		},
		{
			"type": "rectangle",
			"version": 210,
			"versionNonce": 318368912,
			"isDeleted": false,
			"id": "DGmgn5lrpanVkW4MhHn2m",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -870.0146753523394,
			"y": 67.03992593558712,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 193,
			"height": 70,
			"seed": 1179547248,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "H0hZ3wuH"
				}
			],
			"updated": 1684979740554,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 123,
			"versionNonce": 592766064,
			"isDeleted": false,
			"id": "H0hZ3wuH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -818.5146753523394,
			"y": 72.03992593558712,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 90,
			"height": 60,
			"seed": 757125744,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1684979740554,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Alpha Test\ndepth test\nalpha test",
			"rawText": "Alpha Test\ndepth test\nalpha test",
			"baseline": 54,
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "DGmgn5lrpanVkW4MhHn2m",
			"originalText": "Alpha Test\ndepth test\nalpha test"
		},
		{
			"id": "wQjfwUiYrid40WZ8XcDJc",
			"type": "image",
			"x": -1709.9668015154527,
			"y": -305.1577348379767,
			"width": 806.8235712773895,
			"height": 476.250024712348,
			"angle": 0,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 1689483731,
			"version": 76,
			"versionNonce": 485376797,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686796153664,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "0c37acad4a3ea9580f10635b47a29b98789a0ccd",
			"scale": [
				1,
				1
			]
		},
		{
			"id": "QLh42c9O",
			"type": "text",
			"x": -1684.6686718605004,
			"y": -324.4247809290524,
			"width": 126,
			"height": 21,
			"angle": 0,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 107564189,
			"version": 23,
			"versionNonce": 1790394941,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1686796185110,
			"link": "http://geekfaner.com/shineengine/blog20_Vulkanv1.2_6.html",
			"locked": false,
			"text": "🌐[[reference]]",
			"rawText": "[reference](http://geekfaner.com/shineengine/blog20_Vulkanv1.2_6.html)",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "left",
			"verticalAlign": "top",
			"baseline": 15,
			"containerId": null,
			"originalText": "🌐[[reference]]"
		},
		{
			"id": "KChL1pqw",
			"type": "text",
			"x": -1626.9413961377916,
			"y": 180.68888164465,
			"width": 10,
			"height": 20,
			"angle": 0,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 947333843,
			"version": 3,
			"versionNonce": 747657331,
			"isDeleted": true,
			"boundElements": null,
			"updated": 1686796157998,
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
			"originalText": ""
		},
		{
			"id": "xf2Wo8jJ",
			"type": "text",
			"x": -1585.0891212388276,
			"y": -326.589553768654,
			"width": 10,
			"height": 20,
			"angle": 0,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 1485567155,
			"version": 3,
			"versionNonce": 1731257939,
			"isDeleted": true,
			"boundElements": null,
			"updated": 1686796173827,
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
			"originalText": ""
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#000000",
		"currentItemBackgroundColor": "transparent",
		"currentItemFillStyle": "hachure",
		"currentItemStrokeWidth": 1,
		"currentItemStrokeStyle": "solid",
		"currentItemRoughness": 1,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 16,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 1782.0834496425716,
		"scrollY": 497.90144157229474,
		"zoom": {
			"value": 1.3858266997437654
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