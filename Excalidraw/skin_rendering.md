---

excalidraw-plugin: parsed
tags: [excalidraw]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Text Elements
specular surface reflectance ^3zUykEc8

Kelemen/Szirmay-Kalos specular BRDF ^KxH9JwdT

Torrance/Sparrow specular BRDF ^P3vC6rsj

diffuse subsurface scattering ^rqkZS86x

是光在传播时的一种现象, 表现为光在穿过透明物体表面后,
与材料之间发生交互作用而导致光被散射开来, 光路也在其他的位置穿出物体. ^O7gE1Rah

Skin Material ^XhqwceMi

真实的皮肤材质需要考虑的因素:
wrinkles
pores 毛孔
freckles 雀斑
hair follicles
scars ^9RZGfqHN

[Substance 3D Painter: Smart Material for Human Skin Textures](https://www.youtube.com/watch?v=evsEB5474W0) ^fUiS5goz

[The Wikihuman Project](https://vgl.ict.usc.edu/Data/DigitalEmily2/) ^wxQwu46E

从扫描的数据中制作人脸皮肤材质: ^Hqw5PRdY

common material ^4yjBEEzf

surface reflectance ^dMBjGAzj

subsurface scattering ^ldLmmduW

simple specular ^byH0BNTo

simple diffuse calculation ^OzM80W60

对于皮肤材质, 这两部分都需要更精细的模型
才能表现真实的皮肤质感 ^OZRkTGoO

光入射到皮肤之后, 一部分被皮肤表面油脂层
直接反射出去(大约6%), 可以使用BRDF进行近似

还有一部分穿透油脂层, 在皮肤组织上发生散射, 
形成了皮肤的颜色和柔和的质感. ^bLNiHsSH

现实中, 光会和皮肤的多个不同层次的组织发射次表面散射.
在应用中, 在油脂层下, 再添加两层的次表面散射就能够达到逼真的效果.

已有很多很好的皮肤次表面散射的diffusion model的研究, 我们可以通过
一些图片模糊等技巧对diffusion model进行近似, 从而进行实时渲染. ^cPRxR0UM

高效近似 ^LUSJ4jR3

[ref 1](https://huangx916.github.io/2019/04/16/sss/)

[ref 2](https://github.com/QianMo/Game-Programmer-Study-Notes/blob/master/Content/%E3%80%8AGPU%20Gems%203%E3%80%8B%E5%85%A8%E4%B9%A6%E6%8F%90%E7%82%BC%E6%80%BB%E7%BB%93/Part1/README.md)

[ref 3](https://developer.nvidia.com/gpugems/gpugems3/part-iii-rendering/chapter-14-advanced-techniques-realistic-real-time-skin) ^ohCyIHDN

利用预计算的纹理进行高效地计算 ^kh84qRFe

diffusion profile ^VJWCETLw

一束光打到表面后的散射情况, 不同分量沿着距离衰减程度不一样, 从而出现了颜色.
这里假设散射会发生多次, 各个方向是均匀的.
有了diffusion profile, 就可以方便的计算次表面散射 ^LQyYQo3G

对于曲面, 可以直接使用点之间的距离进行近似. ^4jrypWAN

Jensen et al. 2001
dipole model ^KJBGLnhN

多层不同的diffusion profile可以得逼真/丰富的渲染效果 ^s83vPhYK

[腾讯Siren](https://gameinstitute.qq.com/course/detail/10130) ^x2obQR7v


# Embedded files
e4064329b87ded6b621cc344c0aacee8e061dc1f: [[rc/sss_hand.png]]
34aa13c154b7882688ad0ca075e45c98c854cdfe: [[rc/skin_layer_model.png]]
53d9fbad0841de8b068735a6863f3c6932dfb38d: [[rc/skin_sss.png]]
95c524b59fd505dc991ba87fe3fd1d7a8c62474d: [[rc/diffusion_profile.png]]
03a28fa36af783067582ee13cdf307441fffd24f: [[rc/df_profile_curved_surface.png]]
5ab637fd030642d5cd6bca6c164512b7961b2eba: [[rc/multi_layer_df.png]]

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
			"version": 571,
			"versionNonce": 661701972,
			"isDeleted": false,
			"id": "_er1zWZljbOwnW66gIgVM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -985.3455477627838,
			"y": -249.299921209162,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 260,
			"height": 92,
			"seed": 1420664657,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "3zUykEc8",
					"type": "text"
				}
			],
			"updated": 1687861468120,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 906,
			"versionNonce": 1528695122,
			"isDeleted": false,
			"id": "3zUykEc8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -942.9054385098541,
			"y": -228.299921209162,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 175.11978149414062,
			"height": 50,
			"seed": 1667617215,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097343,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "specular surface \nreflectance",
			"rawText": "specular surface reflectance",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "_er1zWZljbOwnW66gIgVM",
			"originalText": "specular surface reflectance",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "rectangle",
			"version": 6,
			"versionNonce": 2035612372,
			"isDeleted": false,
			"id": "dAY-faOi4uk4xSPacrjIm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -635.8687411221586,
			"y": -166.53057306463052,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 381,
			"height": 35,
			"seed": 1733965652,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "doqMqplreSn1QrUIjU8nN",
					"type": "arrow"
				},
				{
					"id": "KxH9JwdT",
					"type": "text"
				}
			],
			"updated": 1687861468120,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 483,
			"versionNonce": 1499815122,
			"isDeleted": false,
			"id": "KxH9JwdT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -630.7485476407132,
			"y": -161.53057306463052,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 370.7596130371094,
			"height": 25,
			"seed": 171705535,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097344,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Kelemen/Szirmay-Kalos specular BRDF",
			"rawText": "Kelemen/Szirmay-Kalos specular BRDF",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "dAY-faOi4uk4xSPacrjIm",
			"originalText": "Kelemen/Szirmay-Kalos specular BRDF",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 6,
			"versionNonce": 1008107604,
			"isDeleted": false,
			"id": "xv5HOuU33yMRWcqXKZJQW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -635.8687411221586,
			"y": -323.29982261390944,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 340,
			"height": 35,
			"seed": 837564116,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "doqMqplreSn1QrUIjU8nN",
					"type": "arrow"
				},
				{
					"id": "P3vC6rsj",
					"type": "text"
				}
			],
			"updated": 1687861468120,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 386,
			"versionNonce": 1301139538,
			"isDeleted": false,
			"id": "P3vC6rsj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -630.5085574063382,
			"y": -318.29982261390944,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 329.2796325683594,
			"height": 25,
			"seed": 715939743,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097345,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "Torrance/Sparrow specular BRDF",
			"rawText": "Torrance/Sparrow specular BRDF",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "xv5HOuU33yMRWcqXKZJQW",
			"originalText": "Torrance/Sparrow specular BRDF",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 494,
			"versionNonce": 126571988,
			"isDeleted": false,
			"id": "LHAQJAlIefn5lH8fQkLla",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -934.8542823947743,
			"y": 634.6012535043021,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 237,
			"height": 103,
			"seed": 355451628,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "rqkZS86x",
					"type": "text"
				}
			],
			"updated": 1687861468120,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 548,
			"versionNonce": 2010379794,
			"isDeleted": false,
			"id": "rqkZS86x",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -914.154155746825,
			"y": 661.1012535043021,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 195.59974670410156,
			"height": 50,
			"seed": 121707889,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097345,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "diffuse subsurface \nscattering",
			"rawText": "diffuse subsurface scattering",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "LHAQJAlIefn5lH8fQkLla",
			"originalText": "diffuse subsurface scattering",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "rectangle",
			"version": 9,
			"versionNonce": 147422036,
			"isDeleted": false,
			"id": "q9JxGsUP0EeRMllbs475Y",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1942.9874258537627,
			"y": -40.49151635548469,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 171,
			"height": 42,
			"seed": 1332966124,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "XhqwceMi",
					"type": "text"
				}
			],
			"updated": 1687861468120,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 380,
			"versionNonce": 1238328274,
			"isDeleted": false,
			"id": "XhqwceMi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1937.8999319572783,
			"y": -35.19150821746388,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 160.82501220703125,
			"height": 31.399983723958368,
			"seed": 24173932,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097346,
			"link": null,
			"locked": false,
			"fontSize": 25.119986979166693,
			"fontFamily": 1,
			"text": "Skin Material",
			"rawText": "Skin Material",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "q9JxGsUP0EeRMllbs475Y",
			"originalText": "Skin Material",
			"lineHeight": 1.25,
			"baseline": 22
		},
		{
			"type": "text",
			"version": 522,
			"versionNonce": 1512501460,
			"isDeleted": false,
			"id": "9RZGfqHN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1938.129582281318,
			"y": 24.222746107313128,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 284.8399963378906,
			"height": 150,
			"seed": 268950612,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "真实的皮肤材质需要考虑的因素:\nwrinkles\npores 毛孔\nfreckles 雀斑\nhair follicles\nscars",
			"rawText": "真实的皮肤材质需要考虑的因素:\nwrinkles\npores 毛孔\nfreckles 雀斑\nhair follicles\nscars",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "真实的皮肤材质需要考虑的因素:\nwrinkles\npores 毛孔\nfreckles 雀斑\nhair follicles\nscars",
			"lineHeight": 1.25,
			"baseline": 143
		},
		{
			"type": "text",
			"version": 144,
			"versionNonce": 1956394604,
			"isDeleted": false,
			"id": "fUiS5goz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2778.3768734829555,
			"y": 24.984653775653953,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 563.10595703125,
			"height": 20,
			"seed": 785125460,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": "https://www.youtube.com/watch?v=evsEB5474W0",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[Substance 3D Painter: Smart Material for Human Skin Textures]]",
			"rawText": "[Substance 3D Painter: Smart Material for Human Skin Textures](https://www.youtube.com/watch?v=evsEB5474W0)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[Substance 3D Painter: Smart Material for Human Skin Textures]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 117,
			"versionNonce": 1530508884,
			"isDeleted": false,
			"id": "wxQwu46E",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2776.0911940744736,
			"y": 66.69895692855567,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 226.59320068359375,
			"height": 20,
			"seed": 1395465428,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": "https://vgl.ict.usc.edu/Data/DigitalEmily2/",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[The Wikihuman Project]]",
			"rawText": "[The Wikihuman Project](https://vgl.ict.usc.edu/Data/DigitalEmily2/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[The Wikihuman Project]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 116,
			"versionNonce": 1461881068,
			"isDeleted": false,
			"id": "Hqw5PRdY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2766.662657523134,
			"y": -15.87254139733733,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 243.87200927734375,
			"height": 20,
			"seed": 1474842092,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "从扫描的数据中制作人脸皮肤材质:",
			"rawText": "从扫描的数据中制作人脸皮肤材质:",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "从扫描的数据中制作人脸皮肤材质:",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 7,
			"versionNonce": 148360148,
			"isDeleted": false,
			"id": "C7V2SNp1XKSpzoNFDfjlq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1942.9874258537627,
			"y": -555.6391313340935,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 201,
			"height": 41,
			"seed": 1254268268,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "4yjBEEzf",
					"type": "text"
				}
			],
			"updated": 1687861468120,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 195,
			"versionNonce": 764877202,
			"isDeleted": false,
			"id": "4yjBEEzf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1937.4748144646026,
			"y": -550.3057980007602,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 189.9747772216797,
			"height": 30.333333333333382,
			"seed": 1135192404,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097347,
			"link": null,
			"locked": false,
			"fontSize": 24.266666666666705,
			"fontFamily": 1,
			"text": "common material",
			"rawText": "common material",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "C7V2SNp1XKSpzoNFDfjlq",
			"originalText": "common material",
			"lineHeight": 1.25,
			"baseline": 21
		},
		{
			"type": "rectangle",
			"version": 9,
			"versionNonce": 1427583316,
			"isDeleted": false,
			"id": "gMnczz6J2f9XESi-KviV1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1646.9875072339714,
			"y": -641.9390987820098,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 206,
			"height": 35,
			"seed": 918240212,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "dMBjGAzj",
					"type": "text"
				}
			],
			"updated": 1687861468120,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 45,
			"versionNonce": 845289298,
			"isDeleted": false,
			"id": "dMBjGAzj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1641.6473964551628,
			"y": -636.9390987820098,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 195.3197784423828,
			"height": 25,
			"seed": 78167764,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097348,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "surface reflectance",
			"rawText": "surface reflectance",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "gMnczz6J2f9XESi-KviV1",
			"originalText": "surface reflectance",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 7,
			"versionNonce": 2135811796,
			"isDeleted": false,
			"id": "zxw1gR4sVr5UrxufPiTu2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1646.9875072339714,
			"y": -477.40577358669736,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 228,
			"height": 35,
			"seed": 1753874004,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "ldLmmduW",
					"type": "text"
				}
			],
			"updated": 1687861468120,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 99,
			"versionNonce": 1753701650,
			"isDeleted": false,
			"id": "ldLmmduW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1641.6673778394402,
			"y": -472.40577358669736,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 217.3597412109375,
			"height": 25,
			"seed": 526910932,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097348,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "subsurface scattering",
			"rawText": "subsurface scattering",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "zxw1gR4sVr5UrxufPiTu2",
			"originalText": "subsurface scattering",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 52,
			"versionNonce": 1813113940,
			"isDeleted": false,
			"id": "byH0BNTo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1646.9875072339714,
			"y": -593.7391069200308,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 144.21981811523438,
			"height": 25,
			"seed": 617577324,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "simple specular",
			"rawText": "simple specular",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "simple specular",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 69,
			"versionNonce": 126923500,
			"isDeleted": false,
			"id": "OzM80W60",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1646.9875072339714,
			"y": -427.60572475857236,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 247.0596923828125,
			"height": 25,
			"seed": 2022950100,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "simple diffuse calculation",
			"rawText": "simple diffuse calculation",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "simple diffuse calculation",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 87,
			"versionNonce": 2100904404,
			"isDeleted": false,
			"id": "OZRkTGoO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1360.1208893954292,
			"y": -564.4058142768021,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 395.1399841308594,
			"height": 50,
			"seed": 662308076,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "对于皮肤材质, 这两部分都需要更精细的模型\n才能表现真实的皮肤质感",
			"rawText": "对于皮肤材质, 这两部分都需要更精细的模型\n才能表现真实的皮肤质感",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "对于皮肤材质, 这两部分都需要更精细的模型\n才能表现真实的皮肤质感",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "image",
			"version": 590,
			"versionNonce": 1998361106,
			"isDeleted": false,
			"id": "4SXJiTLwl2Wccccpr2SYp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1619.7879222730353,
			"y": -53.387686373007966,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 500,
			"height": 168,
			"seed": 405902036,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005110871,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "34aa13c154b7882688ad0ca075e45c98c854cdfe",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 161,
			"versionNonce": 1775888212,
			"isDeleted": false,
			"id": "t24cY16CSmKUL5RWsNs28",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1441.9881376341853,
			"y": -70.62654668634588,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 103.99997287326391,
			"height": 85.33331976996533,
			"seed": 1694771436,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					-0.8888753255208144
				],
				[
					-0.8888753255207575,
					-0.8888753255208144
				],
				[
					-1.7778184678820708,
					-1.7777506510416856
				],
				[
					-4.444444444444571,
					-3.5555691189236427
				],
				[
					-7.111138237847399,
					-5.3333197699652715
				],
				[
					-8.888888888888914,
					-5.3333197699652715
				],
				[
					-11.555582682291742,
					-6.222195095486143
				],
				[
					-13.333333333333258,
					-6.222195095486143
				],
				[
					-15.111151801215328,
					-6.222195095486143
				],
				[
					-16.88890245225707,
					-6.222195095486143
				],
				[
					-17.77777777777783,
					-6.222195095486143
				],
				[
					-19.5555962456599,
					-6.222195095486143
				],
				[
					-20.44447157118043,
					-6.222195095486143
				],
				[
					-22.2222222222224,
					-6.222195095486143
				],
				[
					-23.11109754774293,
					-6.222195095486143
				],
				[
					-24.888916015625,
					-6.222195095486143
				],
				[
					-25.777791341145758,
					-5.3333197699652715
				],
				[
					-27.5555419921875,
					-4.444444444444457
				],
				[
					-30.22223578559033,
					-2.6666259765625
				],
				[
					-31.99998643663207,
					-1.7777506510416856
				],
				[
					-35.55555555555543,
					-0.8888753255208144
				],
				[
					-37.3333740234375,
					0.8888753255208144
				],
				[
					-39.11112467447924,
					1.777818467881957
				],
				[
					-40,
					3.555569118923586
				],
				[
					-40.88887532552076,
					3.555569118923586
				],
				[
					-40.88887532552076,
					4.444444444444457
				],
				[
					-41.77781846788207,
					5.3333197699652715
				],
				[
					-42.66669379340283,
					6.222262912326357
				],
				[
					-43.555569118923586,
					6.222262912326357
				],
				[
					-44.44444444444457,
					7.1111382378472285
				],
				[
					-46.222262912326414,
					8.888888888888857
				],
				[
					-47.1111382378474,
					11.555582682291686
				],
				[
					-48.888888888888914,
					13.333333333333314
				],
				[
					-48.888888888888914,
					16.000027126736086
				],
				[
					-48.888888888888914,
					16.888902452256957
				],
				[
					-49.7777642144099,
					18.666653103298643
				],
				[
					-49.7777642144099,
					21.333346896701357
				],
				[
					-49.7777642144099,
					22.22222222222223
				],
				[
					-50.66670735677076,
					24.000040690104186
				],
				[
					-51.55558268229174,
					26.666666666666686
				],
				[
					-51.55558268229174,
					27.555541992187443
				],
				[
					-52.4444580078125,
					30.22223578559027
				],
				[
					-52.4444580078125,
					31.9999864366319
				],
				[
					-51.55558268229174,
					38.222249348958314
				],
				[
					-50.66670735677076,
					40.888875325520814
				],
				[
					-50.66670735677076,
					42.66669379340277
				],
				[
					-50.66670735677076,
					43.55556911892364
				],
				[
					-50.66670735677076,
					45.33331976996527
				],
				[
					-50.66670735677076,
					47.11113823784723
				],
				[
					-50.66670735677076,
					48.0000135633681
				],
				[
					-48.888888888888914,
					50.666707356770814
				],
				[
					-46.222262912326414,
					54.222208658854186
				],
				[
					-45.33331976996533,
					55.11115180121527
				],
				[
					-43.555569118923586,
					56.8889024522569
				],
				[
					-42.66669379340283,
					57.77777777777777
				],
				[
					-41.77781846788207,
					59.55559624565973
				],
				[
					-40.88887532552076,
					60.4444715711806
				],
				[
					-40,
					62.22222222222223
				],
				[
					-38.22224934895826,
					64.00004069010419
				],
				[
					-36.444430881076414,
					64.00004069010419
				],
				[
					-34.6666802300349,
					64.88891601562494
				],
				[
					-34.6666802300349,
					65.77779134114581
				],
				[
					-32.88892957899293,
					66.66666666666669
				],
				[
					-31.99998643663207,
					68.44448513454864
				],
				[
					-30.22223578559033,
					68.44448513454864
				],
				[
					-29.33336046006957,
					68.44448513454864
				],
				[
					-28.444485134548586,
					69.3333604600694
				],
				[
					-25.777791341145758,
					70.22223578559027
				],
				[
					-24.000040690104242,
					70.22223578559027
				],
				[
					-22.2222222222224,
					70.22223578559027
				],
				[
					-20.44447157118043,
					70.22223578559027
				],
				[
					-18.666653103298586,
					70.22223578559027
				],
				[
					-16.88890245225707,
					70.22223578559027
				],
				[
					-16.000027126736086,
					71.11111111111114
				],
				[
					-13.333333333333258,
					71.11111111111114
				],
				[
					-10.666707356770758,
					71.11111111111114
				],
				[
					-8.00001356336793,
					71.11111111111114
				],
				[
					-6.222262912326414,
					71.11111111111114
				],
				[
					-4.444444444444571,
					71.11111111111114
				],
				[
					-2.6666937934028283,
					71.11111111111114
				],
				[
					-1.7778184678820708,
					71.11111111111114
				],
				[
					0,
					71.11111111111114
				],
				[
					0.8888753255207575,
					71.11111111111114
				],
				[
					2.6666259765625,
					71.11111111111114
				],
				[
					3.555569118923586,
					71.11111111111114
				],
				[
					5.333319769965101,
					71.11111111111114
				],
				[
					8.888888888888914,
					70.22223578559027
				],
				[
					10.66663953993043,
					70.22223578559027
				],
				[
					12.4444580078125,
					69.3333604600694
				],
				[
					14.222208658854242,
					69.3333604600694
				],
				[
					15.111083984375,
					69.3333604600694
				],
				[
					17.7777777777776,
					68.44448513454864
				],
				[
					19.55552842881957,
					67.55554199218744
				],
				[
					21.333346896701414,
					66.66666666666669
				],
				[
					23.11109754774293,
					65.77779134114581
				],
				[
					27.5555419921875,
					64.00004069010419
				],
				[
					29.333292643229242,
					63.1110975477431
				],
				[
					31.111111111111086,
					62.22222222222223
				],
				[
					33.777737087673586,
					60.4444715711806
				],
				[
					36.444430881076414,
					60.4444715711806
				],
				[
					38.22218153211793,
					59.55559624565973
				],
				[
					39.11112467447924,
					58.66665310329864
				],
				[
					40.88887532552076,
					57.77777777777777
				],
				[
					42.6666259765625,
					56.8889024522569
				],
				[
					44.44444444444457,
					55.11115180121527
				],
				[
					46.222195095486086,
					54.222208658854186
				],
				[
					46.222195095486086,
					53.333333333333314
				],
				[
					48.00001356336793,
					50.666707356770814
				],
				[
					49.77776421440967,
					48.88888888888886
				],
				[
					50.66663953993043,
					47.11113823784723
				],
				[
					50.66663953993043,
					44.4444444444444
				],
				[
					51.555514865451414,
					44.4444444444444
				],
				[
					51.555514865451414,
					42.66669379340277
				],
				[
					51.555514865451414,
					38.222249348958314
				],
				[
					51.555514865451414,
					35.5555555555556
				],
				[
					51.555514865451414,
					31.111111111111143
				],
				[
					51.555514865451414,
					29.3333604600694
				],
				[
					51.555514865451414,
					27.555541992187443
				],
				[
					51.555514865451414,
					25.777791341145814
				],
				[
					51.555514865451414,
					22.22222222222223
				],
				[
					51.555514865451414,
					20.4444715711806
				],
				[
					49.77776421440967,
					18.666653103298643
				],
				[
					48.888888888888914,
					16.000027126736086
				],
				[
					47.11107042100707,
					15.111151801215271
				],
				[
					46.222195095486086,
					13.333333333333314
				],
				[
					41.77775065104174,
					11.555582682291686
				],
				[
					37.33330620659717,
					8.000013563368043
				],
				[
					35.55555555555543,
					6.222262912326357
				],
				[
					33.777737087673586,
					2.6666937934027715
				],
				[
					32.8888617621526,
					1.777818467881957
				],
				[
					30.2222357855901,
					0
				],
				[
					27.5555419921875,
					-1.7777506510416856
				],
				[
					23.999972873263914,
					-3.5555691189236427
				],
				[
					22.22222222222217,
					-5.3333197699652715
				],
				[
					20.4444037543401,
					-6.222195095486143
				],
				[
					19.55552842881957,
					-7.111070421006957
				],
				[
					17.7777777777776,
					-7.111070421006957
				],
				[
					15.111083984375,
					-8.888888888888914
				],
				[
					12.4444580078125,
					-9.777764214409729
				],
				[
					8.888888888888914,
					-10.666639539930543
				],
				[
					5.333319769965101,
					-11.555514865451414
				],
				[
					3.555569118923586,
					-12.4444580078125
				],
				[
					1.7777506510417425,
					-12.4444580078125
				],
				[
					-1.7778184678820708,
					-13.333333333333314
				],
				[
					-4.444444444444571,
					-13.333333333333314
				],
				[
					-8.888888888888914,
					-13.333333333333314
				],
				[
					-12.4444580078125,
					-14.222208658854186
				],
				[
					-14.222208658854242,
					-14.222208658854186
				],
				[
					-15.111151801215328,
					-14.222208658854186
				],
				[
					-16.000027126736086,
					-14.222208658854186
				],
				[
					-16.88890245225707,
					-14.222208658854186
				],
				[
					-17.77777777777783,
					-14.222208658854186
				],
				[
					-18.666653103298586,
					-13.333333333333314
				],
				[
					-19.5555962456599,
					-13.333333333333314
				],
				[
					-19.5555962456599,
					-12.4444580078125
				],
				[
					-19.5555962456599,
					-12.4444580078125
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 110,
			"versionNonce": 647620588,
			"isDeleted": false,
			"id": "k3k4f6uy6g1mx6eNVuzaI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1385.9881783242895,
			"y": -59.07096400405419,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 385.77779134114576,
			"height": 131.55558268229169,
			"seed": 1621106284,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.8889431423613132,
					0
				],
				[
					1.7778184678818434,
					0
				],
				[
					10.666707356770985,
					-6.222262912326414
				],
				[
					18.666720920138914,
					-9.777764214409729
				],
				[
					20.444471571180657,
					-10.666707356770871
				],
				[
					26.666666666666742,
					-12.4444580078125
				],
				[
					32.88892957899316,
					-16.000027126736143
				],
				[
					39.11112467447924,
					-18.666653103298643
				],
				[
					47.1112060546875,
					-21.333346896701414
				],
				[
					58.66665310329881,
					-24.888916015625
				],
				[
					68.44448513454881,
					-27.555575900607664
				],
				[
					75.55562337239598,
					-30.22223578559033
				],
				[
					80.88887532552098,
					-31.11114501953125
				],
				[
					85.33331976996533,
					-33.777804904513914
				],
				[
					97.77784559461816,
					-38.22224934895837
				],
				[
					115.55562337239598,
					-44.44447835286462
				],
				[
					134.22220865885424,
					-51.555582682291686
				],
				[
					148.4444851345486,
					-56.88890245225696
				],
				[
					149.33342827690967,
					-57.777811686197936
				],
				[
					152.88892957899316,
					-59.55556233723962
				],
				[
					155.55562337239598,
					-61.333346896701414
				],
				[
					159.11112467447924,
					-62.22225613064239
				],
				[
					165.33331976996533,
					-64.00000678168408
				],
				[
					173.3334011501736,
					-67.55557590060766
				],
				[
					184.88898383246533,
					-71.11114501953125
				],
				[
					192.88892957899316,
					-74.66668023003473
				],
				[
					203.5555691189236,
					-78.22224934895837
				],
				[
					209.77776421440967,
					-80.88890923394098
				],
				[
					214.22220865885424,
					-83.55556911892364
				],
				[
					220.44453938802098,
					-85.33335367838544
				],
				[
					227.5555419921875,
					-87.11113823784723
				],
				[
					232.88892957899316,
					-90.6666734483507
				],
				[
					251.55565049913184,
					-96.88890245225696
				],
				[
					264.00004069010424,
					-100.4444715711806
				],
				[
					272.88892957899316,
					-104.888916015625
				],
				[
					280.0000678168403,
					-108.44445122612848
				],
				[
					284.4445122612847,
					-110.22223578559033
				],
				[
					287.1112060546875,
					-111.11114501953125
				],
				[
					288.88895670572924,
					-112.00002034505212
				],
				[
					290.666707356771,
					-112.88889567057294
				],
				[
					293.3334011501736,
					-113.77780490451391
				],
				[
					296.0000949435764,
					-114.66668023003473
				],
				[
					299.5555962456597,
					-116.44446478949658
				],
				[
					302.2222900390625,
					-117.33334011501739
				],
				[
					304.00004069010424,
					-118.22224934895837
				],
				[
					307.5555419921875,
					-120.00003390842016
				],
				[
					310.2222357855903,
					-121.77778455946185
				],
				[
					313.77787272135424,
					-122.66669379340277
				],
				[
					315.555623372396,
					-123.55556911892364
				],
				[
					317.3333740234375,
					-123.55556911892364
				],
				[
					317.3333740234375,
					-124.44447835286462
				],
				[
					319.11112467447924,
					-124.44447835286462
				],
				[
					320.0000678168403,
					-124.44447835286462
				],
				[
					321.77781846788184,
					-125.33335367838544
				],
				[
					323.5555691189236,
					-126.22222900390625
				],
				[
					326.2222629123264,
					-127.11113823784723
				],
				[
					328.00001356336816,
					-127.11113823784723
				],
				[
					329.7777642144097,
					-127.11113823784723
				],
				[
					333.3334011501736,
					-128.0000135633681
				],
				[
					334.22220865885424,
					-128.0000135633681
				],
				[
					335.1111518012153,
					-128.0000135633681
				],
				[
					336.0000949435764,
					-128.0000135633681
				],
				[
					336.88890245225684,
					-128.0000135633681
				],
				[
					337.77784559461816,
					-128.88892279730902
				],
				[
					338.6666531032986,
					-128.88892279730902
				],
				[
					340.444539388021,
					-128.88892279730902
				],
				[
					341.3333468967014,
					-128.88892279730902
				],
				[
					345.77779134114576,
					-128.88892279730902
				],
				[
					350.2222357855903,
					-128.88892279730902
				],
				[
					351.99998643663207,
					-128.88892279730902
				],
				[
					352.88892957899316,
					-128.88892279730902
				],
				[
					353.77787272135424,
					-128.88892279730902
				],
				[
					354.6666802300347,
					-128.88892279730902
				],
				[
					355.55562337239576,
					-128.88892279730902
				],
				[
					356.4444308810764,
					-128.88892279730902
				],
				[
					357.3333740234375,
					-128.88892279730902
				],
				[
					358.2223171657986,
					-128.88892279730902
				],
				[
					359.11112467447924,
					-128.88892279730902
				],
				[
					360.88887532552076,
					-128.88892279730902
				],
				[
					361.77781846788207,
					-128.88892279730902
				],
				[
					362.66676161024316,
					-128.88892279730902
				],
				[
					363.5555691189236,
					-128.88892279730902
				],
				[
					364.4445122612847,
					-128.88892279730902
				],
				[
					366.2222629123264,
					-128.88892279730902
				],
				[
					368.00001356336816,
					-128.88892279730902
				],
				[
					368.88895670572924,
					-128.88892279730902
				],
				[
					369.7777642144097,
					-129.7777981228299
				],
				[
					370.66670735677076,
					-129.7777981228299
				],
				[
					371.55565049913207,
					-129.7777981228299
				],
				[
					372.4444580078125,
					-129.7777981228299
				],
				[
					373.3334011501736,
					-129.7777981228299
				],
				[
					374.22220865885424,
					-129.7777981228299
				],
				[
					375.1111518012153,
					-129.7777981228299
				],
				[
					376.0000949435764,
					-130.6666734483507
				],
				[
					377.77784559461816,
					-130.6666734483507
				],
				[
					378.6666531032986,
					-130.6666734483507
				],
				[
					379.5555962456597,
					-131.55558268229169
				],
				[
					380.44453938802076,
					-131.55558268229169
				],
				[
					381.3333468967014,
					-131.55558268229169
				],
				[
					382.2222900390625,
					-131.55558268229169
				],
				[
					383.11109754774316,
					-131.55558268229169
				],
				[
					384.00004069010424,
					-131.55558268229169
				],
				[
					384.8889838324653,
					-131.55558268229169
				],
				[
					385.77779134114576,
					-131.55558268229169
				],
				[
					385.77779134114576,
					-131.55558268229169
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 52,
			"versionNonce": 373939412,
			"isDeleted": false,
			"id": "I94yTpYZFsC7Uh5kcpcGj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1022.4326092053659,
			"y": -209.29319978964446,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 21.333414713541742,
			"height": 38.22221544053815,
			"seed": 1242587604,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.8889431423610858,
					0
				],
				[
					2.6666937934028283,
					0.8888753255208144
				],
				[
					3.555636935763914,
					0.8888753255208144
				],
				[
					5.333387586805657,
					1.777784559461793
				],
				[
					5.333387586805657,
					3.5555352105034217
				],
				[
					7.111138237847172,
					3.5555352105034217
				],
				[
					8.888888888888914,
					4.4444444444444
				],
				[
					9.77783203125,
					5.3333197699652715
				],
				[
					10.666639539930657,
					5.3333197699652715
				],
				[
					12.444525824652828,
					6.22222900390625
				],
				[
					14.22227647569457,
					7.111104329427064
				],
				[
					14.22227647569457,
					7.999979654947879
				],
				[
					16.000027126736086,
					7.999979654947879
				],
				[
					16.88897026909717,
					8.888888888888857
				],
				[
					16.88897026909717,
					9.777764214409672
				],
				[
					18.666720920138914,
					9.777764214409672
				],
				[
					18.666720920138914,
					10.66667344835065
				],
				[
					19.55552842881957,
					11.555548773871521
				],
				[
					20.444471571180657,
					11.555548773871521
				],
				[
					20.444471571180657,
					12.444424099392336
				],
				[
					21.333414713541742,
					13.333333333333314
				],
				[
					21.333414713541742,
					14.222208658854129
				],
				[
					21.333414713541742,
					15.111117892795107
				],
				[
					21.333414713541742,
					16.888868543836793
				],
				[
					21.333414713541742,
					17.77777777777777
				],
				[
					21.333414713541742,
					18.666653103298586
				],
				[
					21.333414713541742,
					19.555562337239564
				],
				[
					21.333414713541742,
					20.44443766276038
				],
				[
					20.444471571180657,
					20.44443766276038
				],
				[
					19.55552842881957,
					21.33331298828125
				],
				[
					19.55552842881957,
					23.111097547743043
				],
				[
					18.666720920138914,
					23.111097547743043
				],
				[
					17.77777777777783,
					24.888882107204836
				],
				[
					17.77777777777783,
					25.77775743272565
				],
				[
					17.77777777777783,
					26.66666666666663
				],
				[
					16.88897026909717,
					27.5555419921875
				],
				[
					16.88897026909717,
					28.44445122612842
				],
				[
					16.000027126736086,
					29.333326551649293
				],
				[
					16.000027126736086,
					30.222201877170107
				],
				[
					15.111083984375,
					31.9999864366319
				],
				[
					15.111083984375,
					32.88889567057288
				],
				[
					14.22227647569457,
					33.77777099609369
				],
				[
					14.22227647569457,
					35.55555555555554
				],
				[
					13.333333333333485,
					36.44443088107636
				],
				[
					13.333333333333485,
					37.333340115017336
				],
				[
					13.333333333333485,
					38.22221544053815
				],
				[
					13.333333333333485,
					38.22221544053815
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 187,
			"versionNonce": 295065556,
			"isDeleted": false,
			"id": "8YRhXKzhGfzLDgsnfcmj3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1379.765915411963,
			"y": 93.3734600953382,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 433.2054155569643,
			"height": 580.3864891813935,
			"seed": 1640615252,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861693139,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.9890382995064319,
					0
				],
				[
					1.9780765990131168,
					0
				],
				[
					3.956228656811381,
					4.299174971702872
				],
				[
					7.912381854837615,
					10.747896429286167
				],
				[
					11.868610511648743,
					15.047071400989038
				],
				[
					17.80291576747324,
					27.944514316155487
				],
				[
					24.726334781589824,
					42.991585717144524
				],
				[
					35.60598245251754,
					62.33783208983644
				],
				[
					59.34320347581502,
					96.73106786357522
				],
				[
					68.24462363015907,
					111.77813926456426
				],
				[
					76.15708094378184,
					124.67558217973071
				],
				[
					86.04761485641797,
					139.72265358071974
				],
				[
					91.98199557102761,
					148.3210035241255
				],
				[
					96.92726252734542,
					156.91927146758906
				],
				[
					102.86149232438451,
					163.36799292517236
				],
				[
					109.78498679728625,
					171.9663428685781
				],
				[
					116.70833035261718,
					182.71423929786428
				],
				[
					125.60975050696122,
					199.9108571847336
				],
				[
					134.51132157887582,
					212.80838209984236
				],
				[
					144.4018554915117,
					227.85537150088922
				],
				[
					159.2376563604654,
					249.35124635940372
				],
				[
					172.09522971283567,
					264.39823576045046
				],
				[
					180.99680078475026,
					279.4453891613818
				],
				[
					194.84348789541212,
					298.7914715341892
				],
				[
					201.76683145074304,
					307.389821477595
				],
				[
					207.70121216535296,
					311.6890784492401
				],
				[
					211.65736536337894,
					320.2872643927616
				],
				[
					215.6136694789757,
					324.58652136440674
				],
				[
					217.59174607798857,
					326.7360678502869
				],
				[
					221.54789927601482,
					333.1848713078125
				],
				[
					227.4822799906247,
					341.7830572513336
				],
				[
					233.41666070523436,
					346.0823142229788
				],
				[
					238.36192766155241,
					352.5309536806198
				],
				[
					244.29615745859152,
					356.83021065226495
				],
				[
					247.26334781589622,
					363.278850109906
				],
				[
					251.21950101392218,
					365.4285605956707
				],
				[
					254.18669137122714,
					369.72765356743156
				],
				[
					260.12107208583706,
					378.3260035108373
				],
				[
					265.0663390421549,
					380.47554999671775
				],
				[
					267.044415641168,
					384.7746429684783
				],
				[
					269.02249224018107,
					389.07389994012345
				],
				[
					273.9677591964989,
					391.2234464260039
				],
				[
					277.92406331209565,
					397.6722498835292
				],
				[
					284.8474068674266,
					404.1208893411702
				],
				[
					291.77075042275754,
					410.56969279869577
				],
				[
					294.7379407800625,
					412.71923928457596
				],
				[
					296.7160173790756,
					417.0183322563368
				],
				[
					300.6721705771016,
					421.31758922798195
				],
				[
					304.6284746926984,
					425.6166821997425
				],
				[
					309.5737416490162,
					432.06548565726786
				],
				[
					310.5627044897375,
					434.2150321431483
				],
				[
					313.52989484704244,
					436.3645786290287
				],
				[
					316.49708520434734,
					440.66383560067385
				],
				[
					319.4642755616521,
					442.81338208655404
				],
				[
					322.43146591895703,
					449.262021544195
				],
				[
					325.3985053586912,
					453.5612785158402
				],
				[
					329.35480947428795,
					457.860371487601
				],
				[
					332.3219998315929,
					462.15962845924594
				],
				[
					335.28903927132706,
					466.4587214310068
				],
				[
					337.2672667879107,
					466.4587214310068
				],
				[
					339.2453433869238,
					470.75781440276734
				],
				[
					341.2234199859369,
					472.9075248885321
				],
				[
					342.2125337442288,
					472.9075248885321
				],
				[
					345.17957318396293,
					477.20661786029297
				],
				[
					347.1578007005466,
					477.20661786029297
				],
				[
					349.1358772995597,
					481.5057108320535
				],
				[
					353.09203049758565,
					485.8049678036987
				],
				[
					355.0701070965988,
					487.9545142895791
				],
				[
					358.03729745390376,
					492.25360726133965
				],
				[
					361.0044878112087,
					492.25360726133965
				],
				[
					361.9936015695003,
					494.40331774710444
				],
				[
					365.9497547675265,
					500.8519572047454
				],
				[
					368.91694512483144,
					503.00150369062584
				],
				[
					368.91694512483144,
					505.15121417639057
				],
				[
					370.8950217238443,
					507.300760662271
				],
				[
					371.8841354821364,
					507.300760662271
				],
				[
					373.86221208114927,
					511.5998536340316
				],
				[
					375.84028868016236,
					513.749400119912
				],
				[
					376.8294024384542,
					513.749400119912
				],
				[
					378.8074790374673,
					515.8991106056768
				],
				[
					379.7964418781884,
					518.0486570915572
				],
				[
					380.7855556364802,
					520.1982035774373
				],
				[
					382.76363223549333,
					522.3477500633178
				],
				[
					383.75274599378514,
					522.3477500633178
				],
				[
					386.7199363510901,
					524.4972965491982
				],
				[
					387.7088991918111,
					526.6470070349629
				],
				[
					388.69801295010296,
					528.7965535208431
				],
				[
					390.67608954911606,
					530.9461000067234
				],
				[
					392.6541661481292,
					533.0956464926039
				],
				[
					393.643279906421,
					533.0956464926039
				],
				[
					394.6322427471421,
					535.245192978484
				],
				[
					396.610470263726,
					537.3949034642491
				],
				[
					397.59943310444703,
					539.5444499501292
				],
				[
					398.58854686273884,
					539.5444499501292
				],
				[
					400.56662346175193,
					541.6939964360097
				],
				[
					401.5557372200438,
					543.84354292189
				],
				[
					403.5338138190569,
					543.84354292189
				],
				[
					404.52277665977795,
					545.9930894077702
				],
				[
					406.50100417636185,
					548.1427998935353
				],
				[
					406.50100417636185,
					550.2923463794154
				],
				[
					408.4790807753747,
					550.2923463794154
				],
				[
					408.4790807753747,
					552.4418928652958
				],
				[
					410.4571573743878,
					554.5914393511763
				],
				[
					411.44627113267967,
					554.5914393511763
				],
				[
					412.43523397340095,
					556.7409858370564
				],
				[
					413.42434773169276,
					556.7409858370564
				],
				[
					413.42434773169276,
					558.8906963228211
				],
				[
					414.4133105724138,
					558.8906963228211
				],
				[
					415.4024243307056,
					558.8906963228211
				],
				[
					416.3915380889975,
					561.0402428087016
				],
				[
					417.3805009297188,
					563.1897892945819
				],
				[
					418.3696146880106,
					565.3393357804622
				],
				[
					420.34769128702374,
					565.3393357804622
				],
				[
					421.33680504531554,
					567.4888822663426
				],
				[
					422.3257678860366,
					569.6385927521073
				],
				[
					423.31488164432864,
					569.6385927521073
				],
				[
					425.2929582433415,
					569.6385927521073
				],
				[
					426.28207200163337,
					571.7881392379877
				],
				[
					426.28207200163337,
					573.9376857238682
				],
				[
					427.27103484235465,
					573.9376857238682
				],
				[
					428.26014860064646,
					576.0872322097483
				],
				[
					429.24911144136775,
					576.0872322097483
				],
				[
					430.2382251996596,
					578.2367786956287
				],
				[
					431.2273389579514,
					578.2367786956287
				],
				[
					432.2163017986725,
					580.3864891813935
				],
				[
					433.2054155569643,
					580.3864891813935
				],
				[
					433.2054155569643,
					580.3864891813935
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 372,
			"versionNonce": 1813979732,
			"isDeleted": false,
			"id": "bLNiHsSH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1603.6377666239034,
			"y": 156.29242992623415,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 436.95989990234375,
			"height": 125,
			"seed": 1594287212,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "光入射到皮肤之后, 一部分被皮肤表面油脂层\n直接反射出去(大约6%), 可以使用BRDF进行近似\n\n还有一部分穿透油脂层, 在皮肤组织上发生散射, \n形成了皮肤的颜色和柔和的质感.",
			"rawText": "光入射到皮肤之后, 一部分被皮肤表面油脂层\n直接反射出去(大约6%), 可以使用BRDF进行近似\n\n还有一部分穿透油脂层, 在皮肤组织上发生散射, \n形成了皮肤的颜色和柔和的质感.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "光入射到皮肤之后, 一部分被皮肤表面油脂层\n直接反射出去(大约6%), 可以使用BRDF进行近似\n\n还有一部分穿透油脂层, 在皮肤组织上发生散射, \n形成了皮肤的颜色和柔和的质感.",
			"lineHeight": 1.25,
			"baseline": 118
		},
		{
			"type": "text",
			"version": 718,
			"versionNonce": 1303547220,
			"isDeleted": false,
			"id": "O7gE1Rah",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1759.0198618026657,
			"y": 1059.9479937632314,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 606.1771850585938,
			"height": 44.57144601004472,
			"seed": 647005548,
			"groupIds": [
				"ntrFuR83jLAGmt3XUS39W"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861686599,
			"link": null,
			"locked": false,
			"fontSize": 17.828578404017886,
			"fontFamily": 1,
			"text": "是光在传播时的一种现象, 表现为光在穿过透明物体表面后,\n与材料之间发生交互作用而导致光被散射开来, 光路也在其他的位置穿出物体.",
			"rawText": "是光在传播时的一种现象, 表现为光在穿过透明物体表面后,\n与材料之间发生交互作用而导致光被散射开来, 光路也在其他的位置穿出物体.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "是光在传播时的一种现象, 表现为光在穿过透明物体表面后,\n与材料之间发生交互作用而导致光被散射开来, 光路也在其他的位置穿出物体.",
			"lineHeight": 1.25,
			"baseline": 37
		},
		{
			"type": "image",
			"version": 747,
			"versionNonce": 109486572,
			"isDeleted": false,
			"id": "cV8fWHsE4_2Wcw3KsCPgL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1760.2506122533869,
			"y": 775.7757997073551,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 329.99999999999994,
			"height": 268,
			"seed": 62191596,
			"groupIds": [
				"ntrFuR83jLAGmt3XUS39W"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861686599,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "e4064329b87ded6b621cc344c0aacee8e061dc1f",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 713,
			"versionNonce": 69059284,
			"isDeleted": false,
			"id": "cPRxR0UM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1124.7400096683718,
			"y": 1018.2225963020096,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 638.6798706054688,
			"height": 125,
			"seed": 1875194964,
			"groupIds": [
				"ntrFuR83jLAGmt3XUS39W"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861686599,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "现实中, 光会和皮肤的多个不同层次的组织发射次表面散射.\n在应用中, 在油脂层下, 再添加两层的次表面散射就能够达到逼真的效果.\n\n已有很多很好的皮肤次表面散射的diffusion model的研究, 我们可以通过\n一些图片模糊等技巧对diffusion model进行近似, 从而进行实时渲染.",
			"rawText": "现实中, 光会和皮肤的多个不同层次的组织发射次表面散射.\n在应用中, 在油脂层下, 再添加两层的次表面散射就能够达到逼真的效果.\n\n已有很多很好的皮肤次表面散射的diffusion model的研究, 我们可以通过\n一些图片模糊等技巧对diffusion model进行近似, 从而进行实时渲染.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "现实中, 光会和皮肤的多个不同层次的组织发射次表面散射.\n在应用中, 在油脂层下, 再添加两层的次表面散射就能够达到逼真的效果.\n\n已有很多很好的皮肤次表面散射的diffusion model的研究, 我们可以通过\n一些图片模糊等技巧对diffusion model进行近似, 从而进行实时渲染.",
			"lineHeight": 1.25,
			"baseline": 118
		},
		{
			"type": "image",
			"version": 480,
			"versionNonce": 666076268,
			"isDeleted": false,
			"id": "t5_RDPiNXFtWc32xcggP2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1123.5091653174106,
			"y": 775.7757997073551,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 374.24758349772634,
			"height": 229.5385178786055,
			"seed": 372467308,
			"groupIds": [
				"ntrFuR83jLAGmt3XUS39W"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861686599,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "53d9fbad0841de8b068735a6863f3c6932dfb38d",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "arrow",
			"version": 248,
			"versionNonce": 705032850,
			"isDeleted": false,
			"id": "doqMqplreSn1QrUIjU8nN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -475.91398250690844,
			"y": -170.24612551246753,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 0.9450590918802391,
			"height": 115.53847092848571,
			"seed": 2111379052,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "LUSJ4jR3"
				}
			],
			"updated": 1688005097344,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "dAY-faOi4uk4xSPacrjIm",
				"gap": 3.7155524478370126,
				"focus": -0.15931182232011326
			},
			"endBinding": {
				"elementId": "xv5HOuU33yMRWcqXKZJQW",
				"gap": 2.515226172956204,
				"focus": 0.06555666554883678
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
					-0.9450590918802391,
					-115.53847092848571
				]
			]
		},
		{
			"type": "text",
			"version": 84,
			"versionNonce": 211473108,
			"isDeleted": false,
			"id": "LUSJ4jR3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -515.0220909177741,
			"y": -239.89998575134985,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 80,
			"height": 25,
			"seed": 57002708,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "高效近似",
			"rawText": "高效近似",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "doqMqplreSn1QrUIjU8nN",
			"originalText": "高效近似",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 163,
			"versionNonce": 1028617324,
			"isDeleted": false,
			"id": "ohCyIHDN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1933.0190233521075,
			"y": 213.977239907919,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 109.27302551269531,
			"height": 125,
			"seed": 1154871660,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": "https://huangx916.github.io/2019/04/16/sss/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[ref 1]]\n\n[[ref 2]]\n\n[[ref 3]]",
			"rawText": "[ref 1](https://huangx916.github.io/2019/04/16/sss/)\n\n[ref 2](https://github.com/QianMo/Game-Programmer-Study-Notes/blob/master/Content/%E3%80%8AGPU%20Gems%203%E3%80%8B%E5%85%A8%E4%B9%A6%E6%8F%90%E7%82%BC%E6%80%BB%E7%BB%93/Part1/README.md)\n\n[ref 3](https://developer.nvidia.com/gpugems/gpugems3/part-iii-rendering/chapter-14-advanced-techniques-realistic-real-time-skin)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[ref 1]]\n\n[[ref 2]]\n\n[[ref 3]]",
			"lineHeight": 1.25,
			"baseline": 118
		},
		{
			"type": "text",
			"version": 62,
			"versionNonce": 417421396,
			"isDeleted": false,
			"id": "kh84qRFe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -626.1619851266598,
			"y": -115.14176120815216,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 240,
			"height": 20,
			"seed": 1358803180,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861468120,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "利用预计算的纹理进行高效地计算",
			"rawText": "利用预计算的纹理进行高效地计算",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "利用预计算的纹理进行高效地计算",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 268,
			"versionNonce": 1046697684,
			"isDeleted": false,
			"id": "4wzdNHkms2RwYdy48rJVE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -466.0683665011585,
			"y": 379.40939234833087,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132,
			"height": 30,
			"seed": 229856748,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "VJWCETLw",
					"type": "text"
				}
			],
			"updated": 1687861493592,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 289,
			"versionNonce": 1031662290,
			"isDeleted": false,
			"id": "VJWCETLw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -460.8924936984241,
			"y": 384.40939234833087,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 121.64825439453125,
			"height": 20,
			"seed": 1917973588,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005097349,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "diffusion profile",
			"rawText": "diffusion profile",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "4wzdNHkms2RwYdy48rJVE",
			"originalText": "diffusion profile",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 483,
			"versionNonce": 402387668,
			"isDeleted": false,
			"id": "qJ-MhXL4173XUtEqzyMHF",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -176.87775359441127,
			"y": 84.99456473096097,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 427.4376165594079,
			"height": 197.47617885044644,
			"seed": 1863700692,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861496428,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "95c524b59fd505dc991ba87fe3fd1d7a8c62474d",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 422,
			"versionNonce": 1813009516,
			"isDeleted": false,
			"id": "LQyYQo3G",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -178.115779078042,
			"y": 296.6851571788776,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 535.7254638671875,
			"height": 54.64111415663886,
			"seed": 1878331092,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861496428,
			"link": null,
			"locked": false,
			"fontSize": 14.570963775103694,
			"fontFamily": 1,
			"text": "一束光打到表面后的散射情况, 不同分量沿着距离衰减程度不一样, 从而出现了颜色.\n这里假设散射会发生多次, 各个方向是均匀的.\n有了diffusion profile, 就可以方便的计算次表面散射",
			"rawText": "一束光打到表面后的散射情况, 不同分量沿着距离衰减程度不一样, 从而出现了颜色.\n这里假设散射会发生多次, 各个方向是均匀的.\n有了diffusion profile, 就可以方便的计算次表面散射",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "一束光打到表面后的散射情况, 不同分量沿着距离衰减程度不一样, 从而出现了颜色.\n这里假设散射会发生多次, 各个方向是均匀的.\n有了diffusion profile, 就可以方便的计算次表面散射",
			"lineHeight": 1.25,
			"baseline": 49
		},
		{
			"type": "image",
			"version": 349,
			"versionNonce": 1020216338,
			"isDeleted": false,
			"id": "UvIbeydInemVHGrESOBYB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 461.8283786228517,
			"y": 75.4811342857314,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 305.0407319611655,
			"height": 236.57603434321499,
			"seed": 1926516180,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688005104389,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "03a28fa36af783067582ee13cdf307441fffd24f",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 123,
			"versionNonce": 727907692,
			"isDeleted": false,
			"id": "4jrypWAN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 446.10075876359076,
			"y": 332.9775400399176,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 336.49603271484375,
			"height": 20,
			"seed": 1481381716,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687863330584,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "对于曲面, 可以直接使用点之间的距离进行近似.",
			"rawText": "对于曲面, 可以直接使用点之间的距离进行近似.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "对于曲面, 可以直接使用点之间的距离进行近似.",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 31,
			"versionNonce": 590129388,
			"isDeleted": false,
			"id": "KJBGLnhN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -462.01700575140694,
			"y": 429.8154497542818,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 150.080322265625,
			"height": 40,
			"seed": 1640104172,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687861578168,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Jensen et al. 2001\ndipole model",
			"rawText": "Jensen et al. 2001\ndipole model",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Jensen et al. 2001\ndipole model",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "image",
			"version": 44,
			"versionNonce": 2091682772,
			"isDeleted": false,
			"id": "o0ufdNFH6KJW1aWiP7KI3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -195.30259899745442,
			"y": 443.27058973210546,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 500.00000000000006,
			"height": 229,
			"seed": 1799611092,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687863245113,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "5ab637fd030642d5cd6bca6c164512b7961b2eba",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 108,
			"versionNonce": 1722882772,
			"isDeleted": false,
			"id": "s83vPhYK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -185.16953367919473,
			"y": 691.1811068064845,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 401.64825439453125,
			"height": 20,
			"seed": 1679654380,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687863317800,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "多层不同的diffusion profile可以得逼真/丰富的渲染效果",
			"rawText": "多层不同的diffusion profile可以得逼真/丰富的渲染效果",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "多层不同的diffusion profile可以得逼真/丰富的渲染效果",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 149,
			"versionNonce": 622826188,
			"isDeleted": false,
			"id": "x2obQR7v",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2769.4259038728096,
			"y": 189.37966386505752,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 120.01690673828125,
			"height": 20,
			"seed": 2102251724,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687914201102,
			"link": "https://gameinstitute.qq.com/course/detail/10130",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[腾讯Siren]]",
			"rawText": "[腾讯Siren](https://gameinstitute.qq.com/course/detail/10130)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[腾讯Siren]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"id": "0NzqYAkX",
			"type": "text",
			"x": -1373.7879299024298,
			"y": 18.794131808810164,
			"width": 8.000015258789062,
			"height": 20,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 900233426,
			"version": 2,
			"versionNonce": 139320206,
			"isDeleted": true,
			"boundElements": null,
			"updated": 1688005110389,
			"link": null,
			"locked": false,
			"text": "",
			"rawText": "",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 14,
			"containerId": "4SXJiTLwl2Wccccpr2SYp",
			"originalText": "",
			"lineHeight": 1.25
		},
		{
			"id": "DTjH9MsK",
			"type": "text",
			"x": -1373.7879299024298,
			"y": 18.794131808810164,
			"width": 8.000015258789062,
			"height": 20,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 1055738958,
			"version": 2,
			"versionNonce": 439887186,
			"isDeleted": true,
			"boundElements": null,
			"updated": 1688005107793,
			"link": null,
			"locked": false,
			"text": "",
			"rawText": "",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 14,
			"containerId": "4SXJiTLwl2Wccccpr2SYp",
			"originalText": "",
			"lineHeight": 1.25
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#1e1e1e",
		"currentItemBackgroundColor": "transparent",
		"currentItemFillStyle": "hachure",
		"currentItemStrokeWidth": 1,
		"currentItemStrokeStyle": "solid",
		"currentItemRoughness": 0,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 16,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 2974.2536773658967,
		"scrollY": 950.3667739672726,
		"zoom": {
			"value": 0.55
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