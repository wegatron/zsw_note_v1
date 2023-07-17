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

为了简化, 可以对cv相机绕着x轴旋转180度, 从而沿用ffhq-uv中的camera_k, pnp 求解得到的rt如下.
从而Graphics APIcamera应该设置为绿色标架, x,y,z均为负 ^YfjNyzTL

这里相机在坐标原点, 向着z轴正方向. 这个投影看到的是模型的背面. ^MR5w0bYg

f_c, T_e分别是什么?
smooth-factor求的是什么? ^KDH40Bij

f_c: cut off frequency
T_e: time between x_i, x_{i-1} ^FAimgahF

这样smooth的意义是什么? ^8EPSj2W2

定性地看: 
定义了若是要过滤到数据中高于f_c频率的信息后, 新的值该如何通过与上一时间点的值加权得到.
当f_c, T_e 变大时, X_i的比重变大.

定量地看: ^KApyM3I4

beta, f_Cmin调参方法:
beta=0, 取一个最大的f_Cmin使得所有高频信息均被滤除掉.
然后, 逐渐调大beta, 恢复部分高频信息, 直到融入噪声为止. ^MIdQJkLx

为了防止人脸边界重影, mask向外扩张太大.
mask还是以小幅度向外扩充, 但保证在polygon内部全部为1. 
使用距离场更精准地进行控制. ^GPAxlyeo

https://stackoverflow.com/questions/68178747/fast-2d-signed-distance
https://www.shadertoy.com/view/WdSGRd ^pggYjtIL

