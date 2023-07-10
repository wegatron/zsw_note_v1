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

转换到原图像坐标系下
ts is target_size ^VPkadyIA

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

Hifi3d++
3DMM Geometry
Rt ^IK9hhufW

3DDFA_V2
modified BFM09
Rt ^wLYY69hG

view ^ZRUm2r4p

数字人换头, 视频人头姿态估计 ^8jX0oGoQ

rigid align ^75LfKSmk

pnp estimate ^5BqNhA1v

3DDFA ^UGRJl4rw

PoseEstimator ^s56e4R0Y

corres_align ^K3NBEho8

pnp ^X5vMGPml

MaskGenerator ^TQybxZ6w

calcPoses(poses, frame_0_lm68,
hifi3d_points, 3ddfa_points) ^oIHHwqUM

gen_mask(lm68s, video_path) ^PFMdEfFa

Hifi3d++
3DMM Geometry
Rt ^ekn60TE6

view ^CjdLbug5

pnp ^VfEinSVJ

注意: 这里正常情况下针孔相机的y是朝下的,
Pnp求解的是Transform矩阵T ^6aMwEl6g

world/local ^086Iuols

camera/view ^ZtxS0H9i

rotate PI
algone x axis ^RsOFWp9z

x ^Zdhl7yzB

z ^AitzgXoy

y ^rIPlo3qB

y ^IHRkzu0S

x ^E3Pp4KgI

z ^QeRqoI1h

eye ^kXm119gb

在3DDFA虽然每一帧都能给出相应的Rt, 
有两个问题:
① 需要将模型Rt转化到相机坐标系下
② translate是其对图像crop之后的子图的translate
    每一帧的crop都不一样
③ 转换过程较为复杂 ^iRVePCUb

先计算旋转, 再根据特征点的中心位置, 计算translate的x,y.
z值可以根据3ddfa pose中获取, 或根据pnp获取后进行滤波 ^3V9kGelt

pnp ^wjAXMiNp

cv 中的相机, 与Graphics API中的相机都是右手坐标系
但是, y,z轴朝向相反(像素坐标系y朝下, 而view/NDC坐标系y朝上). ^DT06hYSK

Blender中沿用了Graphics API的投影矩阵, 所以在求解出pnp的transform矩阵之后, 在乘以X轴的180度旋转.
对应于blender 中的相机朝向z轴负方向, up=+y ^lVYurdes

在ffhq-uv/hifi3d中对y值进行了flip, 所以camera matrix
理论上应该需要对f_y --> -f_y, c_y --> h-c_y ^5XXPW42C

为了简化, 可以对cv相机绕着x轴旋转180度, 从而沿用ffhq-uv中的camera_k, 从而省去pnp求解的transform需要绕x轴180度旋转的操作. ^YfjNyzTL


