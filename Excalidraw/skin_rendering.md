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

Skin Material & Rendering ^XhqwceMi

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

[ref 1](https://huangx916.github.io/2019/04/16/sss/) ^ohCyIHDN

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

[ref 2](https://github.com/QianMo/Game-Programmer-Study-Notes/blob/master/Content/%E3%80%8AGPU%20Gems%203%E3%80%8B%E5%85%A8%E4%B9%A6%E6%8F%90%E7%82%BC%E6%80%BB%E7%BB%93/Part1/README.md)
 ^Hz4cOtPH

[ref 3](https://developer.nvidia.com/gpugems/gpugems3/part-iii-rendering/chapter-14-advanced-techniques-realistic-real-time-skin) ^uwT0Lfme

为了方便计算, 使用多个高斯函数之和来近似 diffusion profile,
对于很多材料, 相关参数已有研究可以直接取用(Jensen et al. 2001).

右侧两图是皮肤材质用到的6个高斯函数, 以及其近似的 diffusion profile ^Z6Ux3p0L

Implementation ^aBiuVDq9

Texture Space Blur ^6B8EPmok

Screen Space Blur ^XdQtvRuI

在纹理空间中对irradiance texture
应用各个高斯模糊, 然后合并.

要求高精度纹理, 每一帧都要做
6x3次高斯模糊, 计算量大.
不适合实时场景. ^qt2BI5BW

Scatter ^YXcAdVSn

这里对纹理进行stretch(扭曲/拉伸)
是因为模糊时纹理图片上的像素距离
与其所对应的真实曲面间的距离不一致 ^BRuxd2x9

Post-Scatter: 只对接受光照应用diffusion profile blur. albedo 没有被模糊. 适用于纹理来自于拍摄的照片(albedo本来就已经被"模糊"过了).
Pre-And Post-Scatter: Post-Scatter + Pre-Scatter(光照 * albedo之后, 应用diffusion profile blur) 做颜色混合 ^WHYgaxz4

能量守恒 ^DhVukexC

[UE shadering models](https://docs.unrealengine.com/5.2/en-US/shading-models-in-unreal-engine/) ^7n5bacNW

[UE Material Blend Modes](https://docs.unrealengine.com/5.2/en-US/material-blend-modes-in-unreal-engine/) ^W6T5Wgav

[PBR White Paper](https://github.com/QianMo/PBR-White-Paper)
[Cook-Torrance BRDF](https://www.jianshu.com/p/d70ee9d4180e)
[Physically Based Rendering in Filament](https://google.github.io/filament/Filament.html) ^fwVnFpdn


# Embedded files
597d4e4965fcb42cdc70ca2a15d64e0983bfcef2: $$\begin{aligned} R(r) = \sum_{i=1}^k w_i G(v_i, r)\\ G(v, r) = \frac{1}{2 \pi v} e^{-r^2/2v} \end{aligned}$$
e4064329b87ded6b621cc344c0aacee8e061dc1f: [[sss_hand.png]]
34aa13c154b7882688ad0ca075e45c98c854cdfe: [[skin_layer_model.png]]
53d9fbad0841de8b068735a6863f3c6932dfb38d: [[skin_sss.png]]
95c524b59fd505dc991ba87fe3fd1d7a8c62474d: [[diffusion_profile.png]]
03a28fa36af783067582ee13cdf307441fffd24f: [[df_profile_curved_surface.png]]
5ab637fd030642d5cd6bca6c164512b7961b2eba: [[multi_layer_df.png]]
41f11494a4cfefeb41cc19ba667c5e4383d72925: [[Pasted Image 20230705103358_946.png]]
93c076ee3e03cfbe0b82561a74338edf114ee13a: [[Pasted Image 20230705103428_971.png]]
9ca092c54ed383dd2d5be9ea1a7e7e9b17f7cb66: [[Pasted Image 20230705110722_644.png]]
0e1c2babb45f932d4510c97aa2532bf73afadbad: [[Pasted Image 20230705111438_695.png]]
a409063a49a46ec3e384ddb52a4db4ea1b6dc74c: [[Pasted Image 20230705112340_769.png]]

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
			"version": 577,
			"versionNonce": 598804940,
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
			"updated": 1688528464955,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 912,
			"versionNonce": 1930840308,
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
			"updated": 1688528464956,
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
			"version": 12,
			"versionNonce": 654700620,
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
			"updated": 1688528464956,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 489,
			"versionNonce": 684264052,
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
			"updated": 1688528464956,
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
			"version": 12,
			"versionNonce": 1811547852,
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
			"updated": 1688528464956,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 392,
			"versionNonce": 1839700980,
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
			"updated": 1688528464956,
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
			"version": 500,
			"versionNonce": 1462193484,
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
			"updated": 1688528464956,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 554,
			"versionNonce": 196607348,
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
			"updated": 1688528464956,
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
			"version": 48,
			"versionNonce": 1812971596,
			"isDeleted": false,
			"id": "q9JxGsUP0EeRMllbs475Y",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1936.5289656459995,
			"y": -53.50845304705308,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 171,
			"height": 73,
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
			"updated": 1688529347916,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 431,
			"versionNonce": 1845770868,
			"isDeleted": false,
			"id": "XhqwceMi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1931.4414717495151,
			"y": -48.40843677101145,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 160.82501220703125,
			"height": 62.799967447916735,
			"seed": 24173932,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688529347916,
			"link": null,
			"locked": false,
			"fontSize": 25.119986979166693,
			"fontFamily": 1,
			"text": "Skin Material\n& Rendering",
			"rawText": "Skin Material & Rendering",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "q9JxGsUP0EeRMllbs475Y",
			"originalText": "Skin Material & Rendering",
			"lineHeight": 1.25,
			"baseline": 53
		},
		{
			"type": "text",
			"version": 528,
			"versionNonce": 1783982668,
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
			"updated": 1688528464956,
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
			"version": 151,
			"versionNonce": 533082228,
			"isDeleted": false,
			"id": "fUiS5goz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2778.3768734829555,
			"y": 26.037285354601295,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 563.98876953125,
			"height": 20,
			"seed": 785125460,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464957,
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
			"version": 124,
			"versionNonce": 1263157452,
			"isDeleted": false,
			"id": "wxQwu46E",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2778.3768734829555,
			"y": 66.69895692855567,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 227.47601318359375,
			"height": 20,
			"seed": 1395465428,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464957,
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
			"version": 123,
			"versionNonce": 370147828,
			"isDeleted": false,
			"id": "Hqw5PRdY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2778.3768734829555,
			"y": -15.87254139733733,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 243.87200927734375,
			"height": 20,
			"seed": 1474842092,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464957,
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
			"version": 13,
			"versionNonce": 341854028,
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
			"updated": 1688528464957,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 201,
			"versionNonce": 371434356,
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
			"updated": 1688528464957,
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
			"version": 15,
			"versionNonce": 166821324,
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
			"updated": 1688528464957,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 51,
			"versionNonce": 1715934452,
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
			"updated": 1688528464957,
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
			"version": 13,
			"versionNonce": 1427629132,
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
			"updated": 1688528464957,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 105,
			"versionNonce": 335566452,
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
			"updated": 1688528464957,
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
			"version": 58,
			"versionNonce": 1806531276,
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
			"updated": 1688528464957,
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
			"version": 75,
			"versionNonce": 202729460,
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
			"updated": 1688528464958,
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
			"version": 93,
			"versionNonce": 2018263372,
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
			"updated": 1688528464958,
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
			"version": 596,
			"versionNonce": 848054644,
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
			"updated": 1688528464958,
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
			"version": 167,
			"versionNonce": 1112422348,
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
			"updated": 1688528464958,
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
			"version": 116,
			"versionNonce": 2058025716,
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
			"updated": 1688528464958,
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
			"version": 84,
			"versionNonce": 365780556,
			"isDeleted": false,
			"id": "I94yTpYZFsC7Uh5kcpcGj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1015.2973288324296,
			"y": -205.7255596031763,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 21.333414713541742,
			"height": 38.22221544053815,
			"seed": 1242587604,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464958,
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
			"version": 219,
			"versionNonce": 2130148468,
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
			"width": 438.55687583666645,
			"height": 575.9269389483084,
			"seed": 1640615252,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464958,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0012560580681709,
					0
				],
				[
					2.002512116136598,
					0
				],
				[
					4.005100623213568,
					4.266141144926213
				],
				[
					8.010124855486763,
					10.665312177378437
				],
				[
					12.015225478700076,
					14.931453322304652
				],
				[
					18.022838218050243,
					27.729795387208966
				],
				[
					25.031783406409463,
					42.66124870951361
				],
				[
					36.045829217981996,
					61.858843176744486
				],
				[
					60.07628017538214,
					95.98780959640567
				],
				[
					69.08766108893708,
					110.91926291871032
				],
				[
					77.09786233536423,
					123.71760498361463
				],
				[
					87.11057569792821,
					138.64905830591928
				],
				[
					93.11826482821876,
					147.18134059577173
				],
				[
					98.12462150950049,
					155.7135415157498
				],
				[
					104.13215785791002,
					162.11271254820204
				],
				[
					111.14117943720963,
					170.64499483805443
				],
				[
					118.15004823462796,
					181.3103070154329
				],
				[
					127.16142914818289,
					198.3747902252634
				],
				[
					136.17296284361882,
					211.17321366004222
				],
				[
					146.18567620618256,
					226.10458561247253
				],
				[
					161.20474625002802,
					247.43529133710373
				],
				[
					174.22115139585617,
					262.36666328953396
				],
				[
					183.2326850912921,
					277.29819798171303
				],
				[
					197.2504226861288,
					296.4956297091951
				],
				[
					204.2592914835471,
					305.02791199904755
				],
				[
					210.2669806138379,
					309.2941345138482
				],
				[
					214.27200484611086,
					317.826254063952
				],
				[
					218.27718186026505,
					322.09247657875267
				],
				[
					220.27969397640135,
					324.2255064662784
				],
				[
					224.28471820867458,
					330.6247588686051
				],
				[
					230.29240733896538,
					339.1568784187086
				],
				[
					236.30009646925592,
					343.4231009335093
				],
				[
					241.3064531505379,
					349.82219059608707
				],
				[
					247.31398949894745,
					354.0884131108877
				],
				[
					250.31783406409258,
					360.4875027734655
				],
				[
					254.3228582963655,
					362.6206954007401
				],
				[
					257.3267028615109,
					366.88675517579213
				],
				[
					263.33439199180174,
					375.41903746564464
				],
				[
					268.34074867308345,
					377.5520673531706
				],
				[
					270.34326078922004,
					381.8181271282224
				],
				[
					272.3457729053566,
					386.084349643023
				],
				[
					277.35212958663834,
					388.217379530549
				],
				[
					281.3573066007925,
					394.61663193287546
				],
				[
					288.36617539821094,
					401.0157215954532
				],
				[
					295.3750441956293,
					407.4149739977799
				],
				[
					298.37888876077466,
					409.54800388530566
				],
				[
					300.3814008769112,
					413.8140636603577
				],
				[
					304.3864251091842,
					418.08028617515834
				],
				[
					308.3916021233384,
					422.34634595021004
				],
				[
					313.39795880462015,
					428.7455983525365
				],
				[
					314.39913847174796,
					430.87862824006254
				],
				[
					317.4029830368933,
					433.01165812758853
				],
				[
					320.4068276020387,
					437.27788064238916
				],
				[
					323.41067216718386,
					439.41091052991493
				],
				[
					326.4145167323293,
					445.8100001924927
				],
				[
					329.41820851559345,
					450.07622270729337
				],
				[
					333.42338552974763,
					454.34228248234535
				],
				[
					336.42723009489305,
					458.6085049971458
				],
				[
					339.4309218781571,
					462.87456477219786
				],
				[
					341.4335867761747,
					462.87456477219786
				],
				[
					343.4360988923113,
					467.14062454724956
				],
				[
					345.4386110084479,
					469.27381717452425
				],
				[
					346.4399434574567,
					469.27381717452425
				],
				[
					349.4436352407209,
					473.5398769495763
				],
				[
					351.4463001387385,
					473.5398769495763
				],
				[
					353.44881225487507,
					477.805936724628
				],
				[
					357.45383648714795,
					482.0721592394287
				],
				[
					359.4563486032846,
					484.20518912695474
				],
				[
					362.46019316843,
					488.47124890200644
				],
				[
					365.4640377335754,
					488.47124890200644
				],
				[
					366.46537018258397,
					490.60444152928113
				],
				[
					370.47039441485714,
					497.0035311918589
				],
				[
					373.4742389800025,
					499.1365610793849
				],
				[
					373.4742389800025,
					501.2697537066595
				],
				[
					375.47675109613886,
					503.4027835941855
				],
				[
					376.4780835451479,
					503.4027835941855
				],
				[
					378.48059566128427,
					507.6688433692373
				],
				[
					380.4831077774208,
					509.8018732567633
				],
				[
					381.4844402264296,
					509.8018732567633
				],
				[
					383.4869523425662,
					511.93506588403807
				],
				[
					384.4881320096938,
					514.068095771564
				],
				[
					385.48946445870257,
					516.2011256590897
				],
				[
					387.4919765748392,
					518.3341555466158
				],
				[
					388.493309023848,
					518.3341555466158
				],
				[
					391.4971535889934,
					520.4671854341418
				],
				[
					392.49833325612093,
					522.6003780614164
				],
				[
					393.49966570512976,
					524.7334079489422
				],
				[
					395.50217782126634,
					526.8664378364681
				],
				[
					397.504689937403,
					528.9994677239941
				],
				[
					398.50602238641176,
					528.9994677239941
				],
				[
					399.5072020535393,
					531.13249761152
				],
				[
					401.5098669515571,
					533.2656902387948
				],
				[
					402.5110466186847,
					535.3987201263205
				],
				[
					403.5123790676935,
					535.3987201263205
				],
				[
					405.51489118383006,
					537.5317500138466
				],
				[
					406.5162236328389,
					539.6647799013725
				],
				[
					408.5187357489754,
					539.6647799013725
				],
				[
					409.519915416103,
					541.7978097888982
				],
				[
					411.52258031412083,
					543.9310024161733
				],
				[
					411.52258031412083,
					546.0640323036992
				],
				[
					413.5250924302572,
					546.0640323036992
				],
				[
					413.5250924302572,
					548.1970621912251
				],
				[
					415.5276045463938,
					550.330092078751
				],
				[
					416.5289369954026,
					550.330092078751
				],
				[
					417.5301166625304,
					552.4631219662767
				],
				[
					418.5314491115392,
					552.4631219662767
				],
				[
					418.5314491115392,
					554.5963145935515
				],
				[
					419.5326287786667,
					554.5963145935515
				],
				[
					420.5339612276755,
					554.5963145935515
				],
				[
					421.5352936766843,
					556.7293444810775
				],
				[
					422.53647334381213,
					558.8623743686035
				],
				[
					423.5378057928209,
					560.9954042561293
				],
				[
					425.54031790895755,
					560.9954042561293
				],
				[
					426.5416503579663,
					563.1284341436552
				],
				[
					427.5428300250939,
					565.26162677093
				],
				[
					428.5441624741029,
					565.26162677093
				],
				[
					430.54667459023926,
					565.26162677093
				],
				[
					431.5480070392481,
					567.3946566584559
				],
				[
					431.5480070392481,
					569.527686545982
				],
				[
					432.5491867063759,
					569.527686545982
				],
				[
					433.5505191553847,
					571.6607164335077
				],
				[
					434.5516988225125,
					571.6607164335077
				],
				[
					435.5530312715213,
					573.7937463210336
				],
				[
					436.5543637205301,
					573.7937463210336
				],
				[
					437.5555433876577,
					575.9269389483084
				],
				[
					438.55687583666645,
					575.9269389483084
				],
				[
					438.55687583666645,
					575.9269389483084
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 378,
			"versionNonce": 732148940,
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
			"updated": 1688528464958,
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
			"version": 814,
			"versionNonce": 423087604,
			"isDeleted": false,
			"id": "O7gE1Rah",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1808.90848559923,
			"y": 1033.922153748456,
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
			"updated": 1688528464958,
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
			"version": 843,
			"versionNonce": 292240204,
			"isDeleted": false,
			"id": "cV8fWHsE4_2Wcw3KsCPgL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1810.1392360499513,
			"y": 749.7499596925798,
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
			"updated": 1688528464958,
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
			"version": 809,
			"versionNonce": 2054287220,
			"isDeleted": false,
			"id": "cPRxR0UM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1174.6286334649362,
			"y": 992.1967562872343,
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
			"updated": 1688528464958,
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
			"version": 576,
			"versionNonce": 293466572,
			"isDeleted": false,
			"id": "t5_RDPiNXFtWc32xcggP2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1173.397789113975,
			"y": 749.7499596925798,
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
			"updated": 1688528464959,
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
			"version": 310,
			"versionNonce": 1575597680,
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
			"updated": 1697531357897,
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
			"version": 90,
			"versionNonce": 452319308,
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
			"updated": 1688528464959,
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
			"version": 186,
			"versionNonce": 439067252,
			"isDeleted": false,
			"id": "ohCyIHDN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1930.9137601942127,
			"y": 217.13513464476108,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 110.38435363769531,
			"height": 25,
			"seed": 1154871660,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464959,
			"link": "https://huangx916.github.io/2019/04/16/sss/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[ref 1]]",
			"rawText": "[ref 1](https://huangx916.github.io/2019/04/16/sss/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[ref 1]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 68,
			"versionNonce": 699199180,
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
			"updated": 1688528464959,
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
			"version": 373,
			"versionNonce": 1190605812,
			"isDeleted": false,
			"id": "4wzdNHkms2RwYdy48rJVE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -491.0838288487121,
			"y": 403.3372258981648,
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
			"updated": 1688528464959,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 392,
			"versionNonce": 775763276,
			"isDeleted": false,
			"id": "VJWCETLw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -485.9079560459777,
			"y": 408.3372258981648,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 121.64825439453125,
			"height": 20,
			"seed": 1917973588,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464959,
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
			"version": 490,
			"versionNonce": 1196725620,
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
			"groupIds": [
				"03RAPh2FHBbdULLMmV5-L"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464959,
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
			"version": 429,
			"versionNonce": 1979755468,
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
			"groupIds": [
				"03RAPh2FHBbdULLMmV5-L"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464959,
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
			"version": 383,
			"versionNonce": 1753859828,
			"isDeleted": false,
			"id": "UvIbeydInemVHGrESOBYB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 443.12484559270854,
			"y": 51.27652263573901,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 305.0407319611655,
			"height": 236.57603434321499,
			"seed": 1926516180,
			"groupIds": [
				"03RAPh2FHBbdULLMmV5-L"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464959,
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
			"version": 154,
			"versionNonce": 319902284,
			"isDeleted": false,
			"id": "4jrypWAN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 427.3971952158694,
			"y": 307.67271876947103,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 336.49603271484375,
			"height": 20,
			"seed": 1481381716,
			"groupIds": [
				"03RAPh2FHBbdULLMmV5-L"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
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
			"version": 134,
			"versionNonce": 1595721844,
			"isDeleted": false,
			"id": "KJBGLnhN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -487.0324680989605,
			"y": 453.7432833041157,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 150.080322265625,
			"height": 40,
			"seed": 1640104172,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
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
			"version": 116,
			"versionNonce": 1145645260,
			"isDeleted": false,
			"id": "o0ufdNFH6KJW1aWiP7KI3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -184.3005027929123,
			"y": 400.36241453439175,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 500.00000000000006,
			"height": 229,
			"seed": 1799611092,
			"groupIds": [
				"jx2Ggs1kl4LDX2eyqHf29"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
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
			"version": 171,
			"versionNonce": 1590925812,
			"isDeleted": false,
			"id": "s83vPhYK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -132.18742838948037,
			"y": 641.7135551892126,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 401.64825439453125,
			"height": 20,
			"seed": 1679654380,
			"groupIds": [
				"jx2Ggs1kl4LDX2eyqHf29"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
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
			"version": 215,
			"versionNonce": 1564618572,
			"isDeleted": false,
			"id": "x2obQR7v",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2778.3768734829555,
			"y": 107.27440070716284,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 120.89971923828125,
			"height": 20,
			"seed": 2102251724,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
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
			"type": "text",
			"version": 48,
			"versionNonce": 850672500,
			"isDeleted": false,
			"id": "Hz4cOtPH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1929.8611286152654,
			"y": 260.8858166438704,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 95.36372375488281,
			"height": 40,
			"seed": 1246572126,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
			"link": "https://github.com/QianMo/Game-Programmer-Study-Notes/blob/master/Content/%E3%80%8AGPU%20Gems%203%E3%80%8B%E5%85%A8%E4%B9%A6%E6%8F%90%E7%82%BC%E6%80%BB%E7%BB%93/Part1/README.md",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[ref 2]]\n",
			"rawText": "[ref 2](https://github.com/QianMo/Game-Programmer-Study-Notes/blob/master/Content/%E3%80%8AGPU%20Gems%203%E3%80%8B%E5%85%A8%E4%B9%A6%E6%8F%90%E7%82%BC%E6%80%BB%E7%BB%93/Part1/README.md)\n",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[ref 2]]\n",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 74,
			"versionNonce": 777414092,
			"isDeleted": false,
			"id": "uwT0Lfme",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1930.9137601942127,
			"y": 310.3595008543965,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 94.86772155761719,
			"height": 20,
			"seed": 529690718,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
			"link": "https://developer.nvidia.com/gpugems/gpugems3/part-iii-rendering/chapter-14-advanced-techniques-realistic-real-time-skin",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[ref 3]]",
			"rawText": "[ref 3](https://developer.nvidia.com/gpugems/gpugems3/part-iii-rendering/chapter-14-advanced-techniques-realistic-real-time-skin)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[ref 3]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 458,
			"versionNonce": 1426369780,
			"isDeleted": false,
			"id": "Z6Ux3p0L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -179.6511728309257,
			"y": 1002.7018822293785,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 485.9766845703125,
			"height": 74.8243640754342,
			"seed": 898818548,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
			"link": null,
			"locked": false,
			"fontSize": 14.96487281508684,
			"fontFamily": 1,
			"text": "为了方便计算, 使用多个高斯函数之和来近似 diffusion profile,\n对于很多材料, 相关参数已有研究可以直接取用(Jensen et al. 2001).\n\n右侧两图是皮肤材质用到的6个高斯函数, 以及其近似的 diffusion profile",
			"rawText": "为了方便计算, 使用多个高斯函数之和来近似 diffusion profile,\n对于很多材料, 相关参数已有研究可以直接取用(Jensen et al. 2001).\n\n右侧两图是皮肤材质用到的6个高斯函数, 以及其近似的 diffusion profile",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "为了方便计算, 使用多个高斯函数之和来近似 diffusion profile,\n对于很多材料, 相关参数已有研究可以直接取用(Jensen et al. 2001).\n\n右侧两图是皮肤材质用到的6个高斯函数, 以及其近似的 diffusion profile",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "image",
			"version": 219,
			"versionNonce": 1822411852,
			"isDeleted": false,
			"id": "C4HwMjgy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -187.75899485191258,
			"y": 887.3844898947652,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 167,
			"height": 96,
			"seed": 77807,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "597d4e4965fcb42cdc70ca2a15d64e0983bfcef2",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 94,
			"versionNonce": 122351220,
			"isDeleted": false,
			"id": "-0viEE0ePXT7f19C_bRKH",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 4.8999084957171135,
			"y": 730.8698164629714,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 400,
			"height": 255,
			"seed": 1104904780,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "41f11494a4cfefeb41cc19ba667c5e4383d72925",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 124,
			"versionNonce": 435708620,
			"isDeleted": false,
			"id": "dig2Cm7V_dZr9lDv5vari",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 430.1242221003188,
			"y": 756.2614355253652,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 350,
			"height": 232,
			"seed": 127851084,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464960,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "93c076ee3e03cfbe0b82561a74338edf114ee13a",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 321,
			"versionNonce": 1783431156,
			"isDeleted": false,
			"id": "W2qnr8QfDmgQAccK1ZoYU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -205.5306683241016,
			"y": 100.73124134455463,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 154.72507703689723,
			"height": 980.6184939021445,
			"seed": 123026292,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464961,
			"link": null,
			"locked": false,
			"points": [
				[
					16.596219726492436,
					0.03436032573810891
				],
				[
					15.377912033288514,
					0.03436032573810891
				],
				[
					10.504681260472942,
					-1.0876287977197308
				],
				[
					5.631450487657246,
					-1.0876287977197308
				],
				[
					-4.115011057974019,
					0.03436032573810891
				],
				[
					-8.988241830789715,
					0.03436032573810891
				],
				[
					-13.861472603605414,
					2.278338572653788
				],
				[
					-21.171318762828832,
					4.522316819569409
				],
				[
					-27.262857228848453,
					6.766295066485088
				],
				[
					-45.53747262690719,
					17.98618630106343
				],
				[
					-57.7205495589463,
					25.840110165268246
				],
				[
					-62.593780331762005,
					29.206077535641707
				],
				[
					-66.24870341137377,
					34.81602315293091
				],
				[
					-72.34024187739327,
					46.03591438750919
				],
				[
					-74.77685726380112,
					48.27989263442486
				],
				[
					-78.43178034341288,
					57.25580562208752
				],
				[
					-82.08670342302466,
					67.35370773320797
				],
				[
					-83.30501111622858,
					74.08564247395495
				],
				[
					-84.52331880943251,
					79.69558809124415
				],
				[
					-86.95993419584036,
					84.18354458507545
				],
				[
					-86.95993419584036,
					90.91547932582243
				],
				[
					-86.95993419584036,
					96.52542494311162
				],
				[
					-88.17824188904416,
					102.13537056040077
				],
				[
					-89.39654958224808,
					107.7453161776899
				],
				[
					-91.83316496865592,
					112.23327267152126
				],
				[
					-93.05147266185986,
					116.72122916535257
				],
				[
					-94.26978035506377,
					120.0871965357261
				],
				[
					-94.26978035506377,
					125.69714215301522
				],
				[
					-94.26978035506377,
					130.1850986468465
				],
				[
					-94.26978035506377,
					136.9170333875935
				],
				[
					-95.4880880482677,
					141.40498988142485
				],
				[
					-96.70639574147162,
					145.89294637525614
				],
				[
					-97.92470343467554,
					153.74687023946097
				],
				[
					-97.92470343467554,
					161.60079410366578
				],
				[
					-97.92470343467554,
					170.57670709132844
				],
				[
					-96.70639574147162,
					178.43063095553333
				],
				[
					-96.70639574147162,
					184.0405765728224
				],
				[
					-96.70639574147162,
					189.65052219011162
				],
				[
					-96.70639574147162,
					194.13847868394296
				],
				[
					-96.70639574147162,
					199.74842430123206
				],
				[
					-96.70639574147162,
					206.48035904197909
				],
				[
					-95.4880880482677,
					212.09030465926816
				],
				[
					-95.4880880482677,
					217.70025027655737
				],
				[
					-95.4880880482677,
					223.31019589384655
				],
				[
					-95.4880880482677,
					227.79815238767782
				],
				[
					-96.70639574147162,
					232.28610888150916
				],
				[
					-96.70639574147162,
					236.7740653753405
				],
				[
					-96.70639574147162,
					241.26202186917178
				],
				[
					-96.70639574147162,
					244.6279892395453
				],
				[
					-96.70639574147162,
					247.9939566099188
				],
				[
					-96.70639574147162,
					251.35992398029236
				],
				[
					-96.70639574147162,
					254.72589135066585
				],
				[
					-97.92470343467554,
					258.0918587210392
				],
				[
					-97.92470343467554,
					261.45782609141276
				],
				[
					-97.92470343467554,
					267.06777170870197
				],
				[
					-97.92470343467554,
					270.43373907907545
				],
				[
					-97.92470343467554,
					273.7997064494489
				],
				[
					-99.14301112787948,
					274.92169557290674
				],
				[
					-99.14301112787948,
					280.53164119019596
				],
				[
					-100.3613188210834,
					283.89760856056944
				],
				[
					-100.3613188210834,
					288.3855650544007
				],
				[
					-101.57962651428731,
					291.7515324247742
				],
				[
					-101.57962651428731,
					293.9955106716899
				],
				[
					-102.79793420749124,
					296.23948891860556
				],
				[
					-102.79793420749124,
					298.48346716552123
				],
				[
					-102.79793420749124,
					299.60545628897904
				],
				[
					-104.01624190069518,
					300.7274454124369
				],
				[
					-104.01624190069518,
					302.9714236593526
				],
				[
					-104.01624190069518,
					304.09341278281033
				],
				[
					-105.23454959389898,
					307.4593801531839
				],
				[
					-106.45285728710289,
					308.5813692766417
				],
				[
					-106.45285728710289,
					309.70335840009955
				],
				[
					-107.67116498030681,
					309.70335840009955
				],
				[
					-108.88947267351074,
					309.70335840009955
				],
				[
					-118.63593421914214,
					309.70335840009955
				],
				[
					-122.29085729875376,
					309.70335840009955
				],
				[
					-125.94578037836555,
					309.70335840009955
				],
				[
					-127.1640880715695,
					309.70335840009955
				],
				[
					-128.3823957647734,
					309.70335840009955
				],
				[
					-133.2556265375891,
					310.82534752355735
				],
				[
					-135.69224192399696,
					310.82534752355735
				],
				[
					-138.12885731040478,
					311.94733664701516
				],
				[
					-138.12885731040478,
					313.06932577047303
				],
				[
					-136.91054961720084,
					315.3133040173887
				],
				[
					-134.47393423079302,
					317.5572822643044
				],
				[
					-132.03731884438517,
					319.80126051121994
				],
				[
					-128.3823957647734,
					323.1672278815935
				],
				[
					-124.72747268516162,
					326.53319525196696
				],
				[
					-119.85424191234605,
					329.8991626223405
				],
				[
					-114.98101113953035,
					333.26512999271404
				],
				[
					-113.76270344632644,
					334.3871191161718
				],
				[
					-113.76270344632644,
					336.63109736308746
				],
				[
					-113.76270344632644,
					337.75308648654527
				],
				[
					-113.76270344632644,
					343.3630321038345
				],
				[
					-113.76270344632644,
					345.60701035075016
				],
				[
					-113.76270344632644,
					350.0949668445814
				],
				[
					-113.76270344632644,
					354.58292333841274
				],
				[
					-112.54439575312252,
					359.0708798322441
				],
				[
					-112.54439575312252,
					363.5588363260755
				],
				[
					-110.10778036671465,
					369.16878194336454
				],
				[
					-107.67116498030681,
					377.0227058075694
				],
				[
					-106.45285728710289,
					381.51066230140066
				],
				[
					-106.45285728710289,
					385.998618795232
				],
				[
					-105.23454959389898,
					390.4865752890634
				],
				[
					-105.23454959389898,
					394.97453178289476
				],
				[
					-104.01624190069518,
					399.462488276726
				],
				[
					-104.01624190069518,
					405.0724338940152
				],
				[
					-102.79793420749124,
					409.5603903878465
				],
				[
					-102.79793420749124,
					414.0483468816778
				],
				[
					-102.79793420749124,
					418.53630337550914
				],
				[
					-102.79793420749124,
					423.02425986934054
				],
				[
					-102.79793420749124,
					428.6342054866296
				],
				[
					-102.79793420749124,
					434.2441511039188
				],
				[
					-102.79793420749124,
					439.85409672120795
				],
				[
					-102.79793420749124,
					447.7080205854128
				],
				[
					-102.79793420749124,
					454.43995532615975
				],
				[
					-102.79793420749124,
					461.1718900669067
				],
				[
					-102.79793420749124,
					467.90382480765373
				],
				[
					-102.79793420749124,
					476.8797377953164
				],
				[
					-102.79793420749124,
					486.9776399064369
				],
				[
					-102.79793420749124,
					497.0755420175573
				],
				[
					-102.79793420749124,
					508.2954332521356
				],
				[
					-102.79793420749124,
					518.3933353632561
				],
				[
					-102.79793420749124,
					527.3692483509187
				],
				[
					-102.79793420749124,
					535.2231722151237
				],
				[
					-102.79793420749124,
					544.1990852027863
				],
				[
					-102.79793420749124,
					550.9310199435333
				],
				[
					-102.79793420749124,
					563.2729003015694
				],
				[
					-102.79793420749124,
					570.0048350423164
				],
				[
					-102.79793420749124,
					576.7367697830633
				],
				[
					-102.79793420749124,
					583.4687045238103
				],
				[
					-102.79793420749124,
					590.2006392645574
				],
				[
					-102.79793420749124,
					594.6885957583887
				],
				[
					-102.79793420749124,
					601.4205304991356
				],
				[
					-102.79793420749124,
					607.0304761164248
				],
				[
					-102.79793420749124,
					612.640421733714
				],
				[
					-102.79793420749124,
					619.372356474461
				],
				[
					-102.79793420749124,
					624.9823020917501
				],
				[
					-102.79793420749124,
					629.4702585855814
				],
				[
					-102.79793420749124,
					636.2021933263285
				],
				[
					-102.79793420749124,
					641.8121389436176
				],
				[
					-102.79793420749124,
					651.910041054738
				],
				[
					-102.79793420749124,
					658.6419757954851
				],
				[
					-102.79793420749124,
					665.3739105362321
				],
				[
					-102.79793420749124,
					670.9838561535212
				],
				[
					-101.57962651428731,
					675.4718126473526
				],
				[
					-101.57962651428731,
					678.8377800177259
				],
				[
					-100.3613188210834,
					682.2037473880995
				],
				[
					-99.14301112787948,
					686.6917038819308
				],
				[
					-99.14301112787948,
					693.4236386226777
				],
				[
					-97.92470343467554,
					700.1555733634248
				],
				[
					-96.70639574147162,
					708.0094972276295
				],
				[
					-95.4880880482677,
					714.7414319683766
				],
				[
					-95.4880880482677,
					721.4733667091236
				],
				[
					-95.4880880482677,
					727.0833123264127
				],
				[
					-95.4880880482677,
					734.9372361906175
				],
				[
					-95.4880880482677,
					740.5471818079069
				],
				[
					-95.4880880482677,
					746.1571274251959
				],
				[
					-95.4880880482677,
					751.767073042485
				],
				[
					-95.4880880482677,
					757.3770186597742
				],
				[
					-95.4880880482677,
					765.230942523979
				],
				[
					-95.4880880482677,
					771.962877264726
				],
				[
					-95.4880880482677,
					780.9387902523886
				],
				[
					-95.4880880482677,
					789.9147032400513
				],
				[
					-95.4880880482677,
					798.890616227714
				],
				[
					-95.4880880482677,
					804.5005618450031
				],
				[
					-95.4880880482677,
					811.2324965857501
				],
				[
					-95.4880880482677,
					815.7204530795814
				],
				[
					-95.4880880482677,
					821.3303986968706
				],
				[
					-95.4880880482677,
					825.8183551907019
				],
				[
					-95.4880880482677,
					829.1843225610753
				],
				[
					-95.4880880482677,
					835.9162573018224
				],
				[
					-95.4880880482677,
					839.2822246721958
				],
				[
					-95.4880880482677,
					841.5262029191115
				],
				[
					-95.4880880482677,
					844.8921702894851
				],
				[
					-95.4880880482677,
					847.1361485364007
				],
				[
					-95.4880880482677,
					850.5021159067742
				],
				[
					-95.4880880482677,
					852.7460941536899
				],
				[
					-95.4880880482677,
					856.1120615240633
				],
				[
					-95.4880880482677,
					858.3560397709789
				],
				[
					-95.4880880482677,
					860.6000180178946
				],
				[
					-95.4880880482677,
					863.9659853882682
				],
				[
					-95.4880880482677,
					867.3319527586417
				],
				[
					-95.4880880482677,
					870.6979201290151
				],
				[
					-95.4880880482677,
					875.1858766228464
				],
				[
					-95.4880880482677,
					879.6738331166778
				],
				[
					-95.4880880482677,
					884.1617896105091
				],
				[
					-95.4880880482677,
					887.5277569808825
				],
				[
					-95.4880880482677,
					889.7717352277982
				],
				[
					-94.26978035506377,
					893.1377025981718
				],
				[
					-94.26978035506377,
					896.5036699685453
				],
				[
					-93.05147266185986,
					900.9916264623765
				],
				[
					-93.05147266185986,
					903.2356047092921
				],
				[
					-91.83316496865592,
					906.6015720796656
				],
				[
					-91.83316496865592,
					909.9675394500395
				],
				[
					-91.83316496865592,
					912.2115176969548
				],
				[
					-90.614857275452,
					914.4554959438708
				],
				[
					-90.614857275452,
					917.8214633142442
				],
				[
					-89.39654958224808,
					920.0654415611596
				],
				[
					-89.39654958224808,
					924.553398054991
				],
				[
					-88.17824188904416,
					926.7973763019069
				],
				[
					-88.17824188904416,
					930.1633436722802
				],
				[
					-88.17824188904416,
					932.4073219191957
				],
				[
					-86.95993419584036,
					934.6513001661116
				],
				[
					-85.74162650263644,
					936.8952784130271
				],
				[
					-85.74162650263644,
					939.139256659943
				],
				[
					-85.74162650263644,
					941.3832349068584
				],
				[
					-84.52331880943251,
					942.5052240303164
				],
				[
					-83.30501111622858,
					945.8711914006899
				],
				[
					-83.30501111622858,
					948.1151696476053
				],
				[
					-82.08670342302466,
					950.3591478945212
				],
				[
					-80.86839572982073,
					951.4811370179791
				],
				[
					-79.65008803661682,
					953.7251152648946
				],
				[
					-78.43178034341288,
					954.8471043883525
				],
				[
					-77.21347265020896,
					955.9690935118105
				],
				[
					-75.99516495700504,
					958.213071758726
				],
				[
					-73.55854957059718,
					960.4570500056419
				],
				[
					-69.90362649098554,
					963.8230173760153
				],
				[
					-67.46701110457771,
					964.9450064994728
				],
				[
					-65.03039571816984,
					967.1889847463887
				],
				[
					-63.81208802496593,
					968.3109738698466
				],
				[
					-61.37547263855808,
					969.4329629933042
				],
				[
					-60.15716494535414,
					970.554952116762
				],
				[
					-57.7205495589463,
					971.67694124022
				],
				[
					-55.28393417253845,
					971.67694124022
				],
				[
					-54.065626479334526,
					972.798930363678
				],
				[
					-52.84731878613074,
					972.798930363678
				],
				[
					-50.41070339972289,
					973.9209194871354
				],
				[
					-47.97408801331504,
					975.0429086105935
				],
				[
					-45.53747262690719,
					975.0429086105935
				],
				[
					-41.88254954729542,
					976.1648977340514
				],
				[
					-39.44593416088757,
					977.2868868575093
				],
				[
					-37.009318774479716,
					978.4088759809669
				],
				[
					-33.354395694868074,
					978.4088759809669
				],
				[
					-29.699472615256305,
					979.5308651044248
				],
				[
					-26.044549535644528,
					979.5308651044248
				],
				[
					-23.607934149236684,
					979.5308651044248
				],
				[
					-21.171318762828832,
					979.5308651044248
				],
				[
					-17.516395683217187,
					979.5308651044248
				],
				[
					-13.861472603605414,
					979.5308651044248
				],
				[
					-8.988241830789715,
					979.5308651044248
				],
				[
					-6.551626444381867,
					979.5308651044248
				],
				[
					-4.115011057974019,
					979.5308651044248
				],
				[
					-2.8967033647702234,
					979.5308651044248
				],
				[
					-1.6783956715662995,
					978.4088759809669
				],
				[
					-0.4600879783623739,
					979.5308651044248
				],
				[
					0.7582197148415499,
					979.5308651044248
				],
				[
					-0.4600879783623739,
					979.5308651044248
				],
				[
					-0.4600879783623739,
					979.5308651044248
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "rectangle",
			"version": 225,
			"versionNonce": 1828333900,
			"isDeleted": false,
			"id": "JUfZN7Afw13z83LGm911o",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -471.15803537280374,
			"y": 1299.6388561644126,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 125,
			"height": 30,
			"seed": 1477699020,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "aBiuVDq9",
					"type": "text"
				}
			],
			"updated": 1688528464961,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 257,
			"versionNonce": 370205044,
			"isDeleted": false,
			"id": "aBiuVDq9",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -465.97815713794046,
			"y": 1304.6388561644126,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 114.64024353027344,
			"height": 20,
			"seed": 1955255924,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464961,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Implementation",
			"rawText": "Implementation",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "JUfZN7Afw13z83LGm911o",
			"originalText": "Implementation",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 42,
			"versionNonce": 956243916,
			"isDeleted": false,
			"id": "p8OZuw9NjLQDUzTWGN9yg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -97.5317115339351,
			"y": 1151.9544907755085,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 168,
			"height": 30,
			"seed": 1347350092,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "6B8EPmok",
					"type": "text"
				}
			],
			"updated": 1688528464961,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 451,
			"versionNonce": 836539124,
			"isDeleted": false,
			"id": "6B8EPmok",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -92.15587230053666,
			"y": 1156.9544907755085,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 157.24832153320312,
			"height": 20,
			"seed": 631180020,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464961,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Texture Space Blur",
			"rawText": "Texture Space Blur",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "p8OZuw9NjLQDUzTWGN9yg",
			"originalText": "Texture Space Blur",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 441,
			"versionNonce": 1034325620,
			"isDeleted": false,
			"id": "QodDcoKPPpdu7lEsUBJ7d",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -123.63942233302703,
			"y": 1936.0453857085804,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 153,
			"height": 30,
			"seed": 671012940,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "XdQtvRuI",
					"type": "text"
				}
			],
			"updated": 1688529292905,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 631,
			"versionNonce": 1084670668,
			"isDeleted": false,
			"id": "XdQtvRuI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -118.38756839015593,
			"y": 1941.0453857085804,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 142.4962921142578,
			"height": 20,
			"seed": 250289996,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688529292905,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Screen Space Blur",
			"rawText": "Screen Space Blur",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "QodDcoKPPpdu7lEsUBJ7d",
			"originalText": "Screen Space Blur",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 222,
			"versionNonce": 154836172,
			"isDeleted": false,
			"id": "qt2BI5BW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -114.359036778595,
			"y": 1185.1107523529975,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 220.7632293701172,
			"height": 103.58141406753225,
			"seed": 1942097396,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464961,
			"link": null,
			"locked": false,
			"fontSize": 13.8108552090043,
			"fontFamily": 1,
			"text": "在纹理空间中对irradiance texture\n应用各个高斯模糊, 然后合并.\n\n要求高精度纹理, 每一帧都要做\n6x3次高斯模糊, 计算量大.\n不适合实时场景.",
			"rawText": "在纹理空间中对irradiance texture\n应用各个高斯模糊, 然后合并.\n\n要求高精度纹理, 每一帧都要做\n6x3次高斯模糊, 计算量大.\n不适合实时场景.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "在纹理空间中对irradiance texture\n应用各个高斯模糊, 然后合并.\n\n要求高精度纹理, 每一帧都要做\n6x3次高斯模糊, 计算量大.\n不适合实时场景.",
			"lineHeight": 1.25,
			"baseline": 98
		},
		{
			"type": "image",
			"version": 185,
			"versionNonce": 853763572,
			"isDeleted": false,
			"id": "MyQjcT48TqhACH_p3aX54",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 560.9310918223646,
			"y": 1094.951267129703,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 471.878635689698,
			"height": 252.9793796891992,
			"seed": 44663244,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464961,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "0e1c2babb45f932d4510c97aa2532bf73afadbad",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 232,
			"versionNonce": 227992524,
			"isDeleted": false,
			"id": "klkWJE4cjn72C5ZXW1hh_",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -87.20406679266921,
			"y": 1438.0851910000406,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 73,
			"height": 30,
			"seed": 563022668,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "YXcAdVSn",
					"type": "text"
				}
			],
			"updated": 1688529197145,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 506,
			"versionNonce": 1720913652,
			"isDeleted": false,
			"id": "YXcAdVSn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -81.77614168280593,
			"y": 1443.0851910000406,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 62.14414978027344,
			"height": 20,
			"seed": 1492204364,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688529197145,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Scatter",
			"rawText": "Scatter",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "klkWJE4cjn72C5ZXW1hh_",
			"originalText": "Scatter",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 928,
			"versionNonce": 1260423756,
			"isDeleted": false,
			"id": "HuVSOHzSXtSYTpjk0JX8K",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 94.12600908008824,
			"y": 1388.7693245498222,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 746.840665930575,
			"height": 178.9305762125336,
			"seed": 1982265076,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688529197145,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a409063a49a46ec3e384ddb52a4db4ea1b6dc74c",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 208,
			"versionNonce": 1754364148,
			"isDeleted": false,
			"id": "2u5ZIXJiXV4XD7QMRLVWF",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 181.3101085619228,
			"y": 1086.118447886243,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 313.7994364389039,
			"height": 259.8259333714124,
			"seed": 644942412,
			"groupIds": [
				"gfw4NGCNlOYKeHONRKrgD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464962,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "9ca092c54ed383dd2d5be9ea1a7e7e9b17f7cb66",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 218,
			"versionNonce": 1041612876,
			"isDeleted": false,
			"id": "BRuxd2x9",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 162.96918642916262,
			"y": 1247.40706208531,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 138.125,
			"height": 30.546891449652243,
			"seed": 551938164,
			"groupIds": [
				"gfw4NGCNlOYKeHONRKrgD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688528464962,
			"link": null,
			"locked": false,
			"fontSize": 8.145837719907265,
			"fontFamily": 1,
			"text": "这里对纹理进行stretch(扭曲/拉伸)\n是因为模糊时纹理图片上的像素距离\n与其所对应的真实曲面间的距离不一致",
			"rawText": "这里对纹理进行stretch(扭曲/拉伸)\n是因为模糊时纹理图片上的像素距离\n与其所对应的真实曲面间的距离不一致",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "这里对纹理进行stretch(扭曲/拉伸)\n是因为模糊时纹理图片上的像素距离\n与其所对应的真实曲面间的距离不一致",
			"lineHeight": 1.25,
			"baseline": 27
		},
		{
			"type": "text",
			"version": 570,
			"versionNonce": 1555894388,
			"isDeleted": false,
			"id": "WHYgaxz4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 95.81694607846362,
			"y": 1580.9782226936704,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 1010.8648681640625,
			"height": 40,
			"seed": 1431003124,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688529197145,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Post-Scatter: 只对接受光照应用diffusion profile blur. albedo 没有被模糊. 适用于纹理来自于拍摄的照片(albedo本来就已经被\"模糊\"过了).\nPre-And Post-Scatter: Post-Scatter + Pre-Scatter(光照 * albedo之后, 应用diffusion profile blur) 做颜色混合",
			"rawText": "Post-Scatter: 只对接受光照应用diffusion profile blur. albedo 没有被模糊. 适用于纹理来自于拍摄的照片(albedo本来就已经被\"模糊\"过了).\nPre-And Post-Scatter: Post-Scatter + Pre-Scatter(光照 * albedo之后, 应用diffusion profile blur) 做颜色混合",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Post-Scatter: 只对接受光照应用diffusion profile blur. albedo 没有被模糊. 适用于纹理来自于拍摄的照片(albedo本来就已经被\"模糊\"过了).\nPre-And Post-Scatter: Post-Scatter + Pre-Scatter(光照 * albedo之后, 应用diffusion profile blur) 做颜色混合",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 102,
			"versionNonce": 1202721140,
			"isDeleted": false,
			"id": "DhVukexC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -466.78710508253164,
			"y": 1751.9178290229831,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 64,
			"height": 20,
			"seed": 1644462452,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688529459672,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "能量守恒",
			"rawText": "能量守恒",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "能量守恒",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 98,
			"versionNonce": 484932678,
			"isDeleted": false,
			"id": "7n5bacNW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2770.4749806006052,
			"y": 443.6009084025943,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 211.5079803466797,
			"height": 20,
			"seed": 1876637146,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1694762922711,
			"link": "https://docs.unrealengine.com/5.2/en-US/shading-models-in-unreal-engine/",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[UE shadering models]]",
			"rawText": "[UE shadering models](https://docs.unrealengine.com/5.2/en-US/shading-models-in-unreal-engine/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[UE shadering models]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 15,
			"versionNonce": 1621783558,
			"isDeleted": false,
			"id": "W6T5Wgav",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2765.012795726656,
			"y": 503.4328411757035,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 253.5880584716797,
			"height": 20,
			"seed": 1853727430,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1694762946952,
			"link": "https://docs.unrealengine.com/5.2/en-US/material-blend-modes-in-unreal-engine/",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[UE Material Blend Modes]]",
			"rawText": "[UE Material Blend Modes](https://docs.unrealengine.com/5.2/en-US/material-blend-modes-in-unreal-engine/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[UE Material Blend Modes]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"id": "fwVnFpdn",
			"type": "text",
			"x": -2809.726004086924,
			"y": 648.6024122092456,
			"width": 330.0967102050781,
			"height": 60,
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
			"seed": 196318864,
			"version": 3,
			"versionNonce": 1545749648,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1697531366541,
			"link": "https://github.com/QianMo/PBR-White-Paper",
			"locked": false,
			"text": "🌐[[PBR White Paper]]\n[[Cook-Torrance BRDF]]\n[[Physically Based Rendering in Filament]]",
			"rawText": "[PBR White Paper](https://github.com/QianMo/PBR-White-Paper)\n[Cook-Torrance BRDF](https://www.jianshu.com/p/d70ee9d4180e)\n[Physically Based Rendering in Filament](https://google.github.io/filament/Filament.html)",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "left",
			"verticalAlign": "top",
			"baseline": 54,
			"containerId": null,
			"originalText": "🌐[[PBR White Paper]]\n[[Cook-Torrance BRDF]]\n[[Physically Based Rendering in Filament]]",
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
		"scrollX": 3439.7260040869237,
		"scrollY": 210.34979367310706,
		"zoom": {
			"value": 0.8500000000000003
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