python版本(使用了类似距离场的设置, 且外扩较小): 特征点检测不准确, 导致mask估计变大 ^v9aBZtD0


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
42eba91b8e56930691b50284545929d060842082: [[Pasted Image 20230711181353_691.png]]
7b2270b394d2489abd6fe59bc06123562ab72724: [[Pasted Image 20230713105145_448.png]]
5b708b148d5ce4de7df2c401c4f0a2ddd2a1b901: [[Pasted Image 20230713105200_463.png]]
87194a552129f3e2f4058fd91cb37934dd8daf4d: [[Pasted Image 20230713135319_150.png]]
318654661a1532c33f83a2a3ba5083bfe3ee70be: [[Pasted Image 20230717105855_864.png]]

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
			"version": 329,
			"versionNonce": 734509771,
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
			"updated": 1689562689864,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 163,
			"versionNonce": 566127461,
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
			"updated": 1689562689864,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 118,
			"versionNonce": 809249131,
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
			"updated": 1689562689864,
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
			"version": 347,
			"versionNonce": 537245381,
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
			"updated": 1689562689864,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 139,
			"versionNonce": 359253003,
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
			"updated": 1689562689864,
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
			"version": 400,
			"versionNonce": 2024925483,
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
			"updated": 1689562769083,
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
			"version": 83,
			"versionNonce": 1128991403,
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
			"updated": 1689562689864,
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
			"version": 156,
			"versionNonce": 851478917,
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
			"updated": 1689562689864,
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
			"version": 72,
			"versionNonce": 1049263435,
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
			"updated": 1689562689864,
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
			"version": 130,
			"versionNonce": 593432805,
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
			"updated": 1689562689864,
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
			"version": 141,
			"versionNonce": 310549483,
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
			"updated": 1689562689864,
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
			"version": 72,
			"versionNonce": 1098230853,
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
			"updated": 1689562689864,
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
			"version": 72,
			"versionNonce": 2067654283,
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
			"updated": 1689562689864,
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
			"version": 72,
			"versionNonce": 1289870245,
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
			"updated": 1689562689865,
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
			"version": 71,
			"versionNonce": 1333189931,
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
			"updated": 1689562689865,
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
			"version": 72,
			"versionNonce": 768679685,
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
			"updated": 1689562689865,
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
			"version": 72,
			"versionNonce": 714604491,
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
			"updated": 1689562689865,
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
			"version": 770,
			"versionNonce": 1791030885,
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
			"updated": 1689562689865,
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
			"version": 458,
			"versionNonce": 1455148651,
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
			"updated": 1689562689865,
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
			"version": 361,
			"versionNonce": 1585373637,
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
			"updated": 1689562689865,
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
			"version": 339,
			"versionNonce": 1991035147,
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
			"updated": 1689562689865,
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
			"version": 531,
			"versionNonce": 774398245,
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
			"updated": 1689562689865,
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
			"version": 66,
			"versionNonce": 1877307307,
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
			"updated": 1689562689865,
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
			"version": 199,
			"versionNonce": 2133521541,
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
			"updated": 1689562689865,
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
			"version": 59,
			"versionNonce": 344998475,
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
			"updated": 1689562689865,
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
			"version": 141,
			"versionNonce": 1833180133,
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
			"updated": 1689562689865,
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
			"version": 123,
			"versionNonce": 227000555,
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
			"updated": 1689562689865,
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
			"version": 818,
			"versionNonce": 1082218309,
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
			"updated": 1689562689865,
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
			"version": 649,
			"versionNonce": 72772491,
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
			"updated": 1689562689865,
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
			"version": 423,
			"versionNonce": 1665148581,
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
			"updated": 1689562689865,
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
			"version": 353,
			"versionNonce": 221692459,
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
			"updated": 1689562689865,
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
			"version": 277,
			"versionNonce": 405670405,
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
			"updated": 1689562689865,
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
			"version": 305,
			"versionNonce": 1360217291,
			"isDeleted": false,
			"id": "NRVCGirepK-X4810fxKz3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2629.94442865084,
			"y": -519.6458620847403,
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
			"updated": 1689562689865,
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
			"version": 406,
			"versionNonce": 1883799909,
			"isDeleted": false,
			"id": "AWmaV5p7ePJGQ8-kK63Mp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2527.489488522329,
			"y": -113.14091963096826,
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
			"updated": 1689562689865,
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
			"version": 506,
			"versionNonce": 2005300075,
			"isDeleted": false,
			"id": "M1-kcMqILnKa3kOqlrOco",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2530.339714241012,
			"y": -219.5493464618171,
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
			"updated": 1689562689865,
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
			"version": 333,
			"versionNonce": 14486725,
			"isDeleted": false,
			"id": "aJyrMT4oSR4X0qUhQjr-p",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2005.8981820032568,
			"y": -106.4903929540402,
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
			"updated": 1689562689865,
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
			"version": 289,
			"versionNonce": 1356516875,
			"isDeleted": false,
			"id": "LhRLZB19rYho0YDkDrWRB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2523.689187564084,
			"y": -223.34964742006184,
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
			"updated": 1689562689865,
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
			"version": 298,
			"versionNonce": 1502161957,
			"isDeleted": false,
			"id": "xvv8887jlsfJyLVGB3koT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2007.798332482379,
			"y": -218.5992712222561,
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
			"updated": 1689562689865,
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
			"version": 299,
			"versionNonce": 1074451627,
			"isDeleted": false,
			"id": "Eq5boNLW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2536.040165678379,
			"y": -250.90182936733527,
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
			"updated": 1689562689865,
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
			"version": 296,
			"versionNonce": 976904069,
			"isDeleted": false,
			"id": "4X6ZqQpc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2003.047956284573,
			"y": -246.15145316952942,
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
			"updated": 1689562689865,
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
			"version": 275,
			"versionNonce": 1690371915,
			"isDeleted": false,
			"id": "ow1B7hnZ6igWd03bVHCxG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2530.339714241012,
			"y": -200.54784167059427,
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
			"updated": 1689562689865,
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
			"version": 272,
			"versionNonce": 154019557,
			"isDeleted": false,
			"id": "uObNPPvDY-u0Zb2efvPHW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2534.1400151992566,
			"y": -94.13941483974531,
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
			"updated": 1689562689865,
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
			"version": 273,
			"versionNonce": 89646571,
			"isDeleted": false,
			"id": "ewWWSY5NhdFVdqoxDjmsk",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2496.1370056168107,
			"y": -47.58572810124883,
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
			"updated": 1689562689865,
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
			"version": 278,
			"versionNonce": 150078021,
			"isDeleted": false,
			"id": "mZowLpuTmTMyTIAh_ND_L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2012.548708680185,
			"y": -197.69761595191073,
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
			"updated": 1689562689865,
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
			"version": 275,
			"versionNonce": 953806987,
			"isDeleted": false,
			"id": "D97UH71ohu-wro7X5_tqr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2020.1493105966738,
			"y": -90.33911388150068,
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
			"updated": 1689562689865,
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
			"version": 271,
			"versionNonce": 1315140005,
			"isDeleted": false,
			"id": "xNzVks82QOFxuHajT_45A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2071.453373532976,
			"y": -52.33610429905468,
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
			"updated": 1689562689865,
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
			"version": 611,
			"versionNonce": 1359062827,
			"isDeleted": false,
			"id": "vBDNSNjp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2622.586492690782,
			"y": 57.10916128690258,
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
			"updated": 1689562689865,
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
			"version": 988,
			"versionNonce": 1991243013,
			"isDeleted": false,
			"id": "weE5JWkboymUeqZa4mdJI",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2563.609990980135,
			"y": -277.3249787661596,
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
			"updated": 1689562689865,
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
			"version": 315,
			"versionNonce": 70879691,
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
			"updated": 1689562689865,
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
			"version": 163,
			"versionNonce": 492112997,
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
			"updated": 1689562689865,
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
			"version": 262,
			"versionNonce": 1469847659,
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
			"updated": 1689562689865,
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
			"version": 457,
			"versionNonce": 304101317,
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
			"updated": 1689562689865,
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
			"version": 155,
			"versionNonce": 1223938827,
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
			"updated": 1689562689865,
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
			"version": 263,
			"versionNonce": 1328477989,
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
			"updated": 1689562689865,
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
			"version": 429,
			"versionNonce": 951794091,
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
			"updated": 1689562689865,
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
			"version": 436,
			"versionNonce": 787401349,
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
			"updated": 1689562689865,
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
			"version": 155,
			"versionNonce": 337431627,
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
			"updated": 1689562689865,
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
			"version": 290,
			"versionNonce": 1646080485,
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
			"updated": 1689562689865,
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
			"version": 211,
			"versionNonce": 1056115435,
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
			"updated": 1689562689865,
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
			"version": 291,
			"versionNonce": 633843013,
			"isDeleted": false,
			"id": "cwuHEIqre43cjBiXeIO56",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -3284.1593280322327,
			"y": -488.6976213128884,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 643.6210008502928,
			"height": 535.5127858637202,
			"seed": 1842728702,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689865,
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
			"version": 72,
			"versionNonce": 1036547467,
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
			"updated": 1689562689865,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 157,
			"versionNonce": 961264805,
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
			"updated": 1689562689865,
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
			"version": 222,
			"versionNonce": 534219819,
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
			"updated": 1689562689865,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 304,
			"versionNonce": 341237765,
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
			"updated": 1689562689865,
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
			"version": 177,
			"versionNonce": 688574155,
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
			"updated": 1689562689865,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 49,
			"versionNonce": 1558615909,
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
			"updated": 1689562689865,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 82,
			"versionNonce": 1006419307,
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
			"updated": 1689562689866,
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
			"version": 148,
			"versionNonce": 491283141,
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
			"updated": 1689562689866,
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
			"version": 845,
			"versionNonce": 2092127499,
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
			"updated": 1689562769085,
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
			"version": 345,
			"versionNonce": 221936555,
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
			"updated": 1689562769087,
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
			"version": 127,
			"versionNonce": 1593220779,
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
			"updated": 1689562689866,
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
			"version": 474,
			"versionNonce": 675820933,
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
			"updated": 1689562689866,
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
			"version": 797,
			"versionNonce": 128160075,
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
			"updated": 1689562689866,
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
			"version": 64,
			"versionNonce": 1662074085,
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
			"updated": 1689562689866,
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
			"version": 153,
			"versionNonce": 2136551403,
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
			"updated": 1689562689866,
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
			"version": 340,
			"versionNonce": 570579013,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 292,
			"versionNonce": 941750923,
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
			"updated": 1689562689866,
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
			"version": 217,
			"versionNonce": 1324943269,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 230,
			"versionNonce": 2126016811,
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
			"updated": 1689562689866,
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
			"version": 196,
			"versionNonce": 1008913157,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 211,
			"versionNonce": 612832203,
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
			"updated": 1689562689866,
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
			"version": 159,
			"versionNonce": 436019813,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 164,
			"versionNonce": 1772642923,
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
			"updated": 1689562689866,
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
			"version": 229,
			"versionNonce": 760581573,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 271,
			"versionNonce": 652664075,
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
			"updated": 1689562689866,
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
			"version": 301,
			"versionNonce": 1162448165,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 531,
			"versionNonce": 935134123,
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
			"updated": 1689562689866,
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
			"version": 227,
			"versionNonce": 1900454021,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 414,
			"versionNonce": 609572427,
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
			"updated": 1689562689866,
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
			"version": 63,
			"versionNonce": 1997162469,
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
			"updated": 1689562689866,
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
			"version": 66,
			"versionNonce": 193615083,
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
			"updated": 1689562689866,
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
			"version": 62,
			"versionNonce": 144835397,
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
			"updated": 1689562689866,
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
			"version": 230,
			"versionNonce": 1101385259,
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
			"updated": 1689562769094,
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
			"version": 225,
			"versionNonce": 1002492107,
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
			"updated": 1689562769094,
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
			"version": 226,
			"versionNonce": 1285717867,
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
			"updated": 1689562769094,
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
			"version": 266,
			"versionNonce": 609730757,
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
			"updated": 1689562769095,
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
			"version": 271,
			"versionNonce": 1538152651,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 356,
			"versionNonce": 1066970469,
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
			"updated": 1689562689866,
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
			"version": 333,
			"versionNonce": 631179115,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 215,
			"versionNonce": 1296545989,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 249,
			"versionNonce": 1455481355,
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
			"updated": 1689562689866,
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
			"version": 946,
			"versionNonce": 496505733,
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
			"updated": 1689562769098,
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
			"version": 125,
			"versionNonce": 1208903851,
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
			"updated": 1689562689866,
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
			"version": 486,
			"versionNonce": 1424624517,
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
			"updated": 1689562689866,
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
			"version": 156,
			"versionNonce": 1328683851,
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
			"updated": 1689562689866,
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
			"version": 86,
			"versionNonce": 151540453,
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
			"updated": 1689562689866,
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
			"version": 56,
			"versionNonce": 679901675,
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
			"updated": 1689562689866,
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
			"version": 29,
			"versionNonce": 1688645189,
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
			"updated": 1689562689866,
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
			"version": 833,
			"versionNonce": 555091083,
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
			"updated": 1689562689866,
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
			"version": 1142,
			"versionNonce": 648191397,
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
			"updated": 1689562689866,
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
			"version": 972,
			"versionNonce": 10173227,
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
			"updated": 1689562689866,
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
			"version": 862,
			"versionNonce": 1445568773,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1010,
			"versionNonce": 864067019,
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
			"updated": 1689562689866,
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
			"version": 864,
			"versionNonce": 951662693,
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
			"updated": 1689562689866,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1041,
			"versionNonce": 887139435,
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
			"updated": 1689562689866,
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
			"version": 2837,
			"versionNonce": 1332917829,
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
			"updated": 1689562769101,
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
			"version": 755,
			"versionNonce": 948299531,
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
			"updated": 1689562689866,
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
			"version": 712,
			"versionNonce": 1752703781,
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
			"updated": 1689562689866,
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
			"version": 700,
			"versionNonce": 350932395,
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
			"updated": 1689562689866,
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
			"version": 711,
			"versionNonce": 506623621,
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
			"updated": 1689562689866,
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
			"version": 693,
			"versionNonce": 1832509515,
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
			"updated": 1689562689867,
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
			"version": 690,
			"versionNonce": 67853797,
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
			"updated": 1689562689867,
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
			"version": 708,
			"versionNonce": 458071787,
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
			"updated": 1689562689867,
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
			"version": 704,
			"versionNonce": 1091590469,
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
			"updated": 1689562689867,
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
			"version": 681,
			"versionNonce": 1504741771,
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
			"updated": 1689562689867,
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
			"version": 682,
			"versionNonce": 1050601637,
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
			"updated": 1689562689867,
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
			"version": 681,
			"versionNonce": 765272107,
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
			"updated": 1689562689867,
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
			"version": 698,
			"versionNonce": 1583647749,
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
			"updated": 1689562689867,
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
			"version": 703,
			"versionNonce": 285074123,
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
			"updated": 1689562689867,
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
			"version": 716,
			"versionNonce": 1885258597,
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
			"updated": 1689562689867,
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
			"version": 695,
			"versionNonce": 1550668139,
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
			"updated": 1689562689867,
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
			"version": 716,
			"versionNonce": 1759186629,
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
			"updated": 1689562689867,
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
			"version": 694,
			"versionNonce": 1899359243,
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
			"updated": 1689562689867,
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
			"version": 677,
			"versionNonce": 1450634789,
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
			"updated": 1689562689867,
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
			"version": 676,
			"versionNonce": 592589483,
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
			"updated": 1689562689867,
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
			"version": 697,
			"versionNonce": 404742533,
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
			"updated": 1689562689867,
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
			"version": 377,
			"versionNonce": 1668064587,
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
			"updated": 1689562689867,
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
			"version": 641,
			"versionNonce": 1393780965,
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
			"updated": 1689562689867,
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
			"version": 343,
			"versionNonce": 685753323,
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
			"updated": 1689562689867,
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
			"version": 563,
			"versionNonce": 685704261,
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
			"updated": 1689562689867,
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
			"version": 160,
			"versionNonce": 464916107,
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
			"updated": 1689562689867,
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
			"version": 163,
			"versionNonce": 761279397,
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
			"updated": 1689562689867,
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
			"version": 184,
			"versionNonce": 2125071659,
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
			"updated": 1689562689867,
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
			"version": 337,
			"versionNonce": 482637573,
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
			"updated": 1689562689867,
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
			"version": 182,
			"versionNonce": 1495672779,
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
			"updated": 1689562689867,
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
			"version": 288,
			"versionNonce": 1367952997,
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
			"updated": 1689562689867,
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
			"version": 158,
			"versionNonce": 1631909483,
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
			"updated": 1689562689867,
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
			"version": 178,
			"versionNonce": 2054961605,
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
			"boundElements": [],
			"updated": 1689562689867,
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
			"version": 318,
			"versionNonce": 634450187,
			"isDeleted": false,
			"id": "YfjNyzTL",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1355.309525682047,
			"y": 719.4206973045477,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 721.2325439453125,
			"height": 40,
			"seed": 729846431,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "为了简化, 可以对cv相机绕着x轴旋转180度, 从而沿用ffhq-uv中的camera_k, pnp 求解得到的rt如下.\n从而Graphics APIcamera应该设置为绿色标架, x,y,z均为负",
			"rawText": "为了简化, 可以对cv相机绕着x轴旋转180度, 从而沿用ffhq-uv中的camera_k, pnp 求解得到的rt如下.\n从而Graphics APIcamera应该设置为绿色标架, x,y,z均为负",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "为了简化, 可以对cv相机绕着x轴旋转180度, 从而沿用ffhq-uv中的camera_k, pnp 求解得到的rt如下.\n从而Graphics APIcamera应该设置为绿色标架, x,y,z均为负",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "freedraw",
			"version": 96,
			"versionNonce": 280672549,
			"isDeleted": false,
			"id": "5uhFoz6Rjo624IOc31BL0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1328.9335906086226,
			"y": 723.7566696728358,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 56.72513483476814,
			"height": 95.25541509989387,
			"seed": 566558047,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
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
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 90,
			"versionNonce": 2017761195,
			"isDeleted": false,
			"id": "Xj91OkX-npGN1vF6W9MmT",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1408.3200348979026,
			"y": 844.7383094622603,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 90.19529130712635,
			"height": 3.649520457513745,
			"seed": 231421846,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653589765,
					0
				],
				[
					1.5640801960771569,
					0
				],
				[
					4.1708805228727215,
					-0.5213600653589765
				],
				[
					11.991281503259415,
					-1.5640801960772706
				],
				[
					18.247602287568952,
					-2.0854402614363607
				],
				[
					25.02528313723724,
					-3.128160392154541
				],
				[
					29.196163660110187,
					-3.128160392154541
				],
				[
					32.32432405226473,
					-3.128160392154541
				],
				[
					35.4524844444195,
					-3.128160392154541
				],
				[
					38.05928477121506,
					-3.649520457513745
				],
				[
					39.623364967292446,
					-3.649520457513745
				],
				[
					41.70880522872881,
					-3.649520457513745
				],
				[
					43.794245490165395,
					-3.649520457513745
				],
				[
					46.40104581696096,
					-3.649520457513745
				],
				[
					52.136006535911065,
					-3.649520457513745
				],
				[
					55.78552699342481,
					-3.649520457513745
				],
				[
					58.91368738557958,
					-3.649520457513745
				],
				[
					62.04184777773412,
					-3.128160392154541
				],
				[
					64.64864810452968,
					-3.128160392154541
				],
				[
					66.73408836596627,
					-3.128160392154541
				],
				[
					69.86224875812081,
					-3.128160392154541
				],
				[
					72.46904908491638,
					-3.128160392154541
				],
				[
					75.07584941171194,
					-3.128160392154541
				],
				[
					81.85353026138046,
					-1.5640801960772706
				],
				[
					86.0244107842534,
					-1.0427201307181804
				],
				[
					87.06713091497159,
					-1.0427201307181804
				],
				[
					89.15257117640795,
					-0.5213600653589765
				],
				[
					90.19529130712635,
					-0.5213600653589765
				],
				[
					90.19529130712635,
					-0.5213600653589765
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 88,
			"versionNonce": 229788805,
			"isDeleted": false,
			"id": "STLxryvOa-_09LhcW0YlM",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1498.515326205029,
			"y": 838.481988677951,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 13.5553616993368,
			"height": 13.555361699336913,
			"seed": 2022519306,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653589765,
					0.5213600653592039
				],
				[
					1.042720130717953,
					1.0427201307181804
				],
				[
					2.0854402614363607,
					1.5640801960773842
				],
				[
					2.6068003267953372,
					2.0854402614364744
				],
				[
					3.128160392154541,
					3.1281603921547685
				],
				[
					3.6495204575135176,
					3.1281603921547685
				],
				[
					4.1708805228727215,
					3.1281603921547685
				],
				[
					4.692240588231925,
					3.1281603921547685
				],
				[
					5.213600653590902,
					3.649520457513745
				],
				[
					5.734960718950106,
					3.649520457513745
				],
				[
					5.213600653590902,
					3.649520457513745
				],
				[
					4.692240588231925,
					4.170880522872949
				],
				[
					3.6495204575135176,
					4.170880522872949
				],
				[
					2.0854402614363607,
					4.692240588232039
				],
				[
					0.5213600653589765,
					5.213600653591129
				],
				[
					-1.0427201307184077,
					6.25632078430931
				],
				[
					-2.6068003267955646,
					7.299040915027604
				],
				[
					-4.170880522872949,
					8.863121111104874
				],
				[
					-5.213600653591129,
					9.905841241823168
				],
				[
					-6.256320784309537,
					10.427201307182258
				],
				[
					-6.256320784309537,
					10.948561372541349
				],
				[
					-6.7776808496685135,
					11.469921437900439
				],
				[
					-7.299040915027717,
					11.991281503259643
				],
				[
					-7.299040915027717,
					12.512641568618733
				],
				[
					-7.820400980386694,
					13.555361699336913
				],
				[
					-7.299040915027717,
					13.555361699336913
				],
				[
					-7.299040915027717,
					13.555361699336913
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 68,
			"versionNonce": 382364235,
			"isDeleted": false,
			"id": "wg51alJD3hS61KsN4YdR_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1408.3200348979026,
			"y": 844.2169493969011,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 0.5213600653589765,
			"height": 78.72536986922569,
			"seed": 1983632982,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					-2.0854402614363607
				],
				[
					0,
					-3.128160392154541
				],
				[
					0,
					-5.734960718950106
				],
				[
					0,
					-9.905841241823055
				],
				[
					0,
					-11.991281503259415
				],
				[
					0,
					-14.076721764696003
				],
				[
					0,
					-15.119441895414184
				],
				[
					0,
					-16.683522091491568
				],
				[
					0,
					-18.76896235292793
				],
				[
					0,
					-20.854402614364403
				],
				[
					0,
					-22.418482810441674
				],
				[
					0,
					-24.503923071878148
				],
				[
					0,
					-26.06800326795542
				],
				[
					0,
					-28.153443529392007
				],
				[
					0,
					-30.238883790828368
				],
				[
					0,
					-32.32432405226484
				],
				[
					0,
					-34.93112437906041
				],
				[
					0,
					-35.97384450977859
				],
				[
					0,
					-38.58064483657415
				],
				[
					0,
					-41.187445163369716
				],
				[
					0,
					-43.27288542480619
				],
				[
					0,
					-45.879685751601755
				],
				[
					0,
					-47.965126013038116
				],
				[
					0,
					-49.5292062091155
				],
				[
					0,
					-51.614646470551975
				],
				[
					0,
					-53.178726666629245
				],
				[
					0,
					-54.74280686270663
				],
				[
					0.5213600653589765,
					-56.82824712414299
				],
				[
					0.5213600653589765,
					-58.91368738557958
				],
				[
					0.5213600653589765,
					-62.04184777773412
				],
				[
					0.5213600653589765,
					-64.12728803917071
				],
				[
					0.5213600653589765,
					-65.17000816988889
				],
				[
					0.5213600653589765,
					-66.21272830060707
				],
				[
					0.5213600653589765,
					-67.77680849668445
				],
				[
					0.5213600653589765,
					-68.81952862740263
				],
				[
					0.5213600653589765,
					-70.38360882348002
				],
				[
					0.5213600653589765,
					-71.94768901955729
				],
				[
					0.5213600653589765,
					-72.99040915027558
				],
				[
					0.5213600653589765,
					-74.03312928099376
				],
				[
					0.5213600653589765,
					-75.07584941171194
				],
				[
					0.5213600653589765,
					-75.59720947707115
				],
				[
					0,
					-76.63992960778933
				],
				[
					0,
					-77.68264973850751
				],
				[
					0,
					-78.20400980386671
				],
				[
					0,
					-78.72536986922569
				],
				[
					0,
					-78.72536986922569
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 32,
			"versionNonce": 1629516773,
			"isDeleted": false,
			"id": "qor_Y_jsvKsFBAFOsMxvS",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1408.3200348979026,
			"y": 765.4915795276754,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 11.469921437900439,
			"height": 13.5553616993368,
			"seed": 1550398550,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.5213600653592039,
					0.5213600653589765
				],
				[
					-1.5640801960773842,
					1.5640801960772706
				],
				[
					-3.6495204575139724,
					3.649520457513745
				],
				[
					-6.256320784309537,
					5.734960718950106
				],
				[
					-8.863121111105102,
					8.34176104574567
				],
				[
					-10.427201307182258,
					11.469921437900439
				],
				[
					-11.469921437900439,
					13.03400163397771
				],
				[
					-11.469921437900439,
					13.5553616993368
				],
				[
					-11.469921437900439,
					13.03400163397771
				],
				[
					-11.469921437900439,
					13.03400163397771
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 30,
			"versionNonce": 373090539,
			"isDeleted": false,
			"id": "koNlkV_4A2rxxYwSJccly",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1408.3200348979026,
			"y": 767.0556597237527,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 10.427201307182258,
			"height": 8.863121111104874,
			"seed": 1747418070,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653589765,
					0.5213600653590902
				],
				[
					3.128160392154541,
					2.0854402614364744
				],
				[
					7.29904091502749,
					4.692240588232039
				],
				[
					8.863121111104874,
					6.25632078430931
				],
				[
					9.905841241823055,
					7.820400980386694
				],
				[
					10.427201307182258,
					8.341761045745784
				],
				[
					10.427201307182258,
					8.863121111104874
				],
				[
					10.427201307182258,
					8.863121111104874
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 82,
			"versionNonce": 655535941,
			"isDeleted": false,
			"id": "5XeKY8B1Zus0_P-GYfaMs",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1421.8753965972394,
			"y": 763.927499331598,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 23.46120294116008,
			"height": 31.802963986905866,
			"seed": 1878315466,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653592039,
					0
				],
				[
					1.5640801960773842,
					-0.5213600653592039
				],
				[
					3.1281603921547685,
					-1.5640801960773842
				],
				[
					4.692240588232153,
					-2.0854402614364744
				],
				[
					6.7776808496685135,
					-2.6068003267955646
				],
				[
					8.863121111104874,
					-4.170880522872949
				],
				[
					10.427201307182258,
					-4.692240588232039
				],
				[
					10.948561372541235,
					-4.692240588232039
				],
				[
					10.427201307182258,
					-4.170880522872949
				],
				[
					9.905841241823055,
					-3.649520457513745
				],
				[
					9.384481176464078,
					-2.0854402614364744
				],
				[
					8.863121111104874,
					0
				],
				[
					8.863121111104874,
					2.0854402614363607
				],
				[
					8.863121111104874,
					3.128160392154655
				],
				[
					8.863121111104874,
					3.649520457513745
				],
				[
					9.905841241823055,
					3.128160392154655
				],
				[
					10.427201307182258,
					2.6068003267955646
				],
				[
					11.991281503259643,
					1.5640801960773842
				],
				[
					13.5553616993368,
					0.5213600653590902
				],
				[
					17.204882156850772,
					-2.0854402614364744
				],
				[
					19.290322418287133,
					-3.649520457513745
				],
				[
					18.76896235292793,
					-3.649520457513745
				],
				[
					17.72624222220975,
					-3.1281603921547685
				],
				[
					16.683522091491568,
					-3.1281603921547685
				],
				[
					15.640801960773388,
					-2.0854402614364744
				],
				[
					14.076721764696003,
					0
				],
				[
					13.034001633977823,
					2.6068003267955646
				],
				[
					10.427201307182258,
					7.820400980386694
				],
				[
					9.384481176464078,
					9.384481176463964
				],
				[
					7.820400980386694,
					11.469921437900439
				],
				[
					6.7776808496685135,
					14.076721764696003
				],
				[
					5.213600653591129,
					16.162162026132364
				],
				[
					4.170880522872949,
					18.247602287568952
				],
				[
					2.6068003267955646,
					20.333042549005313
				],
				[
					1.0427201307181804,
					22.418482810441787
				],
				[
					0,
					23.982563006519058
				],
				[
					-1.0427201307181804,
					25.546643202596442
				],
				[
					-1.5640801960773842,
					26.589363333314623
				],
				[
					-2.6068003267955646,
					26.589363333314623
				],
				[
					-3.128160392154541,
					27.110723398673827
				],
				[
					-3.649520457513745,
					26.589363333314623
				],
				[
					-4.170880522872949,
					26.068003267955532
				],
				[
					-4.170880522872949,
					24.503923071878262
				],
				[
					-4.170880522872949,
					21.897122745082697
				],
				[
					-4.170880522872949,
					20.333042549005313
				],
				[
					-4.170880522872949,
					19.290322418287133
				],
				[
					-3.649520457513745,
					18.247602287568952
				],
				[
					-2.6068003267955646,
					17.72624222220975
				],
				[
					-2.0854402614363607,
					17.20488215685066
				],
				[
					-1.0427201307181804,
					16.683522091491568
				],
				[
					0.5213600653592039,
					16.162162026132364
				],
				[
					2.085440261436588,
					15.119441895414184
				],
				[
					5.213600653591129,
					15.119441895414184
				],
				[
					7.820400980386694,
					15.119441895414184
				],
				[
					8.863121111104874,
					15.119441895414184
				],
				[
					9.384481176464078,
					15.119441895414184
				],
				[
					9.905841241823055,
					15.119441895414184
				],
				[
					9.384481176464078,
					15.119441895414184
				],
				[
					9.384481176464078,
					15.640801960773388
				],
				[
					8.863121111104874,
					15.640801960773388
				],
				[
					8.863121111104874,
					15.640801960773388
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 35,
			"versionNonce": 203854731,
			"isDeleted": false,
			"id": "uCtcEPlBaPmMQp73k9mdj",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1514.156128165802,
			"y": 848.9091899851333,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 11.469921437900439,
			"height": 17.204882156850545,
			"seed": 941453974,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.5213600653589765,
					0
				],
				[
					-1.5640801960773842,
					0.5213600653589765
				],
				[
					-2.0854402614363607,
					1.5640801960772706
				],
				[
					-3.128160392154541,
					2.6068003267955646
				],
				[
					-3.649520457513745,
					3.649520457513745
				],
				[
					-4.692240588231925,
					5.734960718950106
				],
				[
					-5.734960718950106,
					7.29904091502749
				],
				[
					-7.29904091502749,
					9.905841241823055
				],
				[
					-8.863121111104874,
					12.51264156861862
				],
				[
					-9.905841241823055,
					14.076721764696003
				],
				[
					-10.948561372541235,
					15.119441895414184
				],
				[
					-11.469921437900439,
					16.683522091491568
				],
				[
					-11.469921437900439,
					17.204882156850545
				],
				[
					-11.469921437900439,
					17.204882156850545
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 32,
			"versionNonce": 501644965,
			"isDeleted": false,
			"id": "C3AON1hEFJ76xXkr2Gupi",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1498.5153262050287,
			"y": 851.5159903119288,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 29.71752372546939,
			"height": 17.72624222220975,
			"seed": 2050030742,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					3.649520457513745,
					1.5640801960772706
				],
				[
					6.7776808496685135,
					3.649520457513745
				],
				[
					10.427201307182258,
					5.2136006535910155
				],
				[
					13.034001633977823,
					6.25632078430931
				],
				[
					18.768962352928156,
					8.863121111104874
				],
				[
					25.025283137237466,
					13.03400163397771
				],
				[
					27.63208346403303,
					14.59808183005498
				],
				[
					29.196163660110187,
					16.683522091491568
				],
				[
					29.71752372546939,
					17.204882156850545
				],
				[
					29.71752372546939,
					17.72624222220975
				],
				[
					29.71752372546939,
					17.72624222220975
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 66,
			"versionNonce": 2025974315,
			"isDeleted": false,
			"id": "DhsBY9TafeCvPkdSr959h",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1408.3200348979026,
			"y": 844.7383094622603,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 42.751525359447214,
			"height": 29.71752372546939,
			"seed": 1266638922,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.5213600653592039,
					0
				],
				[
					-0.5213600653592039,
					0.5213600653590902
				],
				[
					-1.5640801960773842,
					0.5213600653590902
				],
				[
					-2.6068003267955646,
					1.0427201307181804
				],
				[
					-3.1281603921547685,
					1.5640801960773842
				],
				[
					-4.170880522872949,
					2.0854402614363607
				],
				[
					-4.692240588232153,
					3.128160392154655
				],
				[
					-5.734960718950333,
					4.170880522872949
				],
				[
					-6.256320784309537,
					4.692240588231925
				],
				[
					-6.7776808496685135,
					5.734960718950219
				],
				[
					-7.820400980386694,
					6.25632078430931
				],
				[
					-8.341761045745898,
					6.7776808496685135
				],
				[
					-9.384481176464078,
					7.820400980386694
				],
				[
					-9.905841241823282,
					8.341761045745784
				],
				[
					-10.427201307182258,
					8.863121111104874
				],
				[
					-11.469921437900439,
					9.905841241823055
				],
				[
					-12.512641568618847,
					10.427201307182258
				],
				[
					-13.555361699337027,
					11.469921437900439
				],
				[
					-14.598081830055207,
					13.034001633977823
				],
				[
					-16.16216202613259,
					14.076721764696003
				],
				[
					-17.72624222220975,
					15.119441895414184
				],
				[
					-19.290322418287133,
					16.162162026132364
				],
				[
					-20.854402614364517,
					17.20488215685066
				],
				[
					-21.897122745082697,
					17.72624222220975
				],
				[
					-22.939842875800878,
					18.247602287568952
				],
				[
					-23.982563006519285,
					18.76896235292793
				],
				[
					-25.025283137237466,
					19.290322418287133
				],
				[
					-26.068003267955646,
					19.811682483646223
				],
				[
					-27.63208346403303,
					20.854402614364517
				],
				[
					-29.196163660110415,
					21.375762679723493
				],
				[
					-29.71752372546939,
					21.897122745082697
				],
				[
					-30.76024385618757,
					22.418482810441787
				],
				[
					-31.80296398690598,
					22.939842875800878
				],
				[
					-33.367044182983136,
					23.982563006519058
				],
				[
					-34.93112437906052,
					25.025283137237352
				],
				[
					-36.495204575137905,
					26.068003267955532
				],
				[
					-38.580644836574265,
					27.110723398673827
				],
				[
					-40.14472503265165,
					28.153443529392007
				],
				[
					-41.18744516336983,
					28.67480359475121
				],
				[
					-42.23016529408824,
					29.196163660110187
				],
				[
					-42.23016529408824,
					29.71752372546939
				],
				[
					-42.751525359447214,
					29.71752372546939
				],
				[
					-42.23016529408824,
					29.71752372546939
				],
				[
					-41.708805228729034,
					29.71752372546939
				],
				[
					-41.708805228729034,
					29.71752372546939
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 47,
			"versionNonce": 1548313093,
			"isDeleted": false,
			"id": "82pcJaIofB1CDMVP51dO8",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1368.175309865251,
			"y": 861.943191619111,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 27.110723398673827,
			"height": 13.555361699336913,
			"seed": 104608278,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0427201307181804,
					1.042720130718294
				],
				[
					-2.085440261436588,
					2.6068003267955646
				],
				[
					-3.649520457513745,
					4.692240588232039
				],
				[
					-5.213600653591129,
					7.820400980386694
				],
				[
					-6.7776808496685135,
					9.384481176463964
				],
				[
					-8.34176104574567,
					10.427201307182145
				],
				[
					-10.427201307182258,
					11.469921437900553
				],
				[
					-10.948561372541235,
					12.512641568618733
				],
				[
					-11.469921437900439,
					13.03400163397771
				],
				[
					-10.948561372541235,
					13.03400163397771
				],
				[
					-10.427201307182258,
					13.03400163397771
				],
				[
					-9.905841241823055,
					13.03400163397771
				],
				[
					-9.384481176464078,
					13.03400163397771
				],
				[
					-7.820400980386694,
					13.03400163397771
				],
				[
					-4.170880522872949,
					13.03400163397771
				],
				[
					-1.0427201307181804,
					13.03400163397771
				],
				[
					2.0854402614363607,
					12.512641568618733
				],
				[
					4.170880522872949,
					11.991281503259529
				],
				[
					6.7776808496685135,
					11.991281503259529
				],
				[
					9.905841241823055,
					11.991281503259529
				],
				[
					13.034001633977823,
					12.512641568618733
				],
				[
					15.119441895414184,
					13.03400163397771
				],
				[
					15.640801960773388,
					13.03400163397771
				],
				[
					15.640801960773388,
					13.555361699336913
				],
				[
					15.119441895414184,
					13.555361699336913
				],
				[
					15.119441895414184,
					13.555361699336913
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 48,
			"versionNonce": 1895394507,
			"isDeleted": false,
			"id": "zI75vxHHsDJnYbU-aPsrJ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1364.5257894077372,
			"y": 882.7975942334754,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 23.461202941159854,
			"height": 14.598081830055207,
			"seed": 1916646294,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653589765,
					0
				],
				[
					2.0854402614363607,
					0
				],
				[
					6.777680849668286,
					0
				],
				[
					10.427201307182258,
					0
				],
				[
					11.469921437900439,
					0
				],
				[
					11.991281503259415,
					0
				],
				[
					11.991281503259415,
					0.5213600653592039
				],
				[
					11.469921437900439,
					1.0427201307181804
				],
				[
					9.905841241823055,
					2.085440261436588
				],
				[
					6.777680849668286,
					3.1281603921547685
				],
				[
					-0.5213600653592039,
					6.7776808496685135
				],
				[
					-6.7776808496685135,
					10.948561372541462
				],
				[
					-7.820400980386694,
					11.991281503259643
				],
				[
					-8.863121111104874,
					13.034001633977823
				],
				[
					-8.341761045745898,
					13.034001633977823
				],
				[
					-7.820400980386694,
					13.034001633977823
				],
				[
					-6.25632078430931,
					13.034001633977823
				],
				[
					-2.085440261436588,
					13.555361699337027
				],
				[
					3.649520457513745,
					14.076721764696003
				],
				[
					5.213600653591129,
					14.076721764696003
				],
				[
					7.820400980386694,
					14.076721764696003
				],
				[
					9.905841241823055,
					14.598081830055207
				],
				[
					12.51264156861862,
					14.598081830055207
				],
				[
					13.5553616993368,
					14.598081830055207
				],
				[
					14.59808183005498,
					14.598081830055207
				],
				[
					14.076721764696003,
					14.598081830055207
				],
				[
					14.076721764696003,
					14.598081830055207
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 31,
			"versionNonce": 1194908005,
			"isDeleted": false,
			"id": "8Hu1Abxp5cNO95xbI0DOh",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1359.312188754146,
			"y": 887.4898348217075,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 13.5553616993368,
			"height": 1.0427201307181804,
			"seed": 1827930902,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0427201307181804,
					0.5213600653589765
				],
				[
					3.128160392154541,
					0.5213600653589765
				],
				[
					6.777680849668286,
					0.5213600653589765
				],
				[
					8.34176104574567,
					0.5213600653589765
				],
				[
					8.863121111104874,
					1.0427201307181804
				],
				[
					9.38448117646385,
					1.0427201307181804
				],
				[
					9.905841241823055,
					1.0427201307181804
				],
				[
					10.427201307182258,
					1.0427201307181804
				],
				[
					11.469921437900439,
					1.0427201307181804
				],
				[
					13.5553616993368,
					1.0427201307181804
				],
				[
					13.5553616993368,
					1.0427201307181804
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 29,
			"versionNonce": 141007723,
			"isDeleted": false,
			"id": "q05f1sw9pikVebg1kiDR0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1335.3296257476268,
			"y": 847.866469854415,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 13.034001633977823,
			"height": 0,
			"seed": 1294918090,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0427201307184077,
					0
				],
				[
					2.085440261436588,
					0
				],
				[
					3.6495204575139724,
					0
				],
				[
					5.213600653591129,
					0
				],
				[
					6.7776808496685135,
					0
				],
				[
					9.384481176464078,
					0
				],
				[
					11.469921437900666,
					0
				],
				[
					13.034001633977823,
					0
				],
				[
					13.034001633977823,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 27,
			"versionNonce": 1208116421,
			"isDeleted": false,
			"id": "EGOlyfxpDTn4s93kDNf9_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1355.6626682966323,
			"y": 848.9091899851333,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 9.905841241823055,
			"height": 1.042720130718294,
			"seed": 1850528278,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.0854402614363607,
					-0.5213600653592039
				],
				[
					3.649520457513745,
					-0.5213600653592039
				],
				[
					5.734960718950106,
					-1.042720130718294
				],
				[
					7.820400980386694,
					-1.042720130718294
				],
				[
					9.38448117646385,
					-1.042720130718294
				],
				[
					9.905841241823055,
					-1.042720130718294
				],
				[
					9.905841241823055,
					-1.042720130718294
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 26,
			"versionNonce": 2069296651,
			"isDeleted": false,
			"id": "HtdVWFyN57hpsOOZ3HzX0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1375.4743507802784,
			"y": 847.866469854415,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 11.469921437900439,
			"height": 0,
			"seed": 453053770,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					5.213600653591129,
					0
				],
				[
					6.25632078430931,
					0
				],
				[
					8.863121111104874,
					0
				],
				[
					10.948561372541462,
					0
				],
				[
					11.469921437900439,
					0
				],
				[
					11.469921437900439,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 28,
			"versionNonce": 1111720997,
			"isDeleted": false,
			"id": "CQdEtSfjBbkLNGfX9lhri",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1391.636512806411,
			"y": 847.3451097890559,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 9.905841241823055,
			"height": 0.5213600653592039,
			"seed": 1630738506,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.5640801960771569,
					0
				],
				[
					3.649520457513745,
					0
				],
				[
					5.734960718950106,
					-0.5213600653592039
				],
				[
					7.8204009803864665,
					-0.5213600653592039
				],
				[
					8.863121111104874,
					-0.5213600653592039
				],
				[
					9.38448117646385,
					-0.5213600653592039
				],
				[
					9.905841241823055,
					-0.5213600653592039
				],
				[
					9.905841241823055,
					-0.5213600653592039
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 27,
			"versionNonce": 415366315,
			"isDeleted": false,
			"id": "NG0VWg3sW0rnXnD29OfeY",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1411.4481952900571,
			"y": 845.7810295929785,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 1.0427201307181804,
			"height": 8.341761045745784,
			"seed": 1862838794,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.5213600653589765,
					2.6068003267955646
				],
				[
					-1.0427201307181804,
					3.1281603921547685
				],
				[
					-1.0427201307181804,
					5.213600653591129
				],
				[
					-1.0427201307181804,
					6.25632078430931
				],
				[
					-1.0427201307181804,
					7.820400980386694
				],
				[
					-1.0427201307181804,
					8.341761045745784
				],
				[
					-1.0427201307181804,
					8.341761045745784
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 24,
			"versionNonce": 1240053637,
			"isDeleted": false,
			"id": "oNjUW-jQoW1u61-duSZpq",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1408.3200348979026,
			"y": 857.7723110962381,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 0,
			"height": 1.0427201307181804,
			"seed": 652007574,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5213600653589765
				],
				[
					0,
					1.0427201307181804
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
			"version": 29,
			"versionNonce": 1817390923,
			"isDeleted": false,
			"id": "PCgnELdvsE1W2EshoA8Rf",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1409.8841150939797,
			"y": 876.541273449166,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 0.5213600653589765,
			"height": 9.905841241823055,
			"seed": 572151894,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5213600653592039
				],
				[
					0,
					1.0427201307181804
				],
				[
					-0.5213600653589765,
					2.6068003267955646
				],
				[
					-0.5213600653589765,
					4.170880522872949
				],
				[
					-0.5213600653589765,
					5.213600653591129
				],
				[
					-0.5213600653589765,
					7.820400980386694
				],
				[
					-0.5213600653589765,
					8.863121111104874
				],
				[
					0,
					9.905841241823055
				],
				[
					0,
					9.905841241823055
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 25,
			"versionNonce": 422739685,
			"isDeleted": false,
			"id": "3biloIFWcl-kGyW-G-TwB",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1408.8413949632616,
			"y": 895.8315958674532,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 0,
			"height": 5.734960718950333,
			"seed": 429078986,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					3.649520457513745
				],
				[
					0,
					4.170880522872949
				],
				[
					0,
					5.213600653591129
				],
				[
					0,
					5.734960718950333
				],
				[
					0,
					5.734960718950333
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 28,
			"versionNonce": 677711339,
			"isDeleted": false,
			"id": "8_OWQC9tTbmhVAO0qoIgp",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1407.7986748325434,
			"y": 917.7287186125359,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 0.5213600653592039,
			"height": 3.649520457513745,
			"seed": 349267862,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689867,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5213600653592039
				],
				[
					0,
					1.0427201307181804
				],
				[
					0,
					1.5640801960773842
				],
				[
					0,
					2.0854402614363607
				],
				[
					0,
					3.1281603921547685
				],
				[
					0.5213600653592039,
					3.649520457513745
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
			"version": 21,
			"versionNonce": 1185634885,
			"isDeleted": false,
			"id": "5p21sdb9K9wOViIA44QjY",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1370.2607501266873,
			"y": 906.7801572399947,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 0.0001,
			"height": 0.0001,
			"seed": 1624238550,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
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
			"type": "freedraw",
			"version": 41,
			"versionNonce": 1342314635,
			"isDeleted": false,
			"id": "_BL0z7k3u0UdvCv206hXz",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1355.6626682966323,
			"y": 911.4723978282266,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 30.76024385618757,
			"height": 0.5213600653592039,
			"seed": 1448568138,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					-0.5213600653592039
				],
				[
					1.0427201307181804,
					0
				],
				[
					2.0854402614363607,
					-0.5213600653592039
				],
				[
					4.170880522872949,
					0
				],
				[
					5.734960718950106,
					0
				],
				[
					6.777680849668286,
					0
				],
				[
					7.820400980386694,
					0
				],
				[
					10.427201307182031,
					0
				],
				[
					12.51264156861862,
					0
				],
				[
					15.119441895414184,
					0
				],
				[
					17.204882156850545,
					0
				],
				[
					18.247602287568725,
					0
				],
				[
					18.76896235292793,
					0
				],
				[
					19.290322418287133,
					0
				],
				[
					20.333042549005313,
					0
				],
				[
					21.375762679723493,
					0
				],
				[
					25.546643202596442,
					0
				],
				[
					30.238883790828368,
					0
				],
				[
					30.76024385618757,
					0
				],
				[
					30.238883790828368,
					0
				],
				[
					30.238883790828368,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 34,
			"versionNonce": 993118629,
			"isDeleted": false,
			"id": "ShaO9R4Rr5gOZhLNw335c",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1360.8762689502234,
			"y": 901.0451965210443,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 2.6068003267955646,
			"height": 8.341761045745898,
			"seed": 645860886,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5213600653592039
				],
				[
					-0.5213600653592039,
					1.0427201307181804
				],
				[
					-1.0427201307181804,
					1.5640801960773842
				],
				[
					-1.5640801960773842,
					2.6068003267955646
				],
				[
					-2.085440261436588,
					3.649520457513745
				],
				[
					-2.085440261436588,
					4.692240588231925
				],
				[
					-2.6068003267955646,
					5.213600653591129
				],
				[
					-2.6068003267955646,
					6.25632078430931
				],
				[
					-2.6068003267955646,
					6.7776808496685135
				],
				[
					-2.6068003267955646,
					7.29904091502749
				],
				[
					-2.6068003267955646,
					7.820400980386694
				],
				[
					-2.6068003267955646,
					8.341761045745898
				],
				[
					-2.6068003267955646,
					7.820400980386694
				],
				[
					-2.6068003267955646,
					7.820400980386694
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 49,
			"versionNonce": 551866155,
			"isDeleted": false,
			"id": "QSYXjDruYivsTf1Fgam0n",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1364.004429342378,
			"y": 901.0451965210443,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 26.068003267955646,
			"height": 8.863121111105102,
			"seed": 10426390,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0427201307181804,
					-0.5213600653592039
				],
				[
					2.0854402614363607,
					-0.5213600653592039
				],
				[
					3.1281603921547685,
					-0.5213600653592039
				],
				[
					4.692240588231925,
					-0.5213600653592039
				],
				[
					6.25632078430931,
					-0.5213600653592039
				],
				[
					7.29904091502749,
					-0.5213600653592039
				],
				[
					8.863121111104874,
					-0.5213600653592039
				],
				[
					9.905841241823055,
					0
				],
				[
					11.991281503259643,
					0
				],
				[
					13.555361699337027,
					0
				],
				[
					15.640801960773388,
					0
				],
				[
					18.247602287568952,
					0.5213600653592039
				],
				[
					19.290322418287133,
					0.5213600653592039
				],
				[
					20.333042549005313,
					0.5213600653592039
				],
				[
					21.37576267972372,
					0.5213600653592039
				],
				[
					22.4184828104419,
					0.5213600653592039
				],
				[
					23.46120294116008,
					0.5213600653592039
				],
				[
					23.982563006519285,
					0.5213600653592039
				],
				[
					24.503923071878262,
					0.5213600653592039
				],
				[
					25.546643202596442,
					1.0427201307181804
				],
				[
					26.068003267955646,
					1.0427201307181804
				],
				[
					26.068003267955646,
					1.5640801960773842
				],
				[
					25.546643202596442,
					2.6068003267955646
				],
				[
					25.546643202596442,
					4.692240588231925
				],
				[
					25.546643202596442,
					6.25632078430931
				],
				[
					25.546643202596442,
					7.29904091502749
				],
				[
					25.546643202596442,
					7.820400980386694
				],
				[
					25.546643202596442,
					8.341761045745898
				],
				[
					25.546643202596442,
					8.341761045745898
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 88,
			"versionNonce": 1743998213,
			"isDeleted": false,
			"id": "Lb70awliC7ocfyvlwTtHy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1371.3034702574055,
			"y": 911.9937578935858,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 21.375762679723493,
			"height": 18.76896235292793,
			"seed": 2101184906,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0427201307181804,
					0
				],
				[
					-1.0427201307181804,
					0.5213600653589765
				],
				[
					-2.0854402614363607,
					0.5213600653589765
				],
				[
					-2.6068003267955646,
					0.5213600653589765
				],
				[
					-3.128160392154541,
					1.0427201307181804
				],
				[
					-4.1708805228727215,
					1.5640801960771569
				],
				[
					-5.213600653591129,
					2.6068003267953372
				],
				[
					-5.734960718950106,
					3.128160392154541
				],
				[
					-5.734960718950106,
					3.649520457513745
				],
				[
					-6.25632078430931,
					4.692240588231925
				],
				[
					-7.29904091502749,
					5.213600653590902
				],
				[
					-7.8204009803864665,
					5.734960718950106
				],
				[
					-8.34176104574567,
					6.777680849668286
				],
				[
					-8.34176104574567,
					7.29904091502749
				],
				[
					-8.34176104574567,
					8.34176104574567
				],
				[
					-8.34176104574567,
					9.38448117646385
				],
				[
					-8.34176104574567,
					10.427201307182031
				],
				[
					-8.34176104574567,
					11.991281503259415
				],
				[
					-7.8204009803864665,
					13.5553616993368
				],
				[
					-7.29904091502749,
					14.59808183005498
				],
				[
					-6.777680849668286,
					15.64080196077316
				],
				[
					-5.734960718950106,
					16.68352209149134
				],
				[
					-4.692240588231925,
					17.204882156850545
				],
				[
					-2.6068003267955646,
					18.247602287568725
				],
				[
					-1.5640801960771569,
					18.247602287568725
				],
				[
					-0.5213600653589765,
					18.76896235292793
				],
				[
					0,
					18.247602287568725
				],
				[
					0.5213600653592039,
					18.247602287568725
				],
				[
					1.0427201307184077,
					18.247602287568725
				],
				[
					2.085440261436588,
					18.247602287568725
				],
				[
					3.1281603921547685,
					17.72624222220975
				],
				[
					4.692240588232153,
					16.68352209149134
				],
				[
					6.256320784309537,
					15.64080196077316
				],
				[
					7.820400980386694,
					14.59808183005498
				],
				[
					8.863121111105102,
					14.076721764696003
				],
				[
					9.384481176464078,
					13.034001633977596
				],
				[
					10.427201307182258,
					11.991281503259415
				],
				[
					10.948561372541462,
					10.948561372541235
				],
				[
					11.469921437900666,
					10.427201307182031
				],
				[
					11.991281503259643,
					8.863121111104874
				],
				[
					12.512641568618847,
					7.8204009803864665
				],
				[
					12.512641568618847,
					6.777680849668286
				],
				[
					13.034001633977823,
					5.213600653590902
				],
				[
					13.034001633977823,
					4.1708805228727215
				],
				[
					13.034001633977823,
					3.649520457513745
				],
				[
					12.512641568618847,
					3.128160392154541
				],
				[
					12.512641568618847,
					2.6068003267953372
				],
				[
					11.991281503259643,
					2.0854402614363607
				],
				[
					11.469921437900666,
					1.5640801960771569
				],
				[
					10.948561372541462,
					1.5640801960771569
				],
				[
					8.863121111105102,
					1.0427201307181804
				],
				[
					7.820400980386694,
					0.5213600653589765
				],
				[
					7.299040915027717,
					0.5213600653589765
				],
				[
					6.7776808496685135,
					0.5213600653589765
				],
				[
					6.256320784309537,
					0.5213600653589765
				],
				[
					5.734960718950333,
					0.5213600653589765
				],
				[
					5.213600653591129,
					0
				],
				[
					4.692240588232153,
					0
				],
				[
					3.6495204575139724,
					0
				],
				[
					2.6068003267955646,
					0
				],
				[
					1.5640801960773842,
					0
				],
				[
					1.0427201307184077,
					0
				],
				[
					0.5213600653592039,
					0
				],
				[
					0,
					0
				],
				[
					-0.5213600653589765,
					0
				],
				[
					-1.0427201307181804,
					0
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
			"version": 67,
			"versionNonce": 1031254475,
			"isDeleted": false,
			"id": "pr7JRcl3mI0iEjOXu8RDj",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1385.3801920221022,
			"y": 855.1655107694426,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 62.04184777773435,
			"height": 2.6068003267955646,
			"seed": 367315734,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.5213600653592039,
					0
				],
				[
					-1.5640801960773842,
					0
				],
				[
					-2.6068003267955646,
					0
				],
				[
					-3.6495204575139724,
					0
				],
				[
					-4.692240588232153,
					0
				],
				[
					-6.256320784309537,
					0
				],
				[
					-7.820400980386694,
					0
				],
				[
					-9.384481176464078,
					0
				],
				[
					-10.427201307182258,
					0
				],
				[
					-11.469921437900666,
					0
				],
				[
					-13.034001633977823,
					0
				],
				[
					-14.07672176469623,
					0
				],
				[
					-15.119441895414184,
					0
				],
				[
					-18.247602287568952,
					0
				],
				[
					-20.854402614364517,
					0
				],
				[
					-23.46120294116008,
					0
				],
				[
					-26.068003267955646,
					0
				],
				[
					-27.63208346403303,
					0
				],
				[
					-29.196163660110415,
					0
				],
				[
					-29.71752372546939,
					0
				],
				[
					-30.238883790828595,
					0
				],
				[
					-31.281603921546775,
					0
				],
				[
					-32.84568411762416,
					0
				],
				[
					-34.93112437906052,
					0
				],
				[
					-38.05928477121529,
					0
				],
				[
					-41.18744516336983,
					0
				],
				[
					-43.27288542480642,
					0
				],
				[
					-45.35832568624278,
					0
				],
				[
					-46.92240588232016,
					0
				],
				[
					-47.96512601303834,
					0
				],
				[
					-49.007846143756524,
					0
				],
				[
					-50.050566274474704,
					0
				],
				[
					-51.61464647055209,
					0
				],
				[
					-53.70008673198845,
					0
				],
				[
					-55.26416692806583,
					0
				],
				[
					-56.306887058784014,
					0.5213600653592039
				],
				[
					-57.34960718950242,
					0.5213600653592039
				],
				[
					-57.34960718950242,
					1.042720130718294
				],
				[
					-57.8709672548614,
					1.042720130718294
				],
				[
					-58.3923273202206,
					1.042720130718294
				],
				[
					-58.91368738557958,
					1.5640801960773842
				],
				[
					-59.43504745093878,
					1.5640801960773842
				],
				[
					-60.47776758165696,
					2.085440261436588
				],
				[
					-61.52048771237514,
					2.085440261436588
				],
				[
					-62.04184777773435,
					2.6068003267955646
				],
				[
					-62.04184777773435,
					2.085440261436588
				],
				[
					-62.04184777773435,
					2.085440261436588
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 41,
			"versionNonce": 1013802085,
			"isDeleted": false,
			"id": "-xhgYC4fhordOXpAw2arO",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1326.9878647018816,
			"y": 853.0800705080062,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 17.204882156850772,
			"height": 9.905841241823055,
			"seed": 1044339530,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.5213600653589765,
					0
				],
				[
					-1.0427201307181804,
					0
				],
				[
					-1.5640801960773842,
					0
				],
				[
					-2.6068003267955646,
					0
				],
				[
					-3.128160392154541,
					0.5213600653590902
				],
				[
					-4.692240588231925,
					1.5640801960773842
				],
				[
					-6.25632078430931,
					2.6068003267955646
				],
				[
					-7.820400980386694,
					3.649520457513745
				],
				[
					-8.863121111104874,
					4.170880522872949
				],
				[
					-9.384481176464078,
					4.692240588231925
				],
				[
					-8.863121111104874,
					4.692240588231925
				],
				[
					-8.34176104574567,
					4.692240588231925
				],
				[
					-7.820400980386694,
					5.213600653591129
				],
				[
					-5.734960718950106,
					6.25632078430931
				],
				[
					-3.128160392154541,
					7.820400980386694
				],
				[
					-1.5640801960773842,
					8.341761045745784
				],
				[
					0.5213600653592039,
					8.863121111104874
				],
				[
					3.1281603921547685,
					9.384481176464078
				],
				[
					6.25632078430931,
					9.384481176464078
				],
				[
					7.820400980386694,
					9.905841241823055
				],
				[
					7.820400980386694,
					9.905841241823055
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 42,
			"versionNonce": 383074411,
			"isDeleted": false,
			"id": "muenYONtrVmWMK8eOgt2Q",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1384.3374718913838,
			"y": 854.1227906387244,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 19.29032241828736,
			"height": 1.0427201307181804,
			"seed": 1548728342,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653592039,
					0
				],
				[
					1.0427201307184077,
					0
				],
				[
					1.5640801960773842,
					0
				],
				[
					2.085440261436588,
					0
				],
				[
					2.6068003267955646,
					0
				],
				[
					3.6495204575139724,
					0
				],
				[
					5.213600653591129,
					0
				],
				[
					6.7776808496685135,
					0
				],
				[
					7.820400980386694,
					0
				],
				[
					8.341761045745898,
					0
				],
				[
					8.863121111105102,
					0
				],
				[
					10.427201307182258,
					0
				],
				[
					11.469921437900666,
					0
				],
				[
					11.991281503259643,
					0
				],
				[
					13.034001633977823,
					0.5213600653592039
				],
				[
					15.640801960773388,
					1.0427201307181804
				],
				[
					16.683522091491795,
					1.0427201307181804
				],
				[
					17.204882156850772,
					1.0427201307181804
				],
				[
					18.247602287568952,
					1.0427201307181804
				],
				[
					18.768962352928156,
					1.0427201307181804
				],
				[
					19.29032241828736,
					1.0427201307181804
				],
				[
					19.29032241828736,
					1.0427201307181804
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 75,
			"versionNonce": 1550684101,
			"isDeleted": false,
			"id": "myMTEN1hiMktCqRARBOF4",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1403.6277943096711,
			"y": 855.1655107694426,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 4.692240588232153,
			"height": 68.29816856204366,
			"seed": 2002847510,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.5213600653592039,
					0
				],
				[
					-1.0427201307184077,
					0.5213600653592039
				],
				[
					-1.5640801960773842,
					2.6068003267955646
				],
				[
					-2.085440261436588,
					4.170880522872949
				],
				[
					-2.085440261436588,
					5.734960718950333
				],
				[
					-2.6068003267955646,
					7.299040915027717
				],
				[
					-2.6068003267955646,
					8.341761045745898
				],
				[
					-2.6068003267955646,
					9.905841241823168
				],
				[
					-2.6068003267955646,
					11.991281503259643
				],
				[
					-2.6068003267955646,
					13.555361699337027
				],
				[
					-2.6068003267955646,
					15.640801960773388
				],
				[
					-2.6068003267955646,
					17.204882156850772
				],
				[
					-2.6068003267955646,
					18.247602287568952
				],
				[
					-2.6068003267955646,
					20.333042549005427
				],
				[
					-2.085440261436588,
					22.4184828104419
				],
				[
					-2.085440261436588,
					23.982563006519285
				],
				[
					-2.085440261436588,
					25.546643202596556
				],
				[
					-2.085440261436588,
					26.589363333314736
				],
				[
					-2.6068003267955646,
					28.15344352939212
				],
				[
					-2.6068003267955646,
					29.1961636601103
				],
				[
					-2.6068003267955646,
					30.238883790828595
				],
				[
					-3.1281603921547685,
					31.802963986905866
				],
				[
					-3.1281603921547685,
					33.367044182983136
				],
				[
					-3.6495204575139724,
					35.452484444419724
				],
				[
					-3.6495204575139724,
					37.537924705856085
				],
				[
					-3.6495204575139724,
					39.10200490193347
				],
				[
					-3.6495204575139724,
					40.66608509801085
				],
				[
					-3.6495204575139724,
					42.230165294088124
				],
				[
					-4.170880522872949,
					43.794245490165395
				],
				[
					-4.170880522872949,
					44.83696562088369
				],
				[
					-4.170880522872949,
					45.87968575160187
				],
				[
					-4.170880522872949,
					46.92240588232016
				],
				[
					-4.170880522872949,
					48.486486078397434
				],
				[
					-4.170880522872949,
					49.007846143756524
				],
				[
					-4.170880522872949,
					50.050566274474704
				],
				[
					-4.692240588232153,
					51.093286405193
				],
				[
					-4.692240588232153,
					52.13600653591129
				],
				[
					-4.692240588232153,
					52.65736660127027
				],
				[
					-4.692240588232153,
					53.17872666662947
				],
				[
					-4.692240588232153,
					54.22144679734765
				],
				[
					-4.692240588232153,
					55.26416692806583
				],
				[
					-4.692240588232153,
					56.82824712414322
				],
				[
					-4.692240588232153,
					58.91368738557969
				],
				[
					-4.692240588232153,
					59.95640751629787
				],
				[
					-4.692240588232153,
					60.99912764701617
				],
				[
					-4.170880522872949,
					62.04184777773435
				],
				[
					-4.170880522872949,
					63.08456790845253
				],
				[
					-3.6495204575139724,
					64.12728803917071
				],
				[
					-3.6495204575139724,
					64.64864810452991
				],
				[
					-3.6495204575139724,
					65.170008169889
				],
				[
					-3.1281603921547685,
					66.2127283006073
				],
				[
					-2.6068003267955646,
					66.73408836596627
				],
				[
					-2.085440261436588,
					67.77680849668457
				],
				[
					-1.5640801960773842,
					68.29816856204366
				],
				[
					-1.5640801960773842,
					68.29816856204366
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 43,
			"versionNonce": 382204683,
			"isDeleted": false,
			"id": "ElYrVbo5jvm58ee-wm6dH",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1393.7219530678478,
			"y": 922.9423192661271,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 16.683522091491568,
			"height": 13.034001633977823,
			"seed": 992078410,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5213600653590902
				],
				[
					0.5213600653592039,
					1.042720130718294
				],
				[
					1.5640801960773842,
					2.6068003267955646
				],
				[
					1.5640801960773842,
					3.128160392154655
				],
				[
					2.085440261436588,
					3.128160392154655
				],
				[
					2.6068003267955646,
					2.6068003267955646
				],
				[
					3.649520457513745,
					2.6068003267955646
				],
				[
					4.170880522872949,
					2.6068003267955646
				],
				[
					4.692240588232153,
					2.6068003267955646
				],
				[
					6.25632078430931,
					2.0854402614364744
				],
				[
					7.820400980386694,
					1.5640801960772706
				],
				[
					8.863121111104874,
					0.5213600653590902
				],
				[
					9.905841241823282,
					-0.5213600653590902
				],
				[
					10.948561372541235,
					-2.0854402614364744
				],
				[
					11.991281503259643,
					-2.6068003267955646
				],
				[
					12.51264156861862,
					-3.6495204575138587
				],
				[
					14.076721764696003,
					-6.25632078430931
				],
				[
					15.640801960773388,
					-7.820400980386694
				],
				[
					16.162162026132364,
					-9.384481176463964
				],
				[
					16.683522091491568,
					-9.905841241823168
				],
				[
					16.162162026132364,
					-9.905841241823168
				],
				[
					16.162162026132364,
					-9.384481176463964
				],
				[
					16.162162026132364,
					-9.384481176463964
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 86,
			"versionNonce": 370233125,
			"isDeleted": false,
			"id": "kwAOSJwFF4MQL7vCf8rE-",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1407.2773147671846,
			"y": 930.7627202465138,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 20.33304254900554,
			"height": 31.281603921546548,
			"seed": 1072997974,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653592039,
					0
				],
				[
					1.5640801960773842,
					-0.5213600653590902
				],
				[
					2.6068003267955646,
					-0.5213600653590902
				],
				[
					3.6495204575139724,
					-0.5213600653590902
				],
				[
					4.692240588232153,
					-1.5640801960773842
				],
				[
					6.256320784309537,
					-2.6068003267955646
				],
				[
					7.299040915027717,
					-3.128160392154655
				],
				[
					6.7776808496685135,
					-2.6068003267955646
				],
				[
					6.7776808496685135,
					-1.5640801960773842
				],
				[
					6.7776808496685135,
					0
				],
				[
					6.7776808496685135,
					0.5213600653590902
				],
				[
					7.820400980386694,
					0
				],
				[
					8.863121111105102,
					-1.5640801960773842
				],
				[
					9.384481176464078,
					-2.0854402614364744
				],
				[
					10.427201307182258,
					-2.6068003267955646
				],
				[
					11.469921437900666,
					-3.6495204575138587
				],
				[
					14.07672176469623,
					-5.734960718950219
				],
				[
					15.640801960773388,
					-6.7776808496684
				],
				[
					16.683522091491795,
					-8.341761045745784
				],
				[
					17.204882156850772,
					-8.863121111104988
				],
				[
					17.726242222209976,
					-9.384481176463964
				],
				[
					17.204882156850772,
					-9.384481176463964
				],
				[
					16.683522091491795,
					-8.863121111104988
				],
				[
					15.640801960773388,
					-8.863121111104988
				],
				[
					14.598081830055207,
					-8.341761045745784
				],
				[
					13.034001633977823,
					-7.820400980386694
				],
				[
					11.469921437900666,
					-6.256320784309423
				],
				[
					9.905841241823282,
					-3.6495204575138587
				],
				[
					8.863121111105102,
					-1.5640801960773842
				],
				[
					7.820400980386694,
					0
				],
				[
					7.299040915027717,
					2.606800326795451
				],
				[
					6.256320784309537,
					6.25632078430931
				],
				[
					6.256320784309537,
					8.863121111104874
				],
				[
					6.256320784309537,
					10.427201307182145
				],
				[
					5.734960718950333,
					11.469921437900439
				],
				[
					5.213600653591129,
					13.03400163397771
				],
				[
					4.692240588232153,
					14.076721764696003
				],
				[
					4.170880522872949,
					15.640801960773274
				],
				[
					3.6495204575139724,
					17.20488215685066
				],
				[
					3.6495204575139724,
					18.24760228756884
				],
				[
					3.1281603921547685,
					18.768962352928042
				],
				[
					2.6068003267955646,
					19.811682483646223
				],
				[
					1.5640801960773842,
					20.854402614364403
				],
				[
					0.5213600653592039,
					21.375762679723607
				],
				[
					0.5213600653592039,
					21.897122745082584
				],
				[
					0.5213600653592039,
					21.375762679723607
				],
				[
					0,
					20.854402614364403
				],
				[
					-1.0427201307181804,
					20.333042549005313
				],
				[
					-2.0854402614363607,
					19.29032241828702
				],
				[
					-2.6068003267955646,
					18.768962352928042
				],
				[
					-2.6068003267955646,
					18.24760228756884
				],
				[
					-1.5640801960771569,
					17.20488215685066
				],
				[
					0.5213600653592039,
					16.683522091491568
				],
				[
					1.5640801960773842,
					16.162162026132478
				],
				[
					2.6068003267955646,
					15.640801960773274
				],
				[
					4.170880522872949,
					15.119441895414184
				],
				[
					4.692240588232153,
					15.119441895414184
				],
				[
					5.213600653591129,
					15.119441895414184
				],
				[
					6.7776808496685135,
					15.119441895414184
				],
				[
					9.384481176464078,
					14.598081830055094
				],
				[
					11.991281503259643,
					14.598081830055094
				],
				[
					13.555361699337027,
					14.598081830055094
				],
				[
					13.034001633977823,
					14.598081830055094
				],
				[
					13.034001633977823,
					15.119441895414184
				],
				[
					12.512641568618847,
					15.119441895414184
				],
				[
					12.512641568618847,
					15.119441895414184
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 34,
			"versionNonce": 164258219,
			"isDeleted": false,
			"id": "GH9BabhuqmF1VUeY2q51e",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1312.9111429371856,
			"y": 841.0887890047466,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 10.427201307182258,
			"height": 15.119441895414298,
			"seed": 853957398,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0427201307181804,
					0.5213600653592039
				],
				[
					-1.5640801960773842,
					0.5213600653592039
				],
				[
					-3.1281603921547685,
					0.5213600653592039
				],
				[
					-4.1708805228727215,
					1.042720130718294
				],
				[
					-5.213600653591129,
					2.085440261436588
				],
				[
					-7.820400980386694,
					5.213600653591129
				],
				[
					-8.863121111104874,
					7.820400980386694
				],
				[
					-9.38448117646385,
					9.384481176464078
				],
				[
					-9.905841241823055,
					10.427201307182258
				],
				[
					-10.427201307182258,
					11.991281503259643
				],
				[
					-10.427201307182258,
					12.512641568618733
				],
				[
					-10.427201307182258,
					13.034001633977823
				],
				[
					-9.905841241823055,
					14.598081830055207
				],
				[
					-9.905841241823055,
					15.119441895414298
				],
				[
					-9.38448117646385,
					15.119441895414298
				],
				[
					-9.38448117646385,
					15.119441895414298
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 34,
			"versionNonce": 398860933,
			"isDeleted": false,
			"id": "fZqWtqBiMT7VpzKtXNard",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1302.4839416300033,
			"y": 841.6101490701058,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 7.820400980386694,
			"height": 11.469921437900439,
			"seed": 1445483094,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653592039,
					0
				],
				[
					0.5213600653592039,
					0.5213600653590902
				],
				[
					1.5640801960773842,
					1.0427201307181804
				],
				[
					3.6495204575139724,
					2.6068003267955646
				],
				[
					4.692240588231925,
					3.128160392154655
				],
				[
					5.734960718950333,
					4.692240588231925
				],
				[
					6.256320784309537,
					5.734960718950219
				],
				[
					6.7776808496685135,
					6.7776808496684
				],
				[
					6.7776808496685135,
					7.29904091502749
				],
				[
					7.29904091502749,
					7.820400980386694
				],
				[
					7.29904091502749,
					8.341761045745784
				],
				[
					7.29904091502749,
					8.863121111104874
				],
				[
					7.29904091502749,
					10.427201307182258
				],
				[
					7.29904091502749,
					10.948561372541235
				],
				[
					7.820400980386694,
					11.469921437900439
				],
				[
					7.820400980386694,
					11.469921437900439
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 64,
			"versionNonce": 1225192523,
			"isDeleted": false,
			"id": "iHnQtUJlRi2cKPzIkIKjN",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1400.4996339175163,
			"y": 856.2082309001609,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 60.47776758165696,
			"height": 31.802963986905866,
			"seed": 1932927382,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-0.5213600653592039,
					0
				],
				[
					-1.0427201307181804,
					0.5213600653590902
				],
				[
					-2.0854402614363607,
					0.5213600653590902
				],
				[
					-3.1281603921547685,
					1.042720130718294
				],
				[
					-4.170880522872949,
					1.5640801960772706
				],
				[
					-5.213600653591129,
					2.0854402614364744
				],
				[
					-6.25632078430931,
					2.6068003267955646
				],
				[
					-6.7776808496685135,
					3.128160392154655
				],
				[
					-7.820400980386694,
					3.6495204575138587
				],
				[
					-8.863121111104874,
					4.692240588232039
				],
				[
					-10.427201307182258,
					5.734960718950219
				],
				[
					-11.991281503259643,
					6.7776808496684
				],
				[
					-14.076721764696003,
					7.299040915027604
				],
				[
					-16.16216202613259,
					8.341761045745784
				],
				[
					-17.72624222220975,
					8.863121111104874
				],
				[
					-19.290322418287133,
					9.905841241823168
				],
				[
					-21.37576267972372,
					10.948561372541349
				],
				[
					-23.46120294116008,
					11.991281503259529
				],
				[
					-26.58936333331485,
					13.555361699336913
				],
				[
					-29.71752372546939,
					15.119441895414298
				],
				[
					-33.367044182983136,
					16.683522091491568
				],
				[
					-34.40976431370132,
					16.683522091491568
				],
				[
					-36.495204575137905,
					17.726242222209862
				],
				[
					-38.580644836574265,
					18.24760228756884
				],
				[
					-39.10200490193347,
					18.768962352928042
				],
				[
					-42.23016529408801,
					20.333042549005427
				],
				[
					-44.3156055555246,
					21.375762679723607
				],
				[
					-46.40104581696096,
					22.418482810441787
				],
				[
					-46.92240588232016,
					22.93984287580099
				],
				[
					-47.44376594767914,
					22.93984287580099
				],
				[
					-47.96512601303834,
					22.93984287580099
				],
				[
					-48.48648607839732,
					23.461202941159968
				],
				[
					-50.050566274474704,
					24.503923071878262
				],
				[
					-51.093286405192885,
					25.025283137237352
				],
				[
					-52.13600653591129,
					26.068003267955532
				],
				[
					-53.70008673198845,
					27.110723398673827
				],
				[
					-54.74280686270686,
					27.632083464032917
				],
				[
					-56.306887058784014,
					28.674803594751097
				],
				[
					-57.8709672548614,
					29.717523725469277
				],
				[
					-59.43504745093878,
					30.23888379082848
				],
				[
					-59.956407516297986,
					30.76024385618757
				],
				[
					-60.47776758165696,
					31.28160392154666
				],
				[
					-59.956407516297986,
					31.28160392154666
				],
				[
					-59.43504745093878,
					31.28160392154666
				],
				[
					-58.91368738557958,
					31.802963986905866
				],
				[
					-58.91368738557958,
					31.802963986905866
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 45,
			"versionNonce": 1716095461,
			"isDeleted": false,
			"id": "GI8LL2d8GFHqmnXoRwLu7",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1342.628666662655,
			"y": 877.5839935798845,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 18.247602287568952,
			"height": 19.811682483646223,
			"seed": 819314582,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0427201307181804,
					2.0854402614363607
				],
				[
					-1.0427201307181804,
					2.6068003267955646
				],
				[
					-1.5640801960773842,
					4.170880522872835
				],
				[
					-2.6068003267955646,
					6.25632078430931
				],
				[
					-4.170880522872949,
					8.863121111104874
				],
				[
					-5.213600653591129,
					11.469921437900439
				],
				[
					-6.25632078430931,
					14.076721764696003
				],
				[
					-6.25632078430931,
					16.162162026132364
				],
				[
					-6.25632078430931,
					17.72624222220975
				],
				[
					-6.25632078430931,
					18.76896235292793
				],
				[
					-6.25632078430931,
					19.290322418287133
				],
				[
					-5.734960718950106,
					19.811682483646223
				],
				[
					-4.692240588232153,
					19.811682483646223
				],
				[
					-3.649520457513745,
					19.811682483646223
				],
				[
					-2.085440261436588,
					19.811682483646223
				],
				[
					-0.5213600653592039,
					19.290322418287133
				],
				[
					1.5640801960773842,
					18.247602287568952
				],
				[
					4.170880522872949,
					17.20488215685066
				],
				[
					6.7776808496685135,
					15.640801960773388
				],
				[
					9.384481176464078,
					14.076721764696003
				],
				[
					10.948561372541235,
					12.51264156861862
				],
				[
					11.469921437900439,
					11.991281503259529
				],
				[
					11.991281503259643,
					11.991281503259529
				],
				[
					11.469921437900439,
					11.991281503259529
				],
				[
					10.948561372541235,
					11.991281503259529
				],
				[
					10.427201307182258,
					12.51264156861862
				],
				[
					10.427201307182258,
					12.51264156861862
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 51,
			"versionNonce": 609759979,
			"isDeleted": false,
			"id": "e2ANkgzxJXtn-9mXhNjB-",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1319.688823786854,
			"y": 906.2587971746356,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 16.683522091491568,
			"height": 16.162162026132478,
			"seed": 929899338,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0427201307181804,
					0
				],
				[
					1.5640801960773842,
					0
				],
				[
					2.6068003267955646,
					0
				],
				[
					4.170880522872949,
					0
				],
				[
					5.213600653591129,
					0
				],
				[
					6.25632078430931,
					0.5213600653590902
				],
				[
					7.820400980386694,
					0.5213600653590902
				],
				[
					8.863121111104874,
					1.042720130718294
				],
				[
					8.34176104574567,
					2.0854402614364744
				],
				[
					6.7776808496685135,
					2.6068003267955646
				],
				[
					4.692240588231925,
					3.128160392154655
				],
				[
					3.649520457513745,
					4.170880522872835
				],
				[
					2.0854402614363607,
					5.213600653591129
				],
				[
					1.5640801960773842,
					6.7776808496684
				],
				[
					0.5213600653589765,
					7.820400980386694
				],
				[
					0,
					8.863121111104874
				],
				[
					-0.5213600653592039,
					10.427201307182258
				],
				[
					-0.5213600653592039,
					10.948561372541349
				],
				[
					0,
					11.991281503259529
				],
				[
					0.5213600653589765,
					12.512641568618733
				],
				[
					1.5640801960773842,
					13.03400163397771
				],
				[
					2.6068003267955646,
					13.555361699336913
				],
				[
					4.692240588231925,
					14.076721764696003
				],
				[
					6.7776808496685135,
					14.598081830055094
				],
				[
					9.905841241823055,
					15.119441895414298
				],
				[
					13.5553616993368,
					15.119441895414298
				],
				[
					15.640801960773388,
					15.640801960773274
				],
				[
					16.162162026132364,
					15.640801960773274
				],
				[
					15.640801960773388,
					15.640801960773274
				],
				[
					15.119441895414184,
					15.640801960773274
				],
				[
					14.598081830055207,
					15.640801960773274
				],
				[
					14.598081830055207,
					16.162162026132478
				],
				[
					14.598081830055207,
					16.162162026132478
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 28,
			"versionNonce": 313066821,
			"isDeleted": false,
			"id": "qh3nwP_enCv4LJg-6987W",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1316.0393033293403,
			"y": 910.9510377628676,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 23.982563006519058,
			"height": 5.734960718950219,
			"seed": 1572071318,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5213600653589765,
					0
				],
				[
					4.692240588231925,
					1.5640801960773842
				],
				[
					11.469921437900439,
					3.649520457513745
				],
				[
					17.204882156850545,
					4.692240588231925
				],
				[
					22.939842875800878,
					5.213600653591129
				],
				[
					23.982563006519058,
					5.213600653591129
				],
				[
					23.46120294116008,
					5.213600653591129
				],
				[
					22.939842875800878,
					5.213600653591129
				],
				[
					22.939842875800878,
					5.734960718950219
				],
				[
					22.939842875800878,
					5.734960718950219
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 98,
			"versionNonce": 206085515,
			"isDeleted": false,
			"id": "hIBsUmXKgtq0Deinl_MtU",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -568.7231802082969,
			"y": 75.27031726287305,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 78.88917662827919,
			"height": 3.073604284218618,
			"seed": 1617557142,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0245347614061302,
					0
				],
				[
					2.049069522812374,
					0
				],
				[
					7.17174332984348,
					0
				],
				[
					14.343486659687073,
					0
				],
				[
					21.515229989530667,
					1.0245347614062439
				],
				[
					29.711508080780504,
					2.049069522812374
				],
				[
					32.78511236499912,
					2.049069522812374
				],
				[
					34.83418188781161,
					2.049069522812374
				],
				[
					45.07952950187382,
					1.0245347614062439
				],
				[
					53.27580759312366,
					1.0245347614062439
				],
				[
					57.37394663874852,
					0
				],
				[
					66.59475949140449,
					0
				],
				[
					71.7174332984356,
					0
				],
				[
					76.84010710546681,
					-1.0245347614062439
				],
				[
					77.86464186687294,
					-1.0245347614062439
				],
				[
					78.88917662827919,
					-1.0245347614062439
				],
				[
					78.88917662827919,
					-1.0245347614062439
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 104,
			"versionNonce": 809637029,
			"isDeleted": false,
			"id": "o58zrr7hcdWHzpAm1CKln",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -502.1284207168924,
			"y": 60.92683060318586,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 22.53976475093691,
			"height": 33.809647126405366,
			"seed": 2035217034,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0245347614062439,
					0
				],
				[
					5.122673807031106,
					3.0736042842187317
				],
				[
					10.245347614062325,
					5.122673807031106
				],
				[
					15.368021421093431,
					8.196278091249837
				],
				[
					20.490695228124537,
					9.220812852656081
				],
				[
					22.53976475093691,
					10.245347614062212
				],
				[
					22.53976475093691,
					11.269882375468455
				],
				[
					21.51522998953078,
					12.2944171368747
				],
				[
					17.417090943905805,
					13.318951898280943
				],
				[
					12.2944171368747,
					15.368021421093431
				],
				[
					11.269882375468455,
					15.368021421093431
				],
				[
					8.196278091249837,
					17.417090943905805
				],
				[
					5.122673807031106,
					19.466160466718293
				],
				[
					4.0981390456249756,
					20.490695228124537
				],
				[
					3.0736042842187317,
					22.53976475093691
				],
				[
					1.0245347614062439,
					24.5888342737494
				],
				[
					1.0245347614062439,
					26.637903796561886
				],
				[
					0,
					27.66243855796813
				],
				[
					0,
					29.711508080780504
				],
				[
					1.0245347614062439,
					30.736042842186748
				],
				[
					3.0736042842187317,
					32.785112364999236
				],
				[
					4.0981390456249756,
					33.809647126405366
				],
				[
					4.0981390456249756,
					33.809647126405366
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 106,
			"versionNonce": 2081600555,
			"isDeleted": false,
			"id": "mrjHoiSjTisXYr-kw-tYx",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -564.625041162672,
			"y": 77.31938678568542,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 2.0490695228124878,
			"height": 89.13452424234146,
			"seed": 987210262,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					1.0245347614062439
				],
				[
					0,
					0
				],
				[
					-1.0245347614062439,
					-4.098139045624862
				],
				[
					-1.0245347614062439,
					-9.220812852655968
				],
				[
					-1.0245347614062439,
					-13.31895189828083
				],
				[
					-1.0245347614062439,
					-18.441625705311935
				],
				[
					-1.0245347614062439,
					-23.564299512343155
				],
				[
					-1.0245347614062439,
					-28.68697331937426
				],
				[
					-1.0245347614062439,
					-34.83418188781161
				],
				[
					-1.0245347614062439,
					-38.93232093343647
				],
				[
					-1.0245347614062439,
					-44.05499474046758
				],
				[
					-1.0245347614062439,
					-49.17766854749868
				],
				[
					-1.0245347614062439,
					-53.27580759312366
				],
				[
					-1.0245347614062439,
					-59.423016161560895
				],
				[
					-1.0245347614062439,
					-65.57022472999824
				],
				[
					-1.0245347614062439,
					-70.69289853702946
				],
				[
					-1.0245347614062439,
					-75.81557234406051
				],
				[
					-1.0245347614062439,
					-77.864641866873
				],
				[
					-2.0490695228124878,
					-79.91371138968543
				],
				[
					-2.0490695228124878,
					-80.93824615109168
				],
				[
					-2.0490695228124878,
					-84.01185043531035
				],
				[
					-2.0490695228124878,
					-86.06091995812278
				],
				[
					-2.0490695228124878,
					-87.08545471952903
				],
				[
					-2.0490695228124878,
					-88.10998948093521
				],
				[
					-2.0490695228124878,
					-88.10998948093521
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 89,
			"versionNonce": 180500485,
			"isDeleted": false,
			"id": "h0-3kSa5PDBYnBFkWAFJp",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -566.6741106854845,
			"y": -12.839672218062276,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 13.318951898280943,
			"height": 18.441625705312106,
			"seed": 700766730,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-6.14720856843735,
					3.073604284218675
				],
				[
					-9.220812852655968,
					5.122673807031163
				],
				[
					-11.269882375468455,
					9.220812852656024
				],
				[
					-12.294417136874586,
					12.2944171368747
				],
				[
					-13.318951898280943,
					16.392556182499618
				],
				[
					-13.318951898280943,
					18.441625705312106
				],
				[
					-12.294417136874586,
					18.441625705312106
				],
				[
					-12.294417136874586,
					18.441625705312106
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 94,
			"versionNonce": 597751499,
			"isDeleted": false,
			"id": "ZSd4WFvwBZEZ2NzSZF-h-",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -564.625041162672,
			"y": -14.888741740874707,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 15.368021421093317,
			"height": 14.34348665968713,
			"seed": 1938379722,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					1.0245347614062439
				],
				[
					0,
					2.049069522812431
				],
				[
					3.073604284218618,
					5.122673807031106
				],
				[
					6.14720856843735,
					7.1717433298435935
				],
				[
					7.1717433298435935,
					8.19627809124978
				],
				[
					8.196278091249724,
					9.220812852656024
				],
				[
					9.220812852655968,
					10.245347614062268
				],
				[
					10.245347614062212,
					10.245347614062268
				],
				[
					11.269882375468455,
					10.245347614062268
				],
				[
					13.318951898280943,
					12.2944171368747
				],
				[
					14.343486659687073,
					13.318951898280943
				],
				[
					15.368021421093317,
					14.34348665968713
				],
				[
					15.368021421093317,
					14.34348665968713
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 92,
			"versionNonce": 472313701,
			"isDeleted": false,
			"id": "2E2NKEsxM6UAlFb9gPQuV",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -476.51505168173674,
			"y": 87.56473439974775,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 14.343486659687187,
			"height": 27.662438557968017,
			"seed": 2068918934,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0245347614062439,
					1.0245347614062439
				],
				[
					-2.0490695228124878,
					1.0245347614062439
				],
				[
					-3.0736042842187317,
					2.049069522812374
				],
				[
					-5.122673807031106,
					3.073604284218618
				],
				[
					-8.196278091249837,
					8.196278091249724
				],
				[
					-12.2944171368747,
					16.39255618249956
				],
				[
					-14.343486659687187,
					20.490695228124423
				],
				[
					-14.343486659687187,
					23.564299512343155
				],
				[
					-14.343486659687187,
					26.637903796561773
				],
				[
					-14.343486659687187,
					27.662438557968017
				],
				[
					-14.343486659687187,
					27.662438557968017
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 92,
			"versionNonce": 1368253803,
			"isDeleted": false,
			"id": "Y2l1UOkZCLI5sZCMJs6fa",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -500.0793511940799,
			"y": 97.81008201380996,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 22.53976475093691,
			"height": 20.490695228124423,
			"seed": 1342048842,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					4.098139045624862,
					2.0490695228124878
				],
				[
					8.196278091249837,
					5.122673807031106
				],
				[
					11.269882375468455,
					7.1717433298435935
				],
				[
					13.318951898280943,
					8.196278091249837
				],
				[
					16.39255618249956,
					10.245347614062212
				],
				[
					16.39255618249956,
					11.269882375468455
				],
				[
					17.417090943905805,
					12.2944171368747
				],
				[
					19.466160466718293,
					15.368021421093317
				],
				[
					21.515229989530667,
					19.466160466718293
				],
				[
					22.53976475093691,
					20.490695228124423
				],
				[
					22.53976475093691,
					20.490695228124423
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 143,
			"versionNonce": 1119730373,
			"isDeleted": false,
			"id": "MxIam1dp9-NQaKxLmH3D1",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -591.2629449592338,
			"y": -28.207693639155593,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 32.78511236499912,
			"height": 66.59475949140455,
			"seed": 1374559958,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					-1.0245347614062439
				],
				[
					3.073604284218618,
					-5.122673807031163
				],
				[
					5.122673807031106,
					-6.14720856843735
				],
				[
					8.196278091249724,
					-11.269882375468455
				],
				[
					9.220812852655968,
					-14.34348665968713
				],
				[
					8.196278091249724,
					-13.318951898280943
				],
				[
					7.17174332984348,
					-12.2944171368747
				],
				[
					7.17174332984348,
					-11.269882375468455
				],
				[
					7.17174332984348,
					-9.220812852656024
				],
				[
					8.196278091249724,
					-9.220812852656024
				],
				[
					11.269882375468342,
					-11.269882375468455
				],
				[
					16.392556182499447,
					-18.44162570531205
				],
				[
					19.46616046671818,
					-22.539764750936968
				],
				[
					20.490695228124423,
					-24.5888342737494
				],
				[
					22.53976475093691,
					-26.63790379656183
				],
				[
					23.56429951234304,
					-28.686973319374317
				],
				[
					23.56429951234304,
					-29.711508080780504
				],
				[
					23.56429951234304,
					-28.686973319374317
				],
				[
					22.53976475093691,
					-28.686973319374317
				],
				[
					21.515229989530553,
					-27.662438557968073
				],
				[
					20.490695228124423,
					-26.63790379656183
				],
				[
					17.417090943905805,
					-21.515229989530724
				],
				[
					16.392556182499447,
					-18.44162570531205
				],
				[
					14.343486659687073,
					-14.34348665968713
				],
				[
					13.31895189828083,
					-9.220812852656024
				],
				[
					12.2944171368747,
					-4.098139045624919
				],
				[
					10.245347614062212,
					1.024534761406187
				],
				[
					8.196278091249724,
					6.14720856843735
				],
				[
					7.17174332984348,
					10.245347614062212
				],
				[
					6.147208568437236,
					13.318951898280886
				],
				[
					5.122673807031106,
					16.39255618249956
				],
				[
					4.098139045624748,
					20.49069522812448
				],
				[
					3.073604284218618,
					23.564299512343155
				],
				[
					1.0245347614061302,
					28.68697331937426
				],
				[
					0,
					30.73604284218669
				],
				[
					-1.0245347614063576,
					33.80964712640542
				],
				[
					-2.0490695228124878,
					34.83418188781155
				],
				[
					-3.0736042842187317,
					36.88325141062404
				],
				[
					-4.0981390456249756,
					36.88325141062404
				],
				[
					-5.122673807031106,
					36.88325141062404
				],
				[
					-7.1717433298435935,
					36.88325141062404
				],
				[
					-8.196278091249837,
					32.78511236499918
				],
				[
					-8.196278091249837,
					29.711508080780504
				],
				[
					-8.196278091249837,
					28.68697331937426
				],
				[
					-6.147208568437463,
					26.63790379656183
				],
				[
					-5.122673807031106,
					25.613369035155586
				],
				[
					-2.0490695228124878,
					21.515229989530667
				],
				[
					0,
					18.441625705311992
				],
				[
					1.0245347614061302,
					16.39255618249956
				],
				[
					4.098139045624748,
					12.2944171368747
				],
				[
					5.122673807031106,
					10.245347614062212
				],
				[
					6.147208568437236,
					10.245347614062212
				],
				[
					7.17174332984348,
					9.220812852656024
				],
				[
					8.196278091249724,
					9.220812852656024
				],
				[
					10.245347614062212,
					8.19627809124978
				],
				[
					13.31895189828083,
					7.171743329843537
				],
				[
					15.368021421093317,
					6.14720856843735
				],
				[
					19.46616046671818,
					6.14720856843735
				],
				[
					23.56429951234304,
					5.122673807031106
				],
				[
					24.588834273749285,
					5.122673807031106
				],
				[
					24.588834273749285,
					6.14720856843735
				],
				[
					24.588834273749285,
					6.14720856843735
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 109,
			"versionNonce": 488898571,
			"isDeleted": false,
			"id": "BJQWa86Xfi0dtPICb1AfA",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -562.5759716398595,
			"y": 74.2457825014668,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 26.637903796561886,
			"height": 45.07952950187382,
			"seed": 54478550,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0245347614062439,
					0
				],
				[
					-1.0245347614062439,
					1.0245347614062439
				],
				[
					-2.0490695228124878,
					3.073604284218618
				],
				[
					-3.0736042842187317,
					7.1717433298435935
				],
				[
					-5.122673807031219,
					11.269882375468455
				],
				[
					-6.14720856843735,
					14.343486659687187
				],
				[
					-8.196278091249837,
					16.39255618249956
				],
				[
					-8.196278091249837,
					17.417090943905805
				],
				[
					-9.220812852656081,
					18.44162570531205
				],
				[
					-10.245347614062325,
					20.490695228124423
				],
				[
					-12.294417136874813,
					23.564299512343155
				],
				[
					-13.318951898280943,
					24.5888342737494
				],
				[
					-15.368021421093431,
					26.637903796561773
				],
				[
					-16.39255618249956,
					28.68697331937426
				],
				[
					-17.41709094390592,
					30.736042842186748
				],
				[
					-18.44162570531205,
					31.760577603592992
				],
				[
					-19.466160466718293,
					33.809647126405366
				],
				[
					-20.490695228124537,
					34.83418188781161
				],
				[
					-21.51522998953078,
					35.858716649217854
				],
				[
					-22.539764750937024,
					36.8832514106241
				],
				[
					-22.539764750937024,
					38.93232093343647
				],
				[
					-23.564299512343155,
					39.956855694842716
				],
				[
					-24.588834273749512,
					40.98139045624896
				],
				[
					-25.613369035155642,
					43.03045997906145
				],
				[
					-25.613369035155642,
					44.05499474046758
				],
				[
					-26.637903796561886,
					45.07952950187382
				],
				[
					-25.613369035155642,
					45.07952950187382
				],
				[
					-25.613369035155642,
					45.07952950187382
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 100,
			"versionNonce": 925112869,
			"isDeleted": false,
			"id": "otPdiIUpRNIt0z4W0Mk5N",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -588.1893406750152,
			"y": 109.07996438927842,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 19.466160466718293,
			"height": 11.269882375468455,
			"seed": 475266454,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0245347614062439,
					0
				],
				[
					-2.0490695228124878,
					3.0736042842187317
				],
				[
					-3.073604284218618,
					5.122673807031106
				],
				[
					-3.073604284218618,
					6.14720856843735
				],
				[
					-4.0981390456249756,
					8.196278091249837
				],
				[
					-5.122673807031106,
					9.220812852655968
				],
				[
					-5.122673807031106,
					10.245347614062212
				],
				[
					-5.122673807031106,
					11.269882375468455
				],
				[
					-4.0981390456249756,
					11.269882375468455
				],
				[
					-3.073604284218618,
					11.269882375468455
				],
				[
					0,
					10.245347614062212
				],
				[
					1.0245347614061302,
					10.245347614062212
				],
				[
					2.0490695228124878,
					9.220812852655968
				],
				[
					4.098139045624862,
					9.220812852655968
				],
				[
					7.1717433298435935,
					7.1717433298435935
				],
				[
					10.245347614062212,
					6.14720856843735
				],
				[
					13.31895189828083,
					4.098139045624862
				],
				[
					14.343486659687187,
					4.098139045624862
				],
				[
					14.343486659687187,
					4.098139045624862
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 101,
			"versionNonce": 1348322987,
			"isDeleted": false,
			"id": "aSQYRVzZXySLfJVlZoz7g",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -581.0175973451716,
			"y": 132.64426390162157,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 34.83418188781161,
			"height": 21.515229989530667,
			"seed": 920828490,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0245347614061302,
					0
				],
				[
					1.0245347614061302,
					1.0245347614062439
				],
				[
					3.073604284218618,
					0
				],
				[
					5.122673807031106,
					0
				],
				[
					6.147208568437236,
					0
				],
				[
					7.1717433298435935,
					0
				],
				[
					7.1717433298435935,
					1.0245347614062439
				],
				[
					5.122673807031106,
					3.0736042842187317
				],
				[
					-1.0245347614062439,
					5.122673807031106
				],
				[
					-6.147208568437463,
					8.196278091249837
				],
				[
					-7.1717433298435935,
					9.220812852656081
				],
				[
					-9.220812852656081,
					11.269882375468455
				],
				[
					-9.220812852656081,
					12.2944171368747
				],
				[
					-9.220812852656081,
					13.318951898280943
				],
				[
					-5.122673807031106,
					17.417090943905805
				],
				[
					7.1717433298435935,
					20.490695228124537
				],
				[
					21.515229989530667,
					21.515229989530667
				],
				[
					23.564299512343155,
					21.515229989530667
				],
				[
					25.61336903515553,
					21.515229989530667
				],
				[
					25.61336903515553,
					21.515229989530667
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 95,
			"versionNonce": 1111985541,
			"isDeleted": false,
			"id": "T1EjDZMMmFeDENZRXXx0J",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -587.164805913609,
			"y": 137.76693770865268,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 23.56429951234327,
			"height": 4.0981390456249756,
			"seed": 2057370762,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					1.0245347614062439
				],
				[
					1.0245347614063576,
					1.0245347614062439
				],
				[
					3.0736042842187317,
					1.0245347614062439
				],
				[
					5.122673807031219,
					1.0245347614062439
				],
				[
					7.1717433298435935,
					1.0245347614062439
				],
				[
					8.196278091249951,
					1.0245347614062439
				],
				[
					12.2944171368747,
					2.0490695228124878
				],
				[
					16.392556182499675,
					3.0736042842187317
				],
				[
					19.466160466718293,
					3.0736042842187317
				],
				[
					20.490695228124537,
					4.0981390456249756
				],
				[
					21.51522998953078,
					4.0981390456249756
				],
				[
					22.539764750937024,
					4.0981390456249756
				],
				[
					23.56429951234327,
					4.0981390456249756
				],
				[
					23.56429951234327,
					4.0981390456249756
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 56,
			"versionNonce": 300267851,
			"isDeleted": false,
			"id": "MR5w0bYg",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -456.0243564536123,
			"y": 122.39891628755936,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 486.0320739746094,
			"height": 20,
			"seed": 471780438,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689868,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "这里相机在坐标原点, 向着z轴正方向. 这个投影看到的是模型的背面.",
			"rawText": "这里相机在坐标原点, 向着z轴正方向. 这个投影看到的是模型的背面.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "这里相机在坐标原点, 向着z轴正方向. 这个投影看到的是模型的背面.",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 69,
			"versionNonce": 862295269,
			"isDeleted": false,
			"id": "o5t8DP7FvaREzbaemO_bE",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -564.625041162672,
			"y": 7.6510230100623176,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 48.15313378609255,
			"height": 69.66836377562333,
			"seed": 512484374,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					4.098139045624862,
					0
				],
				[
					10.245347614062212,
					0
				],
				[
					17.417090943905805,
					0
				],
				[
					22.53976475093691,
					1.0245347614062439
				],
				[
					23.564299512343155,
					1.0245347614062439
				],
				[
					24.5888342737494,
					1.0245347614062439
				],
				[
					25.613369035155642,
					1.0245347614062439
				],
				[
					26.637903796561886,
					1.0245347614062439
				],
				[
					32.785112364999236,
					0
				],
				[
					34.83418188781161,
					0
				],
				[
					35.858716649217854,
					0
				],
				[
					36.8832514106241,
					-1.0245347614062439
				],
				[
					37.90778617203034,
					-1.0245347614062439
				],
				[
					42.005925217655204,
					-2.0490695228124878
				],
				[
					45.079529501873935,
					-2.0490695228124878
				],
				[
					47.12859902468631,
					-3.0736042842187317
				],
				[
					48.15313378609255,
					-3.0736042842187317
				],
				[
					47.12859902468631,
					-3.0736042842187317
				],
				[
					46.104064263280065,
					-1.0245347614062439
				],
				[
					44.05499474046769,
					3.073604284218618
				],
				[
					43.03045997906145,
					6.14720856843735
				],
				[
					42.005925217655204,
					9.220812852655968
				],
				[
					40.98139045624896,
					11.269882375468455
				],
				[
					40.98139045624896,
					14.343486659687187
				],
				[
					39.956855694842716,
					16.39255618249956
				],
				[
					38.932320933436586,
					18.44162570531205
				],
				[
					37.90778617203034,
					22.53976475093691
				],
				[
					36.8832514106241,
					26.637903796561773
				],
				[
					36.8832514106241,
					28.68697331937426
				],
				[
					36.8832514106241,
					30.736042842186748
				],
				[
					36.8832514106241,
					31.760577603592992
				],
				[
					36.8832514106241,
					35.858716649217854
				],
				[
					36.8832514106241,
					37.90778617203034
				],
				[
					36.8832514106241,
					40.98139045624896
				],
				[
					37.90778617203034,
					44.05499474046769
				],
				[
					37.90778617203034,
					46.104064263280065
				],
				[
					38.932320933436586,
					50.20220330890493
				],
				[
					38.932320933436586,
					52.251272831717415
				],
				[
					39.956855694842716,
					52.251272831717415
				],
				[
					39.956855694842716,
					53.27580759312366
				],
				[
					39.956855694842716,
					54.3003423545299
				],
				[
					39.956855694842716,
					55.32487711593615
				],
				[
					39.956855694842716,
					56.34941187734228
				],
				[
					39.956855694842716,
					57.37394663874852
				],
				[
					39.956855694842716,
					58.398481400154765
				],
				[
					39.956855694842716,
					59.42301616156101
				],
				[
					39.956855694842716,
					60.44755092296725
				],
				[
					39.956855694842716,
					61.472085684373496
				],
				[
					39.956855694842716,
					62.49662044577963
				],
				[
					39.956855694842716,
					63.52115520718587
				],
				[
					39.956855694842716,
					64.54568996859211
				],
				[
					39.956855694842716,
					65.57022472999836
				],
				[
					39.956855694842716,
					66.5947594914046
				],
				[
					39.956855694842716,
					66.5947594914046
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 30,
			"versionNonce": 1326864363,
			"isDeleted": false,
			"id": "GNkjZCsBtu33EwrXBR8ye",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -544.1343459345475,
			"y": 12.773696817093423,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 22.53976475093691,
			"height": 28.68697331937426,
			"seed": 1726433046,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0245347614062439,
					0
				],
				[
					-4.0981390456249756,
					3.0736042842187317
				],
				[
					-6.14720856843735,
					5.122673807031106
				],
				[
					-11.269882375468455,
					10.245347614062212
				],
				[
					-12.2944171368747,
					13.318951898280943
				],
				[
					-15.368021421093431,
					17.417090943905805
				],
				[
					-16.392556182499675,
					18.44162570531205
				],
				[
					-18.44162570531205,
					21.515229989530667
				],
				[
					-20.490695228124537,
					25.613369035155642
				],
				[
					-21.51522998953078,
					27.662438557968017
				],
				[
					-22.53976475093691,
					28.68697331937426
				],
				[
					-21.51522998953078,
					28.68697331937426
				],
				[
					-19.466160466718293,
					28.68697331937426
				],
				[
					-18.44162570531205,
					28.68697331937426
				],
				[
					-18.44162570531205,
					28.68697331937426
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 24,
			"versionNonce": 369864773,
			"isDeleted": false,
			"id": "GTsu7h7raPYxKUY9t_zKI",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -535.9380678432977,
			"y": 31.215322522405472,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 24.5888342737494,
			"height": 29.711508080780504,
			"seed": 270234442,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-8.196278091249724,
					5.122673807031106
				],
				[
					-9.220812852655968,
					7.1717433298435935
				],
				[
					-12.2944171368747,
					11.269882375468455
				],
				[
					-15.368021421093317,
					15.368021421093317
				],
				[
					-18.44162570531205,
					19.466160466718293
				],
				[
					-20.490695228124423,
					23.564299512343155
				],
				[
					-23.564299512343155,
					27.662438557968017
				],
				[
					-24.5888342737494,
					29.711508080780504
				],
				[
					-24.5888342737494,
					29.711508080780504
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 28,
			"versionNonce": 1710891659,
			"isDeleted": false,
			"id": "bFJenj0qVJv0ax6TASRgv",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -529.7908592748604,
			"y": 53.75508727334238,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 26.637903796561773,
			"height": 27.662438557968017,
			"seed": 846203030,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-2.049069522812374,
					1.0245347614062439
				],
				[
					-3.073604284218618,
					1.0245347614062439
				],
				[
					-7.1717433298435935,
					5.122673807031106
				],
				[
					-10.245347614062212,
					8.196278091249837
				],
				[
					-12.2944171368747,
					12.2944171368747
				],
				[
					-15.368021421093317,
					15.368021421093431
				],
				[
					-18.44162570531205,
					18.44162570531205
				],
				[
					-22.53976475093691,
					22.53976475093691
				],
				[
					-25.61336903515553,
					26.637903796561886
				],
				[
					-26.637903796561773,
					27.662438557968017
				],
				[
					-25.61336903515553,
					27.662438557968017
				],
				[
					-24.5888342737494,
					27.662438557968017
				],
				[
					-24.5888342737494,
					27.662438557968017
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 24,
			"versionNonce": 672620453,
			"isDeleted": false,
			"id": "xg_JrWDmF3l-Kd76Bys0z",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -530.8153940362666,
			"y": 66.04950441021708,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 12.294417136874586,
			"height": 11.269882375468455,
			"seed": 1031469834,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-2.049069522812374,
					1.0245347614062439
				],
				[
					-4.098139045624862,
					2.0490695228124878
				],
				[
					-7.17174332984348,
					5.122673807031106
				],
				[
					-9.220812852655968,
					7.1717433298435935
				],
				[
					-10.245347614062212,
					9.220812852656081
				],
				[
					-11.269882375468455,
					10.245347614062212
				],
				[
					-11.269882375468455,
					11.269882375468455
				],
				[
					-12.294417136874586,
					11.269882375468455
				],
				[
					-12.294417136874586,
					11.269882375468455
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 145,
			"versionNonce": 256612651,
			"isDeleted": false,
			"id": "KDH40Bij",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1178.906346878448,
			"y": 1794.9851783292752,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 198.7842559814453,
			"height": 40,
			"seed": 1058883210,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "f_c, T_e分别是什么?\nsmooth-factor求的是什么?",
			"rawText": "f_c, T_e分别是什么?\nsmooth-factor求的是什么?",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f_c, T_e分别是什么?\nsmooth-factor求的是什么?",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "freedraw",
			"version": 126,
			"versionNonce": 263594757,
			"isDeleted": false,
			"id": "0hfbLL3uE9mI31ZdFu4s0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -727.810042011105,
			"y": 1923.7411965704337,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 131.61662760468596,
			"height": 66.37077802287558,
			"seed": 1356465110,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5624642205327746,
					0
				],
				[
					2.8123211026641,
					0
				],
				[
					7.874499087459753,
					-0.5624642205330019
				],
				[
					10.686820190124081,
					-0.5624642205330019
				],
				[
					15.74899817491962,
					-0.5624642205330019
				],
				[
					20.81117615971516,
					-0.5624642205330019
				],
				[
					23.061033041846713,
					-0.5624642205330019
				],
				[
					24.185961482912262,
					-1.1249284410657765
				],
				[
					25.31088992397804,
					-1.1249284410657765
				],
				[
					29.248139467707915,
					-1.1249284410657765
				],
				[
					32.06046057037224,
					-1.1249284410657765
				],
				[
					34.31031745250357,
					-1.1249284410657765
				],
				[
					37.12263855516778,
					-1.1249284410657765
				],
				[
					37.68510277570067,
					-1.1249284410657765
				],
				[
					38.247566996233445,
					-1.1249284410657765
				],
				[
					39.37249543729922,
					-1.1249284410657765
				],
				[
					41.05988809889777,
					-1.1249284410657765
				],
				[
					43.3097449810291,
					-1.1249284410657765
				],
				[
					45.559601863160424,
					-1.1249284410657765
				],
				[
					48.934387186357526,
					-1.1249284410657765
				],
				[
					51.18424406848885,
					-1.1249284410657765
				],
				[
					53.43410095062029,
					-1.1249284410657765
				],
				[
					56.80888627381739,
					-1.1249284410657765
				],
				[
					59.05874315594883,
					-1.1249284410657765
				],
				[
					62.433528479145934,
					-1.1249284410657765
				],
				[
					66.93324224340859,
					-1.1249284410657765
				],
				[
					69.74556334607291,
					-1.687392661598551
				],
				[
					71.99542022820424,
					-1.687392661598551
				],
				[
					74.24527711033556,
					-1.687392661598551
				],
				[
					77.05759821299989,
					-1.1249284410657765
				],
				[
					79.8699193156641,
					-1.1249284410657765
				],
				[
					82.68224041832832,
					-0.5624642205330019
				],
				[
					84.36963307992687,
					-0.5624642205330019
				],
				[
					85.49456152099253,
					0
				],
				[
					86.6194899620582,
					0
				],
				[
					87.18195418259108,
					0
				],
				[
					88.30688262365675,
					0.5624642205327746
				],
				[
					90.55673950578819,
					0.5624642205327746
				],
				[
					92.24413216738674,
					1.1249284410655491
				],
				[
					94.49398904951806,
					1.6873926615983237
				],
				[
					97.86877437271517,
					2.8123211026641
				],
				[
					100.11863125484649,
					3.9372495437296493
				],
				[
					102.36848813697793,
					5.062177984795426
				],
				[
					104.05588079857648,
					5.6246422053282
				],
				[
					105.18080923964214,
					6.187106425861202
				],
				[
					105.74327346017503,
					6.187106425861202
				],
				[
					105.74327346017503,
					6.749570646393977
				],
				[
					106.30573768070781,
					7.312034866926751
				],
				[
					107.99313034230636,
					7.874499087459753
				],
				[
					110.2429872244378,
					8.999427528525302
				],
				[
					111.36791566550346,
					10.124355969591079
				],
				[
					113.05530832710201,
					11.81174863118963
				],
				[
					115.86762942976623,
					14.061605513320956
				],
				[
					118.67995053243044,
					16.31146239545251
				],
				[
					123.1796642966932,
					19.12378349811661
				],
				[
					124.86705695829176,
					20.248711939182385
				],
				[
					124.86705695829176,
					20.81117615971516
				],
				[
					124.86705695829176,
					21.373640380247934
				],
				[
					125.42952117882464,
					22.49856882131371
				],
				[
					125.42952117882464,
					23.62349726237926
				],
				[
					125.42952117882464,
					25.31088992397781
				],
				[
					125.42952117882464,
					26.998282585576362
				],
				[
					125.42952117882464,
					28.12321102664214
				],
				[
					124.86705695829176,
					28.685675247174913
				],
				[
					124.86705695829176,
					30.935532129306466
				],
				[
					124.86705695829176,
					31.49799634983924
				],
				[
					124.86705695829176,
					33.18538901143779
				],
				[
					125.42952117882464,
					35.43524589356912
				],
				[
					125.42952117882464,
					36.560174334634894
				],
				[
					125.42952117882464,
					37.12263855516767
				],
				[
					125.42952117882464,
					38.247566996233445
				],
				[
					125.99198539935742,
					38.81003121676622
				],
				[
					125.42952117882464,
					39.37249543729922
				],
				[
					125.42952117882464,
					40.49742387836477
				],
				[
					125.42952117882464,
					41.059888098897545
				],
				[
					125.42952117882464,
					42.747280760496096
				],
				[
					125.42952117882464,
					43.87220920156187
				],
				[
					125.42952117882464,
					44.43467342209465
				],
				[
					125.42952117882464,
					44.99713764262742
				],
				[
					125.42952117882464,
					46.68453030422597
				],
				[
					125.99198539935742,
					47.80945874529175
				],
				[
					125.99198539935742,
					48.371922965824524
				],
				[
					125.99198539935742,
					48.934387186357526
				],
				[
					125.99198539935742,
					49.4968514068903
				],
				[
					126.5544496198903,
					50.62177984795608
				],
				[
					126.5544496198903,
					51.18424406848885
				],
				[
					127.1169138404232,
					51.18424406848885
				],
				[
					127.67937806095597,
					51.746708289021626
				],
				[
					127.67937806095597,
					52.30917250955463
				],
				[
					127.67937806095597,
					52.8716367300874
				],
				[
					128.24184228148886,
					52.8716367300874
				],
				[
					128.24184228148886,
					53.43410095062018
				],
				[
					128.24184228148886,
					53.99656517115318
				],
				[
					128.80430650202163,
					54.559029391685954
				],
				[
					128.80430650202163,
					55.68395783275173
				],
				[
					129.36677072255452,
					56.246422053284505
				],
				[
					129.9292349430874,
					56.80888627381728
				],
				[
					129.9292349430874,
					57.933814714883056
				],
				[
					129.9292349430874,
					58.49627893541583
				],
				[
					130.49169916362018,
					59.05874315594883
				],
				[
					130.49169916362018,
					59.62120737648161
				],
				[
					131.05416338415307,
					60.18367159701438
				],
				[
					131.05416338415307,
					60.746135817547156
				],
				[
					131.05416338415307,
					61.87106425861293
				],
				[
					131.05416338415307,
					62.43352847914571
				],
				[
					131.05416338415307,
					62.99599269967848
				],
				[
					131.61662760468596,
					63.55845692021148
				],
				[
					131.61662760468596,
					64.12092114074426
				],
				[
					131.61662760468596,
					64.68338536127703
				],
				[
					131.05416338415307,
					64.68338536127703
				],
				[
					131.05416338415307,
					64.68338536127703
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 41,
			"versionNonce": 141900747,
			"isDeleted": false,
			"id": "BgoZ5PjKSzIkRzu_L2PDg",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -609.1300914786746,
			"y": 1981.112547064784,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 25.873354144510927,
			"height": 16.31146239545251,
			"seed": 1784850058,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5624642205328882,
					0
				],
				[
					1.687392661598551,
					1.1249284410655491
				],
				[
					3.374785323197102,
					2.2498568821313256
				],
				[
					5.624642205328428,
					3.3747853231968747
				],
				[
					7.312034866926979,
					4.499713764262651
				],
				[
					8.436963307992755,
					5.6246422053282
				],
				[
					8.99942752852553,
					6.187106425861202
				],
				[
					9.561891749058418,
					6.187106425861202
				],
				[
					9.561891749058418,
					6.749570646393977
				],
				[
					10.124355969591193,
					7.312034866926751
				],
				[
					10.124355969591193,
					7.874499087459753
				],
				[
					10.686820190124081,
					7.874499087459753
				],
				[
					11.24928441065697,
					8.999427528525302
				],
				[
					11.811748631189744,
					8.436963307992528
				],
				[
					12.93667707225552,
					8.436963307992528
				],
				[
					14.624069733853958,
					7.874499087459753
				],
				[
					15.748998174919734,
					6.749570646393977
				],
				[
					19.123783498116723,
					3.3747853231968747
				],
				[
					21.373640380248162,
					0
				],
				[
					23.061033041846713,
					-2.8123211026643276
				],
				[
					24.185961482912376,
					-4.499713764262879
				],
				[
					24.748425703445264,
					-5.624642205328655
				],
				[
					25.31088992397804,
					-6.18710642586143
				],
				[
					25.873354144510927,
					-6.749570646394204
				],
				[
					25.873354144510927,
					-7.312034866927206
				],
				[
					25.873354144510927,
					-7.312034866927206
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 36,
			"versionNonce": 1365604965,
			"isDeleted": false,
			"id": "hej1RAmLIEztRDBOTEaSw",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -606.3177703760103,
			"y": 2021.6099709431487,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 19.123783498116836,
			"height": 1.687392661598551,
			"seed": 225152266,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5624642205328882,
					0
				],
				[
					1.1249284410657765,
					0
				],
				[
					3.9372495437299904,
					0
				],
				[
					5.624642205328541,
					0.5624642205330019
				],
				[
					7.312034866926979,
					0.5624642205330019
				],
				[
					8.99942752852553,
					1.1249284410655491
				],
				[
					10.124355969591306,
					1.1249284410655491
				],
				[
					10.686820190124081,
					1.1249284410655491
				],
				[
					11.24928441065697,
					1.1249284410655491
				],
				[
					11.24928441065697,
					1.687392661598551
				],
				[
					11.811748631189744,
					1.687392661598551
				],
				[
					12.374212851722632,
					1.687392661598551
				],
				[
					12.93667707225552,
					1.687392661598551
				],
				[
					14.061605513321183,
					1.687392661598551
				],
				[
					15.186533954386846,
					1.687392661598551
				],
				[
					15.748998174919734,
					1.687392661598551
				],
				[
					16.31146239545251,
					1.687392661598551
				],
				[
					17.436390836518285,
					1.687392661598551
				],
				[
					18.561319277583948,
					1.687392661598551
				],
				[
					19.123783498116836,
					1.687392661598551
				],
				[
					19.123783498116836,
					1.687392661598551
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 66,
			"versionNonce": 2106690155,
			"isDeleted": false,
			"id": "RZka_Z7OW9rwVfP28NRLR",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -597.8808070680176,
			"y": 2023.2973636047473,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 37.68510277570067,
			"height": 11.811748631189857,
			"seed": 1348692566,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5624642205327746,
					0.5624642205330019
				],
				[
					0.5624642205327746,
					1.1249284410655491
				],
				[
					1.1249284410656628,
					1.687392661598551
				],
				[
					1.1249284410656628,
					2.249856882131553
				],
				[
					1.687392661598551,
					2.8123211026641
				],
				[
					1.687392661598551,
					3.374785323197102
				],
				[
					2.2498568821313256,
					3.9372495437298767
				],
				[
					2.812321102664214,
					5.062177984795653
				],
				[
					3.3747853231969884,
					5.624642205328428
				],
				[
					4.499713764262765,
					6.187106425861202
				],
				[
					5.624642205328428,
					6.749570646394204
				],
				[
					6.7495706463940905,
					7.874499087459753
				],
				[
					8.436963307992642,
					8.436963307992755
				],
				[
					10.124355969591193,
					9.561891749058304
				],
				[
					11.811748631189744,
					10.124355969591306
				],
				[
					12.936677072255407,
					10.124355969591306
				],
				[
					13.499141292788295,
					10.124355969591306
				],
				[
					14.06160551332107,
					10.124355969591306
				],
				[
					15.186533954386846,
					10.124355969591306
				],
				[
					16.31146239545251,
					10.124355969591306
				],
				[
					17.43639083651817,
					10.124355969591306
				],
				[
					18.561319277583834,
					9.561891749058304
				],
				[
					19.123783498116723,
					8.99942752852553
				],
				[
					20.248711939182385,
					8.99942752852553
				],
				[
					20.811176159715274,
					7.874499087459753
				],
				[
					21.373640380248162,
					7.874499087459753
				],
				[
					21.936104600780936,
					7.312034866926979
				],
				[
					23.0610330418466,
					7.312034866926979
				],
				[
					23.623497262379487,
					6.749570646394204
				],
				[
					24.185961482912376,
					6.749570646394204
				],
				[
					25.31088992397804,
					5.624642205328428
				],
				[
					25.873354144510927,
					5.062177984795653
				],
				[
					26.99828258557659,
					4.499713764262651
				],
				[
					27.560746806109478,
					4.499713764262651
				],
				[
					28.68567524717514,
					3.374785323197102
				],
				[
					29.248139467707915,
					2.8123211026641
				],
				[
					29.810603688240803,
					2.8123211026641
				],
				[
					30.37306790877369,
					2.249856882131553
				],
				[
					31.497996349839354,
					1.687392661598551
				],
				[
					32.06046057037224,
					1.687392661598551
				],
				[
					33.185389011437906,
					1.1249284410655491
				],
				[
					33.74785323197068,
					0.5624642205330019
				],
				[
					34.31031745250357,
					0.5624642205330019
				],
				[
					34.87278167303646,
					0.5624642205330019
				],
				[
					34.87278167303646,
					0
				],
				[
					35.43524589356923,
					0
				],
				[
					35.99771011410212,
					-0.5624642205330019
				],
				[
					37.12263855516778,
					-1.1249284410655491
				],
				[
					37.68510277570067,
					-1.687392661598551
				],
				[
					37.68510277570067,
					-1.1249284410655491
				],
				[
					37.68510277570067,
					-1.1249284410655491
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 32,
			"versionNonce": 99804613,
			"isDeleted": false,
			"id": "-wK_9R-GsI1ba8PetyrNq",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -564.1329538360469,
			"y": 2018.7976498404846,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 8.436963307992755,
			"height": 6.749570646394204,
			"seed": 1183454602,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.1249284410657765,
					0
				],
				[
					2.2498568821314393,
					0
				],
				[
					2.8123211026643276,
					0
				],
				[
					3.374785323197102,
					0
				],
				[
					4.499713764262765,
					0
				],
				[
					5.624642205328541,
					0
				],
				[
					7.3120348669270925,
					0
				],
				[
					7.874499087459867,
					0
				],
				[
					8.436963307992755,
					0
				],
				[
					7.874499087459867,
					0.5624642205327746
				],
				[
					7.874499087459867,
					1.687392661598551
				],
				[
					7.3120348669270925,
					2.8123211026641
				],
				[
					7.3120348669270925,
					3.9372495437296493
				],
				[
					6.749570646394204,
					5.062177984795653
				],
				[
					6.749570646394204,
					6.187106425861202
				],
				[
					6.749570646394204,
					6.749570646394204
				],
				[
					6.749570646394204,
					6.749570646394204
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 147,
			"versionNonce": 862651659,
			"isDeleted": false,
			"id": "FAimgahF",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1181.1562037605793,
			"y": 1840.4964919315723,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 246.320556640625,
			"height": 40,
			"seed": 975030090,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "f_c: cut off frequency\nT_e: time between x_i, x_{i-1}",
			"rawText": "f_c: cut off frequency\nT_e: time between x_i, x_{i-1}",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f_c: cut off frequency\nT_e: time between x_i, x_{i-1}",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 86,
			"versionNonce": 1350296869,
			"isDeleted": false,
			"id": "8EPSj2W2",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1319.5049863267013,
			"y": 1997.9864736807692,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 188.94412231445312,
			"height": 20,
			"seed": 201190486,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "这样smooth的意义是什么?",
			"rawText": "这样smooth的意义是什么?",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "这样smooth的意义是什么?",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 412,
			"versionNonce": 1903963051,
			"isDeleted": false,
			"id": "KApyM3I4",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1319.5049863267013,
			"y": 2026.6721489279444,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 488.70062255859375,
			"height": 71.37533695211434,
			"seed": 195631126,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"fontSize": 11.420053912338295,
			"fontFamily": 1,
			"text": "定性地看: \n定义了若是要过滤到数据中高于f_c频率的信息后, 新的值该如何通过与上一时间点的值加权得到.\n当f_c, T_e 变大时, X_i的比重变大.\n\n定量地看:",
			"rawText": "定性地看: \n定义了若是要过滤到数据中高于f_c频率的信息后, 新的值该如何通过与上一时间点的值加权得到.\n当f_c, T_e 变大时, X_i的比重变大.\n\n定量地看:",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "定性地看: \n定义了若是要过滤到数据中高于f_c频率的信息后, 新的值该如何通过与上一时间点的值加权得到.\n当f_c, T_e 变大时, X_i的比重变大.\n\n定量地看:",
			"lineHeight": 1.25,
			"baseline": 67
		},
		{
			"type": "image",
			"version": 240,
			"versionNonce": 342751365,
			"isDeleted": false,
			"id": "nJbps7t5zt0uCLwRXWV_w",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1312.8992948541124,
			"y": 2109.6481913902358,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 388.8666389659444,
			"height": 290.53983792235323,
			"seed": 1804899798,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "42eba91b8e56930691b50284545929d060842082",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 128,
			"versionNonce": 737115723,
			"isDeleted": false,
			"id": "gkJ9zQ2G5iJWNyvbE_pNb",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -390.80532044814674,
			"y": 1951.4200174966716,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 210.007045147074,
			"height": 40.39250688765446,
			"seed": 1048375766,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false
		},
		{
			"type": "freedraw",
			"version": 50,
			"versionNonce": 1803984869,
			"isDeleted": false,
			"id": "fcPSLB_AcotYBVcUHIOFD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -659.4663697662704,
			"y": 1821.8134176627925,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 259.8238645884994,
			"height": 138.71952092436845,
			"seed": 380880330,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					21.285005856119938,
					18.349142979413728
				],
				[
					27.89069732870894,
					22.752937294472986
				],
				[
					33.02845736294478,
					24.954834452002842
				],
				[
					44.03794315059304,
					30.826560205415035
				],
				[
					55.78139465741788,
					38.16621739718062
				],
				[
					72.66260619847867,
					45.5058745889462
				],
				[
					85.87398914365656,
					52.84553178071178
				],
				[
					96.14950921212824,
					57.983291814947506
				],
				[
					109.36089215730624,
					66.05691472588956
				],
				[
					121.10434366413097,
					72.66260619847867
				],
				[
					129.9119322942497,
					77.06640051353793
				],
				[
					135.04969232848566,
					79.26829767106756
				],
				[
					148.99504099284013,
					85.87398914365644
				],
				[
					162.2064239380179,
					91.74571489706909
				],
				[
					173.94987544484275,
					96.14950921212835
				],
				[
					183.49142979413796,
					100.55330352718761
				],
				[
					188.6291898283739,
					102.75520068471724
				],
				[
					192.2990184242567,
					104.95709784224687
				],
				[
					195.2348813009628,
					106.42502928060003
				],
				[
					200.37264133519875,
					109.36089215730613
				],
				[
					209.91419568449396,
					114.49865219154208
				],
				[
					215.78592143790638,
					115.96658362989524
				],
				[
					218.72178431461248,
					116.70054934907171
				],
				[
					219.45575003378895,
					117.4345150682484
				],
				[
					220.18971575296564,
					117.4345150682484
				],
				[
					221.6576471913188,
					118.90244650660156
				],
				[
					224.5935100680249,
					119.63641222577803
				],
				[
					225.32747578720137,
					120.3703779449545
				],
				[
					226.79540722555453,
					121.10434366413097
				],
				[
					227.52937294473122,
					121.83830938330766
				],
				[
					228.99730438308416,
					123.30624082166082
				],
				[
					231.93316725979048,
					126.24210369836692
				],
				[
					235.60299585567327,
					128.44400085589655
				],
				[
					239.27282445155606,
					129.9119322942497
				],
				[
					240.740755889909,
					130.6458980134264
				],
				[
					242.94265304743863,
					132.11382945177934
				],
				[
					247.3464473624981,
					133.5817608901325
				],
				[
					254.68610455426347,
					137.2515894860153
				],
				[
					258.35593315014626,
					137.98555520519176
				],
				[
					259.8238645884994,
					138.71952092436845
				],
				[
					259.8238645884994,
					138.71952092436845
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 27,
			"versionNonce": 1839168747,
			"isDeleted": false,
			"id": "2_kh_2VPE_sBmwIOmsJeY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -400.37647089694747,
			"y": 1947.321555641983,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 14.679314383530937,
			"height": 16.881211541060566,
			"seed": 1563738646,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.7339657191764672
				],
				[
					0.7339657191764672,
					2.201897157529629
				],
				[
					1.4679314383529345,
					3.669828595882791
				],
				[
					2.201897157529629,
					5.137760034235953
				],
				[
					3.669828595882791,
					7.339657191765355
				],
				[
					5.1377600342357255,
					10.275520068471678
				],
				[
					6.605691472588887,
					11.74345150682484
				],
				[
					6.605691472588887,
					12.477417226001307
				],
				[
					7.339657191765355,
					13.211382945178002
				],
				[
					6.605691472588887,
					13.94534866435447
				],
				[
					5.1377600342357255,
					13.94534866435447
				],
				[
					2.201897157529629,
					13.94534866435447
				],
				[
					-1.4679314383531619,
					13.94534866435447
				],
				[
					-4.403794315059486,
					14.679314383530937
				],
				[
					-6.605691472589115,
					15.413280102707631
				],
				[
					-7.339657191765582,
					16.1472458218841
				],
				[
					-7.339657191765582,
					16.881211541060566
				],
				[
					-7.339657191765582,
					16.881211541060566
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 167,
			"versionNonce": 1540578117,
			"isDeleted": false,
			"id": "MIdQJkLx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -382.7520175107859,
			"y": 2104.0848411072457,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 430.3682861328125,
			"height": 60,
			"seed": 1913854794,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "beta, f_Cmin调参方法:\nbeta=0, 取一个最大的f_Cmin使得所有高频信息均被滤除掉.\n然后, 逐渐调大beta, 恢复部分高频信息, 直到融入噪声为止.",
			"rawText": "beta, f_Cmin调参方法:\nbeta=0, 取一个最大的f_Cmin使得所有高频信息均被滤除掉.\n然后, 逐渐调大beta, 恢复部分高频信息, 直到融入噪声为止.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "beta, f_Cmin调参方法:\nbeta=0, 取一个最大的f_Cmin使得所有高频信息均被滤除掉.\n然后, 逐渐调大beta, 恢复部分高频信息, 直到融入噪声为止.",
			"lineHeight": 1.25,
			"baseline": 54
		},
		{
			"type": "image",
			"version": 259,
			"versionNonce": 35039115,
			"isDeleted": false,
			"id": "_3JxzRKLxotQ2Dr1-1Sj_",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3255.6866616539796,
			"y": 249.1215674166433,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 1062.5381166366092,
			"height": 408.7820254282511,
			"seed": 827817226,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "7b2270b394d2489abd6fe59bc06123562ab72724",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 240,
			"versionNonce": 1603239467,
			"isDeleted": false,
			"id": "7tEy-ddO3QACj6HIfD8MW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3237.8832901809274,
			"y": 692.0562249230288,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 1062.5381166366092,
			"height": 438.2969731126013,
			"seed": 2116330006,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "5b708b148d5ce4de7df2c401c4f0a2ddd2a1b901",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 257,
			"versionNonce": 1104088581,
			"isDeleted": false,
			"id": "u93agYBi7Ou59_mI3ZJzS",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2812.8792234307093,
			"y": 1038.854887289834,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 87.56101146357231,
			"height": 79.69035874774569,
			"seed": 2048675146,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					-0.9838315894784537
				],
				[
					-1.967663178956572,
					-2.9514947684350257
				],
				[
					-5.902989536870051,
					-7.8706527158266235
				],
				[
					-8.854484305305077,
					-11.805979073740103
				],
				[
					-10.822147484261649,
					-13.773642252696675
				],
				[
					-11.805979073740103,
					-15.741305431653583
				],
				[
					-12.789810663218221,
					-17.708968610610153
				],
				[
					-13.773642252696675,
					-18.69280020008861
				],
				[
					-14.757473842175129,
					-19.676631789566727
				],
				[
					-15.741305431653247,
					-20.66046337904518
				],
				[
					-16.7251370211317,
					-21.644294968523635
				],
				[
					-17.708968610610153,
					-21.644294968523635
				],
				[
					-20.66046337904518,
					-23.611958147480205
				],
				[
					-25.579621326436776,
					-25.579621326436776
				],
				[
					-27.54728450539335,
					-27.547284505393684
				],
				[
					-29.514947684350258,
					-27.547284505393684
				],
				[
					-30.498779273828376,
					-28.531116094871802
				],
				[
					-31.482610863306828,
					-28.531116094871802
				],
				[
					-34.43410563174186,
					-28.531116094871802
				],
				[
					-36.40176881069843,
					-29.514947684350258
				],
				[
					-38.36943198965533,
					-30.49877927382871
				],
				[
					-39.353263579133454,
					-30.49877927382871
				],
				[
					-40.3370951686119,
					-30.49877927382871
				],
				[
					-42.30475834756848,
					-29.514947684350258
				],
				[
					-43.28858993704693,
					-29.514947684350258
				],
				[
					-44.272421526525385,
					-28.531116094871802
				],
				[
					-45.256253116003506,
					-27.547284505393684
				],
				[
					-46.240084705481955,
					-26.56345291591523
				],
				[
					-47.22391629496041,
					-24.595789736958658
				],
				[
					-48.207747884438525,
					-22.628126558001753
				],
				[
					-48.207747884438525,
					-20.66046337904518
				],
				[
					-48.207747884438525,
					-18.69280020008861
				],
				[
					-47.22391629496041,
					-16.7251370211317
				],
				[
					-47.22391629496041,
					-13.773642252696675
				],
				[
					-45.256253116003506,
					-10.822147484261649
				],
				[
					-43.28858993704693,
					-5.902989536870051
				],
				[
					-43.28858993704693,
					-3.9353263579134796
				],
				[
					-42.30475834756848,
					-0.9838315894784537
				],
				[
					-40.3370951686119,
					0.9838315894784537
				],
				[
					-39.353263579133454,
					3.9353263579134796
				],
				[
					-38.36943198965533,
					6.886821126348505
				],
				[
					-36.40176881069843,
					9.83831589478353
				],
				[
					-35.417937221220306,
					11.805979073740103
				],
				[
					-33.4502740422634,
					14.757473842175129
				],
				[
					-30.498779273828376,
					16.7251370211317
				],
				[
					-26.56345291591523,
					20.66046337904518
				],
				[
					-23.611958147480205,
					22.628126558001753
				],
				[
					-21.644294968523297,
					24.595789736958658
				],
				[
					-20.66046337904518,
					26.56345291591523
				],
				[
					-17.708968610610153,
					29.514947684350258
				],
				[
					-15.741305431653247,
					30.49877927382871
				],
				[
					-14.757473842175129,
					32.46644245278528
				],
				[
					-13.773642252696675,
					33.450274042263736
				],
				[
					-11.805979073740103,
					34.43410563174186
				],
				[
					-9.838315894783195,
					36.40176881069876
				],
				[
					-4.919157947391597,
					37.38560040017688
				],
				[
					0,
					39.35326357913379
				],
				[
					2.9514947684350257,
					40.3370951686119
				],
				[
					3.9353263579134796,
					40.3370951686119
				],
				[
					3.9353263579134796,
					41.32092675809036
				],
				[
					4.919157947391933,
					41.32092675809036
				],
				[
					8.854484305305077,
					43.28858993704693
				],
				[
					10.822147484261984,
					44.272421526525385
				],
				[
					12.789810663218557,
					44.272421526525385
				],
				[
					14.757473842175129,
					45.25625311600384
				],
				[
					16.725137021132035,
					45.25625311600384
				],
				[
					17.708968610610153,
					46.240084705481955
				],
				[
					19.67663178956706,
					46.240084705481955
				],
				[
					21.644294968523635,
					46.240084705481955
				],
				[
					23.611958147480205,
					47.22391629496041
				],
				[
					25.579621326437113,
					47.22391629496041
				],
				[
					28.53111609487214,
					48.20774788443887
				],
				[
					31.482610863307166,
					49.19157947391698
				],
				[
					33.450274042263736,
					49.19157947391698
				],
				[
					34.43410563174219,
					49.19157947391698
				],
				[
					35.417937221220306,
					49.19157947391698
				],
				[
					37.38560040017722,
					48.20774788443887
				],
				[
					38.36943198965533,
					47.22391629496041
				],
				[
					39.35326357913379,
					46.240084705481955
				],
				[
					39.35326357913379,
					45.25625311600384
				],
				[
					38.36943198965533,
					43.28858993704693
				],
				[
					38.36943198965533,
					42.304758347568814
				],
				[
					38.36943198965533,
					41.32092675809036
				],
				[
					38.36943198965533,
					38.36943198965533
				],
				[
					38.36943198965533,
					34.43410563174186
				],
				[
					38.36943198965533,
					30.49877927382871
				],
				[
					37.38560040017722,
					27.547284505393684
				],
				[
					36.40176881069876,
					25.579621326436776
				],
				[
					34.43410563174219,
					23.611958147480205
				],
				[
					33.450274042263736,
					21.644294968523635
				],
				[
					31.482610863307166,
					18.69280020008861
				],
				[
					29.514947684350258,
					15.741305431653583
				],
				[
					28.53111609487214,
					13.773642252696675
				],
				[
					26.56345291591523,
					10.822147484261649
				],
				[
					24.595789736958658,
					8.854484305305077
				],
				[
					23.611958147480205,
					6.886821126348505
				],
				[
					21.644294968523635,
					3.9353263579134796
				],
				[
					17.708968610610153,
					0.9838315894784537
				],
				[
					16.725137021132035,
					0
				],
				[
					14.757473842175129,
					-2.9514947684350257
				],
				[
					10.822147484261984,
					-6.886821126348505
				],
				[
					9.83831589478353,
					-8.854484305305077
				],
				[
					7.870652715826959,
					-10.822147484261649
				],
				[
					5.902989536870051,
					-11.805979073740103
				],
				[
					2.9514947684350257,
					-13.773642252696675
				],
				[
					-0.9838315894781182,
					-15.741305431653583
				],
				[
					-3.935326357913144,
					-16.7251370211317
				],
				[
					-4.919157947391597,
					-17.708968610610153
				],
				[
					-6.88682112634817,
					-19.676631789566727
				],
				[
					-7.8706527158266235,
					-20.66046337904518
				],
				[
					-8.854484305305077,
					-22.628126558001753
				],
				[
					-10.822147484261649,
					-23.611958147480205
				],
				[
					-11.805979073740103,
					-24.595789736958658
				],
				[
					-12.789810663218221,
					-24.595789736958658
				],
				[
					-12.789810663218221,
					-25.579621326436776
				],
				[
					-13.773642252696675,
					-25.579621326436776
				],
				[
					-14.757473842175129,
					-26.56345291591523
				],
				[
					-15.741305431653247,
					-26.56345291591523
				],
				[
					-16.7251370211317,
					-27.547284505393684
				],
				[
					-17.708968610610153,
					-27.547284505393684
				],
				[
					-17.708968610610153,
					-27.547284505393684
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 345,
			"versionNonce": 1799787525,
			"isDeleted": false,
			"id": "GPAxlyeo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2934.816476070887,
			"y": 1182.076840004887,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 528.6598510742188,
			"height": 75,
			"seed": 1698782858,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562936874,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "为了防止人脸边界重影, mask向外扩张太大.\nmask还是以小幅度向外扩充, 但保证在polygon内部全部为1. \n使用距离场更精准地进行控制.",
			"rawText": "为了防止人脸边界重影, mask向外扩张太大.\nmask还是以小幅度向外扩充, 但保证在polygon内部全部为1. \n使用距离场更精准地进行控制.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "为了防止人脸边界重影, mask向外扩张太大.\nmask还是以小幅度向外扩充, 但保证在polygon内部全部为1. \n使用距离场更精准地进行控制.",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "freedraw",
			"version": 239,
			"versionNonce": 1193870693,
			"isDeleted": false,
			"id": "AnYOslD7WW7HUIsw0b9mF",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2565.1104272563152,
			"y": 1012.4211704076963,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 61.13810591758253,
			"height": 70.62505338755244,
			"seed": 949224022,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.0541052744411765,
					1.0541052744411763
				],
				[
					-2.1082105488820173,
					2.1082105488823526
				],
				[
					-4.216421097764035,
					3.162315823323193
				],
				[
					-5.270526372205211,
					3.162315823323193
				],
				[
					-6.324631646646388,
					4.2164210977643695
				],
				[
					-7.378736921087564,
					5.270526372205546
				],
				[
					-8.43284219552874,
					6.324631646646386
				],
				[
					-9.486947469969918,
					8.432842195528739
				],
				[
					-11.595158018851599,
					9.486947469969916
				],
				[
					-13.703368567733952,
					10.541052744410756
				],
				[
					-15.811579116616304,
					12.649263293293108
				],
				[
					-18.973894939939164,
					14.757473842175127
				],
				[
					-21.082105488821515,
					16.865684391057478
				],
				[
					-23.19031603770387,
					17.91978966549832
				],
				[
					-24.244421312145047,
					20.028000214380672
				],
				[
					-26.352631861026726,
					21.08210548882151
				],
				[
					-27.406737135467903,
					22.13621076326269
				],
				[
					-28.46084240990908,
					23.190316037703866
				],
				[
					-29.514947684350258,
					24.244421312145043
				],
				[
					-30.569052958791435,
					25.298526586585883
				],
				[
					-30.569052958791435,
					27.406737135468234
				],
				[
					-31.62315823323261,
					28.460842409909077
				],
				[
					-32.67726350767345,
					29.514947684350254
				],
				[
					-33.731368782114295,
					31.623158233232605
				],
				[
					-34.785474056555465,
					33.73136878211462
				],
				[
					-35.83957933099664,
					34.7854740565558
				],
				[
					-36.89368460543782,
					36.89368460543781
				],
				[
					-37.947789879879,
					37.94778987987899
				],
				[
					-39.001895154320174,
					40.05600042876101
				],
				[
					-39.001895154320174,
					41.11010570320219
				],
				[
					-40.05600042876102,
					42.164210977643364
				],
				[
					-40.05600042876102,
					44.27242152652538
				],
				[
					-40.05600042876102,
					45.326526800966555
				],
				[
					-40.05600042876102,
					47.434737349848575
				],
				[
					-40.05600042876102,
					48.488842624289745
				],
				[
					-40.05600042876102,
					50.5970531731721
				],
				[
					-40.05600042876102,
					53.7593689964953
				],
				[
					-40.05600042876102,
					55.86757954537731
				],
				[
					-40.05600042876102,
					56.92168481981849
				],
				[
					-40.05600042876102,
					57.975790094259665
				],
				[
					-40.05600042876102,
					59.02989536870051
				],
				[
					-40.05600042876102,
					60.08400064314168
				],
				[
					-40.05600042876102,
					61.138105917582855
				],
				[
					-39.001895154320174,
					61.138105917582855
				],
				[
					-39.001895154320174,
					62.1922111920237
				],
				[
					-39.001895154320174,
					63.246316466464876
				],
				[
					-39.001895154320174,
					64.30042174090605
				],
				[
					-37.947789879879,
					65.35452701534723
				],
				[
					-36.89368460543782,
					67.46273756422924
				],
				[
					-35.83957933099664,
					67.46273756422924
				],
				[
					-34.785474056555465,
					68.51684283867041
				],
				[
					-32.67726350767345,
					69.57094811311126
				],
				[
					-31.62315823323261,
					69.57094811311126
				],
				[
					-28.46084240990908,
					69.57094811311126
				],
				[
					-27.406737135467903,
					69.57094811311126
				],
				[
					-27.406737135467903,
					70.62505338755244
				],
				[
					-26.352631861026726,
					70.62505338755244
				],
				[
					-23.19031603770387,
					69.57094811311126
				],
				[
					-20.028000214380338,
					69.57094811311126
				],
				[
					-17.91978966549832,
					69.57094811311126
				],
				[
					-12.649263293292776,
					67.46273756422924
				],
				[
					-10.541052744410758,
					67.46273756422924
				],
				[
					-8.43284219552874,
					66.40863228978807
				],
				[
					-7.378736921087564,
					66.40863228978807
				],
				[
					-5.270526372205211,
					65.35452701534723
				],
				[
					-3.162315823323194,
					63.246316466464876
				],
				[
					0,
					62.1922111920237
				],
				[
					1.0541052744411765,
					61.138105917582855
				],
				[
					3.1623158233235293,
					60.08400064314168
				],
				[
					4.21642109776437,
					59.02989536870051
				],
				[
					5.270526372205547,
					56.92168481981849
				],
				[
					7.378736921087564,
					55.86757954537731
				],
				[
					8.43284219552874,
					54.81347427093613
				],
				[
					9.486947469969918,
					52.70526372205412
				],
				[
					10.541052744411093,
					50.5970531731721
				],
				[
					12.64926329329311,
					47.434737349848575
				],
				[
					13.703368567733952,
					45.326526800966555
				],
				[
					14.757473842175129,
					43.218316252084534
				],
				[
					16.86568439105748,
					41.11010570320219
				],
				[
					17.91978966549866,
					39.00189515432017
				],
				[
					17.91978966549866,
					35.839579330996976
				],
				[
					18.9738949399395,
					32.677263507673445
				],
				[
					20.028000214380675,
					29.514947684350254
				],
				[
					20.028000214380675,
					27.406737135468234
				],
				[
					21.082105488821515,
					24.244421312145043
				],
				[
					21.082105488821515,
					22.13621076326269
				],
				[
					21.082105488821515,
					18.973894939939495
				],
				[
					21.082105488821515,
					16.865684391057478
				],
				[
					21.082105488821515,
					15.811579116616302
				],
				[
					21.082105488821515,
					14.757473842175127
				],
				[
					21.082105488821515,
					13.70336856773395
				],
				[
					20.028000214380675,
					12.649263293293108
				],
				[
					18.9738949399395,
					10.541052744410756
				],
				[
					17.91978966549866,
					9.486947469969916
				],
				[
					17.91978966549866,
					8.432842195528739
				],
				[
					16.86568439105748,
					6.324631646646386
				],
				[
					15.811579116616304,
					6.324631646646386
				],
				[
					14.757473842175129,
					6.324631646646386
				],
				[
					14.757473842175129,
					5.270526372205546
				],
				[
					11.595158018851935,
					4.2164210977643695
				],
				[
					10.541052744411093,
					3.162315823323193
				],
				[
					9.486947469969918,
					2.1082105488823526
				],
				[
					9.486947469969918,
					2.1082105488823526
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "image",
			"version": 189,
			"versionNonce": 1608527723,
			"isDeleted": false,
			"id": "Y783wnNG7pIunphPAC6Lo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3216.957036027918,
			"y": 1145.3383924870482,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 256,
			"height": 256,
			"seed": 1291664650,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "87194a552129f3e2f4058fd91cb37934dd8daf4d",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 84,
			"versionNonce": 822939845,
			"isDeleted": false,
			"id": "pggYjtIL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2922.3087929481344,
			"y": 1275.5601735208313,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 725.7923583984375,
			"height": 50,
			"seed": 35741910,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562689869,
			"link": "https://stackoverflow.com/questions/68178747/fast-2d-signed-distance\nhttps://www.shadertoy.com/view/WdSGRd",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐https://stackoverflow.com/questions/68178747/fast-2d-signed-distance\nhttps://www.shadertoy.com/view/WdSGRd",
			"rawText": "https://stackoverflow.com/questions/68178747/fast-2d-signed-distance\nhttps://www.shadertoy.com/view/WdSGRd",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐https://stackoverflow.com/questions/68178747/fast-2d-signed-distance\nhttps://www.shadertoy.com/view/WdSGRd",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "image",
			"version": 118,
			"versionNonce": 480555819,
			"isDeleted": false,
			"id": "XaSXEBup6KlkNwGvQEBI8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3232.0412368709153,
			"y": 1478.3827088155413,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 1095.5555555555547,
			"height": 328.66666666666646,
			"seed": 1915064491,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562777669,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "318654661a1532c33f83a2a3ba5083bfe3ee70be",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 71,
			"versionNonce": 1188079595,
			"isDeleted": false,
			"id": "v9aBZtD0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3212.0412368709153,
			"y": 1812.218966125483,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 807.619873046875,
			"height": 25,
			"seed": 1895475403,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1689562761516,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "python版本(使用了类似距离场的设置, 且外扩较小): 特征点检测不准确, 导致mask估计变大",
			"rawText": "python版本(使用了类似距离场的设置, 且外扩较小): 特征点检测不准确, 导致mask估计变大",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "python版本(使用了类似距离场的设置, 且外扩较小): 特征点检测不准确, 导致mask估计变大",
			"lineHeight": 1.25,
			"baseline": 18
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
		"currentItemFontSize": 20,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 3599.501554331233,
		"scrollY": -815.1815287821248,
		"zoom": {
			"value": 0.9500000000000002
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