# Embedded files
a94e6b13e717897491707ac9d7132e2131ffe49f: $$\begin{aligned} u' = \frac{u-0.5 ts}{s}+t_0\\ v' = \frac{v-0.5 ts}{s}+t_1 \end{aligned}$$
32ae88891bda452912d09dad879710ca362ca4e8: $$\begin{bmatrix} \frac{f}{s} & 0 & \frac{2c-ts}{2s} + t_0\\ 0 & \frac{f}{s} & \frac{2c-ts}{2s} + t_1\\ 0 & 0 & 1 \end{bmatrix}$$
08703324a9f6f5e1d8520afa2af5ecc05a47ea4f: $$\frac{1}{Z}\begin{bmatrix} u\\ v\\ 1\end{bmatrix} \sim \begin{bmatrix} f & 0 & c\\ 0 & f & c\\ 0 & 0 & 1 \end{bmatrix} \begin{bmatrix} X\\ Y\\ Z\end{bmatrix}$$
905055ec0a5cce209e9aa22b65d791ebcff56e2c: $$\begin{aligned} \hat{x}_i = x_{i-1} + \alpha(x_i - x_{i-1})\\ \alpha = \frac{x_i - x_{i-1}}{d} (h-l) + l \end{aligned}$$
479c1be74938232ad6e7426348a3c07eafd972e5: $$T_{hifi3d}^{view} = T_{3ddfa}^{view} * T_{pose\_3ddfa} * T_{hifi3d}^{3ddfa}$$
914dc48a0e8cf3e995269453f8848efe7771bfd1: $$Translate * Rotation * Scale$$
8c0d6fee0a87976dc1c6967cc6fb6c971e1c55f8: $$\begin{bmatrix} u\\ v\\ 1\\ \end{bmatrix} \sim \begin{bmatrix} f_x & 0 & c_x & 0\\ 0 & f_y & c_y & 0\\ 0 & 0 & 1 & 0 \end{bmatrix} \cdot T \cdot \begin{bmatrix} X\\ Y\\ Z\\ 1\\ \end{bmatrix}$$
3b32af8c3a9a769e46496863bd1eb888aff55a36: $$R = R_{local}^{view} * R_{pose\_local}$$
5b0cf41e04dcb5b40b1cbdc407a0c981fc65937c: [[head_swap_face_lm.png]]
224014bb396acd9b6d11b829ff416ee6f1a47986: [[head_swap_face_mask.png]]
fd20c960045324146f5ab73a3a21f9284412e0ff: [[one_euro_filter.png]]
cd3d9face5bb3c2e206956ad3a4998f9c1516d71: [[one_euro_filter_code2.png]]
1c56a3836ede007d1b77eabca7dd777497730a13: [[one_euro_filter_code1.png]]
62ea47165b299af2e758ef1b022ab36061a3ec0b: [[talking_head_blend_mask.png]]
a8a3479038935d3d6db5015b94a2b6ba53c5368c: [[pin_hole_camera.png]]
a1a6e7c992d4929cdac8abfdb56894e18c998357: [[Pasted Image 20230710111743_021.png]]

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
			"version": 309,
			"versionNonce": 538393265,
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
			"updated": 1688991259020,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 143,
			"versionNonce": 2081670367,
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
			"updated": 1688991259020,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 98,
			"versionNonce": 1402911889,
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
			"updated": 1688991259020,
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
			"version": 327,
			"versionNonce": 1210437887,
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
			"updated": 1688991259020,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 119,
			"versionNonce": 312148593,
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
			"updated": 1688991259020,
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
			"version": 348,
			"versionNonce": 702752945,
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
			"updated": 1688991332948,
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
			"version": 63,
			"versionNonce": 433294417,
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
			"updated": 1688991259021,
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
			"version": 136,
			"versionNonce": 1211555135,
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
			"updated": 1688991259021,
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
			"version": 52,
			"versionNonce": 555735601,
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
			"updated": 1688991259021,
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
			"version": 110,
			"versionNonce": 1694948703,
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
			"updated": 1688991259021,
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
			"version": 121,
			"versionNonce": 2036821009,
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
			"updated": 1688991259021,
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
			"version": 52,
			"versionNonce": 1143069055,
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
			"updated": 1688991259021,
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
			"version": 52,
			"versionNonce": 1788985841,
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
			"updated": 1688991259021,
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
			"version": 52,
			"versionNonce": 1523077535,
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
			"updated": 1688991259021,
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
			"version": 51,
			"versionNonce": 1373002705,
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
			"updated": 1688991259021,
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
			"version": 52,
			"versionNonce": 573228479,
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
			"updated": 1688991259021,
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
			"version": 52,
			"versionNonce": 2132588977,
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
			"updated": 1688991259021,
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
			"version": 750,
			"versionNonce": 426358239,
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
			"updated": 1688991259021,
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
			"version": 438,
			"versionNonce": 1402755985,
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
			"updated": 1688991259021,
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
			"version": 341,
			"versionNonce": 127246847,
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
			"updated": 1688991259021,
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
			"version": 319,
			"versionNonce": 529318257,
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
			"updated": 1688991259021,
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
			"version": 511,
			"versionNonce": 2108623391,
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
			"updated": 1688991259021,
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
			"version": 46,
			"versionNonce": 1077242705,
			"isDeleted": false,
			"id": "VPkadyIA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -179.6317829046726,
			"y": -196.25620853662295,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 160,
			"height": 36.8,
			"seed": 447834015,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259021,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "转换到原图像坐标系下\nts is target_size",
			"rawText": "转换到原图像坐标系下\nts is target_size",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "4KCaeW1_QiHJ6OxzUInLZ",
			"originalText": "转换到原图像坐标系下\nts is target_size",
			"lineHeight": 1.15,
			"baseline": 32
		},
		{
			"type": "arrow",
			"version": 179,
			"versionNonce": 413560383,
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
			"updated": 1688991259021,
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
			"version": 39,
			"versionNonce": 2112739633,
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
			"updated": 1688991259021,
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
			"version": 121,
			"versionNonce": 56381023,
			"isDeleted": false,
			"id": "neIWmjY8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -190.6637597084503,
			"y": -30.58992162045314,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 191.6171875,
			"height": 18.4,
			"seed": 1380261585,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259021,
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
			"version": 103,
			"versionNonce": 706579217,
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
			"updated": 1688991259021,
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
			"version": 798,
			"versionNonce": 950086271,
			"isDeleted": false,
			"id": "optIWpe7CYewdz1T2yVn1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 277.19692224808773,
			"y": 289.641041837972,
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
			"updated": 1688991259021,
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
			"version": 629,
			"versionNonce": 2101084401,
			"isDeleted": false,
			"id": "ukQ3lTSNQNsOVamlA542-",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 394.9983205254623,
			"y": 846.5136539972455,
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
			"updated": 1688991259021,
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
			"version": 403,
			"versionNonce": 87392927,
			"isDeleted": false,
			"id": "Ao4ybPXvelQX1cmaZC7Hs",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 770.5448505232598,
			"y": 878.7691841811052,
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
			"updated": 1688991259021,
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
			"version": 333,
			"versionNonce": 886094545,
			"isDeleted": false,
			"id": "UGoUHEplOntBcwCl2NLA2",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 394.2303317115609,
			"y": 844.9776763694424,
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
			"updated": 1688991259021,
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
			"version": 257,
			"versionNonce": 1237964479,
			"isDeleted": false,
			"id": "gVnOqLuJ",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 437.7930818734761,
			"y": 1036.3843885755869,
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
			"updated": 1688991259021,
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
			"version": 220,
			"versionNonce": 1903376561,
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
			"updated": 1688991259021,
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
			"version": 321,
			"versionNonce": 2097063647,
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
			"updated": 1688991259021,
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
			"version": 421,
			"versionNonce": 1422588561,
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
			"updated": 1688991259021,
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
			"version": 248,
			"versionNonce": 1835299583,
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
			"updated": 1688991259021,
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
			"version": 204,
			"versionNonce": 1603240049,
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
			"updated": 1688991259022,
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
			"version": 213,
			"versionNonce": 1132182303,
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
			"updated": 1688991259022,
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
			"version": 214,
			"versionNonce": 260590161,
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
			"updated": 1688991259022,
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
			"version": 211,
			"versionNonce": 1135935295,
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
			"updated": 1688991259022,
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
			"version": 190,
			"versionNonce": 1032640561,
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
			"updated": 1688991259022,
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
			"version": 187,
			"versionNonce": 1349566303,
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
			"updated": 1688991259022,
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
			"version": 188,
			"versionNonce": 998550033,
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
			"updated": 1688991259022,
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
			"version": 193,
			"versionNonce": 738163583,
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
			"updated": 1688991259022,
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
			"version": 190,
			"versionNonce": 845627377,
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
			"updated": 1688991259022,
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
			"version": 186,
			"versionNonce": 2057417631,
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
			"updated": 1688991259022,
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
			"version": 526,
			"versionNonce": 1077680593,
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
			"updated": 1688991259022,
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
			"version": 903,
			"versionNonce": 76015551,
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
			"updated": 1688991259022,
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
			"version": 295,
			"versionNonce": 1444591537,
			"isDeleted": false,
			"id": "-RYSI7Jy18dJg0NyC0rJt",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 600.0807758180296,
			"y": 764.2226979445236,
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
			"updated": 1688991259022,
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
			"version": 143,
			"versionNonce": 936548319,
			"isDeleted": false,
			"id": "z1FT7jyuPp7Y2SRA-0kzc",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 580.8349584332396,
			"y": 975.9266891772106,
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
			"updated": 1688991259022,
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
			"version": 242,
			"versionNonce": 1445632401,
			"isDeleted": false,
			"id": "dGf7mqLqoSJ2Rwkwol2re",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 282.06655522174185,
			"y": 861.3682523629861,
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
			"updated": 1688991259022,
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
			"version": 437,
			"versionNonce": 1787970559,
			"isDeleted": false,
			"id": "Ic8bhU77qhpC7Rrz59awQ",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 386.5438495963148,
			"y": 864.1176548465273,
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
			"updated": 1688991259022,
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
			"version": 135,
			"versionNonce": 1906524017,
			"isDeleted": false,
			"id": "VeXl3J2O-sdYjCoC-G6hZ",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 776.0425347646784,
			"y": 898.9434196380516,
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
			"updated": 1688991259022,
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
			"version": 243,
			"versionNonce": 1556573215,
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
			"updated": 1688991259022,
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
			"version": 409,
			"versionNonce": 1187785041,
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
			"updated": 1688991259022,
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
			"version": 416,
			"versionNonce": 2053279807,
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
			"updated": 1688991259022,
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
			"version": 135,
			"versionNonce": 1056757553,
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
			"updated": 1688991259022,
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
			"version": 270,
			"versionNonce": 1564749919,
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
			"updated": 1688991259022,
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
			"version": 191,
			"versionNonce": 748472593,
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
			"updated": 1688991259022,
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
			"version": 206,
			"versionNonce": 255642751,
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
			"updated": 1688991259022,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "62ea47165b299af2e758ef1b022ab36061a3ec0b",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 52,
			"versionNonce": 690192113,
			"isDeleted": false,
			"id": "BUZ04prqBCQQ_qjU5-dsV",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 496.34084647282043,
			"y": -449.6680162232336,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132,
			"height": 66,
			"seed": 622899138,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "IK9hhufW",
					"type": "text"
				},
				{
					"id": "oT5YYTU3i1w_P2CyGORhA",
					"type": "arrow"
				},
				{
					"id": "0tpDBhTRdii1sk-4X0GSq",
					"type": "arrow"
				}
			],
			"updated": 1688991259022,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 137,
			"versionNonce": 202171551,
			"isDeleted": false,
			"id": "IK9hhufW",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 501.44240897282043,
			"y": -444.26801622323364,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 121.796875,
			"height": 55.199999999999996,
			"seed": 1170674654,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259022,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "Hifi3d++\n3DMM Geometry\nRt",
			"rawText": "Hifi3d++\n3DMM Geometry\nRt",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "BUZ04prqBCQQ_qjU5-dsV",
			"originalText": "Hifi3d++\n3DMM Geometry\nRt",
			"lineHeight": 1.15,
			"baseline": 51
		},
		{
			"type": "rectangle",
			"version": 202,
			"versionNonce": 857241809,
			"isDeleted": false,
			"id": "Glt81p9uzWPrG-ianYCpy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 774.2353540066864,
			"y": -449.2851970720625,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 154,
			"height": 66,
			"seed": 2058971010,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "wLYY69hG",
					"type": "text"
				},
				{
					"id": "oT5YYTU3i1w_P2CyGORhA",
					"type": "arrow"
				}
			],
			"updated": 1688991259022,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 284,
			"versionNonce": 56948927,
			"isDeleted": false,
			"id": "wLYY69hG",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 792.9892602566864,
			"y": -443.8851970720625,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 116.4921875,
			"height": 55.199999999999996,
			"seed": 519960286,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259022,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "3DDFA_V2\nmodified BFM09\nRt",
			"rawText": "3DDFA_V2\nmodified BFM09\nRt",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Glt81p9uzWPrG-ianYCpy",
			"originalText": "3DDFA_V2\nmodified BFM09\nRt",
			"lineHeight": 1.15,
			"baseline": 51
		},
		{
			"type": "rectangle",
			"version": 157,
			"versionNonce": 202585777,
			"isDeleted": false,
			"id": "P2H1DcMitNIC3nx3-KlL9",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 313.94908923569335,
			"y": -397.34427495631166,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132.7902154292433,
			"height": 188.97069118776938,
			"seed": 437033218,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259022,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 29,
			"versionNonce": 1524992223,
			"isDeleted": false,
			"id": "QL2oLhDapfCtd5LTGJMPU",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 358.2543002576108,
			"y": -438.8811960331096,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 43,
			"height": 29,
			"seed": 1407526722,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "ZRUm2r4p",
					"type": "text"
				},
				{
					"id": "0tpDBhTRdii1sk-4X0GSq",
					"type": "arrow"
				}
			],
			"updated": 1688991259022,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 62,
			"versionNonce": 1455110289,
			"isDeleted": false,
			"id": "ZRUm2r4p",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 363.7503940076108,
			"y": -433.58119603310956,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.0078125,
			"height": 18.4,
			"seed": 1827560258,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "view",
			"rawText": "view",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "QL2oLhDapfCtd5LTGJMPU",
			"originalText": "view",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 128,
			"versionNonce": 1881085183,
			"isDeleted": false,
			"id": "8jX0oGoQ",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 986.2187247990676,
			"y": -526.3028781621009,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 216.890625,
			"height": 18.4,
			"seed": 207050050,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "数字人换头, 视频人头姿态估计",
			"rawText": "数字人换头, 视频人头姿态估计",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "数字人换头, 视频人头姿态估计",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 761,
			"versionNonce": 348011089,
			"isDeleted": false,
			"id": "oT5YYTU3i1w_P2CyGORhA",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 773.2353540066864,
			"y": -419.3447947238883,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 143.89450753386598,
			"height": 0.587465888105271,
			"seed": 1965292318,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688991332951,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "Glt81p9uzWPrG-ianYCpy",
				"gap": 1,
				"focus": 0.08228144147389879
			},
			"endBinding": {
				"elementId": "BUZ04prqBCQQ_qjU5-dsV",
				"gap": 1,
				"focus": -0.106337174911564
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
					-143.89450753386598,
					-0.587465888105271
				]
			]
		},
		{
			"type": "arrow",
			"version": 261,
			"versionNonce": 109365297,
			"isDeleted": false,
			"id": "0tpDBhTRdii1sk-4X0GSq",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 492.681131751786,
			"y": -423.33627214877157,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 89.49676696260775,
			"height": 2.3768092652408654,
			"seed": 615983042,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688991332952,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "BUZ04prqBCQQ_qjU5-dsV",
				"gap": 3.6597147210344474,
				"focus": 0.13864407283110444
			},
			"endBinding": {
				"elementId": "QL2oLhDapfCtd5LTGJMPU",
				"gap": 1.9300645315674387,
				"focus": -0.12966165771640778
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
					-89.49676696260775,
					-2.3768092652408654
				]
			]
		},
		{
			"type": "image",
			"version": 107,
			"versionNonce": 620824657,
			"isDeleted": false,
			"id": "k8O9TiiV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 594.5945918971555,
			"y": -337.5426946389438,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 282.62814202882674,
			"height": 27.449495808555117,
			"seed": 30242,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "yGEEYXU0Vr7Vb_fSZc50u",
					"type": "arrow"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "479c1be74938232ad6e7426348a3c07eafd972e5",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 454,
			"versionNonce": 1840193855,
			"isDeleted": false,
			"id": "3drXIovi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 846.3121677855755,
			"y": -196.56579643189917,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 197.36358622764203,
			"height": 11.25318693403222,
			"seed": 11078,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "yGEEYXU0Vr7Vb_fSZc50u",
					"type": "arrow"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "914dc48a0e8cf3e995269453f8848efe7771bfd1",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "arrow",
			"version": 777,
			"versionNonce": 1631442481,
			"isDeleted": false,
			"id": "yGEEYXU0Vr7Vb_fSZc50u",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 855.7403351224016,
			"y": -309.2844827224245,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 1.3099801639959878,
			"height": 105.2553117215279,
			"seed": 792249939,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "75LfKSmk"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "k8O9TiiV",
				"gap": 1.5250774556632962,
				"focus": -0.804062434835297
			},
			"endBinding": {
				"elementId": "3drXIovi",
				"gap": 7.4633745689974464,
				"focus": -0.9187326376320109
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
					-1.3099801639959878,
					105.2553117215279
				]
			]
		},
		{
			"type": "text",
			"version": 44,
			"versionNonce": 987144543,
			"isDeleted": false,
			"id": "75LfKSmk",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 821.5490669674441,
			"y": -257.4290020832086,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 68.484375,
			"height": 18.4,
			"seed": 1101169171,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "rigid align",
			"rawText": "rigid align",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "yGEEYXU0Vr7Vb_fSZc50u",
			"originalText": "rigid align",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 133,
			"versionNonce": 2087053329,
			"isDeleted": false,
			"id": "5BqNhA1v",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 590.6971166551656,
			"y": -306.7791845999923,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 54.48260498046875,
			"height": 10.956696467777148,
			"seed": 2083974045,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 9.527562145893173,
			"fontFamily": 2,
			"text": "pnp estimate",
			"rawText": "pnp estimate",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "pnp estimate",
			"lineHeight": 1.15,
			"baseline": 8
		},
		{
			"type": "rectangle",
			"version": 320,
			"versionNonce": 1398349183,
			"isDeleted": false,
			"id": "o3Z4AWDeY4wm44V_pNaXX",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 913.8605076570188,
			"y": 29.574477871676265,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 69,
			"height": 29,
			"seed": 1874363571,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"type": "text",
					"id": "UGRJl4rw"
				},
				{
					"id": "8_agNCiFm13h23EI7zQSy",
					"type": "arrow"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 272,
			"versionNonce": 7388657,
			"isDeleted": false,
			"id": "UGRJl4rw",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 922.5753514070188,
			"y": 34.87447787167626,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 51.5703125,
			"height": 18.4,
			"seed": 181093725,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "3DDFA",
			"rawText": "3DDFA",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "o3Z4AWDeY4wm44V_pNaXX",
			"originalText": "3DDFA",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 197,
			"versionNonce": 175576479,
			"isDeleted": false,
			"id": "UYTlhKLSz5tE5Ux64GtzJ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 494.5673962744462,
			"y": -134.5004856552705,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 29,
			"seed": 1402869565,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "s56e4R0Y",
					"type": "text"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 210,
			"versionNonce": 1281742801,
			"isDeleted": false,
			"id": "s56e4R0Y",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 571.0478650244462,
			"y": -129.20048565527048,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 104.0390625,
			"height": 18.4,
			"seed": 935584829,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "PoseEstimator",
			"rawText": "PoseEstimator",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "UYTlhKLSz5tE5Ux64GtzJ",
			"originalText": "PoseEstimator",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 176,
			"versionNonce": 2002848191,
			"isDeleted": false,
			"id": "Ec7OHfr2XVSlQVVE8CZE_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 717.7628004569208,
			"y": 29.32496535816972,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 98,
			"height": 29,
			"seed": 664656381,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "K3NBEho8",
					"type": "text"
				},
				{
					"id": "dyILk286Dp-EutZIwyxvZ",
					"type": "arrow"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 191,
			"versionNonce": 1918678449,
			"isDeleted": false,
			"id": "K3NBEho8",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 723.1846754569208,
			"y": 34.62496535816972,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 87.15625,
			"height": 18.4,
			"seed": 1906180531,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "corres_align",
			"rawText": "corres_align",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Ec7OHfr2XVSlQVVE8CZE_",
			"originalText": "corres_align",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 139,
			"versionNonce": 2000124383,
			"isDeleted": false,
			"id": "syQ_s3TPl7HmgyWcQTqHg",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 604.4391364279727,
			"y": 28.33983699380866,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 37,
			"height": 29,
			"seed": 1551845363,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "X5vMGPml",
					"type": "text"
				},
				{
					"id": "dfZSJPAh3Ldd42J4_5td8",
					"type": "arrow"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 144,
			"versionNonce": 1434245009,
			"isDeleted": false,
			"id": "X5vMGPml",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 609.5914801779727,
			"y": 33.63983699380866,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 26.6953125,
			"height": 18.4,
			"seed": 1828301629,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "pnp",
			"rawText": "pnp",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "syQ_s3TPl7HmgyWcQTqHg",
			"originalText": "pnp",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 209,
			"versionNonce": 1862985215,
			"isDeleted": false,
			"id": "PoClYnFEBQVbA0FnGAxeR",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 918.0565490857966,
			"y": -126.2058893644807,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 225,
			"height": 29,
			"seed": 1403727261,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "TQybxZ6w",
					"type": "text"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 251,
			"versionNonce": 134069617,
			"isDeleted": false,
			"id": "TQybxZ6w",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 975.4237365857966,
			"y": -120.9058893644807,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 110.265625,
			"height": 18.4,
			"seed": 545780061,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "MaskGenerator",
			"rawText": "MaskGenerator",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "PoClYnFEBQVbA0FnGAxeR",
			"originalText": "MaskGenerator",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "rectangle",
			"version": 281,
			"versionNonce": 1306250783,
			"isDeleted": false,
			"id": "rR5X2E67LRZRGue6daDRF",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 494.73534599261507,
			"y": -106.09144289793977,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 257,
			"height": 47,
			"seed": 1604317747,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "oIHHwqUM",
					"type": "text"
				},
				{
					"id": "dfZSJPAh3Ldd42J4_5td8",
					"type": "arrow"
				},
				{
					"id": "dyILk286Dp-EutZIwyxvZ",
					"type": "arrow"
				},
				{
					"id": "8_agNCiFm13h23EI7zQSy",
					"type": "arrow"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 511,
			"versionNonce": 1764157265,
			"isDeleted": false,
			"id": "oIHHwqUM",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 499.73534599261507,
			"y": -100.99144289793978,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 236.5546875,
			"height": 36.8,
			"seed": 704165245,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "calcPoses(poses, frame_0_lm68,\nhifi3d_points, 3ddfa_points)",
			"rawText": "calcPoses(poses, frame_0_lm68,\nhifi3d_points, 3ddfa_points)",
			"textAlign": "left",
			"verticalAlign": "middle",
			"containerId": "rR5X2E67LRZRGue6daDRF",
			"originalText": "calcPoses(poses, frame_0_lm68,\nhifi3d_points, 3ddfa_points)",
			"lineHeight": 1.15,
			"baseline": 32
		},
		{
			"type": "rectangle",
			"version": 207,
			"versionNonce": 1318761023,
			"isDeleted": false,
			"id": "RW2SlMHEaAINPbrzfYioX",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 916.3785598317504,
			"y": -96.33404830322706,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 227,
			"height": 30,
			"seed": 814258269,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "PFMdEfFa",
					"type": "text"
				},
				{
					"id": "LSdw4jACm6wviXRY2I0wD",
					"type": "arrow"
				}
			],
			"updated": 1688991259023,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 394,
			"versionNonce": 55563569,
			"isDeleted": false,
			"id": "PFMdEfFa",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 922.7105910817504,
			"y": -90.53404830322707,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 214.3359375,
			"height": 18.4,
			"seed": 426003987,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "gen_mask(lm68s, video_path)",
			"rawText": "gen_mask(lm68s, video_path)",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "RW2SlMHEaAINPbrzfYioX",
			"originalText": "gen_mask(lm68s, video_path)",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 43,
			"versionNonce": 2049446495,
			"isDeleted": false,
			"id": "d8F8kk-6BcAvT2dvu2sGQ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 760.3350295360083,
			"y": -352.0691984344254,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 34.40913318525065,
			"height": 17.529181056637128,
			"seed": 1955210899,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.6492289280236037
				],
				[
					0.6492289280236037,
					1.2984578560472073
				],
				[
					1.2984578560472073,
					2.5969157120944146
				],
				[
					1.947686784070811,
					3.895373568141622
				],
				[
					2.5969157120944146,
					5.193831424188772
				],
				[
					3.895373568141622,
					6.49228928023598
				],
				[
					5.193831424188829,
					7.790747136283187
				],
				[
					6.492289280236037,
					9.738433920353941
				],
				[
					9.089204992330451,
					11.036891776401148
				],
				[
					11.036891776401148,
					12.335349632448356
				],
				[
					13.633807488495563,
					12.335349632448356
				],
				[
					16.230723200589978,
					11.686120704424752
				],
				[
					20.1260967687316,
					8.43997606430679
				],
				[
					21.424554624778807,
					7.141518208259583
				],
				[
					24.67069926489671,
					3.895373568141622
				],
				[
					27.91684390501473,
					0
				],
				[
					29.215301761061937,
					-1.2984578560472073
				],
				[
					31.812217473156352,
					-3.895373568141565
				],
				[
					32.461446401179956,
					-4.544602496165169
				],
				[
					34.40913318525065,
					-5.193831424188772
				],
				[
					34.40913318525065,
					-5.193831424188772
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 46,
			"versionNonce": 702547729,
			"isDeleted": false,
			"id": "pJUUUi8OkElaIktyohTFy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 842.1378744669815,
			"y": -355.96457200256697,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 48.69216960176982,
			"height": 21.424554624778693,
			"seed": 560557117,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6492289280236037,
					0.6492289280236037
				],
				[
					1.947686784070811,
					2.596915712094358
				],
				[
					4.544602496165226,
					5.843060352212376
				],
				[
					5.843060352212433,
					7.141518208259583
				],
				[
					7.79074713628313,
					9.089204992330338
				],
				[
					9.738433920353941,
					11.036891776401148
				],
				[
					11.686120704424752,
					11.686120704424752
				],
				[
					12.98457856047196,
					11.686120704424752
				],
				[
					13.633807488495563,
					11.686120704424752
				],
				[
					14.93226534454277,
					11.686120704424752
				],
				[
					16.230723200589978,
					11.036891776401148
				],
				[
					20.126096768731486,
					9.738433920353941
				],
				[
					22.073783552802297,
					8.439976064306734
				],
				[
					29.864530689085427,
					3.2461446401179614
				],
				[
					36.356819969321464,
					-0.6492289280236037
				],
				[
					42.19988032153378,
					-5.193831424188772
				],
				[
					44.7967960336282,
					-7.141518208259583
				],
				[
					46.74448281769901,
					-8.43997606430679
				],
				[
					48.042940673746216,
					-9.089204992330338
				],
				[
					48.042940673746216,
					-9.738433920353941
				],
				[
					48.69216960176982,
					-9.738433920353941
				],
				[
					48.042940673746216,
					-9.738433920353941
				],
				[
					47.39371174572261,
					-9.089204992330338
				],
				[
					47.39371174572261,
					-9.089204992330338
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 42,
			"versionNonce": 1767140991,
			"isDeleted": false,
			"id": "CI-FtEckmQnyuZeFwM6dA",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 612.3108339466282,
			"y": -352.718427362449,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 51.938314241887724,
			"height": 12.335349632448299,
			"seed": 1476360477,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259023,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6492289280236037,
					1.947686784070811
				],
				[
					1.2984578560472073,
					4.544602496165226
				],
				[
					1.947686784070811,
					5.843060352212376
				],
				[
					2.5969157120944146,
					8.43997606430679
				],
				[
					3.8953735681415083,
					10.387662848377545
				],
				[
					4.544602496165112,
					10.387662848377545
				],
				[
					5.843060352212319,
					10.387662848377545
				],
				[
					8.439976064306734,
					10.387662848377545
				],
				[
					9.738433920353941,
					10.387662848377545
				],
				[
					12.335349632448356,
					9.738433920353998
				],
				[
					14.932265344542657,
					9.089204992330394
				],
				[
					18.82763891268428,
					8.43997606430679
				],
				[
					22.073783552802297,
					7.141518208259583
				],
				[
					25.969157120943805,
					5.843060352212376
				],
				[
					31.812217473156238,
					3.895373568141622
				],
				[
					38.30450675339216,
					1.947686784070811
				],
				[
					44.7967960336282,
					0
				],
				[
					51.28908531386412,
					-1.2984578560471505
				],
				[
					51.938314241887724,
					-1.9476867840707541
				],
				[
					51.938314241887724,
					-1.9476867840707541
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "arrow",
			"version": 146,
			"versionNonce": 731555761,
			"isDeleted": false,
			"id": "dfZSJPAh3Ldd42J4_5td8",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 621.0094006357796,
			"y": -58.09144289793977,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 3.6367829432969074,
			"height": 84.52270950127144,
			"seed": 177818333,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991332958,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "rR5X2E67LRZRGue6daDRF",
				"gap": 1,
				"focus": 0.02532688597131095
			},
			"endBinding": {
				"elementId": "syQ_s3TPl7HmgyWcQTqHg",
				"gap": 1.9085703904769957,
				"focus": 0.12618053728336595
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
					3.6367829432969074,
					84.52270950127144
				]
			]
		},
		{
			"type": "arrow",
			"version": 141,
			"versionNonce": 1445759377,
			"isDeleted": false,
			"id": "dyILk286Dp-EutZIwyxvZ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 624.5331039301723,
			"y": -57.206185462807866,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 134.50346774978902,
			"height": 82.33899421009244,
			"seed": 1720672691,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991332958,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "rR5X2E67LRZRGue6daDRF",
				"gap": 1.885257435131905,
				"focus": 0.2406997058025906
			},
			"endBinding": {
				"elementId": "Ec7OHfr2XVSlQVVE8CZE_",
				"gap": 4.192156610885149,
				"focus": 0.3137874527746053
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
					134.50346774978902,
					82.33899421009244
				]
			]
		},
		{
			"type": "arrow",
			"version": 142,
			"versionNonce": 2078748529,
			"isDeleted": false,
			"id": "8_agNCiFm13h23EI7zQSy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 623.3163994574618,
			"y": -58.09144289793977,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 323.3473324213189,
			"height": 85.82116735731864,
			"seed": 951862461,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991332958,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "rR5X2E67LRZRGue6daDRF",
				"gap": 1,
				"focus": 0.42493093544589644
			},
			"endBinding": {
				"elementId": "o3Z4AWDeY4wm44V_pNaXX",
				"gap": 1.8447534122973934,
				"focus": 0.6718743406797137
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
					323.3473324213189,
					85.82116735731864
				]
			]
		},
		{
			"type": "arrow",
			"version": 230,
			"versionNonce": 2096790559,
			"isDeleted": false,
			"id": "LSdw4jACm6wviXRY2I0wD",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1028.2283087434912,
			"y": -65.29956554460637,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 80.91534793668689,
			"height": 95.62620571607965,
			"seed": 462396957,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991332960,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "RW2SlMHEaAINPbrzfYioX",
				"gap": 1.0344827586206897,
				"focus": -0.09443935842873184
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
					-80.91534793668689,
					95.62620571607965
				]
			]
		},
		{
			"type": "rectangle",
			"version": 251,
			"versionNonce": 1744254129,
			"isDeleted": false,
			"id": "VNoIJKbL_phUowEAEL3y5",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1619.145146186205,
			"y": -454.29589797930953,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132,
			"height": 66,
			"seed": 317539389,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "ekn60TE6",
					"type": "text"
				},
				{
					"id": "Sg3rf6RRpMe_a5oxMOzpz",
					"type": "arrow"
				}
			],
			"updated": 1688991259024,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 336,
			"versionNonce": 499673823,
			"isDeleted": false,
			"id": "ekn60TE6",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1624.246708686205,
			"y": -448.89589797930955,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 121.796875,
			"height": 55.199999999999996,
			"seed": 1687401629,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "Hifi3d++\n3DMM Geometry\nRt",
			"rawText": "Hifi3d++\n3DMM Geometry\nRt",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "VNoIJKbL_phUowEAEL3y5",
			"originalText": "Hifi3d++\n3DMM Geometry\nRt",
			"lineHeight": 1.15,
			"baseline": 51
		},
		{
			"type": "rectangle",
			"version": 313,
			"versionNonce": 1366259345,
			"isDeleted": false,
			"id": "Y2-sEGkVEbpa3t8WIWIQI",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1332.1200983681151,
			"y": -406.81255034195124,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132.7902154292433,
			"height": 188.97069118776938,
			"seed": 751638781,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 195,
			"versionNonce": 1482012415,
			"isDeleted": false,
			"id": "ubIUbla7FYIGsNnjv_Ufm",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1370.5322841815216,
			"y": -442.456446210238,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 43,
			"height": 29,
			"seed": 85651805,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "CjdLbug5",
					"type": "text"
				},
				{
					"id": "Sg3rf6RRpMe_a5oxMOzpz",
					"type": "arrow"
				}
			],
			"updated": 1688991259024,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 229,
			"versionNonce": 1246002289,
			"isDeleted": false,
			"id": "CjdLbug5",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1376.0283779315216,
			"y": -437.156446210238,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.0078125,
			"height": 18.4,
			"seed": 1523498429,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 2,
			"text": "view",
			"rawText": "view",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ubIUbla7FYIGsNnjv_Ufm",
			"originalText": "view",
			"lineHeight": 1.15,
			"baseline": 14
		},
		{
			"type": "arrow",
			"version": 862,
			"versionNonce": 938688607,
			"isDeleted": false,
			"id": "Sg3rf6RRpMe_a5oxMOzpz",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1615.4854314651707,
			"y": -426.9146719366372,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 200.02308275208156,
			"height": 2.648539596773844,
			"seed": 1963589149,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "VfEinSVJ"
				}
			],
			"updated": 1688991332962,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "VNoIJKbL_phUowEAEL3y5",
				"gap": 3.6597147210343337,
				"focus": 0.13864348253928332
			},
			"endBinding": {
				"elementId": "ubIUbla7FYIGsNnjv_Ufm",
				"gap": 1.9300645315674956,
				"focus": -0.12966165771642013
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
					-200.02308275208156,
					-2.648539596773844
				]
			]
		},
		{
			"type": "text",
			"version": 105,
			"versionNonce": 1379780177,
			"isDeleted": false,
			"id": "VfEinSVJ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1498.7893197766298,
			"y": -439.73894173502407,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 33.369140625,
			"height": 23,
			"seed": 1900112669,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 2,
			"text": "pnp",
			"rawText": "pnp",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Sg3rf6RRpMe_a5oxMOzpz",
			"originalText": "pnp",
			"lineHeight": 1.15,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 466,
			"versionNonce": 1311064895,
			"isDeleted": false,
			"id": "iRVePCUb",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 902.2341633097587,
			"y": -360.0669042070468,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 347.7535705566406,
			"height": 109.70081106144798,
			"seed": 442278495,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 14.626774808193066,
			"fontFamily": 1,
			"text": "在3DDFA虽然每一帧都能给出相应的Rt, \n有两个问题:\n① 需要将模型Rt转化到相机坐标系下\n② translate是其对图像crop之后的子图的translate\n    每一帧的crop都不一样\n③ 转换过程较为复杂",
			"rawText": "在3DDFA虽然每一帧都能给出相应的Rt, \n有两个问题:\n① 需要将模型Rt转化到相机坐标系下\n② translate是其对图像crop之后的子图的translate\n    每一帧的crop都不一样\n③ 转换过程较为复杂",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "在3DDFA虽然每一帧都能给出相应的Rt, \n有两个问题:\n① 需要将模型Rt转化到相机坐标系下\n② translate是其对图像crop之后的子图的translate\n    每一帧的crop都不一样\n③ 转换过程较为复杂",
			"lineHeight": 1.25,
			"baseline": 104
		},
		{
			"type": "freedraw",
			"version": 136,
			"versionNonce": 70439985,
			"isDeleted": false,
			"id": "pKq4y_qgluY7nbcLSTRq_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 853.8373666613118,
			"y": -342.2598407264102,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 46.88756506422601,
			"height": 24.0949987135607,
			"seed": 958916625,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.6512161814475803,
					0
				],
				[
					-1.953648544342741,
					-0.6512161814475803
				],
				[
					-2.6048647257903212,
					-1.3024323628951606
				],
				[
					-3.2560809072379016,
					-1.3024323628951606
				],
				[
					-4.558513270133062,
					-1.3024323628951606
				],
				[
					-5.2097294515806425,
					-1.3024323628951606
				],
				[
					-5.860945633028223,
					-0.6512161814475803
				],
				[
					-6.512161814475803,
					-0.6512161814475803
				],
				[
					-7.163377995923383,
					-0.6512161814475803
				],
				[
					-7.163377995923383,
					0
				],
				[
					-7.814594177370964,
					0
				],
				[
					-8.465810358818544,
					0.6512161814475803
				],
				[
					-9.768242721713705,
					1.3024323628951606
				],
				[
					-11.070675084608865,
					1.3024323628951606
				],
				[
					-11.721891266056446,
					1.3024323628951606
				],
				[
					-12.373107447504026,
					1.953648544342741
				],
				[
					-13.024323628951606,
					1.953648544342741
				],
				[
					-14.326755991846767,
					1.953648544342741
				],
				[
					-14.326755991846767,
					2.6048647257903212
				],
				[
					-14.977972173294347,
					2.6048647257903212
				],
				[
					-15.629188354741927,
					3.2560809072379016
				],
				[
					-16.280404536189508,
					3.907297088685482
				],
				[
					-16.931620717637088,
					4.558513270133119
				],
				[
					-16.931620717637088,
					5.209729451580699
				],
				[
					-17.58283689908467,
					6.51216181447586
				],
				[
					-17.58283689908467,
					7.16337799592344
				],
				[
					-17.58283689908467,
					7.814594177371021
				],
				[
					-18.23405308053225,
					8.465810358818601
				],
				[
					-18.23405308053225,
					9.117026540266181
				],
				[
					-18.23405308053225,
					9.768242721713762
				],
				[
					-18.23405308053225,
					10.419458903161342
				],
				[
					-17.58283689908467,
					11.070675084608979
				],
				[
					-17.58283689908467,
					11.72189126605656
				],
				[
					-16.931620717637088,
					12.37310744750414
				],
				[
					-16.280404536189508,
					13.6755398103993
				],
				[
					-15.629188354741927,
					13.6755398103993
				],
				[
					-15.629188354741927,
					14.32675599184688
				],
				[
					-14.977972173294347,
					14.32675599184688
				],
				[
					-14.977972173294347,
					14.97797217329446
				],
				[
					-14.326755991846767,
					15.629188354742041
				],
				[
					-13.024323628951606,
					16.28040453618962
				],
				[
					-13.024323628951606,
					16.931620717637202
				],
				[
					-12.373107447504026,
					17.58283689908484
				],
				[
					-11.070675084608865,
					17.58283689908484
				],
				[
					-10.419458903161285,
					18.23405308053242
				],
				[
					-9.768242721713705,
					18.23405308053242
				],
				[
					-9.117026540266124,
					18.23405308053242
				],
				[
					-9.117026540266124,
					18.88526926198
				],
				[
					-8.465810358818544,
					18.88526926198
				],
				[
					-7.163377995923383,
					18.88526926198
				],
				[
					-5.860945633028223,
					19.53648544342758
				],
				[
					-5.2097294515806425,
					19.53648544342758
				],
				[
					-4.558513270133062,
					19.53648544342758
				],
				[
					-3.907297088685482,
					19.53648544342758
				],
				[
					-2.6048647257903212,
					18.88526926198
				],
				[
					-1.3024323628951606,
					18.88526926198
				],
				[
					0,
					18.88526926198
				],
				[
					1.3024323628951606,
					18.88526926198
				],
				[
					1.953648544342741,
					18.88526926198
				],
				[
					2.6048647257903212,
					18.23405308053242
				],
				[
					3.2560809072379016,
					18.23405308053242
				],
				[
					3.907297088685482,
					18.23405308053242
				],
				[
					4.558513270133062,
					18.23405308053242
				],
				[
					5.86094563302845,
					18.23405308053242
				],
				[
					7.163377995923611,
					18.23405308053242
				],
				[
					8.465810358818771,
					18.23405308053242
				],
				[
					10.419458903161512,
					18.23405308053242
				],
				[
					11.070675084609093,
					18.23405308053242
				],
				[
					11.721891266056673,
					18.23405308053242
				],
				[
					12.373107447504253,
					18.23405308053242
				],
				[
					13.675539810399414,
					18.23405308053242
				],
				[
					14.977972173294575,
					18.23405308053242
				],
				[
					16.280404536189735,
					18.23405308053242
				],
				[
					18.234053080532476,
					18.23405308053242
				],
				[
					18.885269261980056,
					18.23405308053242
				],
				[
					19.536485443427637,
					18.23405308053242
				],
				[
					20.187701624875217,
					18.23405308053242
				],
				[
					20.838917806322797,
					18.23405308053242
				],
				[
					21.490133987770378,
					18.23405308053242
				],
				[
					22.141350169217958,
					18.88526926198
				],
				[
					22.79256635066554,
					18.88526926198
				],
				[
					23.44378253211312,
					18.88526926198
				],
				[
					24.74621489500828,
					18.23405308053242
				],
				[
					25.39743107645586,
					17.58283689908484
				],
				[
					26.69986343935102,
					16.931620717637202
				],
				[
					28.00229580224618,
					16.28040453618962
				],
				[
					28.65351198369376,
					15.629188354742041
				],
				[
					28.65351198369376,
					14.97797217329446
				],
				[
					28.65351198369376,
					14.32675599184688
				],
				[
					28.65351198369376,
					13.6755398103993
				],
				[
					28.65351198369376,
					12.37310744750414
				],
				[
					28.65351198369376,
					11.070675084608979
				],
				[
					28.00229580224618,
					9.768242721713762
				],
				[
					28.00229580224618,
					9.117026540266181
				],
				[
					27.3510796207986,
					7.16337799592344
				],
				[
					27.3510796207986,
					6.51216181447586
				],
				[
					26.69986343935102,
					5.86094563302828
				],
				[
					26.69986343935102,
					5.209729451580699
				],
				[
					26.04864725790344,
					4.558513270133119
				],
				[
					25.39743107645586,
					3.907297088685482
				],
				[
					24.0949987135607,
					3.2560809072379016
				],
				[
					22.79256635066554,
					2.6048647257903212
				],
				[
					21.490133987770378,
					1.3024323628951606
				],
				[
					20.187701624875217,
					1.3024323628951606
				],
				[
					18.885269261980056,
					0
				],
				[
					18.234053080532476,
					-0.6512161814475803
				],
				[
					16.931620717637315,
					-1.3024323628951606
				],
				[
					15.629188354742155,
					-1.953648544342741
				],
				[
					14.326755991846994,
					-3.2560809072379584
				],
				[
					13.024323628951834,
					-3.9072970886855387
				],
				[
					12.373107447504253,
					-3.9072970886855387
				],
				[
					11.721891266056673,
					-4.558513270133119
				],
				[
					11.070675084609093,
					-4.558513270133119
				],
				[
					10.419458903161512,
					-4.558513270133119
				],
				[
					9.117026540266352,
					-4.558513270133119
				],
				[
					8.465810358818771,
					-4.558513270133119
				],
				[
					7.163377995923611,
					-4.558513270133119
				],
				[
					5.86094563302845,
					-4.558513270133119
				],
				[
					5.2097294515806425,
					-4.558513270133119
				],
				[
					4.558513270133062,
					-4.558513270133119
				],
				[
					3.907297088685482,
					-4.558513270133119
				],
				[
					3.2560809072379016,
					-4.558513270133119
				],
				[
					2.6048647257903212,
					-4.558513270133119
				],
				[
					1.953648544342741,
					-3.9072970886855387
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
			"version": 66,
			"versionNonce": 741901151,
			"isDeleted": false,
			"id": "4oMRdNTvcr3FZ9yKQPJ5z",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 881.1884462821104,
			"y": -329.88673327890604,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 17.582836899084896,
			"height": 31.25837670948414,
			"seed": 1029617631,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6512161814475803,
					0
				],
				[
					1.953648544342741,
					1.3024323628951606
				],
				[
					4.5585132701332896,
					1.953648544342741
				],
				[
					6.5121618144760305,
					2.6048647257903212
				],
				[
					8.465810358818771,
					3.2560809072379016
				],
				[
					11.070675084609093,
					3.907297088685482
				],
				[
					11.721891266056673,
					4.558513270133062
				],
				[
					11.721891266056673,
					5.209729451580699
				],
				[
					11.721891266056673,
					5.86094563302828
				],
				[
					11.070675084609093,
					5.86094563302828
				],
				[
					11.070675084609093,
					6.51216181447586
				],
				[
					11.070675084609093,
					7.16337799592344
				],
				[
					10.419458903161512,
					7.814594177371021
				],
				[
					9.768242721713932,
					8.465810358818601
				],
				[
					9.117026540266352,
					9.768242721713762
				],
				[
					8.465810358818771,
					10.419458903161342
				],
				[
					7.814594177371191,
					11.070675084608979
				],
				[
					7.814594177371191,
					11.72189126605656
				],
				[
					7.163377995923611,
					12.37310744750414
				],
				[
					6.5121618144760305,
					14.32675599184688
				],
				[
					5.86094563302845,
					14.32675599184688
				],
				[
					5.86094563302845,
					15.629188354742041
				],
				[
					5.20972945158087,
					16.28040453618962
				],
				[
					5.20972945158087,
					16.931620717637202
				],
				[
					5.20972945158087,
					17.58283689908484
				],
				[
					5.20972945158087,
					18.23405308053242
				],
				[
					4.5585132701332896,
					19.53648544342758
				],
				[
					4.5585132701332896,
					20.18770162487516
				],
				[
					4.5585132701332896,
					20.83891780632274
				],
				[
					3.9072970886857092,
					21.49013398777032
				],
				[
					3.9072970886857092,
					22.1413501692179
				],
				[
					3.9072970886857092,
					22.79256635066548
				],
				[
					3.9072970886857092,
					23.44378253211306
				],
				[
					3.9072970886857092,
					24.0949987135607
				],
				[
					3.9072970886857092,
					24.74621489500828
				],
				[
					3.9072970886857092,
					25.39743107645586
				],
				[
					3.9072970886857092,
					26.04864725790344
				],
				[
					3.9072970886857092,
					26.69986343935102
				],
				[
					4.5585132701332896,
					27.3510796207986
				],
				[
					4.5585132701332896,
					28.00229580224618
				],
				[
					4.5585132701332896,
					28.65351198369376
				],
				[
					5.20972945158087,
					28.65351198369376
				],
				[
					5.86094563302845,
					29.30472816514134
				],
				[
					6.5121618144760305,
					29.30472816514134
				],
				[
					7.163377995923611,
					29.95594434658892
				],
				[
					7.814594177371191,
					29.95594434658892
				],
				[
					9.117026540266352,
					29.95594434658892
				],
				[
					9.768242721713932,
					29.95594434658892
				],
				[
					10.419458903161512,
					30.60716052803656
				],
				[
					11.070675084609093,
					30.60716052803656
				],
				[
					12.373107447504253,
					30.60716052803656
				],
				[
					13.675539810399414,
					30.60716052803656
				],
				[
					14.326755991846994,
					31.25837670948414
				],
				[
					15.629188354742155,
					30.60716052803656
				],
				[
					16.280404536189735,
					30.60716052803656
				],
				[
					16.931620717637315,
					31.25837670948414
				],
				[
					17.582836899084896,
					31.25837670948414
				],
				[
					17.582836899084896,
					31.25837670948414
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 36,
			"versionNonce": 873145873,
			"isDeleted": false,
			"id": "TOcSTBUYDRTq4otKvE7nd",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 896.8176346368525,
			"y": -306.442950746793,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 8.465810358818544,
			"height": 14.326755991846937,
			"seed": 1037866911,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.6512161814476372
				],
				[
					0,
					1.3024323628952175
				],
				[
					0.6512161814475803,
					1.3024323628952175
				],
				[
					1.3024323628951606,
					1.9536485443427978
				],
				[
					1.953648544342741,
					2.604864725790378
				],
				[
					2.6048647257903212,
					3.2560809072379584
				],
				[
					3.907297088685482,
					4.558513270133119
				],
				[
					5.2097294515806425,
					5.209729451580699
				],
				[
					5.860945633028223,
					5.86094563302828
				],
				[
					6.512161814475803,
					5.86094563302828
				],
				[
					7.163377995923383,
					6.51216181447586
				],
				[
					7.814594177370964,
					7.163377995923497
				],
				[
					7.814594177370964,
					7.814594177371077
				],
				[
					8.465810358818544,
					8.465810358818658
				],
				[
					7.814594177370964,
					8.465810358818658
				],
				[
					7.163377995923383,
					9.117026540266238
				],
				[
					5.860945633028223,
					9.117026540266238
				],
				[
					5.2097294515806425,
					9.117026540266238
				],
				[
					4.558513270133062,
					9.768242721713818
				],
				[
					3.907297088685482,
					9.768242721713818
				],
				[
					3.2560809072379016,
					10.419458903161399
				],
				[
					2.6048647257903212,
					10.419458903161399
				],
				[
					2.6048647257903212,
					11.72189126605656
				],
				[
					1.3024323628951606,
					13.02432362895172
				],
				[
					0.6512161814475803,
					13.02432362895172
				],
				[
					0.6512161814475803,
					13.675539810399357
				],
				[
					0.6512161814475803,
					14.326755991846937
				],
				[
					0.6512161814475803,
					14.326755991846937
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 9,
			"versionNonce": 1110359935,
			"isDeleted": false,
			"id": "KVeFo1ICVS0VTZc5B_pTU",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 846.8389730617664,
			"y": -395.75697856754664,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 0.0001,
			"height": 0.0001,
			"seed": 1330157937,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.0001,
					0.0001
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "image",
			"version": 813,
			"versionNonce": 1287535601,
			"isDeleted": false,
			"id": "eZYaRvPv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1323.8838100550577,
			"y": -158.29499106214246,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 500,
			"height": 373.05699481865287,
			"seed": 16440,
			"groupIds": [
				"HFNBHHwo9GRICQZ2l9HJo",
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a8a3479038935d3d6db5015b94a2b6ba53c5368c",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 1122,
			"versionNonce": 306739103,
			"isDeleted": false,
			"id": "6aMwEl6g",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1829.4673804604895,
			"y": 160.14848360367256,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 386.669921875,
			"height": 46,
			"seed": 65230259,
			"groupIds": [
				"HFNBHHwo9GRICQZ2l9HJo",
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 2,
			"text": "注意: 这里正常情况下针孔相机的y是朝下的,\nPnp求解的是Transform矩阵T",
			"rawText": "注意: 这里正常情况下针孔相机的y是朝下的,\nPnp求解的是Transform矩阵T",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "注意: 这里正常情况下针孔相机的y是朝下的,\nPnp求解的是Transform矩阵T",
			"lineHeight": 1.15,
			"baseline": 41
		},
		{
			"type": "image",
			"version": 952,
			"versionNonce": 1850971601,
			"isDeleted": false,
			"id": "xeHPFSyj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1838.7317187578733,
			"y": -204.4063585355862,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 276,
			"height": 94,
			"seed": 99727,
			"groupIds": [
				"HFNBHHwo9GRICQZ2l9HJo",
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "8c0d6fee0a87976dc1c6967cc6fb6c971e1c55f8",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 842,
			"versionNonce": 45493183,
			"isDeleted": false,
			"id": "wcxVn5mzcwVpKRW5uY0QE",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2069.592064072336,
			"y": -47.247468797365656,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 110,
			"height": 35,
			"seed": 2040945523,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [
				{
					"id": "086Iuols",
					"type": "text"
				},
				{
					"id": "cdH_GNj08BCjbpEn-r3I_",
					"type": "arrow"
				}
			],
			"updated": 1688991259024,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 990,
			"versionNonce": 1273148337,
			"isDeleted": false,
			"id": "086Iuols",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2083.6853868262424,
			"y": -39.64119343066679,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 81.8133544921875,
			"height": 19.78744926660227,
			"seed": 257380723,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 15.829959413281816,
			"fontFamily": 1,
			"text": "world/local",
			"rawText": "world/local",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "wcxVn5mzcwVpKRW5uY0QE",
			"originalText": "world/local",
			"lineHeight": 1.25,
			"baseline": 13
		},
		{
			"type": "rectangle",
			"version": 844,
			"versionNonce": 1603820511,
			"isDeleted": false,
			"id": "OURycegkRJLQgvlrRk97A",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1836.3267294891425,
			"y": -47.20371471739156,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 68,
			"height": 50,
			"seed": 885414579,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [
				{
					"id": "ZtxS0H9i",
					"type": "text"
				},
				{
					"id": "cdH_GNj08BCjbpEn-r3I_",
					"type": "arrow"
				}
			],
			"updated": 1688991259024,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1021,
			"versionNonce": 1234376081,
			"isDeleted": false,
			"id": "ZtxS0H9i",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1843.351036740119,
			"y": -41.78369927818695,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 53.951385498046875,
			"height": 39.15996912159078,
			"seed": 684084509,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 15.66398764863631,
			"fontFamily": 1,
			"text": "camera\n/view",
			"rawText": "camera/view",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "OURycegkRJLQgvlrRk97A",
			"originalText": "camera/view",
			"lineHeight": 1.25,
			"baseline": 33
		},
		{
			"type": "arrow",
			"version": 2753,
			"versionNonce": 842527903,
			"isDeleted": false,
			"id": "cdH_GNj08BCjbpEn-r3I_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2068.5450620266674,
			"y": -30.574322593762815,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 163.1713304918526,
			"height": 7.332226631297043,
			"seed": 1377603837,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [
				{
					"type": "text",
					"id": "RsOFWp9z"
				}
			],
			"updated": 1688991332964,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "wcxVn5mzcwVpKRW5uY0QE",
				"gap": 1.0470020456687053,
				"focus": 0.16750738153763067
			},
			"endBinding": {
				"elementId": "OURycegkRJLQgvlrRk97A",
				"gap": 1.0470020456721159,
				"focus": 0.0202233834895579
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
					-163.1713304918526,
					7.332226631297043
				]
			]
		},
		{
			"type": "text",
			"version": 735,
			"versionNonce": 1520188273,
			"isDeleted": false,
			"id": "RsOFWp9z",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1917.789266087021,
			"y": -55.84854642361066,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 131.0398406982422,
			"height": 50,
			"seed": 778601341,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "rotate PI\nalgone x axis",
			"rawText": "rotate PI\nalgone x axis",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "cdH_GNj08BCjbpEn-r3I_",
			"originalText": "rotate PI\nalgone x axis",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "freedraw",
			"version": 692,
			"versionNonce": 1491873823,
			"isDeleted": false,
			"id": "7lKbFDJLNn53C-gb8-h8a",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2086.387650980976,
			"y": 62.04671590536833,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 84.39981660717703,
			"height": 2.075405326405976,
			"seed": 974352051,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.0754053264058836,
					0
				],
				[
					3.4590088773431398,
					0
				],
				[
					4.84261242828058,
					0
				],
				[
					8.301621305623904,
					-0.6918017754687201
				],
				[
					14.527837284841924,
					-0.6918017754687201
				],
				[
					20.062251488591134,
					-1.383603550937348
				],
				[
					21.445855039528574,
					-1.383603550937348
				],
				[
					24.213062141403086,
					-2.075405326405976
				],
				[
					31.131079896089734,
					-2.075405326405976
				],
				[
					40.12450297718245,
					-2.075405326405976
				],
				[
					48.42612428280653,
					-2.075405326405976
				],
				[
					51.19333138468105,
					-2.075405326405976
				],
				[
					51.88513316014968,
					-2.075405326405976
				],
				[
					55.344142037493185,
					-2.075405326405976
				],
				[
					58.80315091483632,
					-2.075405326405976
				],
				[
					60.87855624124239,
					-2.075405326405976
				],
				[
					62.95396156764846,
					-2.075405326405976
				],
				[
					66.4129704449916,
					-2.075405326405976
				],
				[
					69.87197932233511,
					-2.075405326405976
				],
				[
					72.63918642420963,
					-2.075405326405976
				],
				[
					74.02278997514688,
					-2.075405326405976
				],
				[
					74.7145917506157,
					-2.075405326405976
				],
				[
					77.48179885249039,
					-1.383603550937348
				],
				[
					80.2490059543649,
					-1.383603550937348
				],
				[
					80.94080772983352,
					-1.383603550937348
				],
				[
					81.63260950530234,
					-1.383603550937348
				],
				[
					82.32441128077096,
					-1.383603550937348
				],
				[
					83.0162130562396,
					-1.383603550937348
				],
				[
					83.70801483170841,
					-1.383603550937348
				],
				[
					84.39981660717703,
					-1.383603550937348
				],
				[
					84.39981660717703,
					-1.383603550937348
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 680,
			"versionNonce": 524658001,
			"isDeleted": false,
			"id": "fXR7rVNDIw4q5aD9AQD8p",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2170.0956658126815,
			"y": 53.05329282427573,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 16.603242611247808,
			"height": 10.37702663202988,
			"seed": 903098365,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6918017754686279,
					0
				],
				[
					2.0754053264058836,
					0.6918017754686279
				],
				[
					6.2262159792178355,
					2.075405326405976
				],
				[
					8.993423081092532,
					3.459008877343324
				],
				[
					10.377026632029787,
					4.150810652811952
				],
				[
					11.068828407498415,
					4.84261242828058
				],
				[
					10.377026632029787,
					4.84261242828058
				],
				[
					10.377026632029787,
					5.5344142037493
				],
				[
					9.68522485656116,
					6.226215979217928
				],
				[
					8.993423081092532,
					6.226215979217928
				],
				[
					7.609819530155276,
					6.918017754686648
				],
				[
					6.918017754686648,
					6.918017754686648
				],
				[
					2.7672071018745115,
					7.609819530155276
				],
				[
					-0.6918017754688124,
					8.301621305623904
				],
				[
					-3.4590088773435084,
					9.685224856561252
				],
				[
					-5.534414203749392,
					10.37702663202988
				],
				[
					-4.8426124282807645,
					10.37702663202988
				],
				[
					-4.150810652812137,
					10.37702663202988
				],
				[
					-4.150810652812137,
					10.37702663202988
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 691,
			"versionNonce": 491705407,
			"isDeleted": false,
			"id": "-6xhnXqE8qYe1tGWXUrX0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2089.1548580828503,
			"y": 64.1221212317742,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 5.534414203749392,
			"height": 67.1047722204605,
			"seed": 1894866579,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					-0.6918017754687201
				],
				[
					-1.3836035509372557,
					-2.767207101874696
				],
				[
					-2.7672071018745115,
					-4.842612428280672
				],
				[
					-4.150810652811952,
					-7.609819530155276
				],
				[
					-5.534414203749392,
					-13.144233733904668
				],
				[
					-5.534414203749392,
					-15.911440835779272
				],
				[
					-5.534414203749392,
					-21.445855039528574
				],
				[
					-5.534414203749392,
					-22.829458590465922
				],
				[
					-4.84261242828058,
					-26.980269243277963
				],
				[
					-4.84261242828058,
					-35.28189054890187
				],
				[
					-4.84261242828058,
					-38.04909765077657
				],
				[
					-4.84261242828058,
					-41.50810652811989
				],
				[
					-4.84261242828058,
					-47.734322507337815
				],
				[
					-4.84261242828058,
					-49.11792605827517
				],
				[
					-4.84261242828058,
					-51.88513316014986
				],
				[
					-4.84261242828058,
					-53.96053848655584
				],
				[
					-4.150810652811952,
					-55.344142037493185
				],
				[
					-4.150810652811952,
					-56.72774558843053
				],
				[
					-4.150810652811952,
					-58.80315091483651
				],
				[
					-4.150810652811952,
					-60.18675446577386
				],
				[
					-4.150810652811952,
					-60.878556241242485
				],
				[
					-4.150810652811952,
					-61.57035801671111
				],
				[
					-4.150810652811952,
					-62.26215979217983
				],
				[
					-4.150810652811952,
					-63.64576334311718
				],
				[
					-4.150810652811952,
					-64.33756511858581
				],
				[
					-4.150810652811952,
					-65.02936689405443
				],
				[
					-4.84261242828058,
					-65.72116866952315
				],
				[
					-4.84261242828058,
					-66.41297044499179
				],
				[
					-4.84261242828058,
					-67.1047722204605
				],
				[
					-4.84261242828058,
					-67.1047722204605
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 673,
			"versionNonce": 1122423601,
			"isDeleted": false,
			"id": "sNL7ZwMR1s6Utewe3Yvub",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2084.3122456545707,
			"y": -2.9826509886862027,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 9.685224856561344,
			"height": 11.76063018296732,
			"seed": 9984147,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.6918017754688124,
					0
				],
				[
					-1.3836035509374403,
					0.6918017754687201
				],
				[
					-2.767207101874696,
					1.383603550937348
				],
				[
					-3.459008877343324,
					2.767207101874696
				],
				[
					-5.534414203749392,
					5.534414203749392
				],
				[
					-7.609819530155461,
					8.301621305623996
				],
				[
					-8.993423081092716,
					10.377026632029972
				],
				[
					-9.685224856561344,
					11.068828407498692
				],
				[
					-9.685224856561344,
					11.76063018296732
				],
				[
					-8.993423081092716,
					11.76063018296732
				],
				[
					-8.301621305624089,
					11.76063018296732
				],
				[
					-8.301621305624089,
					11.76063018296732
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 670,
			"versionNonce": 1644688479,
			"isDeleted": false,
			"id": "AGVPNJwWiUCortQtdqPjM",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2080.853236777227,
			"y": -2.9826509886862027,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 11.0688284074986,
			"height": 4.842612428280672,
			"seed": 629165043,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6918017754686279,
					0
				],
				[
					0.6918017754686279,
					0.6918017754687201
				],
				[
					1.3836035509372557,
					0.6918017754687201
				],
				[
					2.7672071018745115,
					1.383603550937348
				],
				[
					4.84261242828058,
					2.0754053264060683
				],
				[
					7.609819530155276,
					3.459008877343324
				],
				[
					9.68522485656116,
					4.150810652812044
				],
				[
					11.0688284074986,
					4.842612428280672
				],
				[
					11.0688284074986,
					4.842612428280672
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 688,
			"versionNonce": 434586897,
			"isDeleted": false,
			"id": "S_YIbdElSMPjactYgyx7Y",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2091.2302634092566,
			"y": 62.73851768083688,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 26.288467467809152,
			"height": 26.288467467809244,
			"seed": 675007133,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.6918017754688124,
					0
				],
				[
					-0.6918017754688124,
					0.6918017754686279
				],
				[
					-1.3836035509374403,
					0.6918017754686279
				],
				[
					-2.767207101874696,
					1.383603550937348
				],
				[
					-3.459008877343324,
					2.075405326405976
				],
				[
					-4.150810652811952,
					3.459008877343324
				],
				[
					-4.84261242828058,
					4.150810652811952
				],
				[
					-6.22621597921802,
					5.5344142037493
				],
				[
					-7.609819530155461,
					6.918017754686648
				],
				[
					-9.685224856561344,
					8.301621305623996
				],
				[
					-11.0688284074986,
					10.377026632029972
				],
				[
					-12.45243195843604,
					12.452431958435948
				],
				[
					-13.144233733904668,
					13.144233733904668
				],
				[
					-13.836035509373296,
					14.527837284841924
				],
				[
					-15.219639060310737,
					15.911440835779272
				],
				[
					-15.911440835779365,
					16.603242611247992
				],
				[
					-17.29504438671662,
					17.98684616218525
				],
				[
					-19.370449713122504,
					19.370449713122596
				],
				[
					-20.062251488591315,
					20.062251488591315
				],
				[
					-21.445855039528755,
					21.445855039528574
				],
				[
					-23.52126036593464,
					23.52126036593464
				],
				[
					-24.213062141403267,
					24.213062141403267
				],
				[
					-24.213062141403267,
					24.904863916871896
				],
				[
					-24.904863916871896,
					24.904863916871896
				],
				[
					-25.596665692340526,
					25.596665692340615
				],
				[
					-26.288467467809152,
					26.288467467809244
				],
				[
					-26.288467467809152,
					26.288467467809244
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 684,
			"versionNonce": 1323831423,
			"isDeleted": false,
			"id": "e_b9DBXRmGgxlOafoFqO1",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2064.249994165978,
			"y": 78.64995851661621,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 28.363872794215222,
			"height": 13.144233733904668,
			"seed": 1417704563,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.6918017754687201
				],
				[
					-0.6918017754686279,
					1.383603550937348
				],
				[
					-1.3836035509374403,
					3.459008877343324
				],
				[
					-2.0754053264060683,
					5.5344142037493
				],
				[
					-2.767207101874696,
					6.918017754686648
				],
				[
					-3.459008877343324,
					9.685224856561344
				],
				[
					-4.150810652811952,
					10.377026632029972
				],
				[
					-4.150810652811952,
					11.068828407498692
				],
				[
					-4.150810652811952,
					12.452431958435948
				],
				[
					-4.150810652811952,
					13.144233733904668
				],
				[
					-3.459008877343324,
					13.144233733904668
				],
				[
					-2.767207101874696,
					13.144233733904668
				],
				[
					-1.3836035509374403,
					13.144233733904668
				],
				[
					0,
					13.144233733904668
				],
				[
					2.0754053264060683,
					12.452431958435948
				],
				[
					4.150810652811952,
					11.76063018296732
				],
				[
					6.918017754686648,
					11.76063018296732
				],
				[
					10.377026632029972,
					11.068828407498692
				],
				[
					16.603242611247992,
					11.068828407498692
				],
				[
					20.754053264059944,
					11.068828407498692
				],
				[
					23.52126036593464,
					10.377026632029972
				],
				[
					24.213062141403267,
					10.377026632029972
				],
				[
					24.213062141403267,
					10.377026632029972
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 661,
			"versionNonce": 2143189745,
			"isDeleted": false,
			"id": "Zdhl7yzB",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2174.938278240962,
			"y": 73.80734608833546,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 9.114883422851562,
			"height": 20.283882669783,
			"seed": 2124859891,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259024,
			"link": null,
			"locked": false,
			"fontSize": 16.2271061358264,
			"fontFamily": 1,
			"text": "x",
			"rawText": "x",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "x",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 662,
			"versionNonce": 1034922143,
			"isDeleted": false,
			"id": "AitzgXoy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2069.0926065942585,
			"y": 97.32860645427007,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 9.277069091796875,
			"height": 20.283882669783,
			"seed": 2085320573,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 16.2271061358264,
			"fontFamily": 1,
			"text": "z",
			"rawText": "z",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "z",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 661,
			"versionNonce": 1962144977,
			"isDeleted": false,
			"id": "rIPlo3qB",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2098.8400829394122,
			"y": -0.9072456622802179,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 7.6065521240234375,
			"height": 20.283882669783,
			"seed": 441138269,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 16.2271061358264,
			"fontFamily": 1,
			"text": "y",
			"rawText": "y",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "y",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 678,
			"versionNonce": 2081373375,
			"isDeleted": false,
			"id": "5S6mjg8ArczoIkBaaK7Ky",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1855.3258579744388,
			"y": 59.971310578962346,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 61.57035801671102,
			"height": 4.842612428280672,
			"seed": 1099826387,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6918017754686279,
					0
				],
				[
					2.7672071018745115,
					0
				],
				[
					5.534414203749208,
					-0.6918017754687201
				],
				[
					8.301621305623904,
					-0.6918017754687201
				],
				[
					11.068828407498415,
					-1.383603550937348
				],
				[
					13.144233733904484,
					-2.0754053264060683
				],
				[
					17.986846162185063,
					-2.767207101874696
				],
				[
					22.1376568149972,
					-3.459008877343324
				],
				[
					28.363872794215222,
					-4.150810652812044
				],
				[
					34.59008877343306,
					-4.842612428280672
				],
				[
					36.66549409983912,
					-4.842612428280672
				],
				[
					38.74089942624501,
					-4.842612428280672
				],
				[
					40.12450297718245,
					-4.842612428280672
				],
				[
					43.583511854525774,
					-4.842612428280672
				],
				[
					46.350718956400286,
					-4.150810652812044
				],
				[
					51.19333138468105,
					-4.150810652812044
				],
				[
					59.494952690304956,
					-4.150810652812044
				],
				[
					61.57035801671102,
					-4.150810652812044
				],
				[
					61.57035801671102,
					-4.150810652812044
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 683,
			"versionNonce": 2099196593,
			"isDeleted": false,
			"id": "riRRL-XAVOX2-ftYpN-S6",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1912.7454053383378,
			"y": 50.97788749786963,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 6.918017754686648,
			"height": 12.452431958435948,
			"seed": 756861565,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6918017754686279,
					0
				],
				[
					0.6918017754686279,
					0.6918017754686279
				],
				[
					0.6918017754686279,
					1.383603550937348
				],
				[
					1.3836035509372557,
					1.383603550937348
				],
				[
					2.0754053264058836,
					2.075405326405976
				],
				[
					2.7672071018745115,
					2.767207101874696
				],
				[
					3.4590088773431398,
					3.459008877343324
				],
				[
					4.150810652811952,
					4.150810652811952
				],
				[
					4.84261242828058,
					4.842612428280672
				],
				[
					5.534414203749392,
					5.5344142037493
				],
				[
					6.22621597921802,
					5.5344142037493
				],
				[
					6.918017754686648,
					6.22621597921802
				],
				[
					6.22621597921802,
					6.22621597921802
				],
				[
					5.534414203749392,
					6.22621597921802
				],
				[
					5.534414203749392,
					6.918017754686648
				],
				[
					4.84261242828058,
					7.609819530155276
				],
				[
					4.150810652811952,
					8.301621305623996
				],
				[
					4.150810652811952,
					8.993423081092624
				],
				[
					3.4590088773431398,
					8.993423081092624
				],
				[
					3.4590088773431398,
					9.685224856561344
				],
				[
					2.7672071018745115,
					9.685224856561344
				],
				[
					2.7672071018745115,
					10.377026632029972
				],
				[
					2.0754053264058836,
					11.0688284074986
				],
				[
					2.0754053264058836,
					11.76063018296732
				],
				[
					2.0754053264058836,
					12.452431958435948
				],
				[
					2.0754053264058836,
					12.452431958435948
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 696,
			"versionNonce": 1302809823,
			"isDeleted": false,
			"id": "vIk2ahuB20OPs0z0D4OD2",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1853.2504526480325,
			"y": 59.971310578962346,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 2.0754053264058836,
			"height": 47.0425207318691,
			"seed": 162642877,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.6918017754686279,
					2.767207101874604
				],
				[
					-1.3836035509372557,
					4.84261242828058
				],
				[
					-1.3836035509372557,
					6.918017754686556
				],
				[
					-2.0754053264058836,
					8.993423081092624
				],
				[
					-2.0754053264058836,
					10.37702663202988
				],
				[
					-2.0754053264058836,
					11.0688284074986
				],
				[
					-2.0754053264058836,
					11.760630182967228
				],
				[
					-2.0754053264058836,
					12.452431958435948
				],
				[
					-2.0754053264058836,
					13.144233733904576
				],
				[
					-2.0754053264058836,
					13.836035509373204
				],
				[
					-2.0754053264058836,
					15.219639060310552
				],
				[
					-2.0754053264058836,
					15.911440835779272
				],
				[
					-2.0754053264058836,
					17.29504438671653
				],
				[
					-2.0754053264058836,
					17.98684616218525
				],
				[
					-1.3836035509372557,
					18.678647937653878
				],
				[
					-1.3836035509372557,
					19.370449713122596
				],
				[
					-1.3836035509372557,
					20.062251488591226
				],
				[
					-1.3836035509372557,
					20.754053264059852
				],
				[
					-1.3836035509372557,
					22.1376568149972
				],
				[
					-1.3836035509372557,
					23.52126036593455
				],
				[
					-1.3836035509372557,
					24.904863916871896
				],
				[
					-1.3836035509372557,
					26.288467467809244
				],
				[
					-1.3836035509372557,
					26.980269243277874
				],
				[
					-1.3836035509372557,
					29.05567456968385
				],
				[
					-1.3836035509372557,
					30.439278120621196
				],
				[
					-2.0754053264058836,
					31.822881671558545
				],
				[
					-2.0754053264058836,
					33.20648522249589
				],
				[
					-2.0754053264058836,
					34.59008877343315
				],
				[
					-2.0754053264058836,
					35.28189054890187
				],
				[
					-2.0754053264058836,
					36.66549409983912
				],
				[
					-2.0754053264058836,
					38.049097650776474
				],
				[
					-2.0754053264058836,
					39.43270120171382
				],
				[
					-2.0754053264058836,
					40.81630475265117
				],
				[
					-2.0754053264058836,
					42.199908303588515
				],
				[
					-2.0754053264058836,
					42.89171007905715
				],
				[
					-2.0754053264058836,
					43.583511854525774
				],
				[
					-2.0754053264058836,
					45.658917180931844
				],
				[
					-2.0754053264058836,
					46.35071895640047
				],
				[
					-2.0754053264058836,
					47.0425207318691
				],
				[
					-2.0754053264058836,
					47.0425207318691
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 675,
			"versionNonce": 1021818001,
			"isDeleted": false,
			"id": "noO-bcAHB43AhcIvaKBlE",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1842.8734260160027,
			"y": 102.17121888255082,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 21.445855039528574,
			"height": 11.760630182967228,
			"seed": 67529629,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.6918017754686279
				],
				[
					0,
					1.3836035509372557
				],
				[
					0.691801775468628,
					3.459008877343324
				],
				[
					2.075405326405884,
					5.5344142037493
				],
				[
					2.767207101874512,
					6.918017754686648
				],
				[
					3.45900887734314,
					8.301621305623904
				],
				[
					4.150810652811953,
					8.301621305623904
				],
				[
					4.842612428280581,
					8.301621305623904
				],
				[
					6.226215979218021,
					8.301621305623904
				],
				[
					8.993423081092534,
					8.301621305623904
				],
				[
					11.76063018296723,
					6.918017754686648
				],
				[
					13.836035509373298,
					5.5344142037493
				],
				[
					15.219639060310554,
					4.150810652811952
				],
				[
					16.60324261124781,
					2.767207101874604
				],
				[
					17.295044386716437,
					1.3836035509372557
				],
				[
					19.370449713122692,
					-1.383603550937348
				],
				[
					21.445855039528574,
					-3.459008877343324
				],
				[
					21.445855039528574,
					-2.767207101874696
				],
				[
					21.445855039528574,
					-2.767207101874696
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 696,
			"versionNonce": 772299007,
			"isDeleted": false,
			"id": "-NgnGhcLlDFGYnMoNpfsv",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1853.9422544235013,
			"y": 59.971310578962346,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 57.419547363899255,
			"height": 31.131079896089915,
			"seed": 1221091219,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.3836035509374403,
					-0.6918017754687201
				],
				[
					4.150810652811952,
					-2.0754053264060683
				],
				[
					6.2262159792178355,
					-3.459008877343324
				],
				[
					9.685224856561344,
					-4.150810652812044
				],
				[
					11.760630182967228,
					-5.534414203749392
				],
				[
					13.836035509373296,
					-6.918017754686648
				],
				[
					15.219639060310552,
					-7.609819530155368
				],
				[
					17.29504438671662,
					-8.301621305623996
				],
				[
					19.370449713122504,
					-8.993423081092716
				],
				[
					21.445855039528574,
					-9.685224856561344
				],
				[
					22.1376568149972,
					-10.377026632029972
				],
				[
					24.213062141403267,
					-11.76063018296732
				],
				[
					26.288467467809152,
					-13.144233733904668
				],
				[
					27.672071018746593,
					-13.836035509373296
				],
				[
					29.74747634515266,
					-15.219639060310644
				],
				[
					31.822881671558545,
					-16.603242611247992
				],
				[
					33.898286997964426,
					-17.29504438671662
				],
				[
					35.28189054890187,
					-17.98684616218534
				],
				[
					35.9736923243705,
					-18.678647937653967
				],
				[
					38.74089942624519,
					-20.754053264059944
				],
				[
					40.12450297718245,
					-20.754053264059944
				],
				[
					42.199908303588515,
					-22.137656814997293
				],
				[
					42.89171007905715,
					-22.82945859046601
				],
				[
					42.89171007905715,
					-23.52126036593464
				],
				[
					43.58351185452596,
					-23.52126036593464
				],
				[
					44.275313629994585,
					-23.52126036593464
				],
				[
					44.96711540546321,
					-24.213062141403267
				],
				[
					45.658917180931844,
					-24.213062141403267
				],
				[
					46.35071895640047,
					-24.213062141403267
				],
				[
					47.0425207318691,
					-24.90486391687199
				],
				[
					48.426124282806356,
					-25.596665692340615
				],
				[
					48.426124282806356,
					-26.288467467809337
				],
				[
					49.11792605827517,
					-26.980269243277963
				],
				[
					50.501529609212604,
					-26.980269243277963
				],
				[
					52.57693493561849,
					-28.36387279421531
				],
				[
					53.96053848655575,
					-29.05567456968394
				],
				[
					55.344142037493,
					-29.74747634515266
				],
				[
					56.03594381296181,
					-30.43927812062129
				],
				[
					56.727745588430444,
					-30.43927812062129
				],
				[
					57.419547363899255,
					-31.131079896089915
				],
				[
					57.419547363899255,
					-30.43927812062129
				],
				[
					57.419547363899255,
					-30.43927812062129
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 674,
			"versionNonce": 1476721265,
			"isDeleted": false,
			"id": "mskbPm13jDU0G2uX9vJi3",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1905.1355858081827,
			"y": 23.305816479123052,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 7.609819530155276,
			"height": 10.37702663202988,
			"seed": 1493159763,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6918017754686279,
					0
				],
				[
					1.3836035509372557,
					0
				],
				[
					3.4590088773431398,
					0.6918017754686279
				],
				[
					4.150810652811767,
					0.6918017754686279
				],
				[
					5.534414203749208,
					0.6918017754686279
				],
				[
					6.918017754686648,
					1.3836035509372557
				],
				[
					7.609819530155276,
					1.3836035509372557
				],
				[
					7.609819530155276,
					2.075405326405976
				],
				[
					7.609819530155276,
					2.767207101874604
				],
				[
					6.918017754686648,
					3.4590088773432317
				],
				[
					6.918017754686648,
					4.84261242828058
				],
				[
					6.22621597921802,
					4.84261242828058
				],
				[
					6.22621597921802,
					5.5344142037493
				],
				[
					5.534414203749208,
					6.226215979217928
				],
				[
					4.84261242828058,
					7.609819530155276
				],
				[
					4.84261242828058,
					8.301621305623904
				],
				[
					4.84261242828058,
					8.993423081092624
				],
				[
					4.84261242828058,
					9.685224856561252
				],
				[
					4.84261242828058,
					10.37702663202988
				],
				[
					4.84261242828058,
					10.37702663202988
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 657,
			"versionNonce": 1387454751,
			"isDeleted": false,
			"id": "IHRkzu0S",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1869.1618934838118,
			"y": 106.32202953536279,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 7.6065521240234375,
			"height": 20.283882669783,
			"seed": 2046216915,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 16.2271061358264,
			"fontFamily": 1,
			"text": "y",
			"rawText": "y",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "y",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 656,
			"versionNonce": 255755345,
			"isDeleted": false,
			"id": "E3Pp4KgI",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1910.6700000119317,
			"y": 69.65653543552361,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 9.114883422851562,
			"height": 20.283882669783,
			"seed": 625822035,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 16.2271061358264,
			"fontFamily": 1,
			"text": "x",
			"rawText": "x",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "x",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 677,
			"versionNonce": 1830249791,
			"isDeleted": false,
			"id": "QeRqoI1h",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1893.374955625215,
			"y": 14.312393398030451,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 9.277069091796875,
			"height": 20.283882669783,
			"seed": 1607857693,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 16.2271061358264,
			"fontFamily": 1,
			"text": "z",
			"rawText": "z",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "z",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 357,
			"versionNonce": 510382641,
			"isDeleted": false,
			"id": "lhbz9OtCyyedjn9btwATd",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1394.1634492943867,
			"y": -120.45759504524054,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 32.99252099531418,
			"height": 21.745070656002497,
			"seed": 911927059,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.7498300226206993,
					0
				],
				[
					-1.4996600452413986,
					0
				],
				[
					-2.9993200904830246,
					0.7498300226207562
				],
				[
					-4.498980135724651,
					1.4996600452415692
				],
				[
					-5.998640180966049,
					2.9993200904831383
				],
				[
					-7.498300226207675,
					3.7491501131038945
				],
				[
					-9.74779029407,
					6.748470203586976
				],
				[
					-11.247450339311627,
					9.747790294070114
				],
				[
					-11.997280361932326,
					11.247450339311683
				],
				[
					-11.997280361932326,
					12.747110384553196
				],
				[
					-11.997280361932326,
					14.246770429794765
				],
				[
					-11.247450339311627,
					14.246770429794765
				],
				[
					-10.4976203166907,
					14.996600452415521
				],
				[
					-8.997960271449301,
					14.996600452415521
				],
				[
					-8.248130248828602,
					14.996600452415521
				],
				[
					-4.498980135724651,
					14.996600452415521
				],
				[
					2.999320090483252,
					14.246770429794765
				],
				[
					6.748470203587203,
					13.496940407174009
				],
				[
					8.248130248828602,
					12.747110384553196
				],
				[
					10.497620316690927,
					11.247450339311683
				],
				[
					11.247450339311854,
					11.247450339311683
				],
				[
					14.246770429794879,
					8.997960271449358
				],
				[
					15.746430475036505,
					8.248130248828545
				],
				[
					18.74575056551953,
					5.99864018096622
				],
				[
					19.49558058814023,
					5.99864018096622
				],
				[
					19.49558058814023,
					5.248810158345464
				],
				[
					20.245410610761155,
					4.498980135724651
				],
				[
					20.245410610761155,
					3.7491501131038945
				],
				[
					20.995240633381854,
					2.2494900678623253
				],
				[
					20.995240633381854,
					0
				],
				[
					20.995240633381854,
					-1.4996600452415692
				],
				[
					20.995240633381854,
					-3.7491501131038945
				],
				[
					20.995240633381854,
					-5.248810158345407
				],
				[
					19.49558058814023,
					-5.99864018096622
				],
				[
					18.74575056551953,
					-6.748470203586976
				],
				[
					17.246090520277903,
					-6.748470203586976
				],
				[
					16.496260497657204,
					-6.748470203586976
				],
				[
					14.246770429794879,
					-5.99864018096622
				],
				[
					11.247450339311854,
					-5.248810158345407
				],
				[
					8.248130248828602,
					-4.498980135724651
				],
				[
					5.998640180966277,
					-3.7491501131038945
				],
				[
					3.7491501131039513,
					-2.9993200904830815
				],
				[
					2.999320090483252,
					-2.2494900678623253
				],
				[
					2.2494900678623253,
					-2.2494900678623253
				],
				[
					1.499660045241626,
					-1.4996600452415692
				],
				[
					0.7498300226209267,
					0
				],
				[
					0,
					0
				],
				[
					0.7498300226209267,
					0.7498300226207562
				],
				[
					1.499660045241626,
					0.7498300226207562
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
			"version": 621,
			"versionNonce": 748053855,
			"isDeleted": false,
			"id": "GneNAQIGNc-zfYKGm9DZv",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1397.059949810356,
			"y": -117.14981623121588,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 18.74575056551953,
			"height": 14.996600452415521,
			"seed": 249478493,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.7498300226206993,
					0.749830022620813
				],
				[
					-2.2494900678623253,
					2.249490067862382
				],
				[
					-2.9993200904830246,
					2.249490067862382
				],
				[
					-3.7491501131039513,
					3.7491501131038945
				],
				[
					-4.498980135724651,
					5.248810158345464
				],
				[
					-4.498980135724651,
					5.99864018096622
				],
				[
					-3.7491501131039513,
					5.99864018096622
				],
				[
					-2.9993200904830246,
					5.99864018096622
				],
				[
					-2.2494900678623253,
					5.99864018096622
				],
				[
					-1.499660045241626,
					5.248810158345464
				],
				[
					0,
					5.248810158345464
				],
				[
					0.7498300226206993,
					4.4989801357247075
				],
				[
					1.499660045241626,
					4.4989801357247075
				],
				[
					1.499660045241626,
					3.7491501131038945
				],
				[
					2.2494900678623253,
					2.9993200904831383
				],
				[
					2.999320090483252,
					2.249490067862382
				],
				[
					2.999320090483252,
					1.4996600452415692
				],
				[
					2.2494900678623253,
					1.4996600452415692
				],
				[
					1.499660045241626,
					1.4996600452415692
				],
				[
					0.7498300226206993,
					2.249490067862382
				],
				[
					-0.7498300226206993,
					2.249490067862382
				],
				[
					-2.2494900678623253,
					2.249490067862382
				],
				[
					-2.2494900678623253,
					2.9993200904831383
				],
				[
					-2.9993200904830246,
					2.9993200904831383
				],
				[
					-3.7491501131039513,
					3.7491501131038945
				],
				[
					-3.7491501131039513,
					4.4989801357247075
				],
				[
					-4.498980135724651,
					5.248810158345464
				],
				[
					-4.498980135724651,
					5.99864018096622
				],
				[
					-4.498980135724651,
					7.498300226207789
				],
				[
					-4.498980135724651,
					8.248130248828602
				],
				[
					-4.498980135724651,
					8.997960271449358
				],
				[
					-2.9993200904830246,
					8.997960271449358
				],
				[
					-1.499660045241626,
					9.747790294070114
				],
				[
					0,
					9.747790294070114
				],
				[
					1.499660045241626,
					9.747790294070114
				],
				[
					3.7491501131039513,
					9.747790294070114
				],
				[
					6.748470203586976,
					9.747790294070114
				],
				[
					8.248130248828602,
					9.747790294070114
				],
				[
					8.997960271449301,
					9.747790294070114
				],
				[
					8.997960271449301,
					8.997960271449358
				],
				[
					8.997960271449301,
					8.248130248828602
				],
				[
					8.997960271449301,
					5.99864018096622
				],
				[
					8.997960271449301,
					4.4989801357247075
				],
				[
					8.997960271449301,
					3.7491501131038945
				],
				[
					8.248130248828602,
					2.9993200904831383
				],
				[
					5.998640180966277,
					2.9993200904831383
				],
				[
					4.498980135724651,
					2.249490067862382
				],
				[
					2.999320090483252,
					1.4996600452415692
				],
				[
					2.999320090483252,
					0.749830022620813
				],
				[
					2.2494900678623253,
					0.749830022620813
				],
				[
					1.499660045241626,
					0.749830022620813
				],
				[
					0,
					1.4996600452415692
				],
				[
					-0.7498300226206993,
					2.249490067862382
				],
				[
					-2.2494900678623253,
					2.249490067862382
				],
				[
					-3.7491501131039513,
					3.7491501131038945
				],
				[
					-4.498980135724651,
					5.248810158345464
				],
				[
					-4.498980135724651,
					5.99864018096622
				],
				[
					-4.498980135724651,
					7.498300226207789
				],
				[
					-4.498980135724651,
					8.248130248828602
				],
				[
					-4.498980135724651,
					8.997960271449358
				],
				[
					-2.9993200904830246,
					9.747790294070114
				],
				[
					-1.499660045241626,
					9.747790294070114
				],
				[
					-0.7498300226206993,
					9.747790294070114
				],
				[
					0,
					9.747790294070114
				],
				[
					1.499660045241626,
					8.997960271449358
				],
				[
					3.7491501131039513,
					7.498300226207789
				],
				[
					5.998640180966277,
					5.248810158345464
				],
				[
					7.498300226207903,
					3.7491501131038945
				],
				[
					7.498300226207903,
					2.9993200904831383
				],
				[
					7.498300226207903,
					2.249490067862382
				],
				[
					7.498300226207903,
					1.4996600452415692
				],
				[
					7.498300226207903,
					0.749830022620813
				],
				[
					5.998640180966277,
					0.749830022620813
				],
				[
					3.7491501131039513,
					1.4996600452415692
				],
				[
					0,
					2.9993200904831383
				],
				[
					-1.499660045241626,
					3.7491501131038945
				],
				[
					-2.2494900678623253,
					4.4989801357247075
				],
				[
					-2.9993200904830246,
					5.248810158345464
				],
				[
					-3.7491501131039513,
					5.99864018096622
				],
				[
					-3.7491501131039513,
					6.748470203587033
				],
				[
					-3.7491501131039513,
					7.498300226207789
				],
				[
					-2.2494900678623253,
					8.248130248828602
				],
				[
					-0.7498300226206993,
					8.997960271449358
				],
				[
					0.7498300226206993,
					8.997960271449358
				],
				[
					2.2494900678623253,
					8.997960271449358
				],
				[
					2.999320090483252,
					8.248130248828602
				],
				[
					4.498980135724651,
					8.248130248828602
				],
				[
					5.998640180966277,
					7.498300226207789
				],
				[
					8.248130248828602,
					5.99864018096622
				],
				[
					10.497620316690927,
					4.4989801357247075
				],
				[
					11.997280361932553,
					2.9993200904831383
				],
				[
					12.747110384553253,
					2.249490067862382
				],
				[
					12.747110384553253,
					1.4996600452415692
				],
				[
					11.997280361932553,
					1.4996600452415692
				],
				[
					11.247450339311627,
					1.4996600452415692
				],
				[
					10.497620316690927,
					1.4996600452415692
				],
				[
					8.997960271449301,
					1.4996600452415692
				],
				[
					6.748470203586976,
					1.4996600452415692
				],
				[
					4.498980135724651,
					1.4996600452415692
				],
				[
					1.499660045241626,
					2.9993200904831383
				],
				[
					-0.7498300226206993,
					3.7491501131038945
				],
				[
					-2.2494900678623253,
					4.4989801357247075
				],
				[
					-2.2494900678623253,
					5.248810158345464
				],
				[
					-2.9993200904830246,
					5.248810158345464
				],
				[
					-2.9993200904830246,
					5.99864018096622
				],
				[
					-2.9993200904830246,
					6.748470203587033
				],
				[
					-2.2494900678623253,
					7.498300226207789
				],
				[
					-0.7498300226206993,
					7.498300226207789
				],
				[
					0.7498300226206993,
					8.248130248828602
				],
				[
					2.2494900678623253,
					8.248130248828602
				],
				[
					3.7491501131039513,
					7.498300226207789
				],
				[
					5.998640180966277,
					6.748470203587033
				],
				[
					7.498300226207903,
					5.248810158345464
				],
				[
					8.248130248828602,
					3.7491501131038945
				],
				[
					8.248130248828602,
					2.249490067862382
				],
				[
					8.248130248828602,
					0.749830022620813
				],
				[
					7.498300226207903,
					0
				],
				[
					6.748470203586976,
					-0.7498300226207562
				],
				[
					5.998640180966277,
					-0.7498300226207562
				],
				[
					5.24881015834535,
					-0.7498300226207562
				],
				[
					4.498980135724651,
					-0.7498300226207562
				],
				[
					2.999320090483252,
					0
				],
				[
					1.499660045241626,
					0.749830022620813
				],
				[
					0,
					1.4996600452415692
				],
				[
					-0.7498300226206993,
					2.249490067862382
				],
				[
					-0.7498300226206993,
					3.7491501131038945
				],
				[
					-1.499660045241626,
					4.4989801357247075
				],
				[
					-1.499660045241626,
					5.248810158345464
				],
				[
					-1.499660045241626,
					5.99864018096622
				],
				[
					-0.7498300226206993,
					6.748470203587033
				],
				[
					0.7498300226206993,
					6.748470203587033
				],
				[
					3.7491501131039513,
					5.99864018096622
				],
				[
					5.24881015834535,
					4.4989801357247075
				],
				[
					5.998640180966277,
					2.9993200904831383
				],
				[
					5.998640180966277,
					2.249490067862382
				],
				[
					5.998640180966277,
					1.4996600452415692
				],
				[
					5.24881015834535,
					0.749830022620813
				],
				[
					4.498980135724651,
					0.749830022620813
				],
				[
					2.999320090483252,
					0.749830022620813
				],
				[
					2.2494900678623253,
					0.749830022620813
				],
				[
					0,
					1.4996600452415692
				],
				[
					-1.499660045241626,
					2.249490067862382
				],
				[
					-2.9993200904830246,
					2.9993200904831383
				],
				[
					-4.498980135724651,
					3.7491501131038945
				],
				[
					-5.24881015834535,
					4.4989801357247075
				],
				[
					-5.998640180966277,
					5.248810158345464
				],
				[
					-5.998640180966277,
					5.99864018096622
				],
				[
					-5.24881015834535,
					5.99864018096622
				],
				[
					-2.9993200904830246,
					7.498300226207789
				],
				[
					-0.7498300226206993,
					7.498300226207789
				],
				[
					0.7498300226206993,
					7.498300226207789
				],
				[
					1.499660045241626,
					7.498300226207789
				],
				[
					2.999320090483252,
					6.748470203587033
				],
				[
					4.498980135724651,
					5.248810158345464
				],
				[
					5.998640180966277,
					4.4989801357247075
				],
				[
					6.748470203586976,
					3.7491501131038945
				],
				[
					8.248130248828602,
					2.249490067862382
				],
				[
					8.997960271449301,
					0.749830022620813
				],
				[
					9.74779029407,
					0
				],
				[
					9.74779029407,
					-0.7498300226207562
				],
				[
					9.74779029407,
					-1.4996600452415123
				],
				[
					9.74779029407,
					-2.2494900678623253
				],
				[
					8.997960271449301,
					-2.9993200904830815
				],
				[
					8.248130248828602,
					-3.7491501131038376
				],
				[
					7.498300226207903,
					-4.498980135724651
				],
				[
					6.748470203586976,
					-5.248810158345407
				],
				[
					5.24881015834535,
					-5.248810158345407
				],
				[
					3.7491501131039513,
					-5.248810158345407
				],
				[
					2.2494900678623253,
					-5.248810158345407
				],
				[
					0.7498300226206993,
					-4.498980135724651
				],
				[
					-0.7498300226206993,
					-4.498980135724651
				],
				[
					-2.2494900678623253,
					-2.9993200904830815
				],
				[
					-2.9993200904830246,
					-2.9993200904830815
				],
				[
					-3.7491501131039513,
					-2.2494900678623253
				],
				[
					-4.498980135724651,
					-1.4996600452415123
				],
				[
					-4.498980135724651,
					-0.7498300226207562
				],
				[
					-5.24881015834535,
					-0.7498300226207562
				],
				[
					-5.24881015834535,
					0
				],
				[
					-5.24881015834535,
					1.4996600452415692
				],
				[
					-5.24881015834535,
					2.9993200904831383
				],
				[
					-4.498980135724651,
					4.4989801357247075
				],
				[
					-4.498980135724651,
					5.248810158345464
				],
				[
					-3.7491501131039513,
					5.99864018096622
				],
				[
					-2.9993200904830246,
					6.748470203587033
				],
				[
					-2.2494900678623253,
					6.748470203587033
				],
				[
					-0.7498300226206993,
					7.498300226207789
				],
				[
					0.7498300226206993,
					7.498300226207789
				],
				[
					2.2494900678623253,
					7.498300226207789
				],
				[
					2.999320090483252,
					7.498300226207789
				],
				[
					3.7491501131039513,
					6.748470203587033
				],
				[
					4.498980135724651,
					5.99864018096622
				],
				[
					4.498980135724651,
					5.248810158345464
				],
				[
					3.7491501131039513,
					3.7491501131038945
				],
				[
					3.7491501131039513,
					2.249490067862382
				],
				[
					3.7491501131039513,
					1.4996600452415692
				],
				[
					3.7491501131039513,
					0.749830022620813
				],
				[
					3.7491501131039513,
					0
				],
				[
					2.999320090483252,
					0
				],
				[
					2.2494900678623253,
					0
				],
				[
					1.499660045241626,
					0
				],
				[
					0.7498300226206993,
					0
				],
				[
					-0.7498300226206993,
					0
				],
				[
					-1.499660045241626,
					0
				],
				[
					-2.9993200904830246,
					0.749830022620813
				],
				[
					-3.7491501131039513,
					0.749830022620813
				],
				[
					-3.7491501131039513,
					1.4996600452415692
				],
				[
					-4.498980135724651,
					2.249490067862382
				],
				[
					-4.498980135724651,
					2.9993200904831383
				],
				[
					-4.498980135724651,
					3.7491501131038945
				],
				[
					-4.498980135724651,
					5.248810158345464
				],
				[
					-3.7491501131039513,
					5.99864018096622
				],
				[
					-2.9993200904830246,
					6.748470203587033
				],
				[
					-1.499660045241626,
					7.498300226207789
				],
				[
					0.7498300226206993,
					7.498300226207789
				],
				[
					2.2494900678623253,
					7.498300226207789
				],
				[
					3.7491501131039513,
					6.748470203587033
				],
				[
					4.498980135724651,
					6.748470203587033
				],
				[
					5.24881015834535,
					6.748470203587033
				],
				[
					5.998640180966277,
					5.99864018096622
				],
				[
					7.498300226207903,
					5.248810158345464
				],
				[
					8.997960271449301,
					3.7491501131038945
				],
				[
					9.74779029407,
					2.9993200904831383
				],
				[
					10.497620316690927,
					2.249490067862382
				],
				[
					10.497620316690927,
					1.4996600452415692
				],
				[
					10.497620316690927,
					0.749830022620813
				],
				[
					10.497620316690927,
					0
				],
				[
					9.74779029407,
					-0.7498300226207562
				],
				[
					8.997960271449301,
					-0.7498300226207562
				],
				[
					8.248130248828602,
					-1.4996600452415123
				],
				[
					7.498300226207903,
					-0.7498300226207562
				],
				[
					6.748470203586976,
					-0.7498300226207562
				],
				[
					5.998640180966277,
					-0.7498300226207562
				],
				[
					5.24881015834535,
					0
				],
				[
					4.498980135724651,
					0.749830022620813
				],
				[
					2.999320090483252,
					2.249490067862382
				],
				[
					2.2494900678623253,
					2.9993200904831383
				],
				[
					2.2494900678623253,
					3.7491501131038945
				],
				[
					2.2494900678623253,
					4.4989801357247075
				],
				[
					2.2494900678623253,
					5.248810158345464
				],
				[
					2.999320090483252,
					5.99864018096622
				],
				[
					3.7491501131039513,
					5.99864018096622
				],
				[
					5.24881015834535,
					5.99864018096622
				],
				[
					6.748470203586976,
					6.748470203587033
				],
				[
					8.997960271449301,
					6.748470203587033
				],
				[
					8.997960271449301,
					6.748470203587033
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 323,
			"versionNonce": 1517577233,
			"isDeleted": false,
			"id": "kXm119gb",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1335.7146096955826,
			"y": -132.91277558312186,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 31.259963989257812,
			"height": 25,
			"seed": 1495147549,
			"groupIds": [
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "eye",
			"rawText": "eye",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "eye",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 543,
			"versionNonce": 8413567,
			"isDeleted": false,
			"id": "RbDIiahp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1848.7771794553491,
			"y": -97.94968383698203,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 166.48123017325406,
			"height": 20.687016767090743,
			"seed": 72233,
			"groupIds": [
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "3b32af8c3a9a769e46496863bd1eb888aff55a36",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 140,
			"versionNonce": 256883185,
			"isDeleted": false,
			"id": "rNwE6voIbWGlyRUX3k4_e",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1848.9594987557034,
			"y": -105.25753058253133,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 23.80387029575013,
			"height": 9.521548118299961,
			"seed": 624891455,
			"groupIds": [
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.6801105798786011,
					0.6801105798785443
				],
				[
					1.3602211597572023,
					1.3602211597571454
				],
				[
					2.0403317396358034,
					2.0403317396356897
				],
				[
					2.0403317396358034,
					2.720442319514291
				],
				[
					2.7204423195144045,
					3.400552899392835
				],
				[
					3.4005528993930056,
					3.400552899392835
				],
				[
					5.440884639028582,
					4.080663479271436
				],
				[
					7.481216378664385,
					3.400552899392835
				],
				[
					8.84143753842136,
					3.400552899392835
				],
				[
					10.201658698178562,
					3.400552899392835
				],
				[
					10.881769278057163,
					3.400552899392835
				],
				[
					13.602211597571568,
					2.0403317396356897
				],
				[
					17.68287507684272,
					-1.3602211597571454
				],
				[
					21.763538556114327,
					-4.080663479271436
				],
				[
					23.80387029575013,
					-5.440884639028525
				],
				[
					23.12375971587153,
					-4.7607740591499805
				],
				[
					23.12375971587153,
					-4.7607740591499805
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 143,
			"versionNonce": 437639583,
			"isDeleted": false,
			"id": "BVYloIs6sZEeUp2i9sHw6",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1961.1777444356676,
			"y": -103.21719884289564,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 31.285086674413833,
			"height": 10.201658698178505,
			"seed": 56066577,
			"groupIds": [
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.6801105798786011
				],
				[
					0,
					1.3602211597571454
				],
				[
					0.6801105798786011,
					1.3602211597571454
				],
				[
					1.3602211597572023,
					2.720442319514291
				],
				[
					2.0403317396353486,
					3.400552899392892
				],
				[
					2.0403317396353486,
					4.080663479271436
				],
				[
					2.7204423195139498,
					4.7607740591499805
				],
				[
					3.400552899392551,
					4.7607740591499805
				],
				[
					4.080663479271152,
					4.7607740591499805
				],
				[
					5.440884639028354,
					4.7607740591499805
				],
				[
					13.602211597571113,
					3.400552899392892
				],
				[
					20.403317396357124,
					0
				],
				[
					23.803870295749675,
					-2.0403317396356897
				],
				[
					26.52431261526408,
					-3.400552899392835
				],
				[
					30.604976094535687,
					-5.440884639028525
				],
				[
					31.285086674413833,
					-5.440884639028525
				],
				[
					30.604976094535687,
					-5.440884639028525
				],
				[
					29.924865514657085,
					-5.440884639028525
				],
				[
					29.924865514657085,
					-4.7607740591499805
				],
				[
					29.924865514657085,
					-4.7607740591499805
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 164,
			"versionNonce": 503665617,
			"isDeleted": false,
			"id": "wjAXMiNp",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1846.6044980080624,
			"y": -79.101600786794,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 23.248046875,
			"height": 20,
			"seed": 1551213105,
			"groupIds": [
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "pnp",
			"rawText": "pnp",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "pnp",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 317,
			"versionNonce": 780619199,
			"isDeleted": false,
			"id": "3V9kGelt",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 2028.6684516156206,
			"y": -95.60652029506747,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 292.5976257324219,
			"height": 27.342839039692738,
			"seed": 380329343,
			"groupIds": [
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 10.937135615877095,
			"fontFamily": 1,
			"text": "先计算旋转, 再根据特征点的中心位置, 计算translate的x,y.\nz值可以根据3ddfa pose中获取, 或根据pnp获取后进行滤波",
			"rawText": "先计算旋转, 再根据特征点的中心位置, 计算translate的x,y.\nz值可以根据3ddfa pose中获取, 或根据pnp获取后进行滤波",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "先计算旋转, 再根据特征点的中心位置, 计算translate的x,y.\nz值可以根据3ddfa pose中获取, 或根据pnp获取后进行滤波",
			"lineHeight": 1.25,
			"baseline": 23
		},
		{
			"type": "image",
			"version": 162,
			"versionNonce": 1521267121,
			"isDeleted": false,
			"id": "DTvAUAYXCOPN-FBaYUvSN",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1334.2534582000917,
			"y": 235.98775766228914,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 731.5331807780318,
			"height": 350.5263157894736,
			"seed": 1074514943,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a1a6e7c992d4929cdac8abfdb56894e18c998357",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 268,
			"versionNonce": 2029338079,
			"isDeleted": false,
			"id": "DT06hYSK",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1353.2593061533105,
			"y": 590.0048516793836,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 467.88824462890625,
			"height": 40,
			"seed": 965168319,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "cv 中的相机, 与Graphics API中的相机都是右手坐标系\n但是, y,z轴朝向相反(像素坐标系y朝下, 而view/NDC坐标系y朝上).",
			"rawText": "cv 中的相机, 与Graphics API中的相机都是右手坐标系\n但是, y,z轴朝向相反(像素坐标系y朝下, 而view/NDC坐标系y朝上).",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "cv 中的相机, 与Graphics API中的相机都是右手坐标系\n但是, y,z轴朝向相反(像素坐标系y朝下, 而view/NDC坐标系y朝上).",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 138,
			"versionNonce": 711807889,
			"isDeleted": false,
			"id": "lVYurdes",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1353.2593061533105,
			"y": 641.3244208437793,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 774.192626953125,
			"height": 40,
			"seed": 1737685809,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991259025,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Blender中沿用了Graphics API的投影矩阵, 所以在求解出pnp的transform矩阵之后, 在乘以X轴的180度旋转.\n对应于blender 中的相机朝向z轴负方向, up=+y",
			"rawText": "Blender中沿用了Graphics API的投影矩阵, 所以在求解出pnp的transform矩阵之后, 在乘以X轴的180度旋转.\n对应于blender 中的相机朝向z轴负方向, up=+y",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Blender中沿用了Graphics API的投影矩阵, 所以在求解出pnp的transform矩阵之后, 在乘以X轴的180度旋转.\n对应于blender 中的相机朝向z轴负方向, up=+y",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 158,
			"versionNonce": 48133233,
			"isDeleted": false,
			"id": "5XXPW42C",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -456.8643005663814,
			"y": 76.73474441889846,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 406.256591796875,
			"height": 40,
			"seed": 702868127,
			"groupIds": [],
			"roundness": null,
			"boundElements": null,
			"updated": 1688991266802,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "在ffhq-uv/hifi3d中对y值进行了flip, 所以camera matrix\n理论上应该需要对f_y --> -f_y, c_y --> h-c_y",
			"rawText": "在ffhq-uv/hifi3d中对y值进行了flip, 所以camera matrix\n理论上应该需要对f_y --> -f_y, c_y --> h-c_y",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "在ffhq-uv/hifi3d中对y值进行了flip, 所以camera matrix\n理论上应该需要对f_y --> -f_y, c_y --> h-c_y",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 200,
			"versionNonce": 1493134417,
			"isDeleted": false,
			"id": "YfjNyzTL",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1355.309525682047,
			"y": 731.9515242424784,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 970.2886962890625,
			"height": 20,
			"seed": 729846431,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1688991475607,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "为了简化, 可以对cv相机绕着x轴旋转180度, 从而沿用ffhq-uv中的camera_k, 从而省去pnp求解的transform需要绕x轴180度旋转的操作.",
			"rawText": "为了简化, 可以对cv相机绕着x轴旋转180度, 从而沿用ffhq-uv中的camera_k, 从而省去pnp求解的transform需要绕x轴180度旋转的操作.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "为了简化, 可以对cv相机绕着x轴旋转180度, 从而沿用ffhq-uv中的camera_k, 从而省去pnp求解的transform需要绕x轴180度旋转的操作.",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"id": "5uhFoz6Rjo624IOc31BL0",
			"type": "freedraw",
			"x": 1328.9335906086226,
			"y": 723.7566696728358,
			"width": 56.72513483476814,
			"height": 95.25541509989387,
			"angle": 0,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 566558047,
			"version": 76,
			"versionNonce": 835034481,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688991492124,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					1.0702855629201622
				],
				[
					-2.1405711258403244,
					1.0702855629201622
				],
				[
					-7.491998940441135,
					6.4217133775208595
				],
				[
					-17.12456900672214,
					11.77314119212167
				],
				[
					-28.897710198843924,
					19.265140132562692
				],
				[
					-36.38970913928506,
					23.54628238424334
				],
				[
					-38.530280265125384,
					25.686853510083665
				],
				[
					-39.600565828045546,
					26.757139073003827
				],
				[
					-39.600565828045546,
					27.82742463592399
				],
				[
					-37.45999470220522,
					29.967995761764314
				],
				[
					-33.17885245052457,
					34.24913801344496
				],
				[
					-20.335425695482627,
					39.60056582804566
				],
				[
					-6.421713377520973,
					42.81142251680615
				],
				[
					1.0702855629201622,
					43.88170807972631
				],
				[
					2.1405711258403244,
					43.88170807972631
				],
				[
					5.351427814600811,
					40.67085139096582
				],
				[
					9.63257006628146,
					38.5302802651255
				],
				[
					13.913712317962109,
					29.967995761764314
				],
				[
					11.773141192121784,
					18.194854569642644
				],
				[
					6.421713377520973,
					6.4217133775208595
				],
				[
					0,
					0
				],
				[
					-14.983997880881816,
					-16.054283443802433
				],
				[
					-22.47599682132295,
					-22.475996821323292
				],
				[
					-26.7571390730036,
					-27.827424635924103
				],
				[
					-26.7571390730036,
					-28.897710198844266
				],
				[
					-26.7571390730036,
					-27.827424635924103
				],
				[
					-27.827424635923762,
					-23.546282384243455
				],
				[
					-27.827424635923762,
					-17.12456900672248
				],
				[
					-27.827424635923762,
					-7.491998940441135
				],
				[
					-27.827424635923762,
					5.351427814600697
				],
				[
					-27.827424635923762,
					17.12456900672248
				],
				[
					-27.827424635923762,
					26.757139073003827
				],
				[
					-27.827424635923762,
					36.38970913928517
				],
				[
					-27.827424635923762,
					43.88170807972631
				],
				[
					-27.827424635923762,
					49.23313589432712
				],
				[
					-27.827424635923762,
					54.58456370892782
				],
				[
					-27.827424635923762,
					58.865705960608466
				],
				[
					-26.7571390730036,
					64.21713377520928
				],
				[
					-25.686853510083438,
					66.3577049010496
				],
				[
					-24.616567947163276,
					66.3577049010496
				],
				[
					-22.47599682132295,
					66.3577049010496
				],
				[
					-18.194854569642303,
					64.21713377520928
				],
				[
					-12.843426755041492,
					58.865705960608466
				],
				[
					-4.281142251680649,
					51.373707020167444
				],
				[
					0,
					43.88170807972631
				],
				[
					4.281142251680649,
					34.24913801344496
				],
				[
					6.421713377520973,
					25.686853510083665
				],
				[
					7.491998940441135,
					14.983997880882157
				],
				[
					7.491998940441135,
					11.77314119212167
				],
				[
					9.63257006628146,
					6.4217133775208595
				],
				[
					9.63257006628146,
					3.210856688760373
				],
				[
					10.702855629201622,
					1.0702855629201622
				],
				[
					11.773141192121784,
					0
				],
				[
					12.843426755041946,
					-1.0702855629201622
				],
				[
					13.913712317962109,
					-2.1405711258403244
				],
				[
					14.98399788088227,
					-3.2108566887604866
				],
				[
					14.98399788088227,
					-5.351427814600811
				],
				[
					16.054283443802433,
					-7.491998940441135
				],
				[
					17.124569006722595,
					-12.843426755041946
				],
				[
					17.124569006722595,
					-13.913712317962109
				],
				[
					16.054283443802433,
					-13.913712317962109
				],
				[
					13.913712317962109,
					-13.913712317962109
				],
				[
					8.562284503361298,
					-11.773141192121784
				],
				[
					5.351427814600811,
					-10.702855629201622
				],
				[
					1.0702855629201622,
					-6.421713377520973
				],
				[
					-2.1405711258403244,
					-4.281142251680649
				],
				[
					-4.281142251680649,
					-2.1405711258403244
				],
				[
					-6.421713377520973,
					-1.0702855629201622
				],
				[
					-7.491998940441135,
					0
				],
				[
					-8.562284503360843,
					0
				],
				[
					-9.632570066281005,
					0
				],
				[
					-9.632570066281005,
					1.0702855629201622
				],
				[
					-13.913712317961654,
					4.281142251680535
				],
				[
					-13.913712317961654,
					4.281142251680535
				]
			],
			"pressures": [],
			"simulatePressure": true,
			"lastCommittedPoint": [
				-13.913712317961654,
				4.281142251680535
			]
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#e03131",
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
		"scrollX": 263.6513270165682,
		"scrollY": 198.94654804778247,
		"zoom": {
			"value": 0.9343300840867284
		},
		"currentItemRoundness": "sharp",
		"gridSize": null,
		"colorPalette": {},
		"currentStrokeOptions": null,
		"previousGridSize": null
	},
	"files": {}
}
```
%%