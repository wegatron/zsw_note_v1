---

excalidraw-plugin: parsed
tags: [excalidraw]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Text Elements
人头区域 ^1BIMSpre

原图 ^RCDSnRAi

重建图片 ^q2bLAXI7

缩放s ^1jb4sdwo

t0 ^I1KKi0ma

t1 ^KXvpBo85

w0 ^ZYA9zWC1

h0 ^v3VDDkdG

224 ^LW93rJBJ

224 ^ZzHU5BFe

重建时相机投影 f=1015, c=112 ^2ygB6MxR

转换到原图像坐标系下 ^VPkadyIA

投影矩阵 ^NGCjcwnL

[[blender.md##Camera]] ^neIWmjY8

blender中的相机参数 ^xGbaxLGJ

3 ^Eq5boNLW

13 ^4X6ZqQpc

数字人嘴部区域混合: 
① 选取上述的点构建一个多边形A 
②  对每个点沿着其法向向外移动一定距离s, 构建另外一个多边形B.
     防止边缘模糊或者重影, 对于红色标记的点, 向外移动为2.5s
    s = 0.2 * (y[33]-y[8])
③  在多边形区域A中的部分使用生成的结果, 在多边形B-A中的部分根据三角花后的结果进行(0-1)插值 ^vBDNSNjp

数字人换头: 虚线以上部分mask out
根据特征点, 得到绿色虚线, 向下沿着法向移动距离s, 得到黑色虚线.
s = 0.2 *(y[33] - y[8]) ^gVnOqLuJ

特征点有明显的抖动, 使用[one euro filter](https://www.zls3201.com/post/object_trace/)进行滤波
 ^0R5R9q0M

人头姿态的低通滤波, [参考](https://ww2.mathworks.cn/help/nav/ug/lowpass-filter-orientation-using-quaternion-slerp.html)
根据$x_i - x_{i-1}$, 将$\alpha$ 归一化到新的区间$[l, h]$, d是一个比较大的值 ^lsnQ75wY


# Embedded files
a94e6b13e717897491707ac9d7132e2131ffe49f: $$\begin{aligned} u' = \frac{u-0.5 ts}{s}+t_0\\ v' = \frac{v-0.5 ts}{s}+t_1 \end{aligned}$$
32ae88891bda452912d09dad879710ca362ca4e8: $$\begin{bmatrix} \frac{f}{s} & 0 & \frac{2c-ts}{2s} + t_0\\ 0 & \frac{f}{s} & \frac{2c-ts}{2s} + t_1\\ 0 & 0 & 1 \end{bmatrix}$$
08703324a9f6f5e1d8520afa2af5ecc05a47ea4f: $$\frac{1}{Z}\begin{bmatrix} u\\ v\\ 1\end{bmatrix} \sim \begin{bmatrix} f & 0 & c\\ 0 & f & c\\ 0 & 0 & 1 \end{bmatrix} \begin{bmatrix} X\\ Y\\ Z\end{bmatrix}$$
905055ec0a5cce209e9aa22b65d791ebcff56e2c: $$\begin{aligned} \hat{x}_i = x_{i-1} + \alpha(x_i - x_{i-1})\\ \alpha = \frac{x_i - x_{i-1}}{d} (h-l) + l \end{aligned}$$
5b0cf41e04dcb5b40b1cbdc407a0c981fc65937c: [[rc/head_swap_face_lm.png]]
224014bb396acd9b6d11b829ff416ee6f1a47986: [[rc/head_swap_face_mask.png]]
fd20c960045324146f5ab73a3a21f9284412e0ff: [[rc/one_euro_filter.png]]
cd3d9face5bb3c2e206956ad3a4998f9c1516d71: [[rc/one_euro_filter_code2.png]]
1c56a3836ede007d1b77eabca7dd777497730a13: [[rc/one_euro_filter_code1.png]]
62ea47165b299af2e758ef1b022ab36061a3ec0b: [[rc/talking_head_blend_mask.png]]

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
			"version": 284,
			"versionNonce": 945827531,
			"isDeleted": false,
			"id": "SDcflM3tqdZjHJe22z78W",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -465.5,
			"y": -489.16796875,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 162.5,
			"height": 212,
			"seed": 659167440,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599143,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 118,
			"versionNonce": 538392421,
			"isDeleted": false,
			"id": "mBE2paThByaSbTbtgL_1b",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -427,
			"y": -469.66796875,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 79,
			"height": 79,
			"seed": 154284240,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"type": "text",
					"id": "1BIMSpre"
				}
			],
			"updated": 1687686599143,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 73,
			"versionNonce": 2040929643,
			"isDeleted": false,
			"id": "1BIMSpre",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -419.5,
			"y": -414.06796875,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 64,
			"height": 18.4,
			"seed": 453151952,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599143,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "人头区域",
			"rawText": "人头区域",
			"textAlign": "center",
			"verticalAlign": "bottom",
			"containerId": "mBE2paThByaSbTbtgL_1b",
			"originalText": "人头区域",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 302,
			"versionNonce": 1902445253,
			"isDeleted": false,
			"id": "gyufPdEtsDfdEjK9EmDzP",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -142.25,
			"y": -519.16796875,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 102,
			"height": 105,
			"seed": 685165776,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "uLN9Vn1LgGDqS5Wbb6cbb",
					"type": "arrow"
				},
				{
					"type": "text",
					"id": "q2bLAXI7"
				}
			],
			"updated": 1687686599143,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 94,
			"versionNonce": 91568139,
			"isDeleted": false,
			"id": "q2bLAXI7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -123.25,
			"y": -475.86796875,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 64,
			"height": 18.4,
			"seed": 252612304,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599143,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "重建图片",
			"rawText": "重建图片",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "gyufPdEtsDfdEjK9EmDzP",
			"originalText": "重建图片",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 247,
			"versionNonce": 61681170,
			"isDeleted": false,
			"id": "uLN9Vn1LgGDqS5Wbb6cbb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -363.1521141275068,
			"y": -448.0861472054106,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 216.82052904592166,
			"height": 29.46749580461625,
			"seed": 1905296592,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"type": "text",
					"id": "1jb4sdwo"
				}
			],
			"updated": 1688005701994,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			},
			"startBinding": {
				"elementId": "KXvpBo85",
				"gap": 11.375,
				"focus": 1.6001013489048161
			},
			"endBinding": {
				"elementId": "gyufPdEtsDfdEjK9EmDzP",
				"gap": 4.08158508158516,
				"focus": 0.3091245336416653
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
					216.82052904592166,
					-29.46749580461625
				]
			]
		},
		{
			"type": "text",
			"version": 38,
			"versionNonce": 164101803,
			"isDeleted": false,
			"id": "1jb4sdwo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -274.4157925407926,
			"y": -472.12797422028746,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 40,
			"height": 18.4,
			"seed": 204702928,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599143,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "缩放s",
			"rawText": "缩放s",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "uLN9Vn1LgGDqS5Wbb6cbb",
			"originalText": "缩放s",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 111,
			"versionNonce": 1438438789,
			"isDeleted": false,
			"id": "RCDSnRAi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -408,
			"y": -326.16796875,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 32,
			"height": 18.4,
			"seed": 563158224,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599143,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "原图",
			"rawText": "原图",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "原图",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 27,
			"versionNonce": 289993035,
			"isDeleted": false,
			"id": "m-B_aHKQwbwIXkkjB-X7m",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -388.875,
			"y": -432.140625,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 0,
			"height": 0.5,
			"seed": 2064691920,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599144,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5
				],
				[
					0,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "line",
			"version": 85,
			"versionNonce": 955374821,
			"isDeleted": false,
			"id": "Erow11RitzVjbN3rfYXKi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -463.875,
			"y": -431.640625,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 72,
			"height": 1.5,
			"seed": 455464496,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686599144,
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
					72,
					-1.5
				]
			]
		},
		{
			"type": "line",
			"version": 96,
			"versionNonce": 1834127339,
			"isDeleted": false,
			"id": "G6xQl-KWKqQ_NBIm6-K4M",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -387.875,
			"y": -489.140625,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 0.5,
			"height": 54.5,
			"seed": 1967397936,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686599144,
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
					-0.5,
					54.5
				]
			]
		},
		{
			"type": "text",
			"version": 27,
			"versionNonce": 852424773,
			"isDeleted": false,
			"id": "I1KKi0ma",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -432.375,
			"y": -441.640625,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 13.34375,
			"height": 18.4,
			"seed": 296874544,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599144,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "t0",
			"rawText": "t0",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "t0",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 27,
			"versionNonce": 1609521803,
			"isDeleted": false,
			"id": "KXvpBo85",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -386.875,
			"y": -471.140625,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 13.34375,
			"height": 18.4,
			"seed": 1003444784,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "uLN9Vn1LgGDqS5Wbb6cbb",
					"type": "arrow"
				}
			],
			"updated": 1687686599144,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			},
			"fontSize": 16,
			"fontFamily": 2,
			"text": "t1",
			"rawText": "t1",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "t1",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 27,
			"versionNonce": 1563535269,
			"isDeleted": false,
			"id": "ZYA9zWC1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -393.875,
			"y": -274.640625,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 20.453125,
			"height": 18.4,
			"seed": 222078000,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599144,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "w0",
			"rawText": "w0",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "w0",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 26,
			"versionNonce": 98160939,
			"isDeleted": false,
			"id": "v3VDDkdG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -295.375,
			"y": -401.140625,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 17.796875,
			"height": 18.4,
			"seed": 1615243472,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599144,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "h0",
			"rawText": "h0",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h0",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 27,
			"versionNonce": 977758981,
			"isDeleted": false,
			"id": "LW93rJBJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -100.375,
			"y": -414.140625,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 26.6953125,
			"height": 18.4,
			"seed": 951725776,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599144,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "224",
			"rawText": "224",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "224",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 27,
			"versionNonce": 8156107,
			"isDeleted": false,
			"id": "ZzHU5BFe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -31.875,
			"y": -484.140625,
			"strokeColor": "#c92a2a",
			"backgroundColor": "transparent",
			"width": 26.6953125,
			"height": 18.4,
			"seed": 937317424,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599144,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "224",
			"rawText": "224",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "224",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 725,
			"versionNonce": 713933413,
			"isDeleted": false,
			"id": "S2atMr7f",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -456.5935858197659,
			"y": -205.2610507794779,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 155,
			"height": 79,
			"seed": 20243,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "4KCaeW1_QiHJ6OxzUInLZ",
					"type": "arrow"
				},
				{
					"id": "NepJOYlre4O-t0nyyqiIc",
					"type": "arrow"
				}
			],
			"updated": 1687686599144,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a94e6b13e717897491707ac9d7132e2131ffe49f",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 413,
			"versionNonce": 1609679467,
			"isDeleted": false,
			"id": "tnFuaTvn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -456.8643005663814,
			"y": -17.83122466816195,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 167,
			"height": 81,
			"seed": 97293,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "NepJOYlre4O-t0nyyqiIc",
					"type": "arrow"
				}
			],
			"updated": 1687686599145,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "32ae88891bda452912d09dad879710ca362ca4e8",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 316,
			"versionNonce": 584199621,
			"isDeleted": false,
			"id": "Lq7uBNhj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -177.19392714451885,
			"y": -363.9798466298877,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 212,
			"height": 69,
			"seed": 26135,
			"groupIds": [
				"RsLXgehyl-tFSNX7dRLbC"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599145,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "08703324a9f6f5e1d8520afa2af5ecc05a47ea4f",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 294,
			"versionNonce": 1292123403,
			"isDeleted": false,
			"id": "2ygB6MxR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -178.14058520769805,
			"y": -273.46016859679366,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 217.5703125,
			"height": 18.4,
			"seed": 1567397585,
			"groupIds": [
				"RsLXgehyl-tFSNX7dRLbC"
			],
			"roundness": null,
			"boundElements": [
				{
					"id": "4KCaeW1_QiHJ6OxzUInLZ",
					"type": "arrow"
				}
			],
			"updated": 1687686599145,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "重建时相机投影 f=1015, c=112",
			"rawText": "重建时相机投影 f=1015, c=112",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "重建时相机投影 f=1015, c=112",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 486,
			"versionNonce": 573713701,
			"isDeleted": false,
			"id": "4KCaeW1_QiHJ6OxzUInLZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -76.58632110736833,
			"y": -240.35763157723818,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 207.0191771559875,
			"height": 68.7712453947828,
			"seed": 58120113,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "VPkadyIA"
				}
			],
			"updated": 1687686599145,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "2ygB6MxR",
				"focus": -0.01410647467363816,
				"gap": 14.702537019555507
			},
			"endBinding": {
				"elementId": "S2atMr7f",
				"focus": -0.06101160847629109,
				"gap": 17.988087556409994
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
					-23.04546179730427,
					62.50142304061524
				],
				[
					-207.0191771559875,
					68.7712453947828
				]
			]
		},
		{
			"type": "text",
			"version": 18,
			"versionNonce": 1932420011,
			"isDeleted": false,
			"id": "VPkadyIA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -179.6317829046726,
			"y": -187.05620853662293,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 160,
			"height": 18.4,
			"seed": 447834015,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599145,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "转换到原图像坐标系下",
			"rawText": "转换到原图像坐标系下",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "4KCaeW1_QiHJ6OxzUInLZ",
			"originalText": "转换到原图像坐标系下",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 154,
			"versionNonce": 1746616453,
			"isDeleted": false,
			"id": "NepJOYlre4O-t0nyyqiIc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -380.1845780958913,
			"y": -119.92676875240085,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 0.7591764767009295,
			"height": 94.21491305565792,
			"seed": 1740843697,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "NGCjcwnL"
				}
			],
			"updated": 1687686599145,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "S2atMr7f",
				"focus": 0.00927369643348075,
				"gap": 6.334282027077052
			},
			"endBinding": {
				"elementId": "tnFuaTvn",
				"focus": -0.09506917310893215,
				"gap": 7.880631028580979
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
					-0.7591764767009295,
					94.21491305565792
				]
			]
		},
		{
			"type": "text",
			"version": 14,
			"versionNonce": 714782283,
			"isDeleted": false,
			"id": "NGCjcwnL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -412.5641663342418,
			"y": -82.01931222457189,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 64,
			"height": 18.4,
			"seed": 1381924351,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599145,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "投影矩阵",
			"rawText": "投影矩阵",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "NepJOYlre4O-t0nyyqiIc",
			"originalText": "投影矩阵",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 93,
			"versionNonce": 1783293925,
			"isDeleted": false,
			"id": "neIWmjY8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -190.6637597084503,
			"y": -31.441140950127703,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 191.6171875,
			"height": 18.4,
			"seed": 1380261585,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599145,
			"link": "[[blender.md##Camera]]",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "📍[[blender.md##Camera]]",
			"rawText": "[[blender.md##Camera]]",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "📍[[blender.md##Camera]]",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 77,
			"versionNonce": 1646507243,
			"isDeleted": false,
			"id": "xGbaxLGJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -167.74661869491194,
			"y": -4.704476434332946,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 149.375,
			"height": 18.4,
			"seed": 969943633,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599145,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "blender中的相机参数",
			"rawText": "blender中的相机参数",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "blender中的相机参数",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 732,
			"versionNonce": 1203755499,
			"isDeleted": false,
			"id": "optIWpe7CYewdz1T2yVn1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 270.3198830774161,
			"y": 150.3809986318737,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 661.371525097735,
			"height": 731.2999793437375,
			"seed": 251128869,
			"groupIds": [
				"3G5ew0XposjAGcQ6gEypb",
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686599147,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "224014bb396acd9b6d11b829ff416ee6f1a47986",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "line",
			"version": 563,
			"versionNonce": 2016628293,
			"isDeleted": false,
			"id": "ukQ3lTSNQNsOVamlA542-",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 388.12128135479065,
			"y": 707.2536107911471,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 377.08250762560033,
			"height": 132.86206480494673,
			"seed": 214197611,
			"groupIds": [
				"3G5ew0XposjAGcQ6gEypb",
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686599147,
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
					29.18357492825419,
					49.15128408969122
				],
				[
					66.04703799552271,
					82.17480308745257
				],
				[
					116.73429971301687,
					110.59038920180535
				],
				[
					186.62128177804664,
					132.86206480494673
				],
				[
					254.97228621527358,
					122.11022141032674
				],
				[
					305.65954793276774,
					99.07055699328396
				],
				[
					345.5949662556419,
					75.26290376233976
				],
				[
					377.08250762560033,
					33.79150781166277
				]
			]
		},
		{
			"type": "line",
			"version": 337,
			"versionNonce": 1378051211,
			"isDeleted": false,
			"id": "Ao4ybPXvelQX1cmaZC7Hs",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 763.6678113525882,
			"y": 739.5091409750069,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 167.42156143051102,
			"height": 0.767988813901411,
			"seed": 1485755653,
			"groupIds": [
				"3G5ew0XposjAGcQ6gEypb",
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686599147,
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
					167.42156143051102,
					0.767988813901411
				]
			]
		},
		{
			"type": "line",
			"version": 267,
			"versionNonce": 1604009381,
			"isDeleted": false,
			"id": "UGoUHEplOntBcwCl2NLA2",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 387.35329254088924,
			"y": 705.7176331633441,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 115.96631089911534,
			"height": 0.767988813901411,
			"seed": 1333138507,
			"groupIds": [
				"3G5ew0XposjAGcQ6gEypb",
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686599147,
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
					-115.96631089911534,
					-0.767988813901411
				]
			]
		},
		{
			"type": "text",
			"version": 191,
			"versionNonce": 1386608017,
			"isDeleted": false,
			"id": "gVnOqLuJ",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 430.9160427028045,
			"y": 897.1243453694885,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 471.1171875,
			"height": 55.199999999999996,
			"seed": 915590053,
			"groupIds": [
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687746949489,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "数字人换头: 虚线以上部分mask out\n根据特征点, 得到绿色虚线, 向下沿着法向移动距离s, 得到黑色虚线.\ns = 0.2 *(y[33] - y[8])",
			"rawText": "数字人换头: 虚线以上部分mask out\n根据特征点, 得到绿色虚线, 向下沿着法向移动距离s, 得到黑色虚线.\ns = 0.2 *(y[33] - y[8])",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "数字人换头: 虚线以上部分mask out\n根据特征点, 得到绿色虚线, 向下沿着法向移动距离s, 得到黑色虚线.\ns = 0.2 *(y[33] - y[8])",
			"lineHeight": 1.15,
			"baseline": 51
		},
		{
			"type": "image",
			"version": 195,
			"versionNonce": 294899243,
			"isDeleted": false,
			"id": "NRVCGirepK-X4810fxKz3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -791.9444286508394,
			"y": 258.3541379152598,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 720.8640265854332,
			"height": 573.9130434782608,
			"seed": 1712422806,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607679,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "5b0cf41e04dcb5b40b1cbdc407a0c981fc65937c",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "line",
			"version": 296,
			"versionNonce": 1559739909,
			"isDeleted": false,
			"id": "AWmaV5p7ePJGQ8-kK63Mp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -689.4894885223282,
			"y": 664.8590803690319,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 0,
			"height": 104.50827635172664,
			"seed": 1315181834,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686607680,
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
					0,
					-104.50827635172664
				]
			]
		},
		{
			"type": "line",
			"version": 396,
			"versionNonce": 1575932107,
			"isDeleted": false,
			"id": "M1-kcMqILnKa3kOqlrOco",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -692.3397142410118,
			"y": 558.450653538183,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 525.3916074773165,
			"height": 1.900150479122317,
			"seed": 39249738,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686607680,
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
					525.3916074773165,
					1.900150479122317
				]
			]
		},
		{
			"type": "line",
			"version": 223,
			"versionNonce": 1505473893,
			"isDeleted": false,
			"id": "aJyrMT4oSR4X0qUhQjr-p",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -167.89818200325624,
			"y": 671.5096070459599,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 0,
			"height": 113.058953507777,
			"seed": 1441318858,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686607680,
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
					0,
					-113.058953507777
				]
			]
		},
		{
			"type": "freedraw",
			"version": 179,
			"versionNonce": 2031124331,
			"isDeleted": false,
			"id": "LhRLZB19rYho0YDkDrWRB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -685.6891875640836,
			"y": 554.6503525799383,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 5.700451437366951,
			"height": 12.35097811429489,
			"seed": 868786314,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					-0.9500752395611016
				],
				[
					0,
					0
				],
				[
					-0.9500752395611585,
					-0.9500752395611016
				],
				[
					-1.900150479122317,
					0
				],
				[
					-1.900150479122317,
					0.9500752395611016
				],
				[
					-1.900150479122317,
					2.8502257186834186
				],
				[
					-1.900150479122317,
					3.800300958244634
				],
				[
					-0.9500752395611585,
					5.700451437366951
				],
				[
					-0.9500752395611585,
					6.650526676928052
				],
				[
					-0.9500752395611585,
					7.600601916489154
				],
				[
					0,
					8.55067715605037
				],
				[
					0.9500752395611585,
					9.500752395611471
				],
				[
					0.9500752395611585,
					10.450827635172686
				],
				[
					0.9500752395611585,
					11.400902874733788
				],
				[
					1.900150479122317,
					11.400902874733788
				],
				[
					2.8502257186834754,
					11.400902874733788
				],
				[
					3.800300958244634,
					11.400902874733788
				],
				[
					3.800300958244634,
					10.450827635172686
				],
				[
					3.800300958244634,
					9.500752395611471
				],
				[
					2.8502257186834754,
					8.55067715605037
				],
				[
					2.8502257186834754,
					7.600601916489154
				],
				[
					2.8502257186834754,
					6.650526676928052
				],
				[
					2.8502257186834754,
					5.700451437366951
				],
				[
					2.8502257186834754,
					4.7503761978057355
				],
				[
					1.900150479122317,
					4.7503761978057355
				],
				[
					0.9500752395611585,
					4.7503761978057355
				],
				[
					2.8502257186834754,
					4.7503761978057355
				],
				[
					0,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 188,
			"versionNonce": 1036632261,
			"isDeleted": false,
			"id": "xvv8887jlsfJyLVGB3koT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -169.79833248237856,
			"y": 559.400728777744,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 12.350978114295003,
			"height": 8.55067715605037,
			"seed": 1824654294,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.9500752395612153
				],
				[
					-0.9500752395612153,
					0.9500752395612153
				],
				[
					-1.900150479122317,
					0.9500752395612153
				],
				[
					-1.900150479122317,
					1.900150479122317
				],
				[
					-2.8502257186835322,
					2.8502257186834186
				],
				[
					-2.8502257186835322,
					3.800300958244634
				],
				[
					-1.900150479122317,
					3.800300958244634
				],
				[
					-0.9500752395612153,
					3.800300958244634
				],
				[
					0.9500752395611016,
					4.7503761978057355
				],
				[
					2.8502257186834186,
					4.7503761978057355
				],
				[
					3.80030095824452,
					4.7503761978057355
				],
				[
					4.7503761978057355,
					4.7503761978057355
				],
				[
					6.650526676928052,
					3.800300958244634
				],
				[
					7.600601916489154,
					3.800300958244634
				],
				[
					8.55067715605037,
					2.8502257186834186
				],
				[
					9.500752395611471,
					2.8502257186834186
				],
				[
					9.500752395611471,
					1.900150479122317
				],
				[
					9.500752395611471,
					0.9500752395612153
				],
				[
					9.500752395611471,
					-0.9500752395611016
				],
				[
					8.55067715605037,
					-1.900150479122317
				],
				[
					7.600601916489154,
					-2.8502257186834186
				],
				[
					7.600601916489154,
					-3.800300958244634
				],
				[
					6.650526676928052,
					-3.800300958244634
				],
				[
					5.700451437366837,
					-3.800300958244634
				],
				[
					4.7503761978057355,
					-3.800300958244634
				],
				[
					3.80030095824452,
					-2.8502257186834186
				],
				[
					2.8502257186834186,
					-2.8502257186834186
				],
				[
					1.900150479122317,
					-1.900150479122317
				],
				[
					0.9500752395611016,
					-1.900150479122317
				],
				[
					0.9500752395611016,
					-0.9500752395611016
				],
				[
					0.9500752395611016,
					0
				],
				[
					0.9500752395611016,
					0.9500752395612153
				],
				[
					0,
					0.9500752395612153
				],
				[
					0,
					1.900150479122317
				],
				[
					0.9500752395611016,
					1.900150479122317
				],
				[
					1.900150479122317,
					2.8502257186834186
				],
				[
					0,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 189,
			"versionNonce": 759388683,
			"isDeleted": false,
			"id": "Eq5boNLW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -698.0401656783785,
			"y": 527.0981706326648,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 8.8984375,
			"height": 18.4,
			"seed": 253164758,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "3",
			"rawText": "3",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "3",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 186,
			"versionNonce": 1052729381,
			"isDeleted": false,
			"id": "4X6ZqQpc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -165.04795628457282,
			"y": 531.8485468304707,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 17.796875,
			"height": 18.4,
			"seed": 1728642070,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "13",
			"rawText": "13",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "13",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 165,
			"versionNonce": 394387627,
			"isDeleted": false,
			"id": "ow1B7hnZ6igWd03bVHCxG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -692.3397142410116,
			"y": 577.4521583294058,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 16.151279072539523,
			"height": 1.900150479122317,
			"seed": 1239728918,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.9500752395611016,
					0
				],
				[
					1.90015047912226,
					0
				],
				[
					3.800300958244577,
					0
				],
				[
					5.700451437366837,
					0.9500752395612153
				],
				[
					6.650526676927996,
					0.9500752395612153
				],
				[
					7.600601916489154,
					0.9500752395612153
				],
				[
					8.550677156050313,
					0.9500752395612153
				],
				[
					9.500752395611471,
					1.900150479122317
				],
				[
					10.45082763517263,
					0.9500752395612153
				],
				[
					11.400902874733731,
					0.9500752395612153
				],
				[
					12.35097811429489,
					0.9500752395612153
				],
				[
					13.301053353856048,
					0.9500752395612153
				],
				[
					14.251128593417207,
					0.9500752395612153
				],
				[
					15.201203832978365,
					0.9500752395612153
				],
				[
					16.151279072539523,
					0.9500752395612153
				],
				[
					16.151279072539523,
					0.9500752395612153
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 162,
			"versionNonce": 42603397,
			"isDeleted": false,
			"id": "uObNPPvDY-u0Zb2efvPHW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -696.1400151992563,
			"y": 683.8605851602548,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 15.201203832978365,
			"height": 0.9500752395612153,
			"seed": 993114710,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.9500752395611016,
					0
				],
				[
					2.8502257186834186,
					0
				],
				[
					4.7503761978057355,
					0
				],
				[
					7.600601916489211,
					0
				],
				[
					8.550677156050313,
					0
				],
				[
					9.500752395611471,
					0
				],
				[
					10.45082763517263,
					0
				],
				[
					11.400902874733788,
					0.9500752395612153
				],
				[
					12.350978114294946,
					0.9500752395612153
				],
				[
					13.301053353856105,
					0
				],
				[
					14.251128593417263,
					0
				],
				[
					15.201203832978365,
					0
				],
				[
					15.201203832978365,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 163,
			"versionNonce": 1366725451,
			"isDeleted": false,
			"id": "ewWWSY5NhdFVdqoxDjmsk",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -658.1370056168103,
			"y": 730.4142718987513,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 24.70195622858995,
			"height": 0.9500752395611016,
			"seed": 1409043786,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.9500752395611016
				],
				[
					0.9500752395611585,
					0.9500752395611016
				],
				[
					1.900150479122317,
					0.9500752395611016
				],
				[
					3.800300958244634,
					0.9500752395611016
				],
				[
					5.700451437366951,
					0.9500752395611016
				],
				[
					6.650526676928052,
					0.9500752395611016
				],
				[
					7.600601916489211,
					0.9500752395611016
				],
				[
					8.55067715605037,
					0.9500752395611016
				],
				[
					10.450827635172686,
					0.9500752395611016
				],
				[
					15.201203832978422,
					0.9500752395611016
				],
				[
					18.051429551661897,
					0.9500752395611016
				],
				[
					20.901655270345316,
					0.9500752395611016
				],
				[
					24.70195622858995,
					0.9500752395611016
				],
				[
					24.70195622858995,
					0.9500752395611016
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 168,
			"versionNonce": 359095013,
			"isDeleted": false,
			"id": "mZowLpuTmTMyTIAh_ND_L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -174.5487086801843,
			"y": 580.3023840480894,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 21.851730509906474,
			"height": 4.7503761978057355,
			"seed": 1849877322,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.9500752395611016
				],
				[
					1.9001504791222033,
					0.9500752395611016
				],
				[
					2.8502257186834186,
					1.900150479122317
				],
				[
					5.700451437366837,
					2.8502257186834186
				],
				[
					7.600601916489154,
					2.8502257186834186
				],
				[
					10.450827635172573,
					3.80030095824452
				],
				[
					11.400902874733788,
					3.80030095824452
				],
				[
					12.35097811429489,
					3.80030095824452
				],
				[
					13.301053353856105,
					3.80030095824452
				],
				[
					14.251128593417207,
					3.80030095824452
				],
				[
					15.201203832978308,
					3.80030095824452
				],
				[
					16.151279072539523,
					3.80030095824452
				],
				[
					18.05142955166184,
					3.80030095824452
				],
				[
					19.001504791222942,
					4.7503761978057355
				],
				[
					19.951580030784157,
					4.7503761978057355
				],
				[
					20.90165527034526,
					4.7503761978057355
				],
				[
					21.851730509906474,
					3.80030095824452
				],
				[
					21.851730509906474,
					4.7503761978057355
				],
				[
					21.851730509906474,
					4.7503761978057355
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 165,
			"versionNonce": 1534849515,
			"isDeleted": false,
			"id": "D97UH71ohu-wro7X5_tqr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -182.14931059667356,
			"y": 687.6608861184994,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 24.701956228589893,
			"height": 1.900150479122317,
			"seed": 1195211478,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.9500752395611016,
					0
				],
				[
					2.8502257186834186,
					0
				],
				[
					4.7503761978057355,
					-0.9500752395612153
				],
				[
					7.600601916489268,
					-0.9500752395612153
				],
				[
					9.500752395611471,
					-0.9500752395612153
				],
				[
					11.400902874733788,
					-1.900150479122317
				],
				[
					12.350978114295003,
					-0.9500752395612153
				],
				[
					13.301053353856105,
					-0.9500752395612153
				],
				[
					14.25112859341732,
					-0.9500752395612153
				],
				[
					15.201203832978422,
					-0.9500752395612153
				],
				[
					17.10135431210074,
					-0.9500752395612153
				],
				[
					19.951580030784157,
					0
				],
				[
					21.851730509906474,
					0
				],
				[
					23.75188098902879,
					0
				],
				[
					24.701956228589893,
					0
				],
				[
					24.701956228589893,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 161,
			"versionNonce": 535082565,
			"isDeleted": false,
			"id": "xNzVks82QOFxuHajT_45A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -233.45337353297566,
			"y": 725.6638957009454,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 15.201203832978422,
			"height": 2.8502257186835322,
			"seed": 277985814,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.9500752395611016,
					0
				],
				[
					1.9001504791222033,
					0
				],
				[
					4.7503761978057355,
					0
				],
				[
					6.650526676928052,
					0.9500752395612153
				],
				[
					10.450827635172573,
					1.900150479122317
				],
				[
					12.35097811429489,
					1.900150479122317
				],
				[
					14.251128593417207,
					1.900150479122317
				],
				[
					15.201203832978422,
					1.900150479122317
				],
				[
					15.201203832978422,
					2.8502257186835322
				],
				[
					15.201203832978422,
					1.900150479122317
				],
				[
					15.201203832978422,
					2.8502257186835322
				],
				[
					15.201203832978422,
					2.8502257186835322
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 501,
			"versionNonce": 1184660619,
			"isDeleted": false,
			"id": "vBDNSNjp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -784.5864926907816,
			"y": 835.1091612869027,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 889.0625,
			"height": 138,
			"seed": 2129660182,
			"groupIds": [
				"AaknR00BVVblqA_vdLEfZ",
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687686607680,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 2,
			"text": "数字人嘴部区域混合: \n① 选取上述的点构建一个多边形A \n②  对每个点沿着其法向向外移动一定距离s, 构建另外一个多边形B.\n     防止边缘模糊或者重影, 对于红色标记的点, 向外移动为2.5s\n    s = 0.2 * (y[33]-y[8])\n③  在多边形区域A中的部分使用生成的结果, 在多边形B-A中的部分根据三角花后的结果进行(0-1)插值",
			"rawText": "数字人嘴部区域混合: \n① 选取上述的点构建一个多边形A \n②  对每个点沿着其法向向外移动一定距离s, 构建另外一个多边形B.\n     防止边缘模糊或者重影, 对于红色标记的点, 向外移动为2.5s\n    s = 0.2 * (y[33]-y[8])\n③  在多边形区域A中的部分使用生成的结果, 在多边形B-A中的部分根据三角花后的结果进行(0-1)插值",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "数字人嘴部区域混合: \n① 选取上述的点构建一个多边形A \n②  对每个点沿着其法向向外移动一定距离s, 构建另外一个多边形B.\n     防止边缘模糊或者重影, 对于红色标记的点, 向外移动为2.5s\n    s = 0.2 * (y[33]-y[8])\n③  在多边形区域A中的部分使用生成的结果, 在多边形B-A中的部分根据三角花后的结果进行(0-1)插值",
			"lineHeight": 1.15,
			"baseline": 133
		},
		{
			"type": "line",
			"version": 878,
			"versionNonce": 1558160805,
			"isDeleted": false,
			"id": "weE5JWkboymUeqZa4mdJI",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -725.6099909801345,
			"y": 500.67502123384054,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 599.2043741816011,
			"height": 326.51256317680054,
			"seed": 1238177925,
			"groupIds": [
				"dNrSXBYxnewcciUpjkcnx"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687686607680,
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
					0.897012536200009,
					187.47562006580029
				],
				[
					53.820752172000084,
					251.16351013600047
				],
				[
					121.09669238700019,
					281.66193636680055
				],
				[
					185.68159499340038,
					308.5723124528006
				],
				[
					270.00077339620054,
					326.51256317680054
				],
				[
					365.9811147696007,
					310.3663375252005
				],
				[
					451.19730570860077,
					275.3828486134005
				],
				[
					530.1344088942009,
					235.91429702060043
				],
				[
					599.2043741816011,
					178.5054947038003
				],
				[
					599.2043741816011,
					16.146225651600048
				],
				[
					0,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 229,
			"versionNonce": 941623921,
			"isDeleted": false,
			"id": "-RYSI7Jy18dJg0NyC0rJt",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 593.2037366473579,
			"y": 624.9626547384253,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 1.8329349890275353,
			"height": 211.70399123268703,
			"seed": 488263857,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687746802716,
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
					1.8329349890275353,
					211.70399123268703
				]
			]
		},
		{
			"type": "line",
			"version": 77,
			"versionNonce": 2052775825,
			"isDeleted": false,
			"id": "z1FT7jyuPp7Y2SRA-0kzc",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 573.957919262568,
			"y": 836.6666459711123,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.828154857358868,
			"height": 0,
			"seed": 1636880671,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687746811824,
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
					23.828154857358868,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 176,
			"versionNonce": 494318737,
			"isDeleted": false,
			"id": "dGf7mqLqoSJ2Rwkwol2re",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 275.1895160510702,
			"y": 722.1082091568878,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 102.64435938554539,
			"height": 1.8329349890275353,
			"seed": 351362559,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687746827450,
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
					102.64435938554539,
					1.8329349890275353
				]
			]
		},
		{
			"type": "line",
			"version": 371,
			"versionNonce": 1899612191,
			"isDeleted": false,
			"id": "Ic8bhU77qhpC7Rrz59awQ",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 379.6668104256431,
			"y": 724.857611640429,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 390.4151526628775,
			"height": 128.3054492319318,
			"seed": 568940799,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687746854609,
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
					23.82815485735864,
					36.65869978055207
				],
				[
					65.98565960499332,
					76.98326953915898
				],
				[
					116.39137180325224,
					106.31022936360046
				],
				[
					189.70877136435593,
					128.3054492319318
				],
				[
					271.27437837608386,
					117.30783929776612
				],
				[
					318.0142205962875,
					95.31261942943502
				],
				[
					360.17172534392216,
					73.31739956110391
				],
				[
					390.4151526628775,
					32.07636230798312
				]
			]
		},
		{
			"type": "line",
			"version": 69,
			"versionNonce": 1220520209,
			"isDeleted": false,
			"id": "VeXl3J2O-sdYjCoC-G6hZ",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 769.1654955940068,
			"y": 759.6833764319533,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 160.38181153991445,
			"height": 0,
			"seed": 775785809,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1687746863196,
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
					160.38181153991445,
					0
				]
			]
		},
		{
			"type": "text",
			"version": 218,
			"versionNonce": 407825919,
			"isDeleted": false,
			"id": "0R5R9q0M",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -749.8684239448659,
			"y": 1370.9259230499467,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 480.587890625,
			"height": 46,
			"seed": 723108229,
			"groupIds": [
				"aH0aixCrIBADjttmNgMRY"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687773097030,
			"link": "https://www.zls3201.com/post/object_trace/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 2,
			"text": "🌐特征点有明显的抖动, 使用[[one euro filter]]进行滤波\n",
			"rawText": "特征点有明显的抖动, 使用[one euro filter](https://www.zls3201.com/post/object_trace/)进行滤波\n",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐特征点有明显的抖动, 使用[[one euro filter]]进行滤波\n",
			"lineHeight": 1.15,
			"baseline": 41
		},
		{
			"type": "image",
			"version": 384,
			"versionNonce": 182334833,
			"isDeleted": false,
			"id": "IViMSU1UxkBBIYeYQv7JA",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -755.9342502753981,
			"y": 1424.5653967775906,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 563,
			"height": 289.7218358831711,
			"seed": 1906730571,
			"groupIds": [
				"aH0aixCrIBADjttmNgMRY"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687773097030,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "fd20c960045324146f5ab73a3a21f9284412e0ff",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 391,
			"versionNonce": 1096734239,
			"isDeleted": false,
			"id": "0VEzaoWkCb7uZ7BJJAEe_",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -404.69101964981417,
			"y": 1765.5616537205976,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 522.0000000000002,
			"height": 339.00000000000017,
			"seed": 1353871519,
			"groupIds": [
				"aH0aixCrIBADjttmNgMRY"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687773097030,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "cd3d9face5bb3c2e206956ad3a4998f9c1516d71",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 110,
			"versionNonce": 691560273,
			"isDeleted": false,
			"id": "ymSmZkkmdsNqUj_C4saA9",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -961.6910196498139,
			"y": 1759.0616537205976,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 558,
			"height": 343,
			"seed": 314982687,
			"groupIds": [
				"aH0aixCrIBADjttmNgMRY"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687773097030,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "1c56a3836ede007d1b77eabca7dd777497730a13",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 245,
			"versionNonce": 1123101041,
			"isDeleted": false,
			"id": "lsnQ75wY",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -748.7725091320534,
			"y": 1160.7967540472969,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 542.3828125,
			"height": 36.8,
			"seed": 1039367953,
			"groupIds": [
				"YGXRtOJc_TtuFjDI-4ZvX"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687773104554,
			"link": "https://ww2.mathworks.cn/help/nav/ug/lowpass-filter-orientation-using-quaternion-slerp.html",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "🌐人头姿态的低通滤波, [[参考]]\n根据$x_i - x_{i-1}$, 将$\\alpha$ 归一化到新的区间$[l, h]$, d是一个比较大的值",
			"rawText": "人头姿态的低通滤波, [参考](https://ww2.mathworks.cn/help/nav/ug/lowpass-filter-orientation-using-quaternion-slerp.html)\n根据$x_i - x_{i-1}$, 将$\\alpha$ 归一化到新的区间$[l, h]$, d是一个比较大的值",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐人头姿态的低通滤波, [[参考]]\n根据$x_i - x_{i-1}$, 将$\\alpha$ 归一化到新的区间$[l, h]$, d是一个比较大的值",
			"lineHeight": 1.15,
			"baseline": 32
		},
		{
			"type": "image",
			"version": 166,
			"versionNonce": 2133139999,
			"isDeleted": false,
			"id": "Zu66uRgu8t01CC2BTdsjY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -745.57829907603,
			"y": 1210.2007056049483,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 194,
			"height": 60,
			"seed": 171144433,
			"groupIds": [
				"YGXRtOJc_TtuFjDI-4ZvX"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1687773104554,
			"link": "",
			"locked": false,
			"status": "pending",
			"fileId": "905055ec0a5cce209e9aa22b65d791ebcff56e2c",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 181,
			"versionNonce": 495445026,
			"isDeleted": false,
			"id": "cwuHEIqre43cjBiXeIO56",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1446.1593280322322,
			"y": 289.30237868711174,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 643.6210008502928,
			"height": 535.5127858637202,
			"seed": 1842728702,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1687931687066,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "62ea47165b299af2e758ef1b022ab36061a3ec0b",
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
		"currentItemStrokeWidth": 4,
		"currentItemStrokeStyle": "dashed",
		"currentItemRoughness": 1,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 2,
		"currentItemFontSize": 16,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 2053.4798712438305,
		"scrollY": 308.80761630413303,
		"zoom": {
			"value": 0.7065741743278433
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