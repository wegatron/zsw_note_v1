---

excalidraw-plugin: parsed
tag: digital_human

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

人头拓扑转换
nonrigidicp ^IchVkKTI

nonrigid icp ^V6N22vpX

wrap4d ^fdFHoUCn

自动选点, 或载入选择的点.
效果略差, 可批量, 自动, 在线实时 ^XaN440GL

有ui, 全流程, 效果好. 适合离线操作 ^aqj9R219

纹理迁移 ^3KG5uJnY

光栅化 ^0wXJKpN0

RBF ^aJoArfPn

使用RBF生成固定的权重映射 ^qzi1qO55

alpha是weight, phi是径向基,
对于3d, each dimension: ^2FE6ESD8

mx1 ^D14uIIxK

mxm ^CGmYRB2A

mx1 ^6KgIh5Go

hifi3d ^NNFOXEml

flame ^lxVaoPht

htemp_tgt ^HkesyX9F

ftemp ^yTQI45Uu

h_tgt ^ZzapQBI8

f_tgt ^PpqBSz1W

RBF ^LUZMZpI1

nicp align ^VCzeqDp3

samples ^a8KLpOL9

querys ^a3WX3bN5

Image Blending主要处理的是 foreground mask/matting不干净的问题. ^XgZhwrsb

Image Harmonization主要解决光照整体不一致的问题, 比如说晚上和白天拍摄的照片. ^4Mydrucy

最终混合时, 背景和前景不是同一个物体 ^l2J9k3FN

将图像B贴入图像A中, 可以改变B的整体颜色, 但保持梯度不变. 将图像 B 边界上的像素与图像 A 中 B 所在位置上的像素相等，然后求解图像 B 内部其他像素的梯度，以保留图像 B 的原始梯度 ^u9AY5I19

S: 背景, 其二维标量场构成的函数为 f*
g: 前景, 其二维标量场构成的函数为 f
v: 期望的目标梯度场 ^dROu5UpL

目标区域 ^Y4D0JQ5G

目标区域的边界区域 ^0ebaf1M3

目标函数(边界与背景一致的情况下, 竟可能保持\Omega中的梯度信息不变): ^mu4KOqEx

Poisson Image Editing ^m2o6lnDE

importing gradients,
直接使用指定的梯度 ^VTk6ZZJK

mix gradients
使用混合的梯度, 也适用于将与背景很相似的物体添加到背景中 ^IY3kWBuk

[SeamlessGAN](https://carlosrodriguezpardo.es/projects/SeamlessGAN/)生成皮肤纹理 ^onPXWxqp

皮肤纹理生成: https://yihua7.github.io/NeRF-Texture-web/ ^v03NyOZj

腐蚀之后的mask ^shH9DPyA

mouth mask ^rF71EYFJ

left major valid ^KJw2hegh

left minor valid ^dpnXc73L

tex_mask * minor_valid_mask ^pR7Hz6MR

clamp(major_valid_mask+blur_mask_minor) ^w5KM2r6L

blur ^tcb8Xxmi

tex_mask * fill_mask_blur ^ZiFhHIc2

Linear Blend ^hvu6hzYB

FFHQ-UV Blender ^in0iinLU

fill mask ^GaC92e14

unreliable part mask ^kFgrUCit

solve unreliable part using possion ^nVxSrZ7u

[fast marching algorithm](https://math.berkeley.edu/~sethian/2006/Explanations/fast_marching_explain.html) ^QCcI23QR

计算了一个面边界演化的情况:
给定一个边界, 边界以一定的速度F(x)向外扩张,
计算得到一个time arrival曲面.

skfmm中phi中可以定义一个高纬度的array. 但只有值为0的边界是有意义的. ^QaKRIbJE

使用color curve实现肤色迁移 ^xM4KsgAg

通过多个采样点, 拟合生成一个mapping曲线 ^PSPXo3Dv

黑色部分颜色小于均值, 而其他皮肤过曝.

肤色迁移手光照、阴影影响很大 ^V0KmBZa6

+std迁移 ^d2S9kCad

没有std迁移 ^DneM9qXz

原图 ^3OnBbIQk

目标图像 ^JKqlfaNx

亮度不做迁移, 只迁移肤色!!!! ^xP0Hgbue

将视频人物皮肤迁移到人脸上 ^raqw3qeJ

人脸皮肤迁移到视频人物上 ^51wALotB

更好的皮肤:
https://github.com/yihua7/NeRF-Texture
https://devashi-choudhary.medium.com/texture-synthesis-generating-arbitrarily-large-textures-from-image-patches-32dd49e2d637 ^Tk5mhurx

blender hair:
https://www.youtube.com/watch?v=_-d0HaT5f1g ^cJ42naKi

arkit to flame:
①使用flame拟合arkit脸, 再进行形变. 
②通过特征点进行对齐, 形变 ^9XyxiPaV

[unreal livelink face importer 基于表情基实现面部整体驱动](https://docs.unrealengine.com/5.1/en-US/live-link-plugin-development-in-unreal-engine/) ^slhZdDOw

RBF based face animation retargeting ^G1aZzoRI

相同shape, 转换拓扑结构 ^RSpoAnBM

相同的拓扑, shape deform 映射 ^RB1lGLY8

X_012 对应的是不同人头id, 其中0是程序内部id, 2表示arkit mesh序列对应的人头id, 1是目标人头的id
T表示template, 是程序的内部数据
meanA 表示Arkit的无表情状态
meanB 表示Flame无表情状态 ^PRcqshOm

3D 人头重建 ^9YXvVwvz

Hifi3d ^IwZiuq0S

color loss ^OvczzAbu

perceptual loss ^GZd0yv9t

landmark loss ^NmpLNn4L

Hifi3d++ ^wZH05pph

depth loss ^rx48cmjE

将人头拆分成几个部分,
增强表达能力 ^doXDzFP9

FLAME ^NIuaUGPw

SynergyNet ^dt6rQLG4

deep3d
+ opt ^CfiuI0LZ

DAD-3DHeads ^oeNQESXe

SPECTRE ^NUH8HSDQ

[MICA](https://github.com/Zielon/MICA) ^wkhjOafi

DECA ^j4klPttw

直接根据arkface特征推断flame coeff
后期可以再加入优化步骤 ^sswZWHLI

[TEMPEH](https://github.com/TimoBolkart/TEMPEH) ^ko5KAEs2

MediaPipe(dense) ^OIPwhEqw

添加了嘴部动作的loss, 能够进行嘴型对齐 ^6sKti1Y7

人脸特征点+pose更准确, 特别对于极端case ^H8kOmjM1

基于多视图几何, 需要相机内外参 ^BYZJ47li

混合方案: 将脖子设计成半透明, 与背景进行混合 ^4jtg7RK5

metahuman face control rig export:
demo: https://blenderartists.org/t/metahuman-rig-for-blender-implement-demo/1446967
detail: https://www.youtube.com/watch?v=aHHkNSBVA9s ^j8DOyZSd


# Embedded files
a94e6b13e717897491707ac9d7132e2131ffe49f: $$\begin{aligned} u' = \frac{u-0.5 ts}{s}+t_0\\ v' = \frac{v-0.5 ts}{s}+t_1 \end{aligned}$$
32ae88891bda452912d09dad879710ca362ca4e8: $$\begin{bmatrix} \frac{f}{s} & 0 & \frac{2c-ts}{2s} + t_0\\ 0 & \frac{f}{s} & \frac{2c-ts}{2s} + t_1\\ 0 & 0 & 1 \end{bmatrix}$$
08703324a9f6f5e1d8520afa2af5ecc05a47ea4f: $$\frac{1}{Z}\begin{bmatrix} u\\ v\\ 1\end{bmatrix} \sim \begin{bmatrix} f & 0 & c\\ 0 & f & c\\ 0 & 0 & 1 \end{bmatrix} \begin{bmatrix} X\\ Y\\ Z\end{bmatrix}$$
905055ec0a5cce209e9aa22b65d791ebcff56e2c: $$\begin{aligned} \hat{x}_i = x_{i-1} + \alpha(x_i - x_{i-1})\\ \alpha = \frac{x_i - x_{i-1}}{d} (h-l) + l \end{aligned}$$
479c1be74938232ad6e7426348a3c07eafd972e5: $$T_{hifi3d}^{view} = T_{3ddfa}^{view} * T_{pose\_3ddfa} * T_{hifi3d}^{3ddfa}$$
914dc48a0e8cf3e995269453f8848efe7771bfd1: $$Translate * Rotation * Scale$$
8c0d6fee0a87976dc1c6967cc6fb6c971e1c55f8: $$\begin{bmatrix} u\\ v\\ 1\\ \end{bmatrix} \sim \begin{bmatrix} f_x & 0 & c_x & 0\\ 0 & f_y & c_y & 0\\ 0 & 0 & 1 & 0 \end{bmatrix} \cdot T \cdot \begin{bmatrix} X\\ Y\\ Z\\ 1\\ \end{bmatrix}$$
3b32af8c3a9a769e46496863bd1eb888aff55a36: $$R = R_{local}^{view} * R_{pose\_local}$$
a5bd19904156bc09be15a44620c5bef264abf44d: $$\begin{aligned} &f(\mathrm{x}) \approx s(\mathrm{x}) = \sum_{i=1}^N \alpha_i \phi_i(\mathrm{x})\\ &\mathrm{with} \; \phi_i(\mathrm{x}) = \phi(\parallel \mathrm{x} - \mathrm{x}_i \parallel) \end{aligned}$$
7ad6b7c7061763d975248e671d2cd7586301807d: $$s^j(\mathrm{x}) = \sum_{i=1}^N \alpha_i^j \phi_i(\mathrm{x})$$
6ba74f9841b8921972080db98ef7dc99d2607f82: $$\Delta \mathrm{x}^j = \phi \cdot \alpha^j$$
ddc6ab93dfdf04908d365f3b5771df3a798e2aad: $$\Omega$$
4e1f37fed50eaaa76822e8e48c71785fdc5bdcb9: $$\partial \Omega$$
285c0bb842666c85a0a76a27e1ee513738580e9e: $$\min \iint_\Omega | \nabla f - v |^2 \; \; \mathrm{with} \; f|_{\partial \Omega} = f^* |_{\partial \Omega}$$
c95873972990a1e8ad144cdcb436452591a67119: $$\mathbf{v} = \nabla g$$
5827e3bac210550fa54d33285aac05a1e277868d: $$\mathbf{v}(\mathbf{x}) = \left\{ \begin{aligned} &\nabla f^*(\mathbf{x}) \; \; \; \mathrm{if} \; | \nabla f^* (\mathbf{x})| > |\nabla g(\mathbf{x})|\\ &\nabla g(\mathbf{x}) \; \; \; \mathrm{otherwise}\end{aligned}\right.$$
7f64417dda1392fc2f3429e9d79fbc7e4240d0c7: $$\begin{aligned} X_2 F_{meanB} &\longleftrightarrow X_1 F_{meanA}\\ X_2 F_* &\Longrightarrow X_1F_* \end{aligned}$$
6224e1aa9605347104e90d0bc748f16a2e57f503: $$X_1F_* \approx X_1F_{meanB} + (X_2F_* - X_2F_{meanA})$$
fbce96bdfeb9587a1d220fb239e3a97ece647287: $$\begin{aligned} X_0 T A_{meanA} &\longleftrightarrow X_0 F_{meanA} \; \; \mathrm{aligned \; using \; NICP}\\ X_2 A_{meanA} &\Longrightarrow X_2 F_{meanA}\\ X_2 A_* &\Longrightarrow X_2 F_* \end{aligned}$$
5b0cf41e04dcb5b40b1cbdc407a0c981fc65937c: [[head_swap_face_lm.png]]
224014bb396acd9b6d11b829ff416ee6f1a47986: [[head_swap_face_mask.png]]
fd20c960045324146f5ab73a3a21f9284412e0ff: [[one_euro_filter.png]]
cd3d9face5bb3c2e206956ad3a4998f9c1516d71: [[one_euro_filter_code2.png]]
1c56a3836ede007d1b77eabca7dd777497730a13: [[one_euro_filter_code1.png]]
62ea47165b299af2e758ef1b022ab36061a3ec0b: [[talking_head_blend_mask.png]]
a8a3479038935d3d6db5015b94a2b6ba53c5368c: [[pin_hole_camera.png]]
a1a6e7c992d4929cdac8abfdb56894e18c998357: [[rc/Pasted Image 20230710111743_021.png]]
42eba91b8e56930691b50284545929d060842082: [[rc/Pasted Image 20230711181353_691.png]]
7b2270b394d2489abd6fe59bc06123562ab72724: [[rc/Pasted Image 20230713105145_448.png]]
5b708b148d5ce4de7df2c401c4f0a2ddd2a1b901: [[rc/Pasted Image 20230713105200_463.png]]
87194a552129f3e2f4058fd91cb37934dd8daf4d: [[rc/Pasted Image 20230713135319_150.png]]
318654661a1532c33f83a2a3ba5083bfe3ee70be: [[rc/Pasted Image 20230717105855_864.png]]
86dfab85d0d3ac7276538ef8409d343b3fae9cea: [[rc/Pasted Image 20230724092115_053.png]]
f835ba52d54be6bc3c027025dc2942b6785ddd2b: [[rc/Pasted Image 20230724094037_201.png]]
4565d89b3c5529ba5700f175e6cc6179ec9b6468: [[rc/Pasted Image 20230724095038_265.png]]
3631e9cecba4c92d85af8c973d2889c472c0d07e: [[rc/Pasted Image 20230724113938_993.png]]
c5ee388b899ba950ac0f821a51dce7c77ccc8a82: [[rc/Pasted Image 20230724142835_475.png]]
ecbb6327d8d3454a2626fe8e843bfd856139e8a4: [[rc/Pasted Image 20230724143131_518.png]]
3dd54594c2e9839ef70576c99031e91bdaeecae8: [[rc/Pasted Image 20230726155933_591.png]]
7eac5a36ed8e2c0f24912a1b039f95fc4ea5dd05: [[rc/Pasted Image 20230726160138_656.png]]
9166d93f07a00e3267314a3d39b681005686122d: [[rc/Pasted Image 20230726160440_687.png]]
1353d70d4a079358d21bcbd10ce1517a974da5d3: [[rc/Pasted Image 20230726160541_722.png]]
42f971d63cae8093237ab832e590fc688923dad1: [[rc/Pasted Image 20230726160611_735.png]]
801ef5d4449614d91aaf298d4759d6efa49a4e26: [[rc/Pasted Image 20230726160813_771.png]]
059bd6951a9072da6e37dc09b63dde8778c67069: [[rc/Pasted Image 20230726161005_734.png]]
a55261d69d817b9b3f4f1d25805c49c753d18522: [[rc/Pasted Image 20230726161121_743.png]]
3fe47a3be0802c75dc51a2f6e1b39aa88d35bccd: [[rc/Pasted Image 20230726162003_920.png]]
3b9efa19a39e0115667c987fcf079eea45b9fc1a: [[rc/Pasted Image 20230726162018_921.png]]
68609e5ec34d805a460b716460c7b1d55e872441: [[rc/Pasted Image 20230726162800_015.png]]
fbef0c0bb114fc0840c1d1e338e6e366281f6f77: [[rc/Pasted Image 20230726163033_057.png]]
87479a655cda699de429a61695655dbe094b070f: [[rc/Pasted Image 20230726163920_154.png]]
c3651f60b292fbd87e193b42866d064d67a7f73c: [[rc/Pasted Image 20230726164238_225.png]]
e03bd67a933ebf0da41d9e57398253a6cc193b3e: [[rc/Pasted Image 20230726164754_324.png]]
1894236d2409c557c6595f98e56b859effdb68d8: [[rc/Pasted Image 20230726165129_345.png]]
df7e8fd5d326d39f8b73ac7c1238f98a9cc817c2: [[rc/Pasted Image 20230726165459_366.png]]
d800e431f073a33de782cc27b931df3550595038: [[rc/Pasted Image 20230728152231_959.png]]
cfaf280be0d1de99a281888a5cd574f0cbb0c515: [[rc/Pasted Image 20230728152331_016.png]]
bdf648271cc6f34d0efb0ee645aeee54a59ff66d: [[rc/Pasted Image 20230728152458_935.png]]
e26c846251d3538a4bd7fba980c995073095b36e: [[rc/Pasted Image 20230728174205_287.png]]
1eff8b522e5961fe78cfc1061ed1ce201250f662: [[rc/Pasted Image 20230728174220_317.png]]
4ca6f63d20ff8cba0a92995e2ecda344d8f0a3c3: [[rc/Pasted Image 20230728174235_320.png]]
34d739230e0b1b2b4d95abcd437969d70dfb8f77: [[rc/Pasted Image 20230802142521_464.png]]
a508f042c708aa3bf62688ec622ec4609b598219: [[rc/Pasted Image 20230802195514_513.png]]
a1dd5a6d2400ef7f5c61b590a15e49149077010f: [[rc/Pasted Image 20230802195629_525.png]]
2b696b3825365b627f2d16676df331ea6ee54220: [[rc/Pasted Image 20230802195929_531.png]]
1043e42b46cb78906aa88553e62753c8be1c54ab: [[rc/Pasted Image 20230802200230_545.png]]
84807b01215c66921f72101aafa5b772afb95ca6: [[rc/Pasted Image 20230802200600_561.png]]
22ba6437d03b159118657e441abb25a72af6f6bc: [[rc/Pasted Image 20230802200844_676.png]]
632f74d8263393f604ed6f170f7a661176c78edb: [[rc/Pasted Image 20230802202159_750.png]]
4716b3142356e4e0e427830a30900c93a9e23ef8: [[rc/Pasted Image 20230803151751_876.png]]
db7c4e765520927ab13b3759f09aaa97572475c3: [[rc/Pasted Image 20230803152636_916.png]]
c9bc65e64c41fe323d111f091aadeb0962ba1798: https://i.ytimg.com/vi/qM9amZJUIok/maxresdefault.jpg

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
			"versionNonce": 1050617414,
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
			"updated": 1693807487406,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 193,
			"versionNonce": 1526843674,
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
			"updated": 1693807487406,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 148,
			"versionNonce": 632188294,
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
			"updated": 1693807487406,
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
			"version": 377,
			"versionNonce": 618501594,
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
			"updated": 1693807487406,
			"link": null,
			"locked": false,
			"customData": {
				"legacyTextWrap": true
			}
		},
		{
			"type": "text",
			"version": 169,
			"versionNonce": 1372769478,
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
			"updated": 1693807487406,
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
			"version": 612,
			"versionNonce": 52546202,
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
			"updated": 1693807487407,
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
			"version": 113,
			"versionNonce": 279528454,
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
			"updated": 1693807487407,
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
			"version": 186,
			"versionNonce": 478242650,
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
			"updated": 1693807487407,
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
			"version": 102,
			"versionNonce": 1949225798,
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
			"updated": 1693807487407,
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
			"version": 160,
			"versionNonce": 1229941786,
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
			"updated": 1693807487407,
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
			"version": 171,
			"versionNonce": 1187019398,
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
			"updated": 1693807487407,
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
			"version": 102,
			"versionNonce": 1602148570,
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
			"updated": 1693807487407,
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
			"version": 102,
			"versionNonce": 2132490694,
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
			"updated": 1693807487408,
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
			"version": 102,
			"versionNonce": 2124590490,
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
			"updated": 1693807487408,
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
			"version": 101,
			"versionNonce": 878448902,
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
			"updated": 1693807487408,
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
			"version": 102,
			"versionNonce": 1542318682,
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
			"updated": 1693807487408,
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
			"version": 102,
			"versionNonce": 301989958,
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
			"updated": 1693807487408,
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
			"version": 800,
			"versionNonce": 238259994,
			"isDeleted": false,
			"id": "S2atMr7f",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -456.23005716288355,
			"y": -205.44720632557465,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 154.27294268623524,
			"height": 79.37231109219348,
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
			"updated": 1693807487408,
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
			"version": 488,
			"versionNonce": 1273235334,
			"isDeleted": false,
			"id": "tnFuaTvn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -457.30066038737914,
			"y": -17.620677382240856,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 167.87271964199545,
			"height": 80.57890542815781,
			"seed": 97293,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "NepJOYlre4O-t0nyyqiIc",
					"type": "arrow"
				}
			],
			"updated": 1693807487408,
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
			"version": 391,
			"versionNonce": 1508285402,
			"isDeleted": false,
			"id": "Lq7uBNhj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -176.77778771469892,
			"y": -364.1158220550261,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 211.16772114036013,
			"height": 69.27195085027688,
			"seed": 26135,
			"groupIds": [
				"RsLXgehyl-tFSNX7dRLbC"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487408,
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
			"version": 369,
			"versionNonce": 306521798,
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
			"updated": 1693807487409,
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
			"version": 561,
			"versionNonce": 2098860186,
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
			"updated": 1693807487409,
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
			"version": 96,
			"versionNonce": 96493062,
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
			"updated": 1693807487409,
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
			"version": 229,
			"versionNonce": 2072046938,
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
			"updated": 1693807487409,
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
			"version": 89,
			"versionNonce": 726838598,
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
			"updated": 1693807487409,
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
			"version": 171,
			"versionNonce": 1785606682,
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
			"width": 184.6328125,
			"height": 18.4,
			"seed": 1380261585,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487409,
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
			"version": 153,
			"versionNonce": 1616450694,
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
			"updated": 1693807487409,
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
			"version": 858,
			"versionNonce": 1020583642,
			"isDeleted": false,
			"id": "optIWpe7CYewdz1T2yVn1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 277.1942959846861,
			"y": 289.641041837972,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 623.9421297898965,
			"height": 689.9130810925225,
			"seed": 251128869,
			"groupIds": [
				"3G5ew0XposjAGcQ6gEypb",
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487410,
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
			"version": 689,
			"versionNonce": 1318097862,
			"isDeleted": false,
			"id": "ukQ3lTSNQNsOVamlA542-",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 388.32888909035574,
			"y": 814.998228331561,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 355.7420511559876,
			"height": 125.34292230139683,
			"seed": 214197611,
			"groupIds": [
				"3G5ew0XposjAGcQ6gEypb",
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1693807487410,
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
					27.531971372561145,
					46.36963599589241
				],
				[
					62.30919836948056,
					77.52423518063269
				],
				[
					110.1278854902447,
					104.33168099075803
				],
				[
					176.05971167190427,
					125.34292230139683
				],
				[
					240.54248672869227,
					115.19956442729533
				],
				[
					288.3611738494564,
					93.46379755422073
				],
				[
					326.036503096119,
					71.00350511871034
				],
				[
					355.7420511559876,
					31.879124747176085
				]
			]
		},
		{
			"type": "line",
			"version": 463,
			"versionNonce": 256373658,
			"isDeleted": false,
			"id": "Ao4ybPXvelQX1cmaZC7Hs",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 742.6218891214717,
			"y": 845.4283019538652,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 157.94657261100883,
			"height": 0.7245255624358056,
			"seed": 1485755653,
			"groupIds": [
				"3G5ew0XposjAGcQ6gEypb",
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1693807487410,
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
					157.94657261100883,
					0.7245255624358056
				]
			]
		},
		{
			"type": "line",
			"version": 393,
			"versionNonce": 1612065542,
			"isDeleted": false,
			"id": "UGoUHEplOntBcwCl2NLA2",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 387.60436352791993,
			"y": 813.5491772066891,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 109.40335992780878,
			"height": 0.7245255624358056,
			"seed": 1333138507,
			"groupIds": [
				"3G5ew0XposjAGcQ6gEypb",
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1693807487410,
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
					-109.40335992780878,
					-0.7245255624358056
				]
			]
		},
		{
			"type": "text",
			"version": 317,
			"versionNonce": 1945792602,
			"isDeleted": false,
			"id": "gVnOqLuJ",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 428.7017408477462,
			"y": 994.1234945729155,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 443.97283935546875,
			"height": 52.07603329960817,
			"seed": 915590053,
			"groupIds": [
				"zDmmB5ijppNtadWLtDFD-"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487410,
			"link": null,
			"locked": false,
			"fontSize": 15.09450240568353,
			"fontFamily": 2,
			"text": "数字人换头: 虚线以上部分mask out\n根据特征点, 得到绿色虚线, 向下沿着法向移动距离s, 得到黑色虚线.\ns = 0.2 *(y[33] - y[8])",
			"rawText": "数字人换头: 虚线以上部分mask out\n根据特征点, 得到绿色虚线, 向下沿着法向移动距离s, 得到黑色虚线.\ns = 0.2 *(y[33] - y[8])",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "数字人换头: 虚线以上部分mask out\n根据特征点, 得到绿色虚线, 向下沿着法向移动距离s, 得到黑色虚线.\ns = 0.2 *(y[33] - y[8])",
			"lineHeight": 1.15,
			"baseline": 49
		},
		{
			"type": "image",
			"version": 335,
			"versionNonce": 862378566,
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
			"updated": 1693807487410,
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
			"version": 436,
			"versionNonce": 1052726554,
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
			"updated": 1693807487410,
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
			"version": 536,
			"versionNonce": 257925510,
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
			"updated": 1693807487410,
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
			"version": 363,
			"versionNonce": 1359585754,
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
			"updated": 1693807487411,
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
			"version": 319,
			"versionNonce": 1463648454,
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
			"updated": 1693807487411,
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
			"version": 328,
			"versionNonce": 1709987482,
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
			"updated": 1693807487411,
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
			"version": 329,
			"versionNonce": 2124249094,
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
			"updated": 1693807487411,
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
			"version": 326,
			"versionNonce": 1578791770,
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
			"updated": 1693807487411,
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
			"version": 305,
			"versionNonce": 2105313094,
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
			"updated": 1693807487411,
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
			"version": 302,
			"versionNonce": 199686170,
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
			"updated": 1693807487411,
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
			"version": 303,
			"versionNonce": 1144499846,
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
			"updated": 1693807487412,
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
			"version": 308,
			"versionNonce": 2135221466,
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
			"updated": 1693807487412,
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
			"version": 305,
			"versionNonce": 797699526,
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
			"updated": 1693807487412,
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
			"version": 301,
			"versionNonce": 1372010906,
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
			"updated": 1693807487412,
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
			"version": 641,
			"versionNonce": 2090222854,
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
			"updated": 1693807487412,
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
			"version": 1018,
			"versionNonce": 1923151450,
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
			"updated": 1693807487412,
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
			"version": 345,
			"versionNonce": 1020507206,
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
			"updated": 1693807487412,
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
			"version": 193,
			"versionNonce": 1923423002,
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
			"updated": 1693807487412,
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
			"version": 292,
			"versionNonce": 1243691910,
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
			"updated": 1693807487413,
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
			"version": 487,
			"versionNonce": 1346807770,
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
			"updated": 1693807487413,
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
			"version": 185,
			"versionNonce": 985389766,
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
			"updated": 1693807487413,
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
			"version": 597,
			"versionNonce": 1134075034,
			"isDeleted": false,
			"id": "0R5R9q0M",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 342.82400640666583,
			"y": 1269.5024168195862,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 481.69921875,
			"height": 46,
			"seed": 723108229,
			"groupIds": [
				"aH0aixCrIBADjttmNgMRY"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487413,
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
			"version": 763,
			"versionNonce": 1430295046,
			"isDeleted": false,
			"id": "IViMSU1UxkBBIYeYQv7JA",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 336.7581800761336,
			"y": 1323.14189054723,
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
			"updated": 1693807487413,
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
			"version": 770,
			"versionNonce": 172882266,
			"isDeleted": false,
			"id": "0VEzaoWkCb7uZ7BJJAEe_",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 688.0014107017173,
			"y": 1664.1381474902373,
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
			"updated": 1693807487413,
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
			"version": 489,
			"versionNonce": 78405958,
			"isDeleted": false,
			"id": "ymSmZkkmdsNqUj_C4saA9",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 131.00141070171776,
			"y": 1657.6381474902373,
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
			"updated": 1693807487413,
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
			"version": 624,
			"versionNonce": 867810842,
			"isDeleted": false,
			"id": "lsnQ75wY",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dashed",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 343.91992121947806,
			"y": 1059.3732478169363,
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
			"updated": 1693807487413,
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
			"version": 545,
			"versionNonce": 1281116294,
			"isDeleted": false,
			"id": "Zu66uRgu8t01CC2BTdsjY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 347.2809413731409,
			"y": 1108.7255197497173,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 193.66637980472157,
			"height": 60.103359249741175,
			"seed": 171144433,
			"groupIds": [
				"YGXRtOJc_TtuFjDI-4ZvX"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487413,
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
			"version": 321,
			"versionNonce": 1825499866,
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
			"updated": 1693807487414,
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
			"version": 102,
			"versionNonce": 1007503302,
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
			"updated": 1693807487414,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 187,
			"versionNonce": 1277198234,
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
			"updated": 1693807487414,
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
			"version": 252,
			"versionNonce": 1675386630,
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
			"updated": 1693807487414,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 334,
			"versionNonce": 501316698,
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
			"updated": 1693807487414,
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
			"version": 207,
			"versionNonce": 1212583494,
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
			"updated": 1693807487414,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 79,
			"versionNonce": 803528986,
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
			"updated": 1693807487414,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 112,
			"versionNonce": 1445516678,
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
			"updated": 1693807487414,
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
			"version": 178,
			"versionNonce": 496872922,
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
			"updated": 1693807487415,
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
			"version": 1239,
			"versionNonce": 1455436998,
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
			"updated": 1693807487415,
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
			"version": 739,
			"versionNonce": 471786138,
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
			"updated": 1693807487415,
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
			"version": 157,
			"versionNonce": 1672064006,
			"isDeleted": false,
			"id": "k8O9TiiV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 594.3406580517136,
			"y": -337.51807623723283,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 283.1360097197105,
			"height": 27.400259005133275,
			"seed": 30242,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "yGEEYXU0Vr7Vb_fSZc50u",
					"type": "arrow"
				}
			],
			"updated": 1693807487415,
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
			"version": 504,
			"versionNonce": 1176207194,
			"isDeleted": false,
			"id": "3drXIovi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 847.8388290143014,
			"y": -196.65421072282984,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 194.3102637701903,
			"height": 11.430015515893546,
			"seed": 11078,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "yGEEYXU0Vr7Vb_fSZc50u",
					"type": "arrow"
				}
			],
			"updated": 1693807487415,
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
			"version": 827,
			"versionNonce": 1524775750,
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
			"updated": 1693807487415,
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
			"version": 94,
			"versionNonce": 1743160346,
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
			"updated": 1693807487415,
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
			"version": 183,
			"versionNonce": 1388765830,
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
			"updated": 1693807487416,
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
			"version": 370,
			"versionNonce": 1265823962,
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
			"updated": 1693807487416,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 322,
			"versionNonce": 236233158,
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
			"updated": 1693807487416,
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
			"version": 247,
			"versionNonce": 72598938,
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
			"updated": 1693807487416,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 260,
			"versionNonce": 1877506310,
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
			"updated": 1693807487416,
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
			"version": 226,
			"versionNonce": 1002177114,
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
			"updated": 1693807487416,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 241,
			"versionNonce": 1874815046,
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
			"updated": 1693807487416,
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
			"version": 189,
			"versionNonce": 2088675098,
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
			"updated": 1693807487416,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 194,
			"versionNonce": 225865606,
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
			"updated": 1693807487416,
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
			"version": 259,
			"versionNonce": 2131669978,
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
			"updated": 1693807487416,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 301,
			"versionNonce": 1162514118,
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
			"updated": 1693807487417,
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
			"version": 331,
			"versionNonce": 1971267738,
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
			"updated": 1693807487417,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 561,
			"versionNonce": 64538118,
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
			"updated": 1693807487417,
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
			"version": 257,
			"versionNonce": 1468204378,
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
			"updated": 1693807487417,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 444,
			"versionNonce": 438179142,
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
			"updated": 1693807487417,
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
			"version": 93,
			"versionNonce": 778914330,
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
			"updated": 1693807487417,
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
			"version": 96,
			"versionNonce": 829914246,
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
			"updated": 1693807487417,
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
			"version": 92,
			"versionNonce": 1630598874,
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
			"updated": 1693807487417,
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
			"version": 624,
			"versionNonce": 1067580358,
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
			"updated": 1693807487417,
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
			"version": 619,
			"versionNonce": 6359962,
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
			"updated": 1693807487418,
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
			"version": 620,
			"versionNonce": 2059047686,
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
			"updated": 1693807487418,
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
			"version": 387,
			"versionNonce": 305170522,
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
			"updated": 1693807487418,
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
			"version": 301,
			"versionNonce": 1295925830,
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
			"updated": 1693807487418,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 386,
			"versionNonce": 1584557338,
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
			"updated": 1693807487418,
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
			"version": 363,
			"versionNonce": 1242171782,
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
			"updated": 1693807487418,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 245,
			"versionNonce": 983153114,
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
			"updated": 1693807487418,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 279,
			"versionNonce": 542828742,
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
			"updated": 1693807487418,
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
			"version": 1340,
			"versionNonce": 1438215834,
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
			"updated": 1693807487418,
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
			"version": 155,
			"versionNonce": 265150470,
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
			"updated": 1693807487419,
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
			"version": 516,
			"versionNonce": 75795290,
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
			"updated": 1693807487419,
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
			"version": 186,
			"versionNonce": 1549791046,
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
			"updated": 1693807487419,
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
			"version": 116,
			"versionNonce": 223219738,
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
			"updated": 1693807487419,
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
			"version": 86,
			"versionNonce": 1114510982,
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
			"updated": 1693807487419,
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
			"version": 59,
			"versionNonce": 1946746074,
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
			"updated": 1693807487420,
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
			"version": 863,
			"versionNonce": 1790268870,
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
			"updated": 1693807487420,
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
			"version": 1172,
			"versionNonce": 1179144602,
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
			"updated": 1693807487420,
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
			"version": 1002,
			"versionNonce": 1582476550,
			"isDeleted": false,
			"id": "xeHPFSyj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1838.6305653541867,
			"y": -204.37193297246748,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 276.20230680737313,
			"height": 93.93114887376252,
			"seed": 99727,
			"groupIds": [
				"HFNBHHwo9GRICQZ2l9HJo",
				"Ug2vcZ2iRE_ETsnXfjR_g",
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487420,
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
			"version": 892,
			"versionNonce": 1732185690,
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
			"updated": 1693807487420,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1044,
			"versionNonce": 2059607110,
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
			"updated": 1693807487421,
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
			"version": 894,
			"versionNonce": 1539322650,
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
			"updated": 1693807487421,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1075,
			"versionNonce": 1709417350,
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
			"updated": 1693807487421,
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
			"version": 3231,
			"versionNonce": 373211098,
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
			"updated": 1693807487421,
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
			"version": 785,
			"versionNonce": 32588486,
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
			"updated": 1693807487421,
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
			"version": 742,
			"versionNonce": 1120777370,
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
			"updated": 1693807487421,
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
			"version": 730,
			"versionNonce": 1636366854,
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
			"updated": 1693807487421,
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
			"version": 741,
			"versionNonce": 320868698,
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
			"updated": 1693807487421,
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
			"version": 723,
			"versionNonce": 1000851782,
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
			"updated": 1693807487422,
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
			"version": 720,
			"versionNonce": 176739866,
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
			"updated": 1693807487422,
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
			"version": 738,
			"versionNonce": 1605021830,
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
			"updated": 1693807487422,
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
			"version": 734,
			"versionNonce": 1241187034,
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
			"updated": 1693807487422,
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
			"version": 711,
			"versionNonce": 693022662,
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
			"updated": 1693807487422,
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
			"version": 712,
			"versionNonce": 1544132506,
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
			"updated": 1693807487422,
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
			"version": 711,
			"versionNonce": 1957742342,
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
			"updated": 1693807487422,
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
			"version": 728,
			"versionNonce": 15176794,
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
			"updated": 1693807487422,
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
			"version": 733,
			"versionNonce": 307099206,
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
			"updated": 1693807487422,
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
			"version": 746,
			"versionNonce": 2053634330,
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
			"updated": 1693807487423,
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
			"version": 725,
			"versionNonce": 990068102,
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
			"updated": 1693807487423,
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
			"version": 746,
			"versionNonce": 1476249050,
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
			"updated": 1693807487423,
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
			"version": 724,
			"versionNonce": 68000966,
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
			"updated": 1693807487423,
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
			"version": 707,
			"versionNonce": 1119615642,
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
			"updated": 1693807487423,
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
			"version": 706,
			"versionNonce": 1393169414,
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
			"updated": 1693807487423,
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
			"version": 727,
			"versionNonce": 1230346074,
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
			"updated": 1693807487423,
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
			"version": 407,
			"versionNonce": 1375052614,
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
			"updated": 1693807487423,
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
			"version": 671,
			"versionNonce": 740138010,
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
			"updated": 1693807487423,
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
			"version": 373,
			"versionNonce": 1663912582,
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
			"updated": 1693807487424,
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
			"version": 593,
			"versionNonce": 688326874,
			"isDeleted": false,
			"id": "RbDIiahp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1849.2972758629548,
			"y": -98.01471753887643,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 165.44103735804265,
			"height": 20.81708417087954,
			"seed": 72233,
			"groupIds": [
				"odkq8xWgSWM-YctfZbvXD"
			],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487424,
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
			"version": 190,
			"versionNonce": 359532998,
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
			"updated": 1693807487424,
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
			"version": 193,
			"versionNonce": 1201986970,
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
			"updated": 1693807487424,
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
			"version": 214,
			"versionNonce": 399827206,
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
			"updated": 1693807487424,
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
			"version": 367,
			"versionNonce": 623516250,
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
			"updated": 1693807487424,
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
			"version": 212,
			"versionNonce": 769577030,
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
			"updated": 1693807487424,
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
			"version": 318,
			"versionNonce": 1080672026,
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
			"updated": 1693807487424,
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
			"version": 188,
			"versionNonce": 594073478,
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
			"updated": 1693807487424,
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
			"version": 208,
			"versionNonce": 1171704794,
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
			"updated": 1693807487425,
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
			"version": 348,
			"versionNonce": 1085273798,
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
			"updated": 1693807487425,
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
			"version": 126,
			"versionNonce": 1535393946,
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
			"updated": 1693807487425,
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
			"version": 120,
			"versionNonce": 1045507590,
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
			"updated": 1693807487425,
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
			"version": 118,
			"versionNonce": 1831148890,
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
			"updated": 1693807487425,
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
			"version": 98,
			"versionNonce": 961117510,
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
			"updated": 1693807487425,
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
			"version": 62,
			"versionNonce": 2014077466,
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
			"updated": 1693807487425,
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
			"version": 60,
			"versionNonce": 653649030,
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
			"updated": 1693807487425,
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
			"version": 112,
			"versionNonce": 1462570714,
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
			"updated": 1693807487425,
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
			"version": 65,
			"versionNonce": 1226007494,
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
			"updated": 1693807487426,
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
			"version": 62,
			"versionNonce": 253371290,
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
			"updated": 1693807487426,
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
			"version": 96,
			"versionNonce": 566164230,
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
			"updated": 1693807487426,
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
			"version": 77,
			"versionNonce": 436641882,
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
			"updated": 1693807487426,
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
			"version": 78,
			"versionNonce": 1735764550,
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
			"updated": 1693807487426,
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
			"version": 61,
			"versionNonce": 868582682,
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
			"updated": 1693807487426,
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
			"version": 59,
			"versionNonce": 2031382918,
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
			"updated": 1693807487426,
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
			"version": 57,
			"versionNonce": 633983450,
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
			"updated": 1693807487426,
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
			"version": 56,
			"versionNonce": 1373130950,
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
			"updated": 1693807487426,
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
			"version": 58,
			"versionNonce": 321291930,
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
			"updated": 1693807487427,
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
			"version": 57,
			"versionNonce": 2103330822,
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
			"updated": 1693807487427,
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
			"version": 54,
			"versionNonce": 1150198618,
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
			"updated": 1693807487427,
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
			"version": 59,
			"versionNonce": 195254086,
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
			"updated": 1693807487427,
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
			"version": 55,
			"versionNonce": 1951737882,
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
			"updated": 1693807487427,
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
			"version": 58,
			"versionNonce": 84180614,
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
			"updated": 1693807487427,
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
			"version": 51,
			"versionNonce": 443356378,
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
			"updated": 1693807487427,
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
			"version": 71,
			"versionNonce": 1581170118,
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
			"updated": 1693807487427,
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
			"version": 64,
			"versionNonce": 946432410,
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
			"updated": 1693807487427,
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
			"version": 79,
			"versionNonce": 1819219206,
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
			"updated": 1693807487427,
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
			"version": 118,
			"versionNonce": 628958810,
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
			"updated": 1693807487428,
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
			"version": 97,
			"versionNonce": 1494385734,
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
			"updated": 1693807487428,
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
			"version": 71,
			"versionNonce": 1518029594,
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
			"updated": 1693807487428,
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
			"version": 72,
			"versionNonce": 369494918,
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
			"updated": 1693807487428,
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
			"version": 105,
			"versionNonce": 1037490138,
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
			"updated": 1693807487428,
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
			"version": 73,
			"versionNonce": 1367780038,
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
			"updated": 1693807487428,
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
			"version": 116,
			"versionNonce": 1872940186,
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
			"updated": 1693807487428,
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
			"version": 64,
			"versionNonce": 1781621254,
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
			"updated": 1693807487428,
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
			"version": 64,
			"versionNonce": 361900378,
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
			"updated": 1693807487428,
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
			"version": 94,
			"versionNonce": 1661153606,
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
			"updated": 1693807487429,
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
			"version": 75,
			"versionNonce": 653782554,
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
			"updated": 1693807487429,
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
			"version": 81,
			"versionNonce": 1465456774,
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
			"updated": 1693807487429,
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
			"version": 58,
			"versionNonce": 952572634,
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
			"updated": 1693807487429,
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
			"version": 128,
			"versionNonce": 1861228486,
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
			"updated": 1693807487429,
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
			"version": 134,
			"versionNonce": 1234349978,
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
			"updated": 1693807487429,
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
			"version": 136,
			"versionNonce": 1373974278,
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
			"updated": 1693807487429,
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
			"version": 119,
			"versionNonce": 227388506,
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
			"updated": 1693807487429,
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
			"version": 124,
			"versionNonce": 481648198,
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
			"updated": 1693807487429,
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
			"version": 122,
			"versionNonce": 982192410,
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
			"updated": 1693807487429,
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
			"version": 122,
			"versionNonce": 1413326214,
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
			"updated": 1693807487430,
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
			"version": 173,
			"versionNonce": 1409146330,
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
			"updated": 1693807487430,
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
			"version": 139,
			"versionNonce": 1505428678,
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
			"updated": 1693807487430,
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
			"version": 130,
			"versionNonce": 1996034714,
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
			"updated": 1693807487430,
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
			"version": 131,
			"versionNonce": 1590328326,
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
			"updated": 1693807487430,
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
			"version": 125,
			"versionNonce": 640659290,
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
			"updated": 1693807487430,
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
			"version": 86,
			"versionNonce": 1500056390,
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
			"updated": 1693807487430,
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
			"version": 99,
			"versionNonce": 368358426,
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
			"updated": 1693807487430,
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
			"version": 60,
			"versionNonce": 2012459654,
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
			"updated": 1693807487430,
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
			"version": 54,
			"versionNonce": 2017140954,
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
			"updated": 1693807487431,
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
			"version": 58,
			"versionNonce": 354906566,
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
			"updated": 1693807487431,
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
			"version": 54,
			"versionNonce": 1217787290,
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
			"updated": 1693807487431,
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
			"version": 479,
			"versionNonce": 740378886,
			"isDeleted": false,
			"id": "KDH40Bij",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -86.21391652691636,
			"y": 1693.5616720989146,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 198.7842559814453,
			"height": 40,
			"seed": 1058883210,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487431,
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
			"version": 460,
			"versionNonce": 406336090,
			"isDeleted": false,
			"id": "0hfbLL3uE9mI31ZdFu4s0",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 364.8823883404266,
			"y": 1822.317690340073,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 131.61662760468596,
			"height": 66.37077802287558,
			"seed": 1356465110,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487431,
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
			"version": 375,
			"versionNonce": 1281243206,
			"isDeleted": false,
			"id": "BgoZ5PjKSzIkRzu_L2PDg",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 483.562338872857,
			"y": 1879.6890408344234,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 25.873354144510927,
			"height": 16.31146239545251,
			"seed": 1784850058,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487431,
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
			"version": 370,
			"versionNonce": 1509218074,
			"isDeleted": false,
			"id": "hej1RAmLIEztRDBOTEaSw",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 486.37465997552135,
			"y": 1920.1864647127882,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 19.123783498116836,
			"height": 1.687392661598551,
			"seed": 225152266,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487431,
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
			"version": 400,
			"versionNonce": 230375302,
			"isDeleted": false,
			"id": "RZka_Z7OW9rwVfP28NRLR",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 494.8116232835141,
			"y": 1921.8738573743867,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 37.68510277570067,
			"height": 11.811748631189857,
			"seed": 1348692566,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487431,
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
			"version": 366,
			"versionNonce": 775873498,
			"isDeleted": false,
			"id": "-wK_9R-GsI1ba8PetyrNq",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 528.5594765154847,
			"y": 1917.374143610124,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 8.436963307992755,
			"height": 6.749570646394204,
			"seed": 1183454602,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487431,
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
			"version": 481,
			"versionNonce": 74800838,
			"isDeleted": false,
			"id": "FAimgahF",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -88.46377340904769,
			"y": 1739.072985701212,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 246.320556640625,
			"height": 40,
			"seed": 975030090,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487431,
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
			"version": 420,
			"versionNonce": 791238810,
			"isDeleted": false,
			"id": "8EPSj2W2",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -226.81255597516974,
			"y": 1896.562967450409,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 188.94412231445312,
			"height": 20,
			"seed": 201190486,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487432,
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
			"version": 746,
			"versionNonce": 891917830,
			"isDeleted": false,
			"id": "KApyM3I4",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -226.81255597516974,
			"y": 1925.2486426975838,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 488.70062255859375,
			"height": 71.37533695211434,
			"seed": 195631126,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487432,
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
			"version": 574,
			"versionNonce": 1013396826,
			"isDeleted": false,
			"id": "nJbps7t5zt0uCLwRXWV_w",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -220.20686450258086,
			"y": 2008.2246851598748,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 388.8666389659444,
			"height": 290.53983792235323,
			"seed": 1804899798,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487432,
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
			"version": 462,
			"versionNonce": 148170054,
			"isDeleted": false,
			"id": "gkJ9zQ2G5iJWNyvbE_pNb",
			"fillStyle": "hachure",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 701.887109903385,
			"y": 1849.9965112663112,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 210.007045147074,
			"height": 40.39250688765446,
			"seed": 1048375766,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487432,
			"link": null,
			"locked": false
		},
		{
			"type": "freedraw",
			"version": 384,
			"versionNonce": 1196128794,
			"isDeleted": false,
			"id": "fcPSLB_AcotYBVcUHIOFD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 433.22606058526117,
			"y": 1720.3899114324322,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 259.8238645884994,
			"height": 138.71952092436845,
			"seed": 380880330,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487432,
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
			"version": 361,
			"versionNonce": 1087655046,
			"isDeleted": false,
			"id": "2_kh_2VPE_sBmwIOmsJeY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 692.3159594545841,
			"y": 1845.8980494116222,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 14.679314383530937,
			"height": 16.881211541060566,
			"seed": 1563738646,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487432,
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
			"version": 501,
			"versionNonce": 516499162,
			"isDeleted": false,
			"id": "MIdQJkLx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 709.9404128407455,
			"y": 2002.6613348768851,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 430.3682861328125,
			"height": 60,
			"seed": 1913854794,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487432,
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
			"version": 289,
			"versionNonce": 1793379270,
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
			"updated": 1693807487432,
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
			"version": 270,
			"versionNonce": 997407642,
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
			"updated": 1693807487432,
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
			"version": 287,
			"versionNonce": 1428382470,
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
			"updated": 1693807487433,
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
			"version": 375,
			"versionNonce": 192723034,
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
			"updated": 1693807487433,
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
			"version": 269,
			"versionNonce": 34411078,
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
			"updated": 1693807487433,
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
			"version": 219,
			"versionNonce": 1052286234,
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
			"updated": 1693807487433,
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
			"version": 127,
			"versionNonce": 478075270,
			"isDeleted": false,
			"id": "pggYjtIL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2922.3087929481344,
			"y": 1276.6584682014116,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 726.9036865234375,
			"height": 50,
			"seed": 35741910,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487433,
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
			"version": 148,
			"versionNonce": 312076762,
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
			"updated": 1693807487433,
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
			"version": 101,
			"versionNonce": 1807071430,
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
			"updated": 1693807487433,
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
		},
		{
			"type": "text",
			"version": 179,
			"versionNonce": 506699418,
			"isDeleted": false,
			"id": "IchVkKTI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -665.7908128023806,
			"y": 2480.3600731264964,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 120,
			"height": 50,
			"seed": 1800125911,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487433,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "人头拓扑转换\nnonrigidicp",
			"rawText": "人头拓扑转换\nnonrigidicp",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "人头拓扑转换\nnonrigidicp",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "rectangle",
			"version": 208,
			"versionNonce": 1196339206,
			"isDeleted": false,
			"id": "y48jDks7rcmXqfSjh4CNS",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -685.9114807255828,
			"y": -792.7691016897625,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 3136,
			"height": 3156,
			"seed": 920364695,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1693807487433,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 57,
			"versionNonce": 507034458,
			"isDeleted": false,
			"id": "iRm8P3VS-9pqpTHd8wsUX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -440.46397454532973,
			"y": 2422.47754055688,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 113,
			"height": 35,
			"seed": 715538231,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "V6N22vpX",
					"type": "text"
				}
			],
			"updated": 1693807487434,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 113,
			"versionNonce": 189185862,
			"isDeleted": false,
			"id": "V6N22vpX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -435.3639150360524,
			"y": 2427.47754055688,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 102.79988098144531,
			"height": 25,
			"seed": 1815869401,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487434,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "nonrigid icp",
			"rawText": "nonrigid icp",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "iRm8P3VS-9pqpTHd8wsUX",
			"originalText": "nonrigid icp",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 58,
			"versionNonce": 1090273306,
			"isDeleted": false,
			"id": "lp1V9n3qJU6ZvspgdCQJ3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -431.71542631011755,
			"y": 2588.1918262711656,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 79,
			"height": 35,
			"seed": 1994916057,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "fdFHoUCn",
					"type": "text"
				}
			],
			"updated": 1693807487434,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 348,
			"versionNonce": 200992390,
			"isDeleted": false,
			"id": "fdFHoUCn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -426.2953899941996,
			"y": 2593.1918262711656,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 68.15992736816406,
			"height": 25,
			"seed": 1015450553,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487434,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "wrap4d",
			"rawText": "wrap4d",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "lp1V9n3qJU6ZvspgdCQJ3",
			"originalText": "wrap4d",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 251,
			"versionNonce": 1920019674,
			"isDeleted": false,
			"id": "XaN440GL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -461.4701743366476,
			"y": 2469.977540556879,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 244.33609008789062,
			"height": 40,
			"seed": 301356695,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487434,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "自动选点, 或载入选择的点.\n效果略差, 可批量, 自动, 在线实时",
			"rawText": "自动选点, 或载入选择的点.\n效果略差, 可批量, 自动, 在线实时",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "自动选点, 或载入选择的点.\n效果略差, 可批量, 自动, 在线实时",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 202,
			"versionNonce": 170403270,
			"isDeleted": false,
			"id": "aqj9R219",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -427.9021811725852,
			"y": 2631.882302461642,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 257.2001037597656,
			"height": 20,
			"seed": 1596938553,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487434,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "有ui, 全流程, 效果好. 适合离线操作",
			"rawText": "有ui, 全流程, 效果好. 适合离线操作",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "有ui, 全流程, 效果好. 适合离线操作",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 168,
			"versionNonce": 673874330,
			"isDeleted": false,
			"id": "3KG5uJnY",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -640.8259388165117,
			"y": 2606.525159604499,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 64,
			"height": 20,
			"seed": 1403982137,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487434,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "纹理迁移",
			"rawText": "纹理迁移",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "纹理迁移",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 98,
			"versionNonce": 652967174,
			"isDeleted": false,
			"id": "JfJqIn1UQDe2nI4m0qksq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -531.6830816736546,
			"y": 2510.3346834140225,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 88.57142857142856,
			"height": 88.5714285714289,
			"seed": 1549966905,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487434,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					5.714285714285666,
					3.809523809523853
				],
				[
					11.428571428571331,
					8.571428571428896
				],
				[
					19.047619047619037,
					11.428571428571558
				],
				[
					25.714285714285666,
					14.28571428571422
				],
				[
					31.42857142857133,
					17.142857142857338
				],
				[
					35.238095238095184,
					20
				],
				[
					38.095238095238074,
					24.761904761905043
				],
				[
					40,
					27.619047619047706
				],
				[
					41.90476190476181,
					30.476190476190368
				],
				[
					43.80952380952374,
					32.380952380952294
				],
				[
					44.7619047619047,
					34.28571428571422
				],
				[
					45.714285714285666,
					37.14285714285734
				],
				[
					48.571428571428555,
					40
				],
				[
					51.42857142857133,
					42.85714285714266
				],
				[
					53.33333333333326,
					46.666666666666515
				],
				[
					55.238095238095184,
					50.47619047619037
				],
				[
					57.14285714285711,
					53.333333333333485
				],
				[
					60,
					57.14285714285734
				],
				[
					61.90476190476181,
					62.85714285714266
				],
				[
					64.7619047619047,
					69.52380952380963
				],
				[
					65.71428571428567,
					71.42857142857156
				],
				[
					66.66666666666663,
					74.28571428571422
				],
				[
					67.61904761904759,
					75.23809523809541
				],
				[
					68.57142857142856,
					77.14285714285734
				],
				[
					69.52380952380952,
					79.04761904761881
				],
				[
					71.42857142857133,
					79.04761904761881
				],
				[
					71.42857142857133,
					80
				],
				[
					72.3809523809523,
					80
				],
				[
					74.28571428571422,
					80
				],
				[
					75.23809523809518,
					80.95238095238119
				],
				[
					76.19047619047615,
					80.95238095238119
				],
				[
					78.09523809523807,
					81.90476190476193
				],
				[
					80.95238095238085,
					83.80952380952385
				],
				[
					82.85714285714278,
					83.80952380952385
				],
				[
					83.80952380952374,
					84.76190476190504
				],
				[
					84.7619047619047,
					85.71428571428578
				],
				[
					86.66666666666663,
					86.66666666666652
				],
				[
					87.61904761904759,
					87.6190476190477
				],
				[
					88.57142857142856,
					87.6190476190477
				],
				[
					88.57142857142856,
					88.5714285714289
				],
				[
					88.57142857142856,
					88.5714285714289
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 121,
			"versionNonce": 760954458,
			"isDeleted": false,
			"id": "nHmKyBPB5lDTnAezvsX1L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -567.8735578641307,
			"y": 2625.572778652118,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 128.57142857142856,
			"height": 6.666666666666515,
			"seed": 1123707255,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487434,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					-8.571428571428896
				],
				[
					0.8687258687258791,
					-8.571428571428896
				],
				[
					1.7374517374516545,
					-8.571428571428896
				],
				[
					3.474903474903413,
					-8.571428571428896
				],
				[
					6.081081081080947,
					-8.571428571428896
				],
				[
					12.162162162162101,
					-8.988095238095653
				],
				[
					18.243243243243256,
					-9.40476190476221
				],
				[
					25.19305019305008,
					-10.238095238095525
				],
				[
					33.01158301158299,
					-10.654761904762282
				],
				[
					39.092664092664045,
					-11.07142857142884
				],
				[
					44.305019305019215,
					-11.904761904762154
				],
				[
					48.64864864864861,
					-12.32142857142891
				],
				[
					52.12355212355212,
					-12.32142857142891
				],
				[
					57.3359073359073,
					-12.32142857142891
				],
				[
					61.67953667953659,
					-12.32142857142891
				],
				[
					66.89189189189186,
					-12.738095238095468
				],
				[
					73.8416988416988,
					-13.154761904762026
				],
				[
					82.52895752895748,
					-14.404761904762097
				],
				[
					88.61003861003853,
					-14.821428571428655
				],
				[
					94.69111969111968,
					-14.821428571428655
				],
				[
					99.90347490347486,
					-14.821428571428655
				],
				[
					101.64092664092661,
					-14.821428571428655
				],
				[
					103.37837837837837,
					-14.821428571428655
				],
				[
					105.11583011583014,
					-14.821428571428655
				],
				[
					106.85328185328179,
					-14.821428571428655
				],
				[
					108.59073359073355,
					-14.821428571428655
				],
				[
					112.06563706563706,
					-14.821428571428655
				],
				[
					113.80308880308881,
					-14.821428571428655
				],
				[
					117.27799227799223,
					-14.821428571428655
				],
				[
					120.75289575289575,
					-14.821428571428655
				],
				[
					123.35907335907339,
					-14.821428571428655
				],
				[
					124.22779922779917,
					-14.821428571428655
				],
				[
					125.09652509652504,
					-15.238095238095411
				],
				[
					125.96525096525092,
					-15.238095238095411
				],
				[
					127.70270270270268,
					-15.238095238095411
				],
				[
					128.57142857142856,
					-15.238095238095411
				],
				[
					128.57142857142856,
					-14.821428571428655
				],
				[
					128.57142857142856,
					-14.821428571428655
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 83,
			"versionNonce": 1472326726,
			"isDeleted": false,
			"id": "gjnfC42-EsiDCkT6hNwsr",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -543.111653102226,
			"y": 2496.0489691283083,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 80.95238095238096,
			"height": 47.619047619047706,
			"seed": 934109721,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487435,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.857142857142776,
					-1.9047619047619264
				],
				[
					4.761904761904702,
					-2.8571428571426623
				],
				[
					7.619047619047592,
					-4.761904761904589
				],
				[
					10.476190476190482,
					-6.666666666666515
				],
				[
					14.285714285714334,
					-9.523809523809632
				],
				[
					19.047619047619037,
					-12.380952380952294
				],
				[
					22.857142857142776,
					-15.238095238095411
				],
				[
					25.714285714285666,
					-17.142857142856883
				],
				[
					30.47619047619048,
					-20
				],
				[
					33.33333333333337,
					-21.904761904761926
				],
				[
					39.04761904761904,
					-25.71428571428578
				],
				[
					45.714285714285666,
					-29.523809523809632
				],
				[
					48.571428571428555,
					-32.380952380952294
				],
				[
					57.14285714285711,
					-36.19047619047615
				],
				[
					59.04761904761904,
					-37.14285714285688
				],
				[
					61.904761904761926,
					-38.095238095238074
				],
				[
					64.7619047619047,
					-39.047619047619264
				],
				[
					68.57142857142856,
					-40.952380952380736
				],
				[
					72.3809523809523,
					-42.85714285714266
				],
				[
					76.19047619047615,
					-44.76190476190459
				],
				[
					77.14285714285711,
					-45.71428571428578
				],
				[
					79.04761904761904,
					-46.666666666666515
				],
				[
					80,
					-46.666666666666515
				],
				[
					80,
					-47.619047619047706
				],
				[
					80.95238095238096,
					-47.619047619047706
				],
				[
					80.95238095238096,
					-47.619047619047706
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "rectangle",
			"version": 93,
			"versionNonce": 1859543834,
			"isDeleted": false,
			"id": "QcV__n599viYbBjBpoNa9",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -291.15927214984515,
			"y": 2424.3823024616418,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 58,
			"height": 30,
			"seed": 1492569591,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "0wXJKpN0",
					"type": "text"
				}
			],
			"updated": 1693807487435,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 194,
			"versionNonce": 1518891910,
			"isDeleted": false,
			"id": "0wXJKpN0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -286.15927214984515,
			"y": 2429.3823024616418,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 48,
			"height": 20,
			"seed": 1442183865,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487435,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "光栅化",
			"rawText": "光栅化",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "QcV__n599viYbBjBpoNa9",
			"originalText": "光栅化",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 111,
			"versionNonce": 1192161242,
			"isDeleted": false,
			"id": "1yGgl2Z4-DA_OhGUH_HJO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -566.9211769117497,
			"y": 2604.6203976997367,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 119.04761904761892,
			"height": 146.66666666666652,
			"seed": 1019694873,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487435,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.9523809523808495,
					-1.9047619047619264
				],
				[
					1.9047619047618127,
					-5.7142857142853245
				],
				[
					3.809523809523739,
					-11.428571428571558
				],
				[
					4.761904761904702,
					-15.238095238095411
				],
				[
					6.666666666666515,
					-19.04761904761881
				],
				[
					7.619047619047478,
					-22.857142857142662
				],
				[
					9.523809523809405,
					-27.619047619047706
				],
				[
					12.380952380952294,
					-31.42857142857156
				],
				[
					15.238095238095184,
					-36.19047619047615
				],
				[
					17.14285714285711,
					-39.04761904761881
				],
				[
					19.047619047619037,
					-41.904761904761926
				],
				[
					22.857142857142776,
					-46.666666666666515
				],
				[
					24.761904761904702,
					-49.52380952380918
				],
				[
					25.714285714285552,
					-51.42857142857156
				],
				[
					28.57142857142844,
					-54.28571428571422
				],
				[
					31.42857142857133,
					-57.14285714285688
				],
				[
					33.33333333333326,
					-60
				],
				[
					36.19047619047615,
					-61.904761904761926
				],
				[
					39.04761904761904,
					-64.76190476190459
				],
				[
					40.95238095238085,
					-66.66666666666652
				],
				[
					43.80952380952374,
					-69.52380952380918
				],
				[
					47.61904761904748,
					-73.33333333333303
				],
				[
					52.380952380952294,
					-77.14285714285688
				],
				[
					58.095238095238074,
					-81.90476190476193
				],
				[
					61.90476190476181,
					-83.80952380952385
				],
				[
					65.71428571428567,
					-86.66666666666652
				],
				[
					70.47619047619037,
					-89.52380952380918
				],
				[
					74.28571428571422,
					-92.3809523809523
				],
				[
					78.09523809523796,
					-95.23809523809496
				],
				[
					80.95238095238085,
					-99.04761904761881
				],
				[
					82.85714285714278,
					-102.85714285714266
				],
				[
					84.7619047619047,
					-105.71428571428578
				],
				[
					86.66666666666652,
					-108.57142857142844
				],
				[
					88.57142857142844,
					-111.4285714285711
				],
				[
					90.47619047619037,
					-113.33333333333303
				],
				[
					91.42857142857133,
					-116.19047619047615
				],
				[
					93.33333333333326,
					-117.14285714285688
				],
				[
					94.28571428571422,
					-119.04761904761881
				],
				[
					95.23809523809518,
					-120.95238095238074
				],
				[
					97.142857142857,
					-122.85714285714266
				],
				[
					99.04761904761892,
					-125.71428571428532
				],
				[
					100.95238095238085,
					-128.57142857142844
				],
				[
					103.80952380952374,
					-131.4285714285711
				],
				[
					104.7619047619047,
					-132.3809523809523
				],
				[
					105.71428571428555,
					-133.33333333333303
				],
				[
					109.5238095238094,
					-136.19047619047615
				],
				[
					111.42857142857133,
					-138.09523809523807
				],
				[
					113.33333333333326,
					-140
				],
				[
					115.23809523809518,
					-141.90476190476193
				],
				[
					117.142857142857,
					-143.80952380952385
				],
				[
					118.09523809523796,
					-144.7619047619046
				],
				[
					118.09523809523796,
					-145.71428571428532
				],
				[
					119.04761904761892,
					-146.66666666666652
				],
				[
					119.04761904761892,
					-146.66666666666652
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "rectangle",
			"version": 56,
			"versionNonce": 695997126,
			"isDeleted": false,
			"id": "_ax03WCcpXAR1JG-uqnep",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -76.32463673317841,
			"y": 2585.3346834140225,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 42,
			"height": 30,
			"seed": 1212460345,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "aJoArfPn",
					"type": "text"
				}
			],
			"updated": 1693807487435,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 117,
			"versionNonce": 1243079834,
			"isDeleted": false,
			"id": "aJoArfPn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -71.15666798317841,
			"y": 2590.3346834140225,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 31.6640625,
			"height": 20,
			"seed": 437425913,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487435,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "RBF",
			"rawText": "RBF",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "_ax03WCcpXAR1JG-uqnep",
			"originalText": "RBF",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 117,
			"versionNonce": 1866058246,
			"isDeleted": false,
			"id": "-t_gnqA8FpEgA_wE3CV6a",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -340.2545102450832,
			"y": 2606.5251596044986,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 254.28571428571422,
			"height": 3.809523809523853,
			"seed": 845378297,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487435,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.9523809523809632,
					0
				],
				[
					2.8571428571428896,
					0
				],
				[
					3.809523809523853,
					0
				],
				[
					7.619047619047592,
					0
				],
				[
					12.380952380952408,
					0
				],
				[
					20.952380952380963,
					0
				],
				[
					29.52380952380952,
					0
				],
				[
					38.095238095238074,
					-0.9523809523807358
				],
				[
					46.66666666666663,
					-1.9047619047619264
				],
				[
					60.95238095238096,
					-2.8571428571426623
				],
				[
					71.42857142857144,
					-2.8571428571426623
				],
				[
					81.90476190476193,
					-2.8571428571426623
				],
				[
					92.38095238095241,
					-2.8571428571426623
				],
				[
					100.95238095238096,
					-2.8571428571426623
				],
				[
					105.71428571428567,
					-3.809523809523853
				],
				[
					110.47619047619048,
					-3.809523809523853
				],
				[
					112.38095238095241,
					-3.809523809523853
				],
				[
					116.19047619047615,
					-3.809523809523853
				],
				[
					120.95238095238096,
					-3.809523809523853
				],
				[
					122.85714285714289,
					-3.809523809523853
				],
				[
					130.47619047619048,
					-3.809523809523853
				],
				[
					134.28571428571422,
					-3.809523809523853
				],
				[
					141.90476190476193,
					-3.809523809523853
				],
				[
					148.57142857142856,
					-3.809523809523853
				],
				[
					155.23809523809518,
					-3.809523809523853
				],
				[
					162.85714285714278,
					-3.809523809523853
				],
				[
					167.6190476190476,
					-3.809523809523853
				],
				[
					171.42857142857144,
					-3.809523809523853
				],
				[
					175.23809523809518,
					-3.809523809523853
				],
				[
					177.1428571428571,
					-3.809523809523853
				],
				[
					180,
					-3.809523809523853
				],
				[
					183.80952380952374,
					-3.809523809523853
				],
				[
					188.57142857142856,
					-2.8571428571426623
				],
				[
					194.28571428571422,
					-2.8571428571426623
				],
				[
					200,
					-2.8571428571426623
				],
				[
					205.71428571428567,
					-1.9047619047619264
				],
				[
					209.52380952380952,
					-1.9047619047619264
				],
				[
					211.42857142857144,
					-1.9047619047619264
				],
				[
					212.3809523809523,
					-1.9047619047619264
				],
				[
					214.28571428571422,
					-1.9047619047619264
				],
				[
					216.19047619047615,
					-1.9047619047619264
				],
				[
					217.1428571428571,
					-1.9047619047619264
				],
				[
					220,
					-1.9047619047619264
				],
				[
					222.85714285714278,
					-1.9047619047619264
				],
				[
					226.66666666666663,
					-1.9047619047619264
				],
				[
					228.57142857142856,
					-1.9047619047619264
				],
				[
					229.52380952380952,
					-1.9047619047619264
				],
				[
					230.47619047619048,
					-1.9047619047619264
				],
				[
					233.33333333333326,
					-1.9047619047619264
				],
				[
					238.09523809523807,
					-1.9047619047619264
				],
				[
					244.7619047619047,
					-1.9047619047619264
				],
				[
					244.7619047619047,
					-2.8571428571426623
				],
				[
					245.71428571428567,
					-2.8571428571426623
				],
				[
					246.66666666666663,
					-2.8571428571426623
				],
				[
					246.66666666666663,
					-3.809523809523853
				],
				[
					248.57142857142856,
					-3.809523809523853
				],
				[
					251.42857142857133,
					-3.809523809523853
				],
				[
					253.33333333333326,
					-3.809523809523853
				],
				[
					254.28571428571422,
					-3.809523809523853
				],
				[
					254.28571428571422,
					-3.809523809523853
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 84,
			"versionNonce": 295977306,
			"isDeleted": false,
			"id": "oVaMdhKi7qPb8lQLQN5Cm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -99.30212929270238,
			"y": 2587.47754055688,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 16.19047619047626,
			"height": 20,
			"seed": 895023641,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487435,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.9047619047619264,
					1.9047619047614717
				],
				[
					1.9047619047619264,
					2.8571428571426623
				],
				[
					4.761904761904816,
					3.809523809523853
				],
				[
					7.619047619047706,
					4.761904761904589
				],
				[
					9.523809523809632,
					5.7142857142853245
				],
				[
					10.476190476190482,
					6.666666666666515
				],
				[
					11.428571428571445,
					6.666666666666515
				],
				[
					13.333333333333371,
					8.571428571428442
				],
				[
					14.285714285714334,
					9.523809523809177
				],
				[
					15.238095238095298,
					10.476190476190368
				],
				[
					15.238095238095298,
					11.428571428571558
				],
				[
					16.19047619047626,
					11.428571428571558
				],
				[
					16.19047619047626,
					12.380952380952294
				],
				[
					15.238095238095298,
					12.380952380952294
				],
				[
					15.238095238095298,
					13.33333333333303
				],
				[
					14.285714285714334,
					13.33333333333303
				],
				[
					13.333333333333371,
					14.28571428571422
				],
				[
					12.380952380952408,
					14.28571428571422
				],
				[
					10.476190476190482,
					14.28571428571422
				],
				[
					9.523809523809632,
					15.238095238094957
				],
				[
					8.571428571428669,
					15.238095238094957
				],
				[
					7.619047619047706,
					17.142857142856883
				],
				[
					6.6666666666667425,
					17.142857142856883
				],
				[
					5.714285714285779,
					18.095238095238074
				],
				[
					4.761904761904816,
					19.04761904761881
				],
				[
					4.761904761904816,
					20
				],
				[
					4.761904761904816,
					20
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 103,
			"versionNonce": 2059311430,
			"isDeleted": false,
			"id": "qzi1qO55",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -103.13416054270226,
			"y": 2628.4299215092606,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 207.6640625,
			"height": 20,
			"seed": 1293579479,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487435,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "使用RBF生成固定的权重映射",
			"rawText": "使用RBF生成固定的权重映射",
			"textAlign": "center",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "使用RBF生成固定的权重映射",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 287,
			"versionNonce": 151455258,
			"isDeleted": false,
			"id": "tWK5q6MJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 128.66478202690567,
			"y": 2448.4225307742745,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 204.60832147640355,
			"height": 77.14739990093905,
			"seed": 3731,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a5bd19904156bc09be15a44620c5bef264abf44d",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 305,
			"versionNonce": 862421126,
			"isDeleted": false,
			"id": "yN5mJZ1D",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 130.81182964945006,
			"y": 2589.8229183140065,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 151.43686803417455,
			"height": 53.84421974548429,
			"seed": 75904,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "7ad6b7c7061763d975248e671d2cd7586301807d",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 255,
			"versionNonce": 959656666,
			"isDeleted": false,
			"id": "2FE6ESD8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 127.43105123153259,
			"y": 2547.7992457550763,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 203.82431030273438,
			"height": 40,
			"seed": 1486509049,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "alpha是weight, phi是径向基,\n对于3d, each dimension:",
			"rawText": "alpha是weight, phi是径向基,\n对于3d, each dimension:",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "alpha是weight, phi是径向基,\n对于3d, each dimension:",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "image",
			"version": 250,
			"versionNonce": 217153478,
			"isDeleted": false,
			"id": "whLrkXYX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 307.92320621117665,
			"y": 2604.6484817252135,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 97.33105020153299,
			"height": 20.137458662386134,
			"seed": 77355,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "6ba74f9841b8921972080db98ef7dc99d2607f82",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 139,
			"versionNonce": 347850650,
			"isDeleted": false,
			"id": "D14uIIxK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 309.44198303146095,
			"y": 2626.6306366971726,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 23.4560546875,
			"height": 20,
			"seed": 1536149881,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "mx1",
			"rawText": "mx1",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "mx1",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 164,
			"versionNonce": 2071566086,
			"isDeleted": false,
			"id": "CGmYRB2A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 345.9426913776406,
			"y": 2626.6306366971726,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 29.248062133789062,
			"height": 20,
			"seed": 1499390743,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "mxm",
			"rawText": "mxm",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "mxm",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 145,
			"versionNonce": 1137951834,
			"isDeleted": false,
			"id": "6KgIh5Go",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 388.5268511148504,
			"y": 2626.6306366971726,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 23.4560546875,
			"height": 20,
			"seed": 1004814935,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "mx1",
			"rawText": "mx1",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "mx1",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 199,
			"versionNonce": 1736230470,
			"isDeleted": false,
			"id": "NNFOXEml",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -100.46047056782129,
			"y": 2657.498168141175,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 42.6881103515625,
			"height": 20,
			"seed": 1983602871,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "hifi3d",
			"rawText": "hifi3d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "hifi3d",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 142,
			"versionNonce": 1884170522,
			"isDeleted": false,
			"id": "lxVaoPht",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -98.77307790622268,
			"y": 2753.117085631759,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 41.53608703613281,
			"height": 20,
			"seed": 460152793,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "flame",
			"rawText": "flame",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "flame",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 159,
			"versionNonce": 567807366,
			"isDeleted": false,
			"id": "HkesyX9F",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 34.530942360061886,
			"y": 2658.060632361708,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 83.02420043945312,
			"height": 20,
			"seed": 1677836599,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "htemp_tgt",
			"rawText": "htemp_tgt",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "htemp_tgt",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 157,
			"versionNonce": 295564762,
			"isDeleted": false,
			"id": "yTQI45Uu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 51.40486897604717,
			"y": 2755.9294067344226,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 43.58409118652344,
			"height": 20,
			"seed": 26422263,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "ftemp",
			"rawText": "ftemp",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "ftemp",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 127,
			"versionNonce": 1472752838,
			"isDeleted": false,
			"id": "ZzapQBI8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 237.5805259724192,
			"y": 2667.0600598902333,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 47.21612548828125,
			"height": 20,
			"seed": 1019094425,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487436,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "h_tgt",
			"rawText": "h_tgt",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h_tgt",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 157,
			"versionNonce": 953559706,
			"isDeleted": false,
			"id": "BSbC2YB0rAhUSqlPpa53C",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 125.08768186584996,
			"y": 2670.4348452134304,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 102.36848813697804,
			"height": 5.062177984795653,
			"seed": 960774393,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
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
					2.8123211026643276,
					0
				],
				[
					8.436963307992755,
					0
				],
				[
					14.624069733854071,
					0.5624642205330019
				],
				[
					19.68624771864961,
					0.5624642205330019
				],
				[
					24.748425703445264,
					0.5624642205330019
				],
				[
					27.560746806109478,
					1.1249284410660039
				],
				[
					30.37306790877369,
					1.687392661598551
				],
				[
					33.18538901143802,
					1.687392661598551
				],
				[
					36.56017433463501,
					1.687392661598551
				],
				[
					41.05988809889777,
					1.687392661598551
				],
				[
					43.8722092015621,
					1.687392661598551
				],
				[
					46.684530304226314,
					1.687392661598551
				],
				[
					50.0593156274233,
					1.687392661598551
				],
				[
					53.434100950620405,
					1.687392661598551
				],
				[
					56.80888627381751,
					1.687392661598551
				],
				[
					60.18367159701461,
					1.687392661598551
				],
				[
					64.68338536127737,
					2.249856882131553
				],
				[
					69.18309912554014,
					3.374785323197102
				],
				[
					73.6828128898029,
					3.937249543730104
				],
				[
					77.057598213,
					3.937249543730104
				],
				[
					79.30745509513133,
					3.937249543730104
				],
				[
					82.68224041832843,
					3.937249543730104
				],
				[
					83.8071688593941,
					3.937249543730104
				],
				[
					86.05702574152554,
					3.937249543730104
				],
				[
					88.86934684418975,
					3.937249543730104
				],
				[
					91.11920372632108,
					3.937249543730104
				],
				[
					93.93152482898529,
					4.499713764263106
				],
				[
					95.61891749058384,
					5.062177984795653
				],
				[
					97.30631015218239,
					5.062177984795653
				],
				[
					98.99370281378094,
					5.062177984795653
				],
				[
					100.6810954753795,
					5.062177984795653
				],
				[
					101.80602391644516,
					5.062177984795653
				],
				[
					102.36848813697804,
					5.062177984795653
				],
				[
					102.36848813697804,
					5.062177984795653
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 146,
			"versionNonce": 116057094,
			"isDeleted": false,
			"id": "HISy4K9BtG5JKWcGCJD-d",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 226.89370578229511,
			"y": 2668.1849883312993,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 10.686820190124081,
			"height": 12.936677072255407,
			"seed": 2004516695,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5624642205325472
				],
				[
					1.1249284410657765,
					1.1249284410655491
				],
				[
					2.2498568821314393,
					1.687392661598551
				],
				[
					3.374785323197102,
					2.2498568821310982
				],
				[
					5.062177984795653,
					3.374785323197102
				],
				[
					6.749570646394204,
					4.499713764262651
				],
				[
					7.312034866926979,
					5.062177984795653
				],
				[
					7.874499087459867,
					5.062177984795653
				],
				[
					7.874499087459867,
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
					8.99942752852553,
					6.187106425861202
				],
				[
					8.436963307992755,
					6.187106425861202
				],
				[
					7.874499087459867,
					6.187106425861202
				],
				[
					7.312034866926979,
					6.187106425861202
				],
				[
					6.749570646394204,
					6.749570646394204
				],
				[
					5.624642205328541,
					7.874499087459753
				],
				[
					3.9372495437299904,
					8.999427528525302
				],
				[
					1.687392661598551,
					10.686820190123854
				],
				[
					0.5624642205328882,
					11.249284410656855
				],
				[
					-0.5624642205327746,
					12.374212851722405
				],
				[
					-1.1249284410656628,
					12.374212851722405
				],
				[
					-1.1249284410656628,
					12.936677072255407
				],
				[
					-1.1249284410656628,
					12.936677072255407
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 257,
			"versionNonce": 1554630490,
			"isDeleted": false,
			"id": "-dVYF_Bpk8B8fsddxiB81",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -53.2134760430622,
			"y": 2763.8039058218833,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 130.4916991636203,
			"height": 80.432383536197,
			"seed": 817621849,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5624642205328882,
					-1.1249284410655491
				],
				[
					1.1249284410657197,
					-2.812321102664555
				],
				[
					1.687392661598551,
					-3.937249543730104
				],
				[
					2.2498568821313825,
					-5.624642205328655
				],
				[
					2.8123211026642707,
					-6.749570646394204
				],
				[
					3.9372495437299335,
					-8.436963307992755
				],
				[
					5.624642205328485,
					-10.686820190124308
				],
				[
					6.187106425861316,
					-11.249284410656855
				],
				[
					7.874499087459867,
					-12.936677072255407
				],
				[
					8.999427528525587,
					-15.18653395438696
				],
				[
					10.12435596959125,
					-16.87392661598551
				],
				[
					11.8117486311898,
					-18.56131927758406
				],
				[
					13.499141292788352,
					-20.81117615971516
				],
				[
					15.748998174919734,
					-23.061033041846713
				],
				[
					17.998855057051117,
					-25.310889923978266
				],
				[
					19.68624771864961,
					-25.873354144511268
				],
				[
					23.061033041846713,
					-29.248139467707915
				],
				[
					25.310889923978095,
					-30.935532129306466
				],
				[
					27.560746806109478,
					-32.62292479090502
				],
				[
					29.81060368824086,
					-34.87278167303657
				],
				[
					31.49799634983941,
					-37.12263855516812
				],
				[
					34.310317452503625,
					-39.93495965783222
				],
				[
					36.56017433463501,
					-42.18481653996378
				],
				[
					38.81003121676639,
					-43.87220920156187
				],
				[
					40.49742387836494,
					-45.55960186316088
				],
				[
					42.747280760496324,
					-47.246994524758975
				],
				[
					44.997137642627706,
					-48.934387186357526
				],
				[
					47.24699452475909,
					-51.18424406848908
				],
				[
					49.49685140689047,
					-53.43410095062063
				],
				[
					51.74670828902185,
					-55.12149361221918
				],
				[
					53.996565171153236,
					-56.808886273817734
				],
				[
					55.68395783275179,
					-57.93381471488328
				],
				[
					57.37135049435034,
					-59.05874315594883
				],
				[
					58.496278935416,
					-60.18367159701438
				],
				[
					59.62120737648172,
					-60.74613581754738
				],
				[
					61.8710642586131,
					-62.433528479145934
				],
				[
					63.5584569202116,
					-62.995992699678936
				],
				[
					65.24584958181015,
					-64.12092114074449
				],
				[
					66.9332422434087,
					-65.24584958181049
				],
				[
					69.18309912554008,
					-66.37077802287604
				],
				[
					71.43295600767146,
					-67.49570646394159
				],
				[
					73.68281288980285,
					-68.62063490500714
				],
				[
					76.49513399246706,
					-70.30802756660569
				],
				[
					79.30745509513133,
					-71.99542022820424
				],
				[
					81.55731197726271,
					-72.55788444873724
				],
				[
					83.24470463886121,
					-73.68281288980279
				],
				[
					84.93209730045976,
					-74.8077413308688
				],
				[
					86.61948996205831,
					-75.37020555140134
				],
				[
					88.30688262365686,
					-76.49513399246734
				],
				[
					88.86934684418975,
					-76.49513399246734
				],
				[
					90.55673950578819,
					-77.6200624335329
				],
				[
					91.11920372632108,
					-77.6200624335329
				],
				[
					92.24413216738674,
					-77.6200624335329
				],
				[
					93.36906060845251,
					-78.1825266540659
				],
				[
					94.49398904951818,
					-78.1825266540659
				],
				[
					96.18138171111673,
					-78.74499087459844
				],
				[
					97.86877437271528,
					-79.30745509513144
				],
				[
					100.1186312548466,
					-79.86991931566399
				],
				[
					101.80602391644516,
					-79.86991931566399
				],
				[
					102.93095235751082,
					-80.432383536197
				],
				[
					103.4934165780437,
					-80.432383536197
				],
				[
					104.05588079857648,
					-80.432383536197
				],
				[
					104.61834501910937,
					-80.432383536197
				],
				[
					106.30573768070792,
					-79.86991931566399
				],
				[
					107.99313034230647,
					-79.86991931566399
				],
				[
					110.2429872244378,
					-79.30745509513144
				],
				[
					112.49284410656924,
					-78.74499087459844
				],
				[
					113.6177725476349,
					-78.74499087459844
				],
				[
					114.74270098870056,
					-78.1825266540659
				],
				[
					115.30516520923345,
					-77.6200624335329
				],
				[
					115.86762942976634,
					-77.6200624335329
				],
				[
					116.43009365029911,
					-77.05759821299989
				],
				[
					116.992557870832,
					-77.05759821299989
				],
				[
					118.11748631189766,
					-75.93266977193434
				],
				[
					119.24241475296333,
					-75.37020555140134
				],
				[
					119.80487897349622,
					-74.24527711033579
				],
				[
					121.49227163509477,
					-73.12034866927024
				],
				[
					122.05473585562765,
					-72.55788444873724
				],
				[
					123.17966429669332,
					-70.87049178713869
				],
				[
					123.74212851722609,
					-69.74556334607314
				],
				[
					124.30459273775898,
					-68.05817068447459
				],
				[
					125.42952117882464,
					-66.93324224340859
				],
				[
					125.42952117882464,
					-65.80831380234304
				],
				[
					125.99198539935753,
					-64.68338536127749
				],
				[
					125.99198539935753,
					-63.55845692021148
				],
				[
					126.55444961989042,
					-62.433528479145934
				],
				[
					126.55444961989042,
					-60.18367159701438
				],
				[
					127.1169138404232,
					-57.93381471488328
				],
				[
					127.67937806095608,
					-54.55902939168618
				],
				[
					127.67937806095608,
					-53.99656517115318
				],
				[
					128.24184228148897,
					-50.62177984795608
				],
				[
					128.24184228148897,
					-50.05931562742353
				],
				[
					128.80430650202175,
					-49.49685140689053
				],
				[
					128.80430650202175,
					-48.37192296582498
				],
				[
					128.80430650202175,
					-47.80945874529198
				],
				[
					128.80430650202175,
					-46.68453030422643
				],
				[
					129.36677072255463,
					-45.55960186316088
				],
				[
					129.36677072255463,
					-44.434673422094875
				],
				[
					129.36677072255463,
					-42.747280760496324
				],
				[
					129.9292349430874,
					-41.622352319430775
				],
				[
					129.9292349430874,
					-39.93495965783222
				],
				[
					129.9292349430874,
					-38.810031216766674
				],
				[
					129.9292349430874,
					-37.68510277570067
				],
				[
					130.4916991636203,
					-36.56017433463512
				],
				[
					130.4916991636203,
					-35.43524589356957
				],
				[
					130.4916991636203,
					-34.31031745250357
				],
				[
					130.4916991636203,
					-33.18538901143802
				],
				[
					130.4916991636203,
					-31.497996349839468
				],
				[
					130.4916991636203,
					-30.37306790877392
				],
				[
					130.4916991636203,
					-28.123211026642366
				],
				[
					130.4916991636203,
					-26.998282585576817
				],
				[
					130.4916991636203,
					-25.873354144511268
				],
				[
					130.4916991636203,
					-25.310889923978266
				],
				[
					130.4916991636203,
					-24.748425703445264
				],
				[
					130.4916991636203,
					-24.185961482912262
				],
				[
					130.4916991636203,
					-23.623497262379715
				],
				[
					130.4916991636203,
					-23.061033041846713
				],
				[
					130.4916991636203,
					-21.936104600781164
				],
				[
					130.4916991636203,
					-21.373640380248162
				],
				[
					130.4916991636203,
					-20.81117615971516
				],
				[
					130.4916991636203,
					-20.248711939182613
				],
				[
					130.4916991636203,
					-19.123783498117064
				],
				[
					130.4916991636203,
					-17.99885505705106
				],
				[
					130.4916991636203,
					-17.436390836518513
				],
				[
					130.4916991636203,
					-16.87392661598551
				],
				[
					130.4916991636203,
					-15.748998174919961
				],
				[
					130.4916991636203,
					-14.624069733853958
				],
				[
					130.4916991636203,
					-14.06160551332141
				],
				[
					130.4916991636203,
					-13.499141292788408
				],
				[
					130.4916991636203,
					-12.37421285172286
				],
				[
					130.4916991636203,
					-11.811748631189857
				],
				[
					130.4916991636203,
					-10.686820190124308
				],
				[
					130.4916991636203,
					-10.124355969591306
				],
				[
					130.4916991636203,
					-10.124355969591306
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 146,
			"versionNonce": 1899787078,
			"isDeleted": false,
			"id": "ShZipQ9Mx3QFU-mle5vSK",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 71.65358091522967,
			"y": 2749.742300308562,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 16.873926615985397,
			"height": 14.624069733853503,
			"seed": 322285273,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					1.1249284410655491
				],
				[
					0.5624642205327746,
					2.249856882131553
				],
				[
					1.1249284410656628,
					2.8123211026641
				],
				[
					2.812321102664214,
					4.499713764262651
				],
				[
					4.499713764262765,
					6.187106425861202
				],
				[
					6.187106425861316,
					7.312034866926751
				],
				[
					6.7495706463940905,
					7.312034866926751
				],
				[
					6.187106425861316,
					7.312034866926751
				],
				[
					6.7495706463940905,
					7.312034866926751
				],
				[
					6.7495706463940905,
					6.749570646394204
				],
				[
					7.874499087459867,
					6.187106425861202
				],
				[
					8.99942752852553,
					5.062177984795653
				],
				[
					9.561891749058304,
					3.937249543730104
				],
				[
					10.686820190124081,
					2.249856882131553
				],
				[
					12.936677072255407,
					-1.1249284410655491
				],
				[
					14.624069733853958,
					-3.374785323197102
				],
				[
					15.186533954386846,
					-3.937249543730104
				],
				[
					15.74899817491962,
					-5.624642205328655
				],
				[
					15.74899817491962,
					-6.187106425861202
				],
				[
					16.31146239545251,
					-6.749570646394204
				],
				[
					16.873926615985397,
					-6.749570646394204
				],
				[
					16.873926615985397,
					-7.312034866926751
				],
				[
					16.873926615985397,
					-6.749570646394204
				],
				[
					16.873926615985397,
					-6.749570646394204
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 167,
			"versionNonce": 627821594,
			"isDeleted": false,
			"id": "aJqAapKGIBpO8y-SyFwB5",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 106.52636258826612,
			"y": 2767.741155365613,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 109.68052300390491,
			"height": 5.062177984795653,
			"seed": 444251705,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
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
					2.812321102664214,
					0
				],
				[
					8.436963307992642,
					-0.5624642205330019
				],
				[
					14.06160551332107,
					-1.1249284410655491
				],
				[
					16.31146239545251,
					-1.1249284410655491
				],
				[
					20.248711939182385,
					-1.687392661598551
				],
				[
					22.498568821313825,
					-2.249856882131553
				],
				[
					24.74842570344515,
					-2.8123211026641
				],
				[
					28.123211026642252,
					-2.8123211026641
				],
				[
					31.497996349839354,
					-3.374785323197102
				],
				[
					34.87278167303646,
					-3.374785323197102
				],
				[
					37.12263855516778,
					-3.374785323197102
				],
				[
					39.37249543729922,
					-3.374785323197102
				],
				[
					42.747280760496324,
					-3.374785323197102
				],
				[
					46.12206608369331,
					-3.374785323197102
				],
				[
					48.934387186357526,
					-3.374785323197102
				],
				[
					52.30917250955463,
					-3.937249543730104
				],
				[
					55.12149361221884,
					-4.499713764262651
				],
				[
					56.80888627381739,
					-4.499713764262651
				],
				[
					59.62120737648161,
					-4.499713764262651
				],
				[
					65.24584958181015,
					-4.499713764262651
				],
				[
					69.74556334607291,
					-4.499713764262651
				],
				[
					73.68281288980279,
					-4.499713764262651
				],
				[
					76.495133992467,
					-4.499713764262651
				],
				[
					79.30745509513122,
					-4.499713764262651
				],
				[
					82.11977619779555,
					-4.499713764262651
				],
				[
					84.93209730045976,
					-4.499713764262651
				],
				[
					87.74441840312397,
					-4.499713764262651
				],
				[
					90.55673950578819,
					-4.499713764262651
				],
				[
					92.24413216738674,
					-4.499713764262651
				],
				[
					93.93152482898529,
					-4.499713764262651
				],
				[
					95.05645327005095,
					-4.499713764262651
				],
				[
					96.7438459316495,
					-4.499713764262651
				],
				[
					97.86877437271517,
					-4.499713764262651
				],
				[
					99.55616703431372,
					-4.499713764262651
				],
				[
					102.36848813697793,
					-4.499713764262651
				],
				[
					104.05588079857648,
					-4.499713764262651
				],
				[
					105.74327346017503,
					-4.499713764262651
				],
				[
					107.43066612177358,
					-4.499713764262651
				],
				[
					108.55559456283925,
					-4.499713764262651
				],
				[
					109.11805878337213,
					-4.499713764262651
				],
				[
					109.11805878337213,
					-5.062177984795653
				],
				[
					109.68052300390491,
					-5.062177984795653
				],
				[
					109.68052300390491,
					-4.499713764262651
				],
				[
					109.68052300390491,
					-4.499713764262651
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 142,
			"versionNonce": 286923398,
			"isDeleted": false,
			"id": "rbN20fry8deTkt0IEUbN_",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 215.64442137163826,
			"y": 2757.0543351754886,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 10.124355969591306,
			"height": 11.24928441065731,
			"seed": 431986615,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
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
					1.687392661598551,
					0.5624642205330019
				],
				[
					2.812321102664214,
					2.249856882131553
				],
				[
					3.9372495437298767,
					2.812321102664555
				],
				[
					5.0621779847955395,
					3.937249543730104
				],
				[
					5.624642205328428,
					3.937249543730104
				],
				[
					5.624642205328428,
					4.499713764263106
				],
				[
					6.187106425861316,
					4.499713764263106
				],
				[
					6.187106425861316,
					5.062177984796108
				],
				[
					5.624642205328428,
					5.062177984796108
				],
				[
					4.499713764262765,
					5.062177984796108
				],
				[
					3.3747853231969884,
					5.624642205328655
				],
				[
					2.2498568821313256,
					6.187106425861657
				],
				[
					1.1249284410656628,
					6.187106425861657
				],
				[
					0,
					7.312034866927206
				],
				[
					-1.1249284410657765,
					8.436963307992755
				],
				[
					-2.2498568821314393,
					8.999427528525757
				],
				[
					-3.374785323197102,
					10.124355969591306
				],
				[
					-3.9372495437299904,
					11.24928441065731
				],
				[
					-3.9372495437299904,
					11.24928441065731
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 153,
			"versionNonce": 957298906,
			"isDeleted": false,
			"id": "PpqBSz1W",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 228.58109844389378,
			"y": 2751.429692970161,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 47.08811950683594,
			"height": 20,
			"seed": 1598397751,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "f_tgt",
			"rawText": "f_tgt",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f_tgt",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 197,
			"versionNonce": 222353862,
			"isDeleted": false,
			"id": "LUZMZpI1",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 193.14585255032455,
			"y": 2703.6202342248685,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 31.6640625,
			"height": 20,
			"seed": 994947097,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "RBF",
			"rawText": "RBF",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "RBF",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 133,
			"versionNonce": 119999898,
			"isDeleted": false,
			"id": "VCzeqDp3",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 8.657588215551016,
			"y": 2699.120520460605,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 68.76815795898438,
			"height": 20,
			"seed": 934895705,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "nicp align",
			"rawText": "nicp align",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "nicp align",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 269,
			"versionNonce": 751677702,
			"isDeleted": false,
			"id": "a8KLpOL9",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 117.21318277839038,
			"y": 2684.496450726751,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 59.02412414550781,
			"height": 20,
			"seed": 66080441,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "samples",
			"rawText": "samples",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "samples",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 134,
			"versionNonce": 350636634,
			"isDeleted": false,
			"id": "a3WX3bN5",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 125.65014608638302,
			"y": 2713.1821259739263,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 49.648101806640625,
			"height": 20,
			"seed": 240591863,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "querys",
			"rawText": "querys",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "querys",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "freedraw",
			"version": 187,
			"versionNonce": 1262329926,
			"isDeleted": false,
			"id": "h5tQbVh4A5fONDKsp0QJT",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 118.90057543998881,
			"y": 2672.684702095561,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 105.74327346017503,
			"height": 12.936677072255407,
			"seed": 502688855,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5624642205330019
				],
				[
					0.5624642205328882,
					1.1249284410660039
				],
				[
					1.687392661598551,
					2.8123211026641
				],
				[
					2.812321102664214,
					4.499713764263106
				],
				[
					4.499713764262765,
					6.749570646394204
				],
				[
					5.624642205328428,
					7.874499087459753
				],
				[
					7.312034866926979,
					8.999427528525757
				],
				[
					7.874499087459867,
					9.561891749058304
				],
				[
					8.99942752852553,
					10.124355969591306
				],
				[
					9.561891749058418,
					10.124355969591306
				],
				[
					10.124355969591193,
					10.124355969591306
				],
				[
					10.686820190124081,
					10.686820190124308
				],
				[
					12.374212851722632,
					10.686820190124308
				],
				[
					14.061605513321183,
					11.249284410656855
				],
				[
					15.186533954386846,
					11.811748631189857
				],
				[
					15.748998174919734,
					11.811748631189857
				],
				[
					16.31146239545251,
					11.811748631189857
				],
				[
					17.99885505705106,
					12.37421285172286
				],
				[
					20.2487119391825,
					12.936677072255407
				],
				[
					23.061033041846713,
					12.936677072255407
				],
				[
					25.873354144510927,
					12.936677072255407
				],
				[
					26.435818365043815,
					12.936677072255407
				],
				[
					26.99828258557659,
					12.936677072255407
				],
				[
					28.123211026642252,
					12.936677072255407
				],
				[
					30.37306790877369,
					12.936677072255407
				],
				[
					32.06046057037224,
					12.936677072255407
				],
				[
					34.31031745250357,
					12.936677072255407
				],
				[
					36.56017433463501,
					12.936677072255407
				],
				[
					38.24756699623356,
					12.936677072255407
				],
				[
					39.37249543729922,
					12.936677072255407
				],
				[
					40.497423878364884,
					12.936677072255407
				],
				[
					42.184816539963435,
					12.936677072255407
				],
				[
					43.872209201561986,
					12.936677072255407
				],
				[
					45.55960186316054,
					12.936677072255407
				],
				[
					47.24699452475909,
					12.936677072255407
				],
				[
					48.93438718635764,
					12.37421285172286
				],
				[
					50.62177984795619,
					12.37421285172286
				],
				[
					52.871636730087516,
					12.37421285172286
				],
				[
					54.55902939168607,
					12.37421285172286
				],
				[
					56.80888627381751,
					12.37421285172286
				],
				[
					58.496278935415944,
					12.37421285172286
				],
				[
					60.74613581754738,
					12.37421285172286
				],
				[
					63.5584569202116,
					12.37421285172286
				],
				[
					66.9332422434087,
					12.37421285172286
				],
				[
					69.18309912554002,
					12.37421285172286
				],
				[
					70.87049178713858,
					12.37421285172286
				],
				[
					73.12034866927002,
					12.37421285172286
				],
				[
					75.37020555140134,
					12.37421285172286
				],
				[
					78.18252665406555,
					12.37421285172286
				],
				[
					80.432383536197,
					12.37421285172286
				],
				[
					82.68224041832832,
					11.811748631189857
				],
				[
					84.36963307992687,
					11.811748631189857
				],
				[
					86.05702574152542,
					11.811748631189857
				],
				[
					87.74441840312397,
					11.811748631189857
				],
				[
					89.99427528525541,
					11.811748631189857
				],
				[
					91.68166794685396,
					11.811748631189857
				],
				[
					93.3690606084524,
					11.249284410656855
				],
				[
					94.49398904951818,
					11.249284410656855
				],
				[
					95.61891749058384,
					11.249284410656855
				],
				[
					96.7438459316495,
					11.249284410656855
				],
				[
					97.86877437271517,
					11.249284410656855
				],
				[
					100.1186312548466,
					11.249284410656855
				],
				[
					101.24355969591227,
					11.249284410656855
				],
				[
					103.4934165780437,
					11.249284410656855
				],
				[
					104.05588079857648,
					11.249284410656855
				],
				[
					104.61834501910937,
					11.249284410656855
				],
				[
					105.18080923964226,
					11.249284410656855
				],
				[
					105.74327346017503,
					11.249284410656855
				],
				[
					105.18080923964226,
					11.249284410656855
				],
				[
					105.18080923964226,
					11.249284410656855
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 133,
			"versionNonce": 1226829594,
			"isDeleted": false,
			"id": "yAX4e0IHIRM4GpCyB79Y-",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 222.39399201803252,
			"y": 2679.9967369624883,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 7.874499087459867,
			"height": 4.499713764262651,
			"seed": 1185541335,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487437,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5624642205325472
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
					1.687392661598551,
					2.2498568821310982
				],
				[
					2.2498568821313256,
					2.8123211026641
				],
				[
					2.812321102664214,
					2.8123211026641
				],
				[
					3.374785323197102,
					3.374785323197102
				],
				[
					2.2498568821313256,
					3.374785323197102
				],
				[
					0.5624642205327746,
					3.9372495437296493
				],
				[
					-1.1249284410657765,
					3.9372495437296493
				],
				[
					-1.687392661598551,
					3.9372495437296493
				],
				[
					-2.2498568821314393,
					3.9372495437296493
				],
				[
					-2.812321102664214,
					4.499713764262651
				],
				[
					-3.9372495437299904,
					4.499713764262651
				],
				[
					-4.499713764262765,
					4.499713764262651
				],
				[
					-4.499713764262765,
					4.499713764262651
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 204,
			"versionNonce": 1282254726,
			"isDeleted": false,
			"id": "dv1y-0Y1BGoxR3m3PFL1v",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 95.83954239814216,
			"y": 2762.6789773808164,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 130.49169916362024,
			"height": 30.935532129306466,
			"seed": 1256297207,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0.5624642205328314,
					0
				],
				[
					1.6873926615984942,
					-0.5624642205325472
				],
				[
					2.812321102664214,
					-0.5624642205325472
				],
				[
					4.499713764262765,
					-1.1249284410655491
				],
				[
					6.187106425861259,
					-2.2498568821310982
				],
				[
					7.312034866926979,
					-3.374785323197102
				],
				[
					8.436963307992642,
					-4.499713764262651
				],
				[
					10.686820190124024,
					-6.7495706463937495
				],
				[
					11.811748631189744,
					-7.874499087459753
				],
				[
					13.499141292788238,
					-8.999427528525302
				],
				[
					15.186533954386789,
					-10.124355969590852
				],
				[
					17.43639083651823,
					-11.811748631189857
				],
				[
					19.686247718649554,
					-12.936677072255407
				],
				[
					22.498568821313768,
					-15.186533954386505
				],
				[
					24.748425703445207,
					-16.31146239545251
				],
				[
					26.435818365043758,
					-17.436390836518058
				],
				[
					28.12321102664231,
					-18.561319277583607
				],
				[
					30.373067908773635,
					-19.68624771864961
				],
				[
					32.060460570372186,
					-20.81117615971516
				],
				[
					34.310317452503625,
					-21.93610460078071
				],
				[
					35.997710114102176,
					-22.49856882131371
				],
				[
					37.12263855516784,
					-23.62349726237926
				],
				[
					38.81003121676639,
					-24.185961482912262
				],
				[
					39.93495965783205,
					-24.748425703445264
				],
				[
					41.622352319430604,
					-25.873354144510813
				],
				[
					43.309744981029155,
					-26.43581836504336
				],
				[
					44.997137642627706,
					-27.560746806109364
				],
				[
					46.68453030422614,
					-28.123211026642366
				],
				[
					48.371922965824695,
					-28.685675247174913
				],
				[
					49.49685140689047,
					-28.685675247174913
				],
				[
					51.18424406848891,
					-28.685675247174913
				],
				[
					52.309172509554685,
					-29.248139467707915
				],
				[
					53.996565171153236,
					-29.248139467707915
				],
				[
					55.68395783275179,
					-29.810603688240462
				],
				[
					58.496278935416,
					-30.373067908773464
				],
				[
					59.058743155948775,
					-30.373067908773464
				],
				[
					60.18367159701455,
					-30.373067908773464
				],
				[
					62.995992699678766,
					-30.935532129306466
				],
				[
					64.68338536127732,
					-30.935532129306466
				],
				[
					66.93324224340864,
					-30.935532129306466
				],
				[
					69.74556334607286,
					-30.935532129306466
				],
				[
					71.43295600767141,
					-30.935532129306466
				],
				[
					73.68281288980285,
					-30.935532129306466
				],
				[
					76.49513399246706,
					-30.935532129306466
				],
				[
					79.30745509513127,
					-30.935532129306466
				],
				[
					82.68224041832838,
					-30.935532129306466
				],
				[
					84.9320973004597,
					-30.935532129306466
				],
				[
					87.18195418259114,
					-30.935532129306466
				],
				[
					88.86934684418969,
					-30.935532129306466
				],
				[
					91.11920372632102,
					-30.935532129306466
				],
				[
					93.36906060845246,
					-30.935532129306466
				],
				[
					96.18138171111667,
					-30.935532129306466
				],
				[
					97.86877437271522,
					-30.935532129306466
				],
				[
					98.99370281378089,
					-30.373067908773464
				],
				[
					100.68109547537944,
					-30.373067908773464
				],
				[
					102.36848813697799,
					-29.810603688240462
				],
				[
					103.49341657804365,
					-29.248139467707915
				],
				[
					104.61834501910931,
					-29.248139467707915
				],
				[
					105.74327346017498,
					-29.248139467707915
				],
				[
					106.30573768070786,
					-28.685675247174913
				],
				[
					106.86820190124075,
					-28.123211026642366
				],
				[
					107.99313034230642,
					-27.560746806109364
				],
				[
					109.68052300390497,
					-26.998282585576362
				],
				[
					111.36791566550352,
					-25.873354144510813
				],
				[
					111.93037988603629,
					-25.31088992397781
				],
				[
					113.61777254763484,
					-24.185961482912262
				],
				[
					115.86762942976628,
					-23.061033041846713
				],
				[
					116.99255787083194,
					-22.49856882131371
				],
				[
					118.11748631189761,
					-21.93610460078071
				],
				[
					119.24241475296338,
					-21.373640380248162
				],
				[
					119.80487897349616,
					-21.373640380248162
				],
				[
					120.92980741456182,
					-20.81117615971516
				],
				[
					121.49227163509471,
					-20.248711939182158
				],
				[
					122.0547358556276,
					-19.68624771864961
				],
				[
					123.17966429669326,
					-19.12378349811661
				],
				[
					123.74212851722615,
					-19.12378349811661
				],
				[
					124.30459273775892,
					-18.561319277583607
				],
				[
					124.86705695829181,
					-17.99885505705106
				],
				[
					125.99198539935747,
					-17.436390836518058
				],
				[
					126.55444961989036,
					-17.436390836518058
				],
				[
					127.11691384042314,
					-16.873926615985056
				],
				[
					128.2418422814889,
					-16.31146239545251
				],
				[
					129.36677072255458,
					-15.186533954386505
				],
				[
					129.92923494308747,
					-14.624069733853958
				],
				[
					130.49169916362024,
					-14.624069733853958
				],
				[
					130.49169916362024,
					-14.061605513320956
				],
				[
					130.49169916362024,
					-14.061605513320956
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 135,
			"versionNonce": 944176090,
			"isDeleted": false,
			"id": "7o0RYxClc1GY0ysWYYfDy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 232.5183479876237,
			"y": 2741.867801221101,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 16.31146239545251,
			"height": 6.187106425861202,
			"seed": 369183353,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5624642205330019
				],
				[
					0,
					1.687392661598551
				],
				[
					0,
					2.249856882131553
				],
				[
					0,
					2.8123211026641
				],
				[
					0,
					3.937249543730104
				],
				[
					0,
					5.062177984795653
				],
				[
					0,
					5.624642205328655
				],
				[
					-0.5624642205328882,
					5.624642205328655
				],
				[
					-1.687392661598551,
					5.624642205328655
				],
				[
					-2.812321102664214,
					5.624642205328655
				],
				[
					-4.499713764262765,
					5.624642205328655
				],
				[
					-6.187106425861316,
					5.624642205328655
				],
				[
					-8.436963307992642,
					5.624642205328655
				],
				[
					-10.686820190124081,
					5.624642205328655
				],
				[
					-12.936677072255407,
					5.624642205328655
				],
				[
					-14.624069733853958,
					6.187106425861202
				],
				[
					-16.31146239545251,
					6.187106425861202
				],
				[
					-16.31146239545251,
					6.187106425861202
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 141,
			"versionNonce": 278578886,
			"isDeleted": false,
			"id": "qansOcwrV0ia0WiDenJIy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 178.52178281647053,
			"y": 2699.682984681138,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 11.811748631189744,
			"height": 14.061605513320956,
			"seed": 277559097,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					0.5624642205325472
				],
				[
					0.5624642205327746,
					0.5624642205325472
				],
				[
					0.5624642205327746,
					1.1249284410655491
				],
				[
					1.1249284410656628,
					2.2498568821310982
				],
				[
					2.2498568821313256,
					3.9372495437296493
				],
				[
					2.812321102664214,
					5.062177984795653
				],
				[
					2.812321102664214,
					5.6246422053282
				],
				[
					3.9372495437298767,
					6.749570646394204
				],
				[
					5.0621779847955395,
					7.312034866926751
				],
				[
					5.624642205328428,
					8.436963307992755
				],
				[
					6.7495706463940905,
					8.999427528525302
				],
				[
					7.312034866926979,
					9.561891749058304
				],
				[
					7.312034866926979,
					10.124355969591306
				],
				[
					7.874499087459867,
					10.124355969591306
				],
				[
					7.874499087459867,
					10.686820190123854
				],
				[
					8.436963307992642,
					10.686820190123854
				],
				[
					8.99942752852553,
					11.811748631189403
				],
				[
					9.561891749058304,
					12.374212851722405
				],
				[
					10.124355969591193,
					12.936677072255407
				],
				[
					10.686820190124081,
					12.936677072255407
				],
				[
					11.249284410656855,
					13.499141292788408
				],
				[
					11.811748631189744,
					13.499141292788408
				],
				[
					11.811748631189744,
					14.061605513320956
				],
				[
					11.811748631189744,
					14.061605513320956
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 147,
			"versionNonce": 1886285978,
			"isDeleted": false,
			"id": "UCa32onmUq_3OHGROIaP-",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 180.77163969860186,
			"y": 2721.6190892819186,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 16.873926615985397,
			"height": 5.062177984795198,
			"seed": 185903769,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
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
					1.1249284410656628,
					0
				],
				[
					1.687392661598551,
					0
				],
				[
					2.2498568821314393,
					0
				],
				[
					3.374785323197102,
					0
				],
				[
					3.9372495437299904,
					0
				],
				[
					4.499713764262765,
					0
				],
				[
					5.062177984795653,
					0
				],
				[
					6.187106425861316,
					-0.5624642205325472
				],
				[
					7.312034866926979,
					-0.5624642205325472
				],
				[
					8.436963307992755,
					-0.5624642205325472
				],
				[
					8.99942752852553,
					-1.1249284410655491
				],
				[
					9.561891749058418,
					-1.1249284410655491
				],
				[
					10.124355969591306,
					-1.1249284410655491
				],
				[
					10.686820190124081,
					-1.1249284410655491
				],
				[
					11.24928441065697,
					-1.1249284410655491
				],
				[
					11.811748631189744,
					-1.687392661598551
				],
				[
					12.374212851722632,
					-1.687392661598551
				],
				[
					12.374212851722632,
					-2.2498568821310982
				],
				[
					12.93667707225552,
					-2.2498568821310982
				],
				[
					13.499141292788295,
					-2.8123211026641
				],
				[
					14.061605513321183,
					-2.8123211026641
				],
				[
					14.061605513321183,
					-3.374785323197102
				],
				[
					14.624069733854071,
					-3.374785323197102
				],
				[
					15.186533954386846,
					-3.374785323197102
				],
				[
					16.31146239545251,
					-3.9372495437296493
				],
				[
					16.873926615985397,
					-4.499713764262651
				],
				[
					16.873926615985397,
					-5.062177984795198
				],
				[
					16.873926615985397,
					-4.499713764262651
				],
				[
					16.873926615985397,
					-4.499713764262651
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "image",
			"version": 165,
			"versionNonce": 1751252486,
			"isDeleted": false,
			"id": "dabB_a6FwSHhYWUS62Ilq",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3251.9293437728447,
			"y": 1928.1556065821592,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 1835.69892473118,
			"height": 474.22222222222155,
			"seed": 974279808,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "86dfab85d0d3ac7276538ef8409d343b3fae9cea",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 325,
			"versionNonce": 1162431834,
			"isDeleted": false,
			"id": "XgZhwrsb",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3073.471741433663,
			"y": 2505.547628303127,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 511.6806640625,
			"height": 20,
			"seed": 146674560,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Image Blending主要处理的是 foreground mask/matting不干净的问题.",
			"rawText": "Image Blending主要处理的是 foreground mask/matting不干净的问题.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Image Blending主要处理的是 foreground mask/matting不干净的问题.",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 293,
			"versionNonce": 146820422,
			"isDeleted": false,
			"id": "4Mydrucy",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2039.7217414336628,
			"y": 2465.5476283031276,
			"strokeColor": "#f08c00",
			"backgroundColor": "transparent",
			"width": 607.8243408203125,
			"height": 20,
			"seed": 467608704,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Image Harmonization主要解决光照整体不一致的问题, 比如说晚上和白天拍摄的照片.",
			"rawText": "Image Harmonization主要解决光照整体不一致的问题, 比如说晚上和白天拍摄的照片.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Image Harmonization主要解决光照整体不一致的问题, 比如说晚上和白天拍摄的照片.",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 172,
			"versionNonce": 472551962,
			"isDeleted": false,
			"id": "l2J9k3FN",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3073.471741433663,
			"y": 2439.297628303127,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 443.925048828125,
			"height": 31.24999999999984,
			"seed": 744903808,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"fontSize": 24.999999999999872,
			"fontFamily": 1,
			"text": "最终混合时, 背景和前景不是同一个物体",
			"rawText": "最终混合时, 背景和前景不是同一个物体",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "最终混合时, 背景和前景不是同一个物体",
			"lineHeight": 1.25,
			"baseline": 22
		},
		{
			"type": "image",
			"version": 191,
			"versionNonce": 2131932294,
			"isDeleted": false,
			"id": "RidkO8pgJHU29I5IeCwjZ",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3073.471741433663,
			"y": 2541.297628303127,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 889.0000000000001,
			"height": 321,
			"seed": 1616634752,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "f835ba52d54be6bc3c027025dc2942b6785ddd2b",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 372,
			"versionNonce": 939867866,
			"isDeleted": false,
			"id": "u9AY5I19",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3078.0023161472827,
			"y": 3290.2008258038068,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 1391.392333984375,
			"height": 20,
			"seed": 1484456832,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "将图像B贴入图像A中, 可以改变B的整体颜色, 但保持梯度不变. 将图像 B 边界上的像素与图像 A 中 B 所在位置上的像素相等，然后求解图像 B 内部其他像素的梯度，以保留图像 B 的原始梯度",
			"rawText": "将图像B贴入图像A中, 可以改变B的整体颜色, 但保持梯度不变. 将图像 B 边界上的像素与图像 A 中 B 所在位置上的像素相等，然后求解图像 B 内部其他像素的梯度，以保留图像 B 的原始梯度",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "将图像B贴入图像A中, 可以改变B的整体颜色, 但保持梯度不变. 将图像 B 边界上的像素与图像 A 中 B 所在位置上的像素相等，然后求解图像 B 内部其他像素的梯度，以保留图像 B 的原始梯度",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 170,
			"versionNonce": 622212038,
			"isDeleted": false,
			"id": "nENrA3tNbtxtTFg53D-uU",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3083.7523161472827,
			"y": 3069.9874506736337,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 229.00000000000003,
			"height": 205,
			"seed": 1292886912,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "4565d89b3c5529ba5700f175e6cc6179ec9b6468",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 414,
			"versionNonce": 90985370,
			"isDeleted": false,
			"id": "7rd2TTTvTTBIh_HjOtS81",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3072.5023161472836,
			"y": 3357.507858836899,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 809.8823529411769,
			"height": 280.97959183673487,
			"seed": 778474624,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487438,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "3631e9cecba4c92d85af8c973d2889c472c0d07e",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 130,
			"versionNonce": 350735110,
			"isDeleted": false,
			"id": "dROu5UpL",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3028.4422343593806,
			"y": 3670.851269756209,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 281.744140625,
			"height": 60,
			"seed": 674993280,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "S: 背景, 其二维标量场构成的函数为 f*\ng: 前景, 其二维标量场构成的函数为 f\nv: 期望的目标梯度场",
			"rawText": "S: 背景, 其二维标量场构成的函数为 f*\ng: 前景, 其二维标量场构成的函数为 f\nv: 期望的目标梯度场",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "S: 背景, 其二维标量场构成的函数为 f*\ng: 前景, 其二维标量场构成的函数为 f\nv: 期望的目标梯度场",
			"lineHeight": 1.25,
			"baseline": 54
		},
		{
			"type": "image",
			"version": 107,
			"versionNonce": 1720897626,
			"isDeleted": false,
			"id": "xUi2XTPm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -3031.674128457775,
			"y": 3742.7282801145034,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 21.71509738742736,
			"height": 12.571898487457945,
			"seed": 86446,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "ddc6ab93dfdf04908d365f3b5771df3a798e2aad",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 68,
			"versionNonce": 486832710,
			"isDeleted": false,
			"id": "Y4D0JQ5G",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3003.658856924593,
			"y": 3740.435367938498,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 64,
			"height": 20,
			"seed": 123724928,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "目标区域",
			"rawText": "目标区域",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "目标区域",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 74,
			"versionNonce": 2135667994,
			"isDeleted": false,
			"id": "dYEFh0Vj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -3035.113529471004,
			"y": 3772.028024210125,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 22.874658467395747,
			"height": 13.071233409940428,
			"seed": 86861,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "4e1f37fed50eaaa76822e8e48c71785fdc5bdcb9",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 75,
			"versionNonce": 877216134,
			"isDeleted": false,
			"id": "0ebaf1M3",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3003.6588569245932,
			"y": 3768.078365846531,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 144,
			"height": 20,
			"seed": 1020064896,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "目标区域的边界区域",
			"rawText": "目标区域的边界区域",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "目标区域的边界区域",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "image",
			"version": 93,
			"versionNonce": 17433050,
			"isDeleted": false,
			"id": "BEqfDtzm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -3034.4752950660054,
			"y": 3842.7921839670535,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 288.4961004935769,
			"height": 41.213728641939554,
			"seed": 67642,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "285c0bb842666c85a0a76a27e1ee513738580e9e",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 96,
			"versionNonce": 1844650182,
			"isDeleted": false,
			"id": "mu4KOqEx",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3035.114682130285,
			"y": 3813.832293418447,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 533.2161865234375,
			"height": 20,
			"seed": 997336192,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "目标函数(边界与背景一致的情况下, 竟可能保持\\Omega中的梯度信息不变):",
			"rawText": "目标函数(边界与背景一致的情况下, 竟可能保持\\Omega中的梯度信息不变):",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "目标函数(边界与背景一致的情况下, 竟可能保持\\Omega中的梯度信息不变):",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 53,
			"versionNonce": 1994438298,
			"isDeleted": false,
			"id": "m2o6lnDE",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3081.3220844127445,
			"y": 3018.008215109123,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 315.6138610839844,
			"height": 37.07324973965414,
			"seed": 1112949632,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"fontSize": 29.658599791723308,
			"fontFamily": 1,
			"text": "Poisson Image Editing",
			"rawText": "Poisson Image Editing",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Poisson Image Editing",
			"lineHeight": 1.25,
			"baseline": 26
		},
		{
			"type": "image",
			"version": 167,
			"versionNonce": 1839142918,
			"isDeleted": false,
			"id": "dRpJH8G0",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2323.9529358198242,
			"y": 3688.400123756832,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 59.780551065662536,
			"height": 15.791088960741046,
			"seed": 27411,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "c95873972990a1e8ad144cdcb436452591a67119",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 140,
			"versionNonce": 293786458,
			"isDeleted": false,
			"id": "PTCjTd1P",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -2323.269860784139,
			"y": 3853.2078729855343,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 314.5029860035167,
			"height": 43.34140089801113,
			"seed": 19826,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "5827e3bac210550fa54d33285aac05a1e277868d",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 147,
			"versionNonce": 1531586374,
			"isDeleted": false,
			"id": "VTk6ZZJK",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2208.285132910874,
			"y": 3683.7956682372023,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 186.91978454589844,
			"height": 50,
			"seed": 523625344,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "importing gradients,\n直接使用指定的梯度",
			"rawText": "importing gradients,\n直接使用指定的梯度",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "importing gradients,\n直接使用指定的梯度",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "text",
			"version": 132,
			"versionNonce": 1933793306,
			"isDeleted": false,
			"id": "IY3kWBuk",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1937.5973151508024,
			"y": 3863.4177854158465,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 555.1400146484375,
			"height": 50,
			"seed": 1735517312,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487439,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "mix gradients\n使用混合的梯度, 也适用于将与背景很相似的物体添加到背景中",
			"rawText": "mix gradients\n使用混合的梯度, 也适用于将与背景很相似的物体添加到背景中",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "mix gradients\n使用混合的梯度, 也适用于将与背景很相似的物体添加到背景中",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "image",
			"version": 261,
			"versionNonce": 1464946310,
			"isDeleted": false,
			"id": "KjBIO_Kg7o-7R0oQh9wfs",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1308.377964691958,
			"y": 3776.8513367169353,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 442.8405784999206,
			"height": 329.8435900613017,
			"seed": 1966719872,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "c5ee388b899ba950ac0f821a51dce7c77ccc8a82",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 121,
			"versionNonce": 2081768666,
			"isDeleted": false,
			"id": "uPq1hriTlUfnDubbAJDpV",
			"fillStyle": "hachure",
			"strokeWidth": 0.5,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1680.3344734405136,
			"y": 3479.5051052518065,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 381.19719362651324,
			"height": 272.44064558897776,
			"seed": 2029908864,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "ecbb6327d8d3454a2626fe8e843bfd856139e8a4",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 52,
			"versionNonce": 1852935622,
			"isDeleted": false,
			"id": "wtFwlRRyho1WV1e0gZ36j",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2334.095611439411,
			"y": 3665.023607943411,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 338.78310590616843,
			"height": 84.17617048588863,
			"seed": 1693766784,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 94,
			"versionNonce": 361470362,
			"isDeleted": false,
			"id": "S_SWb4DN01tl7VAelQ6hn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2340.330883327255,
			"y": 3830.2583129712666,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 976.8592624288297,
			"height": 102.88198614941939,
			"seed": 2012263552,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false
		},
		{
			"type": "freedraw",
			"version": 92,
			"versionNonce": 231204102,
			"isDeleted": false,
			"id": "odpsh0u2PlcvcUEWrNq1G",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2873.446629737882,
			"y": 3721.1410549340035,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 519.605990653633,
			"height": 16.627391700916178,
			"seed": 1258976128,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.078423962614579,
					-2.078423962614579
				],
				[
					5.196059906536448,
					-2.078423962614579
				],
				[
					9.352907831765151,
					-3.117635943921414
				],
				[
					15.588179719608888,
					-4.156847925228703
				],
				[
					30.137147457910487,
					-5.196059906535993
				],
				[
					36.372419345754224,
					-5.196059906535993
				],
				[
					44.68611519621254,
					-5.196059906535993
				],
				[
					52.9998110466704,
					-5.196059906535993
				],
				[
					60.27429491582143,
					-5.196059906535993
				],
				[
					65.47035482235788,
					-5.196059906535993
				],
				[
					69.62720274758658,
					-5.196059906535993
				],
				[
					73.78405067281574,
					-6.2352718878432825
				],
				[
					77.9408985980449,
					-6.2352718878432825
				],
				[
					82.09774652327405,
					-6.2352718878432825
				],
				[
					88.33301841111734,
					-6.2352718878432825
				],
				[
					101.8427741681121,
					-6.2352718878432825
				],
				[
					105.9996220933408,
					-6.2352718878432825
				],
				[
					115.35252992510641,
					-6.2352718878432825
				],
				[
					124.70543775687202,
					-6.2352718878432825
				],
				[
					134.05834558863717,
					-6.2352718878432825
				],
				[
					140.2936174764809,
					-6.2352718878432825
				],
				[
					146.52888936432464,
					-6.2352718878432825
				],
				[
					150.68573728955334,
					-6.2352718878432825
				],
				[
					167.31312899046952,
					-7.274483869150572
				],
				[
					174.58761285962055,
					-8.313695850457862
				],
				[
					182.9013087100784,
					-9.352907831765151
				],
				[
					189.13658059792215,
					-10.39211981307244
				],
				[
					196.41106446707317,
					-10.39211981307244
				],
				[
					205.76397229883878,
					-10.39211981307244
				],
				[
					220.31294003714038,
					-10.39211981307244
				],
				[
					232.7834838128274,
					-10.39211981307244
				],
				[
					247.332451551129,
					-10.39211981307244
				],
				[
					269.1559031585816,
					-10.39211981307244
				],
				[
					286.8225068408051,
					-9.352907831765151
				],
				[
					307.6067464669504,
					-9.352907831765151
				],
				[
					316.95965429871603,
					-9.352907831765151
				],
				[
					322.1557142052525,
					-9.352907831765151
				],
				[
					324.23413816786706,
					-10.39211981307244
				],
				[
					328.39098609309576,
					-11.43133179437973
				],
				[
					333.5870459996322,
					-11.43133179437973
				],
				[
					342.93995383139736,
					-11.43133179437973
				],
				[
					361.6457694949286,
					-11.43133179437973
				],
				[
					375.1555252519229,
					-11.43133179437973
				],
				[
					387.6260690276099,
					-11.43133179437973
				],
				[
					396.9789768593755,
					-11.43133179437973
				],
				[
					402.1750367659115,
					-11.43133179437973
				],
				[
					405.29267270983337,
					-12.47054377568702
				],
				[
					408.41030865375524,
					-13.50975575699431
				],
				[
					410.4887326163698,
					-14.548967738301599
				],
				[
					414.645580541599,
					-16.627391700916178
				],
				[
					420.8808524294427,
					-16.627391700916178
				],
				[
					429.1945482799006,
					-16.627391700916178
				],
				[
					438.5474561116662,
					-16.627391700916178
				],
				[
					448.9395759247386,
					-16.627391700916178
				],
				[
					455.17484781258236,
					-16.627391700916178
				],
				[
					459.33169573781106,
					-16.627391700916178
				],
				[
					462.4493316817334,
					-16.627391700916178
				],
				[
					464.5277556443475,
					-16.627391700916178
				],
				[
					469.72381555088396,
					-16.627391700916178
				],
				[
					479.0767233826491,
					-16.627391700916178
				],
				[
					485.31199527049284,
					-16.627391700916178
				],
				[
					490.5080551770293,
					-16.627391700916178
				],
				[
					493.62569112095116,
					-16.627391700916178
				],
				[
					496.74332706487303,
					-16.627391700916178
				],
				[
					497.7825390461803,
					-16.627391700916178
				],
				[
					501.9393869714095,
					-16.627391700916178
				],
				[
					504.0178109340236,
					-16.627391700916178
				],
				[
					506.0962348966382,
					-16.627391700916178
				],
				[
					509.21387084056005,
					-16.627391700916178
				],
				[
					513.3707187657892,
					-16.627391700916178
				],
				[
					517.5275666910184,
					-16.627391700916178
				],
				[
					519.605990653633,
					-16.627391700916178
				],
				[
					518.5667786723252,
					-16.627391700916178
				],
				[
					519.605990653633,
					-16.627391700916178
				],
				[
					519.605990653633,
					-16.627391700916178
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 117,
			"versionNonce": 2128172634,
			"isDeleted": false,
			"id": "8F_1w42BmG8IxQLkXPa4L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2872.407417756575,
			"y": 3724.2586908779253,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 520.6452026349402,
			"height": 137.17598153255904,
			"seed": 1432953984,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.0392119813072895,
					0
				],
				[
					4.156847925229158,
					1.0392119813072895
				],
				[
					11.43133179437973,
					2.078423962614579
				],
				[
					19.745027644838046,
					3.1176359439218686
				],
				[
					29.097935476603197,
					4.156847925229158
				],
				[
					34.293995383139645,
					5.196059906536448
				],
				[
					39.49005528967609,
					6.235271887843737
				],
				[
					43.64690321490525,
					6.235271887843737
				],
				[
					48.842963121441244,
					7.274483869151027
				],
				[
					56.11744699059227,
					8.313695850458316
				],
				[
					61.31350689712872,
					10.392119813072895
				],
				[
					67.548778784972,
					11.431331794380185
				],
				[
					76.9016866167376,
					12.470543775687474
				],
				[
					90.41144237373192,
					13.509755756994764
				],
				[
					104.96041011203351,
					15.588179719609343
				],
				[
					116.3917419064137,
					17.666603682223922
				],
				[
					123.66622577556473,
					18.705815663530757
				],
				[
					127.82307370079343,
					18.705815663530757
				],
				[
					136.13676955125175,
					19.745027644838046
				],
				[
					141.3328294577882,
					19.745027644838046
				],
				[
					150.68573728955334,
					20.784239626145336
				],
				[
					160.03864512131895,
					21.823451607452625
				],
				[
					171.46997691569868,
					22.862663588759915
				],
				[
					179.783672766157,
					24.941087551374494
				],
				[
					191.21500456053673,
					27.019511513989073
				],
				[
					204.7247603175315,
					29.097935476603652
				],
				[
					214.07766814929664,
					32.21557142052552
				],
				[
					222.39136399975496,
					32.21557142052552
				],
				[
					228.62663588759824,
					33.25478340183281
				],
				[
					233.8226957941347,
					33.25478340183281
				],
				[
					237.97954371936385,
					33.25478340183281
				],
				[
					242.136391644593,
					33.25478340183281
				],
				[
					245.25402758851442,
					33.25478340183281
				],
				[
					248.3716635324363,
					33.25478340183281
				],
				[
					252.52851145766545,
					35.33320736444739
				],
				[
					258.7637833455092,
					37.41163132706197
				],
				[
					271.2343271211962,
					39.49005528967609
				],
				[
					288.90093080341967,
					44.68611519621254
				],
				[
					297.214626653878,
					45.72532717751983
				],
				[
					302.410686560414,
					46.76453915882712
				],
				[
					305.52832250433585,
					47.80375114013441
				],
				[
					308.6459584482577,
					48.8429631214417
				],
				[
					316.95965429871603,
					49.88217510274899
				],
				[
					319.0380782613306,
					50.92138708405628
				],
				[
					324.2341381678666,
					51.96059906536357
				],
				[
					328.39098609309576,
					54.03902302797769
				],
				[
					334.6262579809395,
					56.11744699059227
				],
				[
					349.1752257192411,
					61.31350689712872
				],
				[
					358.5281335510067,
					64.43114284105059
				],
				[
					363.7241934575427,
					66.50956680366517
				],
				[
					365.8026174201573,
					67.54877878497246
				],
				[
					366.84182940146457,
					67.54877878497246
				],
				[
					368.92025336407914,
					68.58799076627975
				],
				[
					375.1555252519229,
					69.62720274758703
				],
				[
					382.4300091210739,
					71.70562671020161
				],
				[
					388.6652810089172,
					73.78405067281574
				],
				[
					395.9397648780682,
					75.86247463543032
				],
				[
					402.17503676591195,
					77.9408985980449
				],
				[
					408.41030865375524,
					81.05853454196676
				],
				[
					414.645580541599,
					82.09774652327405
				],
				[
					417.76321648552084,
					84.17617048588863
				],
				[
					419.8416404481354,
					85.21538246719592
				],
				[
					420.88085242944226,
					86.25459444850321
				],
				[
					422.95927639205684,
					86.25459444850321
				],
				[
					427.116124317286,
					89.37223039242508
				],
				[
					431.27297224251515,
					90.41144237373237
				],
				[
					435.4298201677443,
					92.48986633634695
				],
				[
					436.4690321490516,
					93.52907831765378
				],
				[
					438.5474561116657,
					94.56829029896153
				],
				[
					440.6258800742803,
					97.68592624288294
				],
				[
					444.78272799950946,
					100.80356218680481
				],
				[
					447.90036394343133,
					103.92119813072668
				],
				[
					451.0179998873532,
					105.99962209334126
				],
				[
					453.0964238499678,
					107.03883407464855
				],
				[
					455.17484781258236,
					108.07804605595584
				],
				[
					458.29248375650377,
					110.15647001857042
				],
				[
					463.4885436630402,
					113.27410596249183
				],
				[
					469.72381555088396,
					117.43095388772099
				],
				[
					470.76302753219124,
					118.47016586902828
				],
				[
					471.80223951349853,
					119.50937785033557
				],
				[
					474.9198754574204,
					121.58780181295015
				],
				[
					476.998299420035,
					122.62701379425744
				],
				[
					478.0375114013418,
					123.66622577556473
				],
				[
					480.1159353639564,
					124.70543775687202
				],
				[
					481.15514734526414,
					124.70543775687202
				],
				[
					482.194359326571,
					124.70543775687202
				],
				[
					483.23357130787826,
					125.7446497381793
				],
				[
					485.31199527049284,
					126.7838617194866
				],
				[
					487.3904192331074,
					126.7838617194866
				],
				[
					491.5472671583366,
					128.86228568210117
				],
				[
					500.9001749901022,
					131.97992162602304
				],
				[
					507.13544687794547,
					134.05834558863762
				],
				[
					512.3315067844819,
					136.1367695512522
				],
				[
					515.4491427284038,
					136.1367695512522
				],
				[
					517.5275666910179,
					137.17598153255904
				],
				[
					518.5667786723257,
					137.17598153255904
				],
				[
					519.6059906536325,
					137.17598153255904
				],
				[
					520.6452026349402,
					137.17598153255904
				],
				[
					519.6059906536325,
					137.17598153255904
				],
				[
					519.6059906536325,
					137.17598153255904
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 145,
			"versionNonce": 1993430086,
			"isDeleted": false,
			"id": "onPXWxqp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3684.564215258942,
			"y": 3846.168885378397,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 314.5042724609375,
			"height": 25,
			"seed": 663241856,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": "https://carlosrodriguezpardo.es/projects/SeamlessGAN/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[SeamlessGAN]]生成皮肤纹理",
			"rawText": "[SeamlessGAN](https://carlosrodriguezpardo.es/projects/SeamlessGAN/)生成皮肤纹理",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[SeamlessGAN]]生成皮肤纹理",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 152,
			"versionNonce": 416381722,
			"isDeleted": false,
			"id": "v03NyOZj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3678.825222060366,
			"y": 3900.582802245321,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 554.5394287109375,
			"height": 25,
			"seed": 1822962775,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": "https://yihua7.github.io/NeRF-Texture-web/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "皮肤纹理生成: https://yihua7.github.io/NeRF-Texture-web/",
			"rawText": "皮肤纹理生成: https://yihua7.github.io/NeRF-Texture-web/",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "皮肤纹理生成: https://yihua7.github.io/NeRF-Texture-web/",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 237,
			"versionNonce": 862641030,
			"isDeleted": false,
			"id": "LSw7gECt1DefU9QzkwHDn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3009.738927640697,
			"y": 4440.443463786819,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 230.83536810950727,
			"height": 288.09123649459696,
			"seed": 1612357966,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "3dd54594c2e9839ef70576c99031e91bdaeecae8",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 353,
			"versionNonce": 837224410,
			"isDeleted": false,
			"id": "zZiYtPoK5w8N6nX-Lr9cR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3013.1623460646706,
			"y": 4821.003821095044,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 259.6951871657754,
			"height": 258.86944730197325,
			"seed": 939630286,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "7eac5a36ed8e2c0f24912a1b039f95fc4ea5dd05",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 508,
			"versionNonce": 164723398,
			"isDeleted": false,
			"id": "8geQggPjgTZiPsFlRmwRN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2621.6892653069435,
			"y": 8147.222875551526,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 444.40677966101714,
			"height": 443.90519187358933,
			"seed": 1568702674,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "9166d93f07a00e3267314a3d39b681005686122d",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 443,
			"versionNonce": 1378679962,
			"isDeleted": false,
			"id": "cS_RiE6MbqHN_Mymc8Yhe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2757.0446990058467,
			"y": 5720.277497400262,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 327.99247685981146,
			"height": 354.69628913512355,
			"seed": 1808261394,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "1353d70d4a079358d21bcbd10ce1517a974da5d3",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 428,
			"versionNonce": 1889677830,
			"isDeleted": false,
			"id": "eywm6J7SZ-mjbLX6LAKuc",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2357.3724300982844,
			"y": 5709.45816966917,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 270.3453570107292,
			"height": 353.0588235294122,
			"seed": 1349100814,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "42f971d63cae8093237ab832e590fc688923dad1",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 378,
			"versionNonce": 123099482,
			"isDeleted": false,
			"id": "wTTqu07Rp0AsZM6M9Ihof",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3011.876631778956,
			"y": 5181.794304122955,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 298.52941176470586,
			"height": 319.97715591090804,
			"seed": 1143707086,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487440,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "801ef5d4449614d91aaf298d4759d6efa49a4e26",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 435,
			"versionNonce": 47841606,
			"isDeleted": false,
			"id": "vj8fXL_TdOrGmFxUdWc9q",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3135.3094048882,
			"y": 5724.1262368960615,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 310.94117647058863,
			"height": 350.82024928930724,
			"seed": 2091210642,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "059bd6951a9072da6e37dc09b63dde8778c67069",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 369,
			"versionNonce": 817241626,
			"isDeleted": false,
			"id": "DValVr7FmSfNX6aV_SNNL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2672.4816737957635,
			"y": 5184.844724291021,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 331.00000000000006,
			"height": 324.1806656101427,
			"seed": 550840782,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a55261d69d817b9b3f4f1d25805c49c753d18522",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "rectangle",
			"version": 467,
			"versionNonce": 1943398534,
			"isDeleted": false,
			"id": "FErjp1TtUnGpEBvwPcFbd",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3045.805203207528,
			"y": 5157.29010244228,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 751.4285714285713,
			"height": 370.5882352941171,
			"seed": 1685507918,
			"groupIds": [],
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 185,
			"versionNonce": 1262439130,
			"isDeleted": false,
			"id": "shH9DPyA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2823.5362956445024,
			"y": 5599.474976391858,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 146.59994506835938,
			"height": 25,
			"seed": 678724946,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "腐蚀之后的mask",
			"rawText": "腐蚀之后的mask",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "腐蚀之后的mask",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 271,
			"versionNonce": 55764934,
			"isDeleted": false,
			"id": "UHL7XvUeJ_wLsojVr_C2Z",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2715.746056471911,
			"y": 4818.425756850333,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 266.38461538461576,
			"height": 260.89650128001983,
			"seed": 1732460110,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a55261d69d817b9b3f4f1d25805c49c753d18522",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 330,
			"versionNonce": 1032118170,
			"isDeleted": false,
			"id": "rF71EYFJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2929.5867158125698,
			"y": 5444.045112138468,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 182.28369140625,
			"height": 40.38461538461525,
			"seed": 697685714,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"fontSize": 32.3076923076922,
			"fontFamily": 1,
			"text": "mouth mask",
			"rawText": "mouth mask",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "mouth mask",
			"lineHeight": 1.25,
			"baseline": 28
		},
		{
			"type": "freedraw",
			"version": 162,
			"versionNonce": 1903034118,
			"isDeleted": false,
			"id": "qK_tmFrJZGIXv-e84IBko",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2730.3254035412956,
			"y": 5531.572323200186,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 201.42857142857116,
			"height": 178.57142857142932,
			"seed": 249790350,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"points": [
				[
					25.714285714285836,
					0
				],
				[
					24.076655052265302,
					0
				],
				[
					19.163763066202655,
					1.5262515262516656
				],
				[
					12.613240418118949,
					4.578754578754997
				],
				[
					4.425087108014189,
					9.157509157509022
				],
				[
					-2.1254355400689953,
					12.210012210012353
				],
				[
					-10.313588850173751,
					15.262515262515684
				],
				[
					-18.501742160278518,
					18.315018315019017
				],
				[
					-26.68989547038275,
					21.367521367521377
				],
				[
					-39.790940766550165,
					27.47252747252804
				],
				[
					-47.979094076654405,
					30.5250305250304
				],
				[
					-61.080139372821804,
					39.682539682540394
				],
				[
					-72.54355400696817,
					45.78754578754609
				],
				[
					-87.28222996515663,
					54.945054945055105
				],
				[
					-95.47038327526086,
					61.05006105006177
				],
				[
					-102.02090592334457,
					67.15506715506746
				],
				[
					-103.65853658536511,
					70.2075702075708
				],
				[
					-105.29616724738617,
					71.73382173382245
				],
				[
					-106.93379790940722,
					73.26007326007316
				],
				[
					-108.57142857142827,
					74.78632478632481
				],
				[
					-110.20905923344932,
					77.83882783882815
				],
				[
					-111.84668989546986,
					79.36507936507981
				],
				[
					-115.12195121951146,
					82.41758241758315
				],
				[
					-118.39721254355356,
					86.99633699633716
				],
				[
					-121.67247386759567,
					91.57509157509217
				],
				[
					-124.94773519163726,
					96.15384615384619
				],
				[
					-126.5853658536578,
					100.73260073260118
				],
				[
					-129.8606271776999,
					105.31135531135521
				],
				[
					-133.13588850174204,
					111.41636141636188
				],
				[
					-133.13588850174204,
					114.4688644688652
				],
				[
					-136.4111498257836,
					117.52136752136757
				],
				[
					-139.6864111498252,
					123.62637362637423
				],
				[
					-142.96167247386734,
					128.20512820512826
				],
				[
					-146.2369337979089,
					131.2576312576316
				],
				[
					-147.87456445992999,
					134.3101343101349
				],
				[
					-147.87456445992999,
					135.8363858363866
				],
				[
					-149.5121951219505,
					137.3626373626373
				],
				[
					-151.14982578397158,
					138.88888888888894
				],
				[
					-152.78745644599263,
					141.94139194139228
				],
				[
					-154.42508710801368,
					143.46764346764394
				],
				[
					-156.06271777003474,
					144.9938949938956
				],
				[
					-156.06271777003474,
					146.52014652014728
				],
				[
					-157.70034843205528,
					148.04639804639797
				],
				[
					-157.70034843205528,
					149.57264957264962
				],
				[
					-159.33797909407633,
					149.57264957264962
				],
				[
					-160.97560975609687,
					152.62515262515296
				],
				[
					-160.97560975609687,
					154.15140415140462
				],
				[
					-162.61324041811793,
					154.15140415140462
				],
				[
					-162.61324041811793,
					155.6776556776563
				],
				[
					-164.25087108013898,
					157.20390720390796
				],
				[
					-165.88850174216003,
					160.25641025641033
				],
				[
					-167.52613240418108,
					161.782661782662
				],
				[
					-167.52613240418108,
					163.30891330891365
				],
				[
					-169.16376306620162,
					164.83516483516533
				],
				[
					-169.16376306620162,
					167.88766788766864
				],
				[
					-170.80139372822268,
					169.41391941391933
				],
				[
					-174.07665505226427,
					173.99267399267433
				],
				[
					-174.07665505226427,
					175.518925518926
				],
				[
					-174.07665505226427,
					177.04517704517767
				],
				[
					-175.71428571428532,
					177.04517704517767
				],
				[
					-175.71428571428532,
					178.57142857142932
				],
				[
					-175.71428571428532,
					178.57142857142932
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 113,
			"versionNonce": 599383130,
			"isDeleted": false,
			"id": "2czayUGC8umoyc-E1o-M7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2914.6111178270094,
			"y": 5690.143751771615,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 55.714285714285325,
			"height": 31.42857142857065,
			"seed": 1788273298,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					4.285714285713766
				],
				[
					0,
					5.7142857142853245
				],
				[
					0,
					11.428571428570649
				],
				[
					0,
					17.142857142856883
				],
				[
					0,
					22.857142857142208
				],
				[
					0,
					25.714285714285325
				],
				[
					1.4285714285715585,
					27.142857142856883
				],
				[
					1.4285714285715585,
					28.57142857142844
				],
				[
					1.4285714285715585,
					30
				],
				[
					2.8571428571426623,
					31.42857142857065
				],
				[
					4.285714285714221,
					31.42857142857065
				],
				[
					2.8571428571426623,
					31.42857142857065
				],
				[
					4.285714285714221,
					30
				],
				[
					2.8571428571426623,
					30
				],
				[
					4.285714285714221,
					30
				],
				[
					5.7142857142853245,
					30
				],
				[
					11.428571428571558,
					27.142857142856883
				],
				[
					15.714285714285325,
					25.714285714285325
				],
				[
					21.42857142857156,
					22.857142857142208
				],
				[
					31.42857142857156,
					17.142857142856883
				],
				[
					38.57142857142844,
					11.428571428570649
				],
				[
					45.714285714285325,
					8.571428571428442
				],
				[
					51.42857142857156,
					4.285714285713766
				],
				[
					55.714285714285325,
					2.8571428571422075
				],
				[
					55.714285714285325,
					2.8571428571422075
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 111,
			"versionNonce": 1923362374,
			"isDeleted": false,
			"id": "KJw2hegh",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2686.039689255581,
			"y": 6091.572323200186,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 154.27981567382812,
			"height": 25,
			"seed": 709683346,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "left major valid",
			"rawText": "left major valid",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "left major valid",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 108,
			"versionNonce": 464601370,
			"isDeleted": false,
			"id": "dpnXc73L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2317.4682606841525,
			"y": 6103.000894628757,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 148.09982299804688,
			"height": 25,
			"seed": 1465229522,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "left minor valid",
			"rawText": "left minor valid",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "left minor valid",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 766,
			"versionNonce": 600995206,
			"isDeleted": false,
			"id": "WwaZ9kT0Q9Rr0T-PUU4Ee",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2515.64893295306,
			"y": 7222.131146729597,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 297.4143534190928,
			"height": 455.8433068142512,
			"seed": 1839127374,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "3fe47a3be0802c75dc51a2f6e1b39aa88d35bccd",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 334,
			"versionNonce": 282987994,
			"isDeleted": false,
			"id": "l4VPcmBJy6UepGYn7A4X8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2032.9178405160856,
			"y": 7227.063919838838,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 292.0303600847253,
			"height": 439.85714285714215,
			"seed": 593158798,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "3b9efa19a39e0115667c987fcf079eea45b9fc1a",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 425,
			"versionNonce": 2117457094,
			"isDeleted": false,
			"id": "pR7Hz6MR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3157.7822810291323,
			"y": 6206.928360351884,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 437.3306884765625,
			"height": 36.76470588235336,
			"seed": 15361618,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"fontSize": 29.41176470588269,
			"fontFamily": 1,
			"text": "tex_mask * minor_valid_mask",
			"rawText": "tex_mask * minor_valid_mask",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "tex_mask * minor_valid_mask",
			"lineHeight": 1.25,
			"baseline": 25
		},
		{
			"type": "image",
			"version": 287,
			"versionNonce": 139674266,
			"isDeleted": false,
			"id": "TnN56Owp3ZIJj40ZDzLm2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2650.3855539172373,
			"y": 6314.989395292173,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 324.36418134132623,
			"height": 471.5294117647057,
			"seed": 1348819538,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "68609e5ec34d805a460b716460c7b1d55e872441",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 124,
			"versionNonce": 1265323014,
			"isDeleted": false,
			"id": "5vBCv6iQJp3TBl6T-QPPv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3000.9401757659775,
			"y": 6080.407462519064,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 21.42857142857156,
			"height": 228.57142857142935,
			"seed": 1651606094,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.8571428571426623,
					5.714285714286234
				],
				[
					5.714285714285779,
					14.285714285714675
				],
				[
					7.142857142857338,
					22.857142857143117
				],
				[
					8.571428571428896,
					31.42857142857156
				],
				[
					11.428571428571558,
					45.714285714286234
				],
				[
					12.857142857142662,
					51.42857142857156
				],
				[
					14.28571428571422,
					57.14285714285779
				],
				[
					15.71428571428578,
					64.28571428571468
				],
				[
					18.571428571428896,
					75.71428571428623
				],
				[
					21.42857142857156,
					91.42857142857156
				],
				[
					21.42857142857156,
					101.42857142857156
				],
				[
					21.42857142857156,
					112.85714285714312
				],
				[
					21.42857142857156,
					124.28571428571468
				],
				[
					21.42857142857156,
					134.28571428571468
				],
				[
					20,
					142.85714285714312
				],
				[
					17.142857142857338,
					155.71428571428623
				],
				[
					15.71428571428578,
					164.28571428571468
				],
				[
					14.28571428571422,
					172.85714285714312
				],
				[
					12.857142857142662,
					178.57142857142935
				],
				[
					12.857142857142662,
					182.85714285714312
				],
				[
					11.428571428571558,
					191.42857142857156
				],
				[
					11.428571428571558,
					194.28571428571468
				],
				[
					11.428571428571558,
					200
				],
				[
					10,
					201.42857142857156
				],
				[
					10,
					207.1428571428578
				],
				[
					10,
					208.57142857142935
				],
				[
					10,
					210
				],
				[
					10,
					211.42857142857156
				],
				[
					10,
					214.28571428571468
				],
				[
					10,
					215.71428571428623
				],
				[
					10,
					217.1428571428578
				],
				[
					10,
					220
				],
				[
					10,
					221.42857142857156
				],
				[
					10,
					224.28571428571468
				],
				[
					10,
					225.71428571428623
				],
				[
					10,
					227.1428571428578
				],
				[
					10,
					228.57142857142935
				],
				[
					10,
					228.57142857142935
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 105,
			"versionNonce": 1824776026,
			"isDeleted": false,
			"id": "GGwJoH1l7Ad_BfCPcO18v",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3013.79731862312,
			"y": 6296.12174823335,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 54.28571428571422,
			"height": 24.285714285714675,
			"seed": 749178702,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.4285714285715585,
					0
				],
				[
					1.4285714285715585,
					1.4285714285715585
				],
				[
					4.285714285714221,
					5.7142857142853245
				],
				[
					8.571428571428442,
					10
				],
				[
					11.428571428571558,
					15.714285714285325
				],
				[
					17.142857142856883,
					20
				],
				[
					18.57142857142844,
					21.42857142857156
				],
				[
					20,
					21.42857142857156
				],
				[
					21.42857142857156,
					21.42857142857156
				],
				[
					22.857142857142662,
					21.42857142857156
				],
				[
					25.714285714285325,
					21.42857142857156
				],
				[
					30,
					20
				],
				[
					32.85714285714266,
					18.57142857142844
				],
				[
					35.714285714285325,
					15.714285714285325
				],
				[
					41.42857142857156,
					10
				],
				[
					45.714285714285325,
					4.285714285713766
				],
				[
					51.42857142857156,
					0
				],
				[
					54.28571428571422,
					-2.857142857143117
				],
				[
					54.28571428571422,
					-2.857142857143117
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 157,
			"versionNonce": 426761030,
			"isDeleted": false,
			"id": "hMc-_DrqCh4Tnz90SvVDk",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2698.083032908835,
			"y": 6084.693176804779,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 291.4285714285711,
			"height": 215.71428571428532,
			"seed": 1458382354,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487441,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.4285714285711038,
					0
				],
				[
					-7.142857142856883,
					1.4285714285715585
				],
				[
					-12.857142857142662,
					4.2857142857146755
				],
				[
					-20,
					7.142857142856883
				],
				[
					-25.714285714285325,
					11.428571428571558
				],
				[
					-30,
					15.714285714285325
				],
				[
					-35.714285714285325,
					20
				],
				[
					-40,
					21.42857142857156
				],
				[
					-47.14285714285688,
					28.57142857142844
				],
				[
					-54.285714285713766,
					35.714285714285325
				],
				[
					-58.57142857142844,
					37.14285714285688
				],
				[
					-64.28571428571377,
					41.42857142857156
				],
				[
					-74.28571428571377,
					48.57142857142844
				],
				[
					-90,
					58.57142857142844
				],
				[
					-98.57142857142844,
					65.71428571428532
				],
				[
					-110,
					72.85714285714312
				],
				[
					-117.14285714285688,
					78.57142857142844
				],
				[
					-125.71428571428532,
					84.28571428571468
				],
				[
					-135.71428571428532,
					91.42857142857156
				],
				[
					-144.28571428571377,
					98.57142857142844
				],
				[
					-154.28571428571377,
					105.71428571428532
				],
				[
					-160,
					110
				],
				[
					-162.85714285714266,
					114.28571428571468
				],
				[
					-165.71428571428532,
					117.14285714285688
				],
				[
					-170,
					121.42857142857156
				],
				[
					-174.28571428571377,
					124.28571428571468
				],
				[
					-177.14285714285688,
					128.57142857142844
				],
				[
					-181.4285714285711,
					134.28571428571468
				],
				[
					-184.28571428571377,
					137.14285714285688
				],
				[
					-185.71428571428532,
					140
				],
				[
					-188.57142857142844,
					142.85714285714312
				],
				[
					-190,
					147.14285714285688
				],
				[
					-192.85714285714266,
					150
				],
				[
					-195.71428571428532,
					154.28571428571468
				],
				[
					-200,
					158.57142857142844
				],
				[
					-204.28571428571377,
					164.28571428571468
				],
				[
					-208.57142857142844,
					168.57142857142844
				],
				[
					-211.4285714285711,
					171.42857142857156
				],
				[
					-215.71428571428532,
					174.28571428571468
				],
				[
					-221.4285714285711,
					177.14285714285688
				],
				[
					-227.14285714285688,
					181.42857142857156
				],
				[
					-231.4285714285711,
					182.85714285714312
				],
				[
					-235.71428571428532,
					185.71428571428532
				],
				[
					-240,
					187.14285714285688
				],
				[
					-242.85714285714266,
					188.57142857142844
				],
				[
					-245.71428571428532,
					190
				],
				[
					-247.14285714285688,
					191.42857142857156
				],
				[
					-251.4285714285711,
					194.28571428571468
				],
				[
					-255.71428571428532,
					197.14285714285688
				],
				[
					-258.57142857142844,
					197.14285714285688
				],
				[
					-261.4285714285711,
					198.57142857142844
				],
				[
					-262.85714285714266,
					200
				],
				[
					-264.28571428571377,
					201.42857142857156
				],
				[
					-267.1428571428569,
					202.85714285714312
				],
				[
					-268.57142857142844,
					202.85714285714312
				],
				[
					-270,
					204.28571428571468
				],
				[
					-272.85714285714266,
					205.71428571428532
				],
				[
					-274.28571428571377,
					205.71428571428532
				],
				[
					-275.7142857142853,
					205.71428571428532
				],
				[
					-277.1428571428569,
					207.14285714285688
				],
				[
					-278.57142857142844,
					207.14285714285688
				],
				[
					-280,
					208.57142857142844
				],
				[
					-281.4285714285711,
					208.57142857142844
				],
				[
					-282.85714285714266,
					210
				],
				[
					-284.28571428571377,
					211.42857142857156
				],
				[
					-285.7142857142853,
					212.85714285714312
				],
				[
					-287.1428571428569,
					212.85714285714312
				],
				[
					-288.57142857142844,
					214.28571428571468
				],
				[
					-290,
					215.71428571428532
				],
				[
					-291.4285714285711,
					215.71428571428532
				],
				[
					-291.4285714285711,
					215.71428571428532
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 164,
			"versionNonce": 1518527514,
			"isDeleted": false,
			"id": "sAzk0Ktp8uEcnJDRxggQy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2992.3687471945486,
			"y": 6080.407462519064,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 429.99999999999955,
			"height": 230,
			"seed": 296897806,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.4285714285711038,
					1.4285714285715585
				],
				[
					5.7142857142853245,
					2.857142857143117
				],
				[
					12.857142857142662,
					5.714285714286234
				],
				[
					30,
					11.428571428571558
				],
				[
					42.85714285714266,
					15.714285714286234
				],
				[
					54.285714285713766,
					21.42857142857156
				],
				[
					60,
					22.857142857143117
				],
				[
					62.85714285714266,
					24.285714285714675
				],
				[
					64.28571428571377,
					25.714285714286234
				],
				[
					65.71428571428532,
					25.714285714286234
				],
				[
					70,
					28.57142857142935
				],
				[
					75.71428571428532,
					31.42857142857156
				],
				[
					85.71428571428532,
					37.14285714285779
				],
				[
					97.14285714285688,
					41.42857142857156
				],
				[
					108.57142857142844,
					45.714285714286234
				],
				[
					118.57142857142844,
					51.42857142857156
				],
				[
					130,
					55.714285714286234
				],
				[
					154.28571428571377,
					64.28571428571468
				],
				[
					165.71428571428532,
					67.14285714285779
				],
				[
					172.85714285714266,
					70
				],
				[
					177.14285714285688,
					72.85714285714312
				],
				[
					182.85714285714266,
					74.28571428571468
				],
				[
					191.4285714285711,
					77.14285714285779
				],
				[
					204.28571428571377,
					82.85714285714312
				],
				[
					225.71428571428532,
					88.57142857142935
				],
				[
					234.28571428571377,
					91.42857142857156
				],
				[
					240,
					92.85714285714312
				],
				[
					241.4285714285711,
					95.71428571428623
				],
				[
					242.85714285714266,
					95.71428571428623
				],
				[
					244.28571428571377,
					97.14285714285779
				],
				[
					247.14285714285688,
					98.57142857142935
				],
				[
					250,
					100
				],
				[
					257.1428571428569,
					105.71428571428623
				],
				[
					264.28571428571377,
					110
				],
				[
					272.85714285714266,
					114.28571428571468
				],
				[
					282.85714285714266,
					118.57142857142935
				],
				[
					290,
					122.85714285714312
				],
				[
					294.28571428571377,
					125.71428571428623
				],
				[
					298.57142857142844,
					128.57142857142935
				],
				[
					304.28571428571377,
					132.85714285714312
				],
				[
					310,
					135.71428571428623
				],
				[
					315.7142857142853,
					138.57142857142935
				],
				[
					321.4285714285711,
					141.42857142857156
				],
				[
					325.7142857142853,
					145.71428571428623
				],
				[
					332.85714285714266,
					148.57142857142935
				],
				[
					347.1428571428569,
					154.28571428571468
				],
				[
					350,
					155.71428571428623
				],
				[
					355.7142857142853,
					158.57142857142935
				],
				[
					357.1428571428569,
					158.57142857142935
				],
				[
					358.57142857142844,
					160
				],
				[
					360,
					161.42857142857156
				],
				[
					362.85714285714266,
					162.85714285714312
				],
				[
					365.7142857142853,
					165.71428571428623
				],
				[
					370,
					170
				],
				[
					371.4285714285711,
					172.85714285714312
				],
				[
					374.28571428571377,
					177.1428571428578
				],
				[
					377.1428571428569,
					180
				],
				[
					378.57142857142844,
					184.28571428571468
				],
				[
					381.4285714285711,
					187.1428571428578
				],
				[
					384.28571428571377,
					190
				],
				[
					385.7142857142853,
					192.85714285714312
				],
				[
					387.1428571428569,
					195.71428571428623
				],
				[
					389.99999999999955,
					200
				],
				[
					392.85714285714266,
					202.85714285714312
				],
				[
					394.28571428571377,
					205.71428571428623
				],
				[
					398.57142857142844,
					210
				],
				[
					399.99999999999955,
					211.42857142857156
				],
				[
					402.85714285714266,
					214.28571428571468
				],
				[
					407.1428571428569,
					218.57142857142935
				],
				[
					412.85714285714266,
					221.42857142857156
				],
				[
					414.28571428571377,
					222.85714285714312
				],
				[
					417.1428571428569,
					225.71428571428623
				],
				[
					419.99999999999955,
					227.1428571428578
				],
				[
					422.85714285714266,
					228.57142857142935
				],
				[
					427.1428571428569,
					230
				],
				[
					428.57142857142844,
					230
				],
				[
					429.99999999999955,
					230
				],
				[
					429.99999999999955,
					230
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 104,
			"versionNonce": 782271110,
			"isDeleted": false,
			"id": "KboShwHQLV-szEjMvH_O5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2558.083032908835,
			"y": 6291.836033947636,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 58.57142857142844,
			"height": 27.142857142857792,
			"seed": 349447950,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					1.4285714285715585
				],
				[
					1.4285714285715585,
					4.2857142857146755
				],
				[
					2.857142857143117,
					8.571428571428442
				],
				[
					5.714285714285779,
					12.857142857143117
				],
				[
					7.142857142857338,
					17.142857142857792
				],
				[
					8.571428571428896,
					20
				],
				[
					10,
					22.857142857143117
				],
				[
					11.428571428571558,
					25.714285714286234
				],
				[
					11.428571428571558,
					27.142857142857792
				],
				[
					10,
					27.142857142857792
				],
				[
					5.714285714285779,
					27.142857142857792
				],
				[
					-1.4285714285711038,
					25.714285714286234
				],
				[
					-8.571428571428442,
					22.857142857143117
				],
				[
					-27.142857142856883,
					20
				],
				[
					-38.57142857142844,
					18.57142857142844
				],
				[
					-44.28571428571422,
					17.142857142857792
				],
				[
					-47.14285714285688,
					17.142857142857792
				],
				[
					-47.14285714285688,
					17.142857142857792
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 159,
			"versionNonce": 1803768026,
			"isDeleted": false,
			"id": "D8A3vCT1WRA0ZkLJYSgJT",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2288.083032908835,
			"y": 6066.12174823335,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 275.71428571428555,
			"height": 242.85714285714312,
			"seed": 1304776078,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-5.714285714285779,
					2.857142857143117
				],
				[
					-14.28571428571422,
					7.142857142856883
				],
				[
					-21.42857142857156,
					10
				],
				[
					-28.57142857142867,
					14.285714285713766
				],
				[
					-34.28571428571422,
					17.142857142856883
				],
				[
					-44.28571428571422,
					21.42857142857156
				],
				[
					-57.14285714285711,
					28.57142857142844
				],
				[
					-70.00000000000023,
					35.714285714285325
				],
				[
					-80.00000000000023,
					41.42857142857156
				],
				[
					-91.42857142857133,
					48.57142857142844
				],
				[
					-97.14285714285711,
					54.285714285713766
				],
				[
					-115.71428571428555,
					68.57142857142844
				],
				[
					-128.57142857142867,
					78.57142857142844
				],
				[
					-137.1428571428571,
					84.28571428571377
				],
				[
					-144.285714285714,
					90
				],
				[
					-152.8571428571429,
					97.14285714285688
				],
				[
					-160.00000000000023,
					102.85714285714312
				],
				[
					-164.285714285714,
					105.71428571428532
				],
				[
					-168.57142857142867,
					110
				],
				[
					-171.42857142857133,
					112.85714285714312
				],
				[
					-174.285714285714,
					115.71428571428532
				],
				[
					-178.57142857142867,
					118.57142857142844
				],
				[
					-182.8571428571429,
					122.85714285714312
				],
				[
					-187.1428571428571,
					127.14285714285688
				],
				[
					-191.42857142857133,
					130
				],
				[
					-195.71428571428555,
					132.85714285714312
				],
				[
					-198.57142857142867,
					135.71428571428532
				],
				[
					-202.8571428571429,
					138.57142857142844
				],
				[
					-205.71428571428555,
					141.42857142857156
				],
				[
					-207.1428571428571,
					144.28571428571377
				],
				[
					-210.00000000000023,
					147.14285714285688
				],
				[
					-212.8571428571429,
					151.42857142857156
				],
				[
					-215.71428571428555,
					154.28571428571377
				],
				[
					-220.00000000000023,
					158.57142857142844
				],
				[
					-221.42857142857133,
					161.42857142857156
				],
				[
					-224.285714285714,
					164.28571428571377
				],
				[
					-225.71428571428555,
					168.57142857142844
				],
				[
					-227.1428571428571,
					171.42857142857156
				],
				[
					-230.00000000000023,
					174.28571428571377
				],
				[
					-231.42857142857133,
					178.57142857142844
				],
				[
					-232.8571428571429,
					181.42857142857156
				],
				[
					-235.71428571428555,
					187.14285714285688
				],
				[
					-238.57142857142867,
					190
				],
				[
					-240.00000000000023,
					192.85714285714312
				],
				[
					-241.42857142857133,
					194.28571428571377
				],
				[
					-242.8571428571429,
					195.71428571428532
				],
				[
					-244.28571428571445,
					198.57142857142844
				],
				[
					-245.71428571428555,
					200
				],
				[
					-247.1428571428571,
					202.85714285714312
				],
				[
					-250.00000000000023,
					204.28571428571377
				],
				[
					-251.42857142857133,
					207.14285714285688
				],
				[
					-252.8571428571429,
					208.57142857142844
				],
				[
					-254.28571428571445,
					211.42857142857156
				],
				[
					-255.71428571428555,
					214.28571428571377
				],
				[
					-257.1428571428571,
					215.71428571428532
				],
				[
					-258.57142857142867,
					217.14285714285688
				],
				[
					-260.0000000000002,
					220
				],
				[
					-261.42857142857133,
					222.85714285714312
				],
				[
					-262.8571428571429,
					224.28571428571377
				],
				[
					-264.28571428571445,
					227.14285714285688
				],
				[
					-265.71428571428555,
					228.57142857142844
				],
				[
					-265.71428571428555,
					230
				],
				[
					-267.1428571428571,
					231.42857142857156
				],
				[
					-268.57142857142867,
					232.85714285714312
				],
				[
					-270.0000000000002,
					234.28571428571377
				],
				[
					-271.42857142857133,
					235.71428571428532
				],
				[
					-272.8571428571429,
					238.57142857142844
				],
				[
					-274.28571428571445,
					240
				],
				[
					-274.28571428571445,
					241.42857142857156
				],
				[
					-275.71428571428555,
					241.42857142857156
				],
				[
					-275.71428571428555,
					242.85714285714312
				],
				[
					-275.71428571428555,
					241.42857142857156
				],
				[
					-275.71428571428555,
					241.42857142857156
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "image",
			"version": 154,
			"versionNonce": 2109358534,
			"isDeleted": false,
			"id": "TKv6_SnXSPpSe5GHO5onL",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3101.0116043374055,
			"y": 6317.97889109049,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 289.93667157584724,
			"height": 464.85714285714346,
			"seed": 30971918,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "fbef0c0bb114fc0840c1d1e338e6e366281f6f77",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 237,
			"versionNonce": 56108442,
			"isDeleted": false,
			"id": "Cq4z2XI4gr2UduONi2kzv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2808.083032908835,
			"y": 6716.121748233345,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 384.28571428571365,
			"height": 495.71428571428567,
			"seed": 240420818,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.088509316770374,
					0
				],
				[
					8.354037267080832,
					12.710622710623745
				],
				[
					29.239130434782584,
					25.42124542124749
				],
				[
					48.03571428571396,
					38.13186813187124
				],
				[
					66.83229813664599,
					50.84249084249498
				],
				[
					87.71739130434774,
					88.97435897435813
				],
				[
					102.33695652173904,
					101.68498168498186
				],
				[
					112.77950310559024,
					127.10622710622935
				],
				[
					121.13354037267041,
					139.8168498168531
				],
				[
					131.5760869565216,
					152.52747252747685
				],
				[
					144.10714285714317,
					177.94871794871625
				],
				[
					154.54968944099375,
					190.65934065934
				],
				[
					167.08074534161463,
					216.0805860805875
				],
				[
					185.87732919254668,
					241.501831501835
				],
				[
					204.67391304347808,
					254.21245421245064
				],
				[
					213.0279503105589,
					254.21245421245064
				],
				[
					217.20496894409968,
					266.92307692307435
				],
				[
					219.29347826086936,
					266.92307692307435
				],
				[
					223.47049689440945,
					279.63369963369814
				],
				[
					233.91304347826068,
					292.3443223443219
				],
				[
					246.44409937888224,
					317.76556776556936
				],
				[
					258.97515527950316,
					317.76556776556936
				],
				[
					267.32919254658333,
					330.4761904761931
				],
				[
					271.50621118012407,
					330.4761904761931
				],
				[
					273.59472049689447,
					330.4761904761931
				],
				[
					275.6832298136648,
					330.4761904761931
				],
				[
					279.86024844720487,
					343.1868131868087
				],
				[
					288.2142857142857,
					355.8974358974325
				],
				[
					300.7453416149067,
					355.8974358974325
				],
				[
					304.92236024844743,
					368.60805860805624
				],
				[
					307.0108695652171,
					368.60805860805624
				],
				[
					309.0993788819875,
					381.31868131868
				],
				[
					317.4534161490683,
					394.0293040293037
				],
				[
					323.71894409937875,
					394.0293040293037
				],
				[
					327.89596273291886,
					406.73992673992745
				],
				[
					329.9844720496892,
					406.73992673992745
				],
				[
					332.0729813664596,
					406.73992673992745
				],
				[
					342.5155279503102,
					432.1611721611669
				],
				[
					361.31211180124217,
					457.58241758241434
				],
				[
					378.0201863354038,
					483.00366300366187
				],
				[
					384.28571428571365,
					495.7142857142856
				],
				[
					384.28571428571365,
					495.7142857142856
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 260,
			"versionNonce": 433723654,
			"isDeleted": false,
			"id": "qv5TPZnNnGTuPC8QVg8KZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2468.083032908835,
			"y": 6793.264605376202,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 58.5714285714285,
			"height": 420.00000000000006,
			"seed": 1319804050,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.3015873015870052,
					0
				],
				[
					2.6031746031744247,
					10.327868852459934
				],
				[
					5.206349206349264,
					37.86885245901757
				],
				[
					6.507936507936684,
					51.63934426229529
				],
				[
					7.809523809523689,
					61.96721311475522
				],
				[
					14.317460317460373,
					113.60655737704832
				],
				[
					18.222222222222218,
					144.59016393442593
				],
				[
					24.7301587301589,
					172.13114754098356
				],
				[
					27.333333333333325,
					192.78688524590123
				],
				[
					28.63492063492033,
					206.55737704918116
				],
				[
					29.936507936507752,
					216.88524590163888
				],
				[
					31.23809523809517,
					227.21311475409883
				],
				[
					33.84126984127001,
					237.54098360655655
				],
				[
					35.14285714285702,
					247.8688524590165
				],
				[
					36.444444444444436,
					258.1967213114742
				],
				[
					37.74603174603144,
					265.0819672131142
				],
				[
					39.04761904761886,
					271.96721311475414
				],
				[
					40.34920634920628,
					275.40983606557415
				],
				[
					41.6507936507937,
					282.2950819672119
				],
				[
					41.6507936507937,
					285.73770491803185
				],
				[
					42.95238095238112,
					296.0655737704918
				],
				[
					44.253968253968125,
					302.9508196721318
				],
				[
					44.253968253968125,
					309.83606557376953
				],
				[
					45.55555555555554,
					316.7213114754095
				],
				[
					46.85714285714255,
					323.60655737704946
				],
				[
					46.85714285714255,
					327.0491803278694
				],
				[
					46.85714285714255,
					330.4918032786872
				],
				[
					48.158730158729966,
					333.93442622950715
				],
				[
					48.158730158729966,
					337.37704918032716
				],
				[
					49.46031746031739,
					344.2622950819671
				],
				[
					49.46031746031739,
					347.7049180327871
				],
				[
					49.46031746031739,
					351.1475409836071
				],
				[
					50.76190476190481,
					354.5901639344249
				],
				[
					50.76190476190481,
					358.03278688524483
				],
				[
					52.06349206349223,
					361.4754098360648
				],
				[
					53.36507936507923,
					368.36065573770475
				],
				[
					53.36507936507923,
					371.80327868852476
				],
				[
					53.36507936507923,
					375.2459016393447
				],
				[
					53.36507936507923,
					378.6885245901625
				],
				[
					54.66666666666665,
					385.57377049180246
				],
				[
					54.66666666666665,
					389.0163934426224
				],
				[
					54.66666666666665,
					392.4590163934424
				],
				[
					55.968253968253656,
					399.3442622950824
				],
				[
					57.26984126984108,
					409.67213114754014
				],
				[
					58.5714285714285,
					416.55737704918005
				],
				[
					58.5714285714285,
					420.00000000000006
				],
				[
					58.5714285714285,
					420.00000000000006
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 218,
			"versionNonce": 456417882,
			"isDeleted": false,
			"id": "w5KM2r6L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2728.0830329088353,
			"y": 7100.407462519058,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 606.527587890625,
			"height": 36.42857142857155,
			"seed": 400473166,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"fontSize": 29.142857142857242,
			"fontFamily": 1,
			"text": "clamp(major_valid_mask+blur_mask_minor)",
			"rawText": "clamp(major_valid_mask+blur_mask_minor)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "clamp(major_valid_mask+blur_mask_minor)",
			"lineHeight": 1.25,
			"baseline": 25
		},
		{
			"type": "freedraw",
			"version": 107,
			"versionNonce": 712837190,
			"isDeleted": false,
			"id": "AnSMlihzEPVACbP82_tEn",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2213.797318623122,
			"y": 7454.6931768047725,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 167.1428571428571,
			"height": 8.571428571428442,
			"seed": 1853010002,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.4285714285713311,
					0
				],
				[
					10,
					2.857142857143117
				],
				[
					25.71428571428578,
					4.2857142857146755
				],
				[
					40,
					7.1428571428577925
				],
				[
					52.85714285714289,
					8.571428571428442
				],
				[
					58.57142857142844,
					8.571428571428442
				],
				[
					62.85714285714289,
					8.571428571428442
				],
				[
					68.57142857142844,
					8.571428571428442
				],
				[
					75.71428571428555,
					8.571428571428442
				],
				[
					84.28571428571422,
					8.571428571428442
				],
				[
					97.14285714285711,
					8.571428571428442
				],
				[
					112.85714285714289,
					8.571428571428442
				],
				[
					121.42857142857133,
					7.1428571428577925
				],
				[
					122.85714285714289,
					7.1428571428577925
				],
				[
					124.28571428571422,
					7.1428571428577925
				],
				[
					132.8571428571429,
					7.1428571428577925
				],
				[
					144.28571428571422,
					7.1428571428577925
				],
				[
					157.1428571428571,
					7.1428571428577925
				],
				[
					165.71428571428555,
					5.714285714286234
				],
				[
					167.1428571428571,
					5.714285714286234
				],
				[
					167.1428571428571,
					5.714285714286234
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 105,
			"versionNonce": 233506586,
			"isDeleted": false,
			"id": "q1_5UURsea0Cq_gh-V1Jz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2058.0830329088362,
			"y": 7447.550319661914,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 25.71428571428578,
			"height": 30,
			"seed": 514306702,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.4285714285715585,
					0
				],
				[
					2.8571428571428896,
					0
				],
				[
					11.428571428571558,
					2.857142857143117
				],
				[
					21.42857142857156,
					5.7142857142853245
				],
				[
					22.85714285714289,
					7.142857142856883
				],
				[
					24.285714285714448,
					7.142857142856883
				],
				[
					25.71428571428578,
					7.142857142856883
				],
				[
					24.285714285714448,
					8.571428571428442
				],
				[
					21.42857142857156,
					8.571428571428442
				],
				[
					18.57142857142867,
					10
				],
				[
					11.428571428571558,
					14.285714285714675
				],
				[
					7.142857142857338,
					17.142857142856883
				],
				[
					5.714285714285779,
					20
				],
				[
					4.285714285714448,
					22.857142857143117
				],
				[
					4.285714285714448,
					24.285714285714675
				],
				[
					2.8571428571428896,
					27.142857142856883
				],
				[
					2.8571428571428896,
					28.57142857142844
				],
				[
					2.8571428571428896,
					30
				],
				[
					2.8571428571428896,
					30
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 121,
			"versionNonce": 1602228102,
			"isDeleted": false,
			"id": "tcb8Xxmi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2162.3687471945505,
			"y": 7403.2646053762,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 62.49549865722656,
			"height": 44.17954247854996,
			"seed": 375471250,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"fontSize": 35.34363398283997,
			"fontFamily": 1,
			"text": "blur",
			"rawText": "blur",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "blur",
			"lineHeight": 1.25,
			"baseline": 31
		},
		{
			"type": "image",
			"version": 190,
			"versionNonce": 1676612570,
			"isDeleted": false,
			"id": "e6ed6YdKQ6sMveZQsivRz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3092.2020805278835,
			"y": 8120.216986328578,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 277.2857142857142,
			"height": 466.8510149368057,
			"seed": 594484430,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "87479a655cda699de429a61695655dbe094b070f",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 181,
			"versionNonce": 1696607942,
			"isDeleted": false,
			"id": "dzXads8jqYXJwnY4KXubg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1888.6544614802638,
			"y": 7685.335534447129,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 1008.6666666666669,
			"height": 443.33333333333286,
			"seed": 967653966,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					-4.666666666666508,
					0
				],
				[
					-7.98464912280701,
					0
				],
				[
					-14.62061403508756,
					3.5185185185191554
				],
				[
					-31.210526315789167,
					10.555555555555545
				],
				[
					-37.84649122807017,
					14.0740740740747
				],
				[
					-51.11842105263128,
					21.11111111111109
				],
				[
					-61.07236842105232,
					24.629629629630244
				],
				[
					-71.02631578947337,
					31.666666666666636
				],
				[
					-77.6622807017544,
					31.666666666666636
				],
				[
					-84.29824561403494,
					35.18518518518579
				],
				[
					-87.61622807017544,
					35.18518518518579
				],
				[
					-94.25219298245598,
					38.70370370370399
				],
				[
					-104.20614035087705,
					42.22222222222218
				],
				[
					-117.4780701754386,
					45.74074074074134
				],
				[
					-130.7499999999997,
					52.77777777777773
				],
				[
					-147.33991228070178,
					56.29629629629688
				],
				[
					-167.2478070175439,
					63.33333333333327
				],
				[
					-190.47368421052602,
					70.37037037037062
				],
				[
					-197.10964912280704,
					73.88888888888881
				],
				[
					-220.3355263157892,
					80.92592592592617
				],
				[
					-256.83333333333337,
					98.51851851851906
				],
				[
					-276.74122807017545,
					105.55555555555546
				],
				[
					-303.28508771929813,
					112.59259259259281
				],
				[
					-319.8749999999998,
					119.62962962963016
				],
				[
					-336.4649122807018,
					123.14814814814835
				],
				[
					-356.3728070175439,
					130.1851851851857
				],
				[
					-379.598684210526,
					137.2222222222221
				],
				[
					-402.82456140350865,
					144.25925925925944
				],
				[
					-439.3223684210524,
					161.85185185185233
				],
				[
					-465.8662280701755,
					165.37037037037052
				],
				[
					-492.4100877192982,
					172.40740740740787
				],
				[
					-525.5899122807018,
					179.4444444444443
				],
				[
					-545.4978070175439,
					186.48148148148164
				],
				[
					-562.0877192982456,
					193.518518518519
				],
				[
					-591.9495614035087,
					200.55555555555534
				],
				[
					-615.1754385964913,
					211.11111111111092
				],
				[
					-635.0833333333335,
					218.14814814814827
				],
				[
					-658.3092105263156,
					225.18518518518562
				],
				[
					-681.5350877192982,
					228.70370370370378
				],
				[
					-698.1249999999999,
					235.74074074074113
				],
				[
					-721.3508771929824,
					242.77777777777754
				],
				[
					-741.2587719298244,
					253.3333333333331
				],
				[
					-764.4846491228071,
					260.37037037037044
				],
				[
					-787.7105263157893,
					267.4074074074078
				],
				[
					-807.6184210526313,
					274.4444444444442
				],
				[
					-834.1622807017545,
					281.4814814814815
				],
				[
					-854.0701754385966,
					288.5185185185189
				],
				[
					-867.3421052631577,
					295.55555555555526
				],
				[
					-883.9320175438598,
					306.11111111111086
				],
				[
					-900.5219298245614,
					313.14814814814815
				],
				[
					-917.111842105263,
					327.2222222222219
				],
				[
					-930.3837719298245,
					334.2592592592593
				],
				[
					-940.3377192982456,
					341.2962962962966
				],
				[
					-946.9736842105261,
					344.81481481481484
				],
				[
					-950.2916666666667,
					351.85185185185213
				],
				[
					-956.9276315789473,
					355.3703703703703
				],
				[
					-963.5635964912283,
					362.4074074074077
				],
				[
					-966.8815789473683,
					369.4444444444441
				],
				[
					-973.5175438596493,
					376.4814814814814
				],
				[
					-983.4714912280704,
					387.037037037037
				],
				[
					-983.4714912280704,
					390.55555555555515
				],
				[
					-990.1074561403509,
					397.59259259259255
				],
				[
					-993.4254385964913,
					404.62962962962985
				],
				[
					-996.7434210526314,
					408.1481481481481
				],
				[
					-996.7434210526314,
					411.6666666666663
				],
				[
					-1000.0614035087718,
					415.1851851851854
				],
				[
					-1003.3793859649123,
					418.7037037037036
				],
				[
					-1003.3793859649123,
					422.22222222222183
				],
				[
					-1006.6973684210524,
					425.740740740741
				],
				[
					-1006.6973684210524,
					429.2592592592591
				],
				[
					-1010.0153508771929,
					432.7777777777774
				],
				[
					-1010.0153508771929,
					436.29629629629653
				],
				[
					-1013.3333333333335,
					436.29629629629653
				],
				[
					-1013.3333333333335,
					439.8148148148147
				],
				[
					-1013.3333333333335,
					443.33333333333286
				],
				[
					-1013.3333333333335,
					443.33333333333286
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 175,
			"versionNonce": 525568154,
			"isDeleted": false,
			"id": "UhBsGEkbnrycOAQjnxjmC",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3143.3211281469303,
			"y": 5972.002201113796,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 520,
			"height": 2163.333333333333,
			"seed": 1654537234,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-3.333333333333485,
					0
				],
				[
					-6.66666666666697,
					6.66666666666697
				],
				[
					-16.66666666666697,
					16.66666666666697
				],
				[
					-43.333333333333485,
					43.33333333333303
				],
				[
					-80,
					80
				],
				[
					-113.33333333333348,
					116.66666666666697
				],
				[
					-156.66666666666697,
					153.33333333333303
				],
				[
					-180,
					176.66666666666697
				],
				[
					-196.66666666666697,
					190
				],
				[
					-220,
					220
				],
				[
					-250,
					286.66666666666697
				],
				[
					-266.66666666666697,
					333.33333333333303
				],
				[
					-270,
					353.33333333333303
				],
				[
					-283.3333333333335,
					423.33333333333303
				],
				[
					-283.3333333333335,
					463.33333333333303
				],
				[
					-283.3333333333335,
					546.666666666667
				],
				[
					-283.3333333333335,
					613.333333333333
				],
				[
					-283.3333333333335,
					673.333333333333
				],
				[
					-283.3333333333335,
					710
				],
				[
					-283.3333333333335,
					773.333333333333
				],
				[
					-280,
					830
				],
				[
					-273.3333333333335,
					860
				],
				[
					-266.66666666666697,
					893.333333333333
				],
				[
					-260,
					923.333333333333
				],
				[
					-253.33333333333348,
					973.333333333333
				],
				[
					-243.33333333333348,
					1010
				],
				[
					-240,
					1040
				],
				[
					-233.33333333333348,
					1070
				],
				[
					-226.66666666666697,
					1106.666666666667
				],
				[
					-216.66666666666697,
					1136.666666666667
				],
				[
					-210,
					1160
				],
				[
					-200,
					1193.333333333333
				],
				[
					-196.66666666666697,
					1220
				],
				[
					-186.66666666666697,
					1246.666666666667
				],
				[
					-183.33333333333348,
					1280
				],
				[
					-170,
					1326.666666666667
				],
				[
					-156.66666666666697,
					1353.333333333333
				],
				[
					-153.33333333333348,
					1366.666666666667
				],
				[
					-140,
					1416.666666666667
				],
				[
					-130,
					1446.666666666667
				],
				[
					-116.66666666666697,
					1473.333333333333
				],
				[
					-106.66666666666697,
					1500
				],
				[
					-96.66666666666697,
					1520
				],
				[
					-90,
					1536.666666666667
				],
				[
					-83.33333333333348,
					1556.666666666667
				],
				[
					-73.33333333333348,
					1583.333333333333
				],
				[
					-56.66666666666697,
					1620
				],
				[
					-40,
					1650
				],
				[
					-23.333333333333485,
					1676.666666666667
				],
				[
					-6.66666666666697,
					1706.666666666667
				],
				[
					3.33333333333303,
					1730
				],
				[
					16.666666666666515,
					1750
				],
				[
					23.33333333333303,
					1766.666666666667
				],
				[
					33.33333333333303,
					1780
				],
				[
					40,
					1793.333333333333
				],
				[
					46.666666666666515,
					1803.333333333333
				],
				[
					53.33333333333303,
					1816.666666666667
				],
				[
					56.666666666666515,
					1833.333333333333
				],
				[
					73.33333333333303,
					1856.666666666667
				],
				[
					90,
					1883.333333333333
				],
				[
					103.33333333333303,
					1900
				],
				[
					113.33333333333303,
					1916.666666666667
				],
				[
					126.66666666666652,
					1930
				],
				[
					136.66666666666652,
					1943.333333333333
				],
				[
					146.66666666666652,
					1963.333333333333
				],
				[
					153.33333333333303,
					1973.333333333333
				],
				[
					156.66666666666652,
					1983.333333333333
				],
				[
					163.33333333333303,
					1993.333333333333
				],
				[
					166.66666666666652,
					2003.333333333333
				],
				[
					173.33333333333303,
					2016.666666666667
				],
				[
					176.66666666666652,
					2033.333333333333
				],
				[
					183.33333333333303,
					2046.666666666667
				],
				[
					186.66666666666652,
					2060
				],
				[
					193.33333333333303,
					2070
				],
				[
					196.66666666666652,
					2080
				],
				[
					206.66666666666652,
					2096.666666666667
				],
				[
					206.66666666666652,
					2100
				],
				[
					210,
					2110
				],
				[
					216.66666666666652,
					2123.333333333333
				],
				[
					223.33333333333303,
					2130
				],
				[
					226.66666666666652,
					2136.666666666667
				],
				[
					230,
					2143.333333333333
				],
				[
					230,
					2150
				],
				[
					233.33333333333303,
					2150
				],
				[
					233.33333333333303,
					2153.333333333333
				],
				[
					233.33333333333303,
					2156.666666666667
				],
				[
					236.66666666666652,
					2160
				],
				[
					236.66666666666652,
					2163.333333333333
				],
				[
					236.66666666666652,
					2163.333333333333
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 121,
			"versionNonce": 1476027910,
			"isDeleted": false,
			"id": "e91ix7c7mjq1XKxmNADfD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2973.3211281469303,
			"y": 8062.002201113795,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 156.66666666666652,
			"height": 70,
			"seed": 2055713618,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					3.33333333333303,
					0
				],
				[
					6.666666666666515,
					6.66666666666697
				],
				[
					13.33333333333303,
					13.33333333333303
				],
				[
					20,
					20
				],
				[
					26.666666666666515,
					26.66666666666697
				],
				[
					33.33333333333303,
					33.33333333333303
				],
				[
					40,
					36.66666666666697
				],
				[
					43.33333333333303,
					40
				],
				[
					46.666666666666515,
					40
				],
				[
					46.666666666666515,
					43.33333333333303
				],
				[
					50,
					43.33333333333303
				],
				[
					53.33333333333303,
					43.33333333333303
				],
				[
					60,
					53.33333333333303
				],
				[
					63.33333333333303,
					56.66666666666697
				],
				[
					66.66666666666652,
					56.66666666666697
				],
				[
					66.66666666666652,
					60
				],
				[
					70,
					63.33333333333303
				],
				[
					73.33333333333303,
					63.33333333333303
				],
				[
					80,
					66.66666666666697
				],
				[
					83.33333333333303,
					70
				],
				[
					83.33333333333303,
					66.66666666666697
				],
				[
					86.66666666666652,
					66.66666666666697
				],
				[
					93.33333333333303,
					56.66666666666697
				],
				[
					110,
					40
				],
				[
					113.33333333333303,
					36.66666666666697
				],
				[
					116.66666666666652,
					33.33333333333303
				],
				[
					120,
					26.66666666666697
				],
				[
					130,
					16.66666666666697
				],
				[
					133.33333333333303,
					13.33333333333303
				],
				[
					140,
					6.66666666666697
				],
				[
					143.33333333333303,
					3.33333333333303
				],
				[
					146.66666666666652,
					3.33333333333303
				],
				[
					150,
					3.33333333333303
				],
				[
					153.33333333333303,
					0
				],
				[
					156.66666666666652,
					0
				],
				[
					156.66666666666652,
					0
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 160,
			"versionNonce": 130770266,
			"isDeleted": false,
			"id": "ZiFhHIc2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3054.6544614802633,
			"y": 7968.668867780465,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 628.9158935546875,
			"height": 58.999999999999645,
			"seed": 1972479058,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"fontSize": 47.19999999999972,
			"fontFamily": 1,
			"text": "tex_mask * fill_mask_blur",
			"rawText": "tex_mask * fill_mask_blur",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "tex_mask * fill_mask_blur",
			"lineHeight": 1.25,
			"baseline": 41
		},
		{
			"type": "image",
			"version": 255,
			"versionNonce": 957068614,
			"isDeleted": false,
			"id": "tzWvgrGrWwtIAF_AG_Ll1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3013.3211281469303,
			"y": 9102.61331222491,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 522,
			"height": 719,
			"seed": 678895122,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "c3651f60b292fbd87e193b42866d064d67a7f73c",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 188,
			"versionNonce": 1990830618,
			"isDeleted": false,
			"id": "gt90dvPPwOCfoUtA4y_ek",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3009.526256352059,
			"y": 4994.254337865938,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 886.6666666666665,
			"height": 4106.666666666665,
			"seed": 1946010514,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-6.66666666666697,
					6.66666666666697
				],
				[
					-13.33333333333303,
					13.33333333333303
				],
				[
					-33.33333333333303,
					33.33333333333303
				],
				[
					-73.33333333333348,
					53.33333333333303
				],
				[
					-106.66666666666652,
					80
				],
				[
					-146.66666666666652,
					100
				],
				[
					-180,
					120
				],
				[
					-206.66666666666652,
					140
				],
				[
					-233.33333333333348,
					166.66666666666697
				],
				[
					-260,
					186.66666666666697
				],
				[
					-293.3333333333335,
					213.33333333333303
				],
				[
					-333.3333333333335,
					240
				],
				[
					-366.6666666666665,
					266.66666666666697
				],
				[
					-393.3333333333335,
					313.33333333333303
				],
				[
					-420,
					353.33333333333303
				],
				[
					-446.6666666666665,
					406.66666666666697
				],
				[
					-486.6666666666665,
					466.66666666666697
				],
				[
					-520,
					533.333333333333
				],
				[
					-553.3333333333335,
					613.333333333333
				],
				[
					-586.6666666666665,
					733.333333333333
				],
				[
					-606.6666666666665,
					813.333333333333
				],
				[
					-620,
					860
				],
				[
					-653.333333333333,
					986.666666666667
				],
				[
					-700,
					1140
				],
				[
					-713.333333333333,
					1240
				],
				[
					-720,
					1300
				],
				[
					-726.6666666666665,
					1353.333333333333
				],
				[
					-740,
					1406.666666666667
				],
				[
					-746.6666666666665,
					1459.999999999999
				],
				[
					-746.6666666666665,
					1506.666666666667
				],
				[
					-746.6666666666665,
					1586.666666666667
				],
				[
					-746.6666666666665,
					1673.333333333333
				],
				[
					-733.333333333333,
					1766.666666666667
				],
				[
					-726.6666666666665,
					1853.333333333333
				],
				[
					-720,
					1939.999999999999
				],
				[
					-720,
					1999.999999999999
				],
				[
					-720,
					2046.666666666666
				],
				[
					-720,
					2126.666666666666
				],
				[
					-733.333333333333,
					2186.666666666666
				],
				[
					-733.333333333333,
					2253.333333333333
				],
				[
					-733.333333333333,
					2306.666666666666
				],
				[
					-733.333333333333,
					2353.333333333333
				],
				[
					-733.333333333333,
					2406.666666666666
				],
				[
					-733.333333333333,
					2453.333333333333
				],
				[
					-720,
					2499.999999999999
				],
				[
					-713.333333333333,
					2559.999999999999
				],
				[
					-700,
					2633.333333333333
				],
				[
					-693.333333333333,
					2693.333333333333
				],
				[
					-680,
					2733.333333333333
				],
				[
					-673.333333333333,
					2773.333333333333
				],
				[
					-666.6666666666665,
					2826.666666666666
				],
				[
					-653.333333333333,
					2859.999999999999
				],
				[
					-633.333333333333,
					2933.333333333333
				],
				[
					-606.6666666666665,
					2986.666666666666
				],
				[
					-573.333333333333,
					3059.999999999999
				],
				[
					-540,
					3113.333333333333
				],
				[
					-513.3333333333335,
					3166.666666666666
				],
				[
					-500,
					3206.666666666666
				],
				[
					-473.3333333333335,
					3259.999999999999
				],
				[
					-460,
					3299.999999999999
				],
				[
					-446.6666666666665,
					3339.999999999999
				],
				[
					-440,
					3379.999999999999
				],
				[
					-433.3333333333335,
					3399.999999999999
				],
				[
					-426.6666666666665,
					3419.999999999999
				],
				[
					-420,
					3439.999999999999
				],
				[
					-413.3333333333335,
					3453.333333333333
				],
				[
					-406.6666666666665,
					3493.333333333333
				],
				[
					-393.3333333333335,
					3519.999999999999
				],
				[
					-386.6666666666665,
					3546.666666666665
				],
				[
					-373.3333333333335,
					3579.999999999999
				],
				[
					-360,
					3613.333333333333
				],
				[
					-346.6666666666665,
					3639.999999999999
				],
				[
					-333.3333333333335,
					3666.666666666665
				],
				[
					-313.3333333333335,
					3693.333333333333
				],
				[
					-306.6666666666665,
					3706.666666666665
				],
				[
					-300,
					3713.333333333333
				],
				[
					-300,
					3719.999999999999
				],
				[
					-293.3333333333335,
					3726.666666666665
				],
				[
					-280,
					3746.666666666665
				],
				[
					-266.6666666666665,
					3759.999999999999
				],
				[
					-253.33333333333348,
					3786.666666666665
				],
				[
					-233.33333333333348,
					3799.999999999999
				],
				[
					-213.33333333333348,
					3826.666666666665
				],
				[
					-200,
					3839.999999999999
				],
				[
					-186.66666666666652,
					3853.333333333333
				],
				[
					-186.66666666666652,
					3859.999999999999
				],
				[
					-180,
					3866.666666666665
				],
				[
					-166.66666666666652,
					3879.999999999999
				],
				[
					-140,
					3906.666666666665
				],
				[
					-106.66666666666652,
					3933.333333333333
				],
				[
					-73.33333333333348,
					3959.999999999999
				],
				[
					-40,
					3979.999999999999
				],
				[
					-26.66666666666697,
					3986.666666666665
				],
				[
					-26.66666666666697,
					3993.333333333333
				],
				[
					-6.66666666666697,
					4013.333333333333
				],
				[
					6.66666666666697,
					4019.999999999999
				],
				[
					20,
					4026.666666666665
				],
				[
					26.66666666666697,
					4033.333333333333
				],
				[
					73.33333333333303,
					4066.666666666665
				],
				[
					106.66666666666697,
					4086.666666666665
				],
				[
					120,
					4093.333333333333
				],
				[
					140,
					4106.666666666665
				],
				[
					140,
					4106.666666666665
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 119,
			"versionNonce": 1638997126,
			"isDeleted": false,
			"id": "QAqhUtLrj5vFMxPdEb-wE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2896.192923018726,
			"y": 8587.587671199271,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 60,
			"height": 513.3333333333321,
			"seed": 1136733070,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					20
				],
				[
					0,
					33.33333333333212
				],
				[
					0,
					73.33333333333212
				],
				[
					0,
					93.33333333333212
				],
				[
					0,
					126.66666666666606
				],
				[
					0,
					160
				],
				[
					0,
					186.66666666666606
				],
				[
					6.66666666666697,
					226.66666666666606
				],
				[
					20,
					266.66666666666606
				],
				[
					20,
					280
				],
				[
					26.66666666666697,
					286.66666666666606
				],
				[
					26.66666666666697,
					293.3333333333321
				],
				[
					26.66666666666697,
					300
				],
				[
					33.33333333333394,
					313.3333333333321
				],
				[
					40,
					333.3333333333321
				],
				[
					46.66666666666697,
					340
				],
				[
					46.66666666666697,
					353.3333333333321
				],
				[
					46.66666666666697,
					360
				],
				[
					46.66666666666697,
					366.66666666666606
				],
				[
					53.33333333333394,
					366.66666666666606
				],
				[
					53.33333333333394,
					380
				],
				[
					53.33333333333394,
					400
				],
				[
					53.33333333333394,
					420
				],
				[
					60,
					433.3333333333321
				],
				[
					60,
					446.66666666666606
				],
				[
					60,
					453.3333333333321
				],
				[
					60,
					460
				],
				[
					60,
					466.66666666666606
				],
				[
					60,
					473.3333333333321
				],
				[
					60,
					486.66666666666606
				],
				[
					60,
					493.3333333333321
				],
				[
					60,
					506.66666666666606
				],
				[
					60,
					513.3333333333321
				],
				[
					60,
					513.3333333333321
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 130,
			"versionNonce": 585193178,
			"isDeleted": false,
			"id": "zoCGlB9phOVarxaHn2-4A",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2362.859589685392,
			"y": 8600.921004532604,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 413.33333333333394,
			"height": 500,
			"seed": 1037124622,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487442,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					6.666666666667879
				],
				[
					-13.33333333333394,
					26.66666666666788
				],
				[
					-46.66666666666697,
					53.33333333333394
				],
				[
					-86.66666666666697,
					86.66666666666788
				],
				[
					-120,
					113.33333333333394
				],
				[
					-140,
					126.66666666666788
				],
				[
					-153.33333333333394,
					140
				],
				[
					-166.66666666666697,
					153.33333333333394
				],
				[
					-180,
					166.66666666666788
				],
				[
					-200,
					173.33333333333394
				],
				[
					-226.66666666666697,
					186.66666666666788
				],
				[
					-246.66666666666697,
					200
				],
				[
					-266.66666666666697,
					213.33333333333394
				],
				[
					-280,
					220
				],
				[
					-293.33333333333394,
					233.33333333333394
				],
				[
					-300,
					246.66666666666788
				],
				[
					-313.33333333333394,
					260
				],
				[
					-320,
					266.6666666666679
				],
				[
					-326.66666666666697,
					280
				],
				[
					-333.33333333333394,
					286.6666666666679
				],
				[
					-340,
					293.33333333333394
				],
				[
					-353.33333333333394,
					306.6666666666679
				],
				[
					-360,
					320
				],
				[
					-366.66666666666697,
					326.6666666666679
				],
				[
					-373.33333333333394,
					340
				],
				[
					-373.33333333333394,
					353.33333333333394
				],
				[
					-380,
					366.6666666666679
				],
				[
					-380,
					380
				],
				[
					-380,
					386.6666666666679
				],
				[
					-380,
					393.33333333333394
				],
				[
					-380,
					400
				],
				[
					-380,
					406.6666666666679
				],
				[
					-386.66666666666697,
					420
				],
				[
					-386.66666666666697,
					426.6666666666679
				],
				[
					-386.66666666666697,
					433.33333333333394
				],
				[
					-386.66666666666697,
					440
				],
				[
					-393.33333333333394,
					446.6666666666679
				],
				[
					-393.33333333333394,
					453.33333333333394
				],
				[
					-400,
					460
				],
				[
					-406.66666666666697,
					466.6666666666679
				],
				[
					-406.66666666666697,
					473.33333333333394
				],
				[
					-406.66666666666697,
					480
				],
				[
					-413.33333333333394,
					493.33333333333394
				],
				[
					-413.33333333333394,
					500
				],
				[
					-413.33333333333394,
					500
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 136,
			"versionNonce": 2007473094,
			"isDeleted": false,
			"id": "hvu6hzYB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3003.6214944472977,
			"y": 8959.635290246892,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 292.87896728515625,
			"height": 61.00000000000001,
			"seed": 1694627282,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"fontSize": 48.800000000000004,
			"fontFamily": 1,
			"text": "Linear Blend",
			"rawText": "Linear Blend",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Linear Blend",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "text",
			"version": 128,
			"versionNonce": 1829071770,
			"isDeleted": false,
			"id": "in0iinLU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3041.3288711778932,
			"y": 4341.696888349514,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 317.261474609375,
			"height": 48.99999999999988,
			"seed": 1194912146,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"fontSize": 39.1999999999999,
			"fontFamily": 1,
			"text": "FFHQ-UV Blender",
			"rawText": "FFHQ-UV Blender",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "FFHQ-UV Blender",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "image",
			"version": 526,
			"versionNonce": 1628189446,
			"isDeleted": false,
			"id": "cLPQ6Na9CZF1GeAIFpnQZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1305.7186480676692,
			"y": 4475.607921760556,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 295.86454529647034,
			"height": 283.44444444444457,
			"seed": 533131474,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "e03bd67a933ebf0da41d9e57398253a6cc193b3e",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 213,
			"versionNonce": 726198362,
			"isDeleted": false,
			"id": "GaC92e14",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1228.86516821419,
			"y": 4789.563355215987,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 151.14559936523438,
			"height": 46.538461538461924,
			"seed": 4766162,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"fontSize": 37.23076923076954,
			"fontFamily": 1,
			"text": "fill mask",
			"rawText": "fill mask",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "fill mask",
			"lineHeight": 1.25,
			"baseline": 32
		},
		{
			"type": "image",
			"version": 91,
			"versionNonce": 945545798,
			"isDeleted": false,
			"id": "aFP8PO62mVsHgbn7fUBVU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -895.9249972740188,
			"y": 4484.781303933931,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 290,
			"height": 271,
			"seed": 1040046674,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "1894236d2409c557c6595f98e56b859effdb68d8",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 121,
			"versionNonce": 1971244314,
			"isDeleted": false,
			"id": "kFgrUCit",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -896.7027750517964,
			"y": 4778.5035261561525,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 340.9560241699219,
			"height": 42.77777777777778,
			"seed": 231276434,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"fontSize": 34.22222222222222,
			"fontFamily": 1,
			"text": "unreliable part mask",
			"rawText": "unreliable part mask",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "unreliable part mask",
			"lineHeight": 1.25,
			"baseline": 29
		},
		{
			"type": "image",
			"version": 116,
			"versionNonce": 1081321862,
			"isDeleted": false,
			"id": "HQgj8SFUdflVC3H1KweyM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1264.149999396078,
			"y": 5063.2264682467385,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 656,
			"height": 657,
			"seed": 486958674,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "df7e8fd5d326d39f8b73ac7c1238f98a9cc817c2",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "freedraw",
			"version": 93,
			"versionNonce": 1897535962,
			"isDeleted": false,
			"id": "rOlDcjVtd5VPGf-P_GJTI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -801.1499993960783,
			"y": 4761.7264682467385,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 116.66666666666652,
			"height": 293.33333333333303,
			"seed": 1271431314,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					-1.666666666666515,
					1.6666666666660603
				],
				[
					-1.666666666666515,
					5
				],
				[
					-3.3333333333332575,
					11.66666666666606
				],
				[
					-5,
					21.66666666666606
				],
				[
					-6.666666666666515,
					35
				],
				[
					-11.666666666666515,
					53.33333333333303
				],
				[
					-18.333333333333258,
					75
				],
				[
					-33.33333333333326,
					106.66666666666606
				],
				[
					-43.33333333333326,
					131.66666666666606
				],
				[
					-56.666666666666515,
					165
				],
				[
					-66.66666666666652,
					185
				],
				[
					-73.33333333333326,
					200
				],
				[
					-76.66666666666652,
					206.66666666666606
				],
				[
					-78.33333333333326,
					213.33333333333303
				],
				[
					-85,
					223.33333333333303
				],
				[
					-90,
					230
				],
				[
					-95,
					238.33333333333303
				],
				[
					-96.66666666666652,
					241.66666666666606
				],
				[
					-100,
					248.33333333333303
				],
				[
					-103.33333333333326,
					255
				],
				[
					-103.33333333333326,
					258.33333333333303
				],
				[
					-105,
					260
				],
				[
					-105,
					261.66666666666606
				],
				[
					-105,
					263.33333333333303
				],
				[
					-105,
					265
				],
				[
					-106.66666666666652,
					265
				],
				[
					-108.33333333333326,
					268.33333333333303
				],
				[
					-110,
					273.33333333333303
				],
				[
					-113.33333333333326,
					281.66666666666606
				],
				[
					-115,
					285
				],
				[
					-115,
					288.33333333333303
				],
				[
					-115,
					290
				],
				[
					-116.66666666666652,
					291.66666666666606
				],
				[
					-116.66666666666652,
					293.33333333333303
				],
				[
					-116.66666666666652,
					293.33333333333303
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 86,
			"versionNonce": 1485867206,
			"isDeleted": false,
			"id": "iqR5Y7q-V0GA0Hv7Jmngy",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1131.1499993960783,
			"y": 4753.3931349134045,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 206.66666666666674,
			"height": 305,
			"seed": 848807890,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					3.3333333333339397
				],
				[
					3.333333333333485,
					11.66666666666697
				],
				[
					16.666666666666742,
					35
				],
				[
					30,
					58.33333333333394
				],
				[
					45,
					78.33333333333394
				],
				[
					65,
					101.66666666666697
				],
				[
					81.66666666666674,
					123.33333333333394
				],
				[
					88.33333333333348,
					130
				],
				[
					95,
					141.66666666666697
				],
				[
					105,
					156.66666666666697
				],
				[
					118.33333333333348,
					176.66666666666697
				],
				[
					125,
					191.66666666666697
				],
				[
					136.66666666666674,
					215
				],
				[
					146.66666666666674,
					240
				],
				[
					153.33333333333348,
					250
				],
				[
					155,
					255
				],
				[
					158.33333333333348,
					260
				],
				[
					163.33333333333348,
					265
				],
				[
					166.66666666666674,
					270
				],
				[
					173.33333333333348,
					278.33333333333394
				],
				[
					176.66666666666674,
					283.33333333333394
				],
				[
					178.33333333333348,
					285
				],
				[
					180,
					285
				],
				[
					183.33333333333348,
					288.33333333333394
				],
				[
					190,
					293.33333333333394
				],
				[
					196.66666666666674,
					298.33333333333394
				],
				[
					201.66666666666674,
					301.66666666666697
				],
				[
					206.66666666666674,
					305
				],
				[
					206.66666666666674,
					305
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "freedraw",
			"version": 77,
			"versionNonce": 489541274,
			"isDeleted": false,
			"id": "n1or92JFLAgd87NW0iGGz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -959.4833327294116,
			"y": 5040.0598015800715,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 81.66666666666674,
			"height": 40,
			"seed": 187575310,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.6666666666667425,
					0
				],
				[
					6.6666666666667425,
					5
				],
				[
					15,
					16.66666666666697
				],
				[
					28.333333333333258,
					28.33333333333303
				],
				[
					40,
					38.33333333333303
				],
				[
					45,
					40
				],
				[
					46.66666666666674,
					40
				],
				[
					46.66666666666674,
					38.33333333333303
				],
				[
					50,
					33.33333333333303
				],
				[
					51.66666666666674,
					31.66666666666697
				],
				[
					56.66666666666674,
					25
				],
				[
					60,
					21.66666666666697
				],
				[
					66.66666666666674,
					13.33333333333303
				],
				[
					73.33333333333326,
					8.33333333333303
				],
				[
					78.33333333333326,
					5
				],
				[
					80,
					3.33333333333303
				],
				[
					81.66666666666674,
					3.33333333333303
				],
				[
					81.66666666666674,
					1.6666666666669698
				],
				[
					81.66666666666674,
					3.33333333333303
				],
				[
					81.66666666666674,
					3.33333333333303
				]
			],
			"lastCommittedPoint": null,
			"simulatePressure": true,
			"pressures": []
		},
		{
			"type": "text",
			"version": 128,
			"versionNonce": 1884258310,
			"isDeleted": false,
			"id": "nVxSrZ7u",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1122.816666062745,
			"y": 4926.7264682467385,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 490.80584716796875,
			"height": 36.66666666666697,
			"seed": 588793614,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"fontSize": 29.333333333333577,
			"fontFamily": 1,
			"text": "solve unreliable part using possion",
			"rawText": "solve unreliable part using possion",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "solve unreliable part using possion",
			"lineHeight": 1.25,
			"baseline": 25
		},
		{
			"type": "text",
			"version": 224,
			"versionNonce": 510454618,
			"isDeleted": false,
			"id": "QCcI23QR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2042.9252177451745,
			"y": 1275.365805664399,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 295.7041320800781,
			"height": 25,
			"seed": 1642292008,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": "https://math.berkeley.edu/~sethian/2006/Explanations/fast_marching_explain.html",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[fast marching algorithm]]",
			"rawText": "[fast marching algorithm](https://math.berkeley.edu/~sethian/2006/Explanations/fast_marching_explain.html)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[fast marching algorithm]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 119,
			"versionNonce": 2074971974,
			"isDeleted": false,
			"id": "QaKRIbJE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -2026.8764952258628,
			"y": 1337.62902610409,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 667.7398071289062,
			"height": 125,
			"seed": 1593690200,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "计算了一个面边界演化的情况:\n给定一个边界, 边界以一定的速度F(x)向外扩张,\n计算得到一个time arrival曲面.\n\nskfmm中phi中可以定义一个高纬度的array. 但只有值为0的边界是有意义的.",
			"rawText": "计算了一个面边界演化的情况:\n给定一个边界, 边界以一定的速度F(x)向外扩张,\n计算得到一个time arrival曲面.\n\nskfmm中phi中可以定义一个高纬度的array. 但只有值为0的边界是有意义的.",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "计算了一个面边界演化的情况:\n给定一个边界, 边界以一定的速度F(x)向外扩张,\n计算得到一个time arrival曲面.\n\nskfmm中phi中可以定义一个高纬度的array. 但只有值为0的边界是有意义的.",
			"lineHeight": 1.25,
			"baseline": 118
		},
		{
			"type": "image",
			"version": 128,
			"versionNonce": 187330586,
			"isDeleted": false,
			"id": "7OGK7gfGYrs7Ojz4F6Zl7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1653.8764952258628,
			"y": 1047.12902610409,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 508.0000000000002,
			"height": 234.17919075144516,
			"seed": 1913040728,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "d800e431f073a33de782cc27b931df3550595038",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 121,
			"versionNonce": 1728558726,
			"isDeleted": false,
			"id": "b8u_nRJr21pHgZg-CRqOo",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1624.8764952258628,
			"y": 1263.62902610409,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 80,
			"height": 80,
			"seed": 83509080,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "cfaf280be0d1de99a281888a5cd574f0cbb0c515",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 78,
			"versionNonce": 928603354,
			"isDeleted": false,
			"id": "Jc0b8sj__6zhcgkGsALww",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1475.3764952258628,
			"y": 1288.12902610409,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 101,
			"height": 101,
			"seed": 2055506776,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "bdf648271cc6f34d0efb0ee645aeee54a59ff66d",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 56,
			"versionNonce": 186316230,
			"isDeleted": false,
			"id": "Bgush_YIS37DFLjDyrXAz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1990.7168215661886,
			"y": 1491.3411473162114,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 278.090909090909,
			"height": 339.28890850250065,
			"seed": 1739304792,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487443,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "e26c846251d3538a4bd7fba980c995073095b36e",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 38,
			"versionNonce": 9220506,
			"isDeleted": false,
			"id": "beTYTaNCfhdmJU9HbBp5m",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1683.0350033843702,
			"y": 1469.568420043484,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 302.7272727272725,
			"height": 372.4462809917353,
			"seed": 576769112,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "1eff8b522e5961fe78cfc1061ed1ce201250f662",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 63,
			"versionNonce": 553929990,
			"isDeleted": false,
			"id": "rMQkDbpQ1-d1alIa8ytpf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1364.4440942934611,
			"y": 1478.2502382253024,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 290.99999999999994,
			"height": 360.24115755627,
			"seed": 622947416,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "4ca6f63d20ff8cba0a92995e2ecda344d8f0a3c3",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 41,
			"versionNonce": 435646042,
			"isDeleted": false,
			"id": "P9VTq4ov",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -759.7188685388221,
			"y": 2979.5463612199537,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 500,
			"height": 281.25,
			"seed": 85966,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": "https://www.youtube.com/watch?v=qM9amZJUIok",
			"locked": false,
			"status": "pending",
			"fileId": "c9bc65e64c41fe323d111f091aadeb0962ba1798",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 26,
			"versionNonce": 910212166,
			"isDeleted": false,
			"id": "xM4KsgAg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -755.9688685388221,
			"y": 2932.6713612199537,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 267.45989990234375,
			"height": 25,
			"seed": 529979619,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": "https://helpx.adobe.com/photoshop/using/curves-adjustment.html#access_token=eyJhbGciOiJSUzI1NiIsIng1dSI6Imltc19uYTEta2V5LWF0LTEuY2VyIiwia2lkIjoiaW1zX25hMS1rZXktYXQtMSIsIml0dCI6ImF0In0.eyJpZCI6IjE2OTA5NTY3MzkzMzhfNzhlNTNlZGEtNGZkZC00Y2RmLTg0ZTItYjJjNDM0YTc3OGYxX3VlMSIsInR5cGUiOiJhY2Nlc3NfdG9rZW4iLCJjbGllbnRfaWQiOiJBZG9iZVN1cHBvcnQxIiwidXNlcl9pZCI6IjYwNkYyOEFCNjQ1NEMyQTQwQTQ5NUU5MkBBZG9iZUlEIiwic3RhdGUiOiIiLCJhcyI6Imltcy1uYTEiLCJhYV9pZCI6IjYwNkYyOEFCNjQ1NEMyQTQwQTQ5NUU5MkBBZG9iZUlEIiwiY3RwIjowLCJmZyI6IlhWRFRJQlpCWFBQN01QNktHT1FWWkhBQUpBPT09PT09Iiwic2lkIjoiMTY4MzUxMDc1ODM4M18wZGJlNzcwOC1mMDU1LTQ2OWItYTg2Mi1jOWJmZTY3MjhlNzNfdWUxIiwibW9pIjoiMWYwYWU2MmEiLCJwYmEiOiJNZWRTZWNOb0VWLExvd1NlYyIsImV4cGlyZXNfaW4iOiI4NjQwMDAwMCIsInNjb3BlIjoiQWRvYmVJRCxvcGVuaWQsZ25hdixjcmVhdGl2ZV9jbG91ZCxyZWFkX29yZ2FuaXphdGlvbnMsYWRkaXRpb25hbF9pbmZvLnByb2plY3RlZFByb2R1Y3RDb250ZXh0LGFkZGl0aW9uYWxfaW5mby5yb2xlcyIsImNyZWF0ZWRfYXQiOiIxNjkwOTU2NzM5MzM4In0.Asx9SVdaL0xqq4caR_VLphGmzM5sdJztlM_oXwz_7x84yc4lpcqumMlWosM8yjwcY_dAE-OIsxSghkzMaHmk4l54RS9hN4FITZeYJB-5E5h0WdyCnVwXyH4IU9CBnidYT_0i4VOrqhustVIhvhPBS58CgCkpxzU8u3Qxt3dD8LH3BR_685q7H_htMWy8weBZMesKygm99F06JaNvL4SJTKS20BZdVZ5eVkN9PGv8FUD9vdlLGdyJUe7aaCxPFz-K667LrhfzjuxcIXToKn0gkhgf2U7QhVPK6gT0hN4DuIS_kSQzD7l6Wjix39jTj4ILrP5LIxIZwRG-bOffeOWadQ&token_type=bearer&expires_in=86399996",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "使用color curve实现肤色迁移",
			"rawText": "使用color curve实现肤色迁移",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "使用color curve实现肤色迁移",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 177,
			"versionNonce": 1483510554,
			"isDeleted": false,
			"id": "SGqAnwUtKs74_D3lWxW3o",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -751.7016739276114,
			"y": 3331.0250486708687,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 342.78666721894433,
			"height": 299.29453581887793,
			"seed": 1999962125,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "34d739230e0b1b2b4d95abcd437969d70dfb8f77",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 52,
			"versionNonce": 548225926,
			"isDeleted": false,
			"id": "PSPXo3Dv",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -757.5745268118936,
			"y": 3301.8097469098066,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 384.59991455078125,
			"height": 25,
			"seed": 1847903523,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "通过多个采样点, 拟合生成一个mapping曲线",
			"rawText": "通过多个采样点, 拟合生成一个mapping曲线",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "通过多个采样点, 拟合生成一个mapping曲线",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 62,
			"versionNonce": 2120163290,
			"isDeleted": false,
			"id": "eVLJglD0_QOdMRr-XCZZ-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -178.8584577078226,
			"y": 2989.028504077096,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 450.3267973856208,
			"height": 652.7993109388457,
			"seed": 36768227,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a508f042c708aa3bf62688ec622ec4609b598219",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 50,
			"versionNonce": 1921442502,
			"isDeleted": false,
			"id": "V0KmBZa6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -130.36172568167876,
			"y": 3655.6951707437624,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 360.6199951171875,
			"height": 75,
			"seed": 1961756515,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "黑色部分颜色小于均值, 而其他皮肤过曝.\n\n肤色迁移手光照、阴影影响很大",
			"rawText": "黑色部分颜色小于均值, 而其他皮肤过曝.\n\n肤色迁移手光照、阴影影响很大",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "黑色部分颜色小于均值, 而其他皮肤过曝.\n\n肤色迁移手光照、阴影影响很大",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "image",
			"version": 155,
			"versionNonce": 132256922,
			"isDeleted": false,
			"id": "1OGW4rK2_ZSo5RfKKbv5H",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 284.80494098498764,
			"y": 2988.47294852154,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 294.34278959810854,
			"height": 298.79289656827433,
			"seed": 1604369251,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "a1dd5a6d2400ef7f5c61b590a15e49149077010f",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 376,
			"versionNonce": 1852480006,
			"isDeleted": false,
			"id": "lwmq0nT8-HO1lcZdIIiC1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 275.360496540544,
			"y": 3293.0285040770955,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 303.7125603864732,
			"height": 340.0594996619335,
			"seed": 856776717,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "2b696b3825365b627f2d16676df331ea6ee54220",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 148,
			"versionNonce": 1990750554,
			"isDeleted": false,
			"id": "dyU3O_BB_tCOk7o1VcoNI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 589.8651639851172,
			"y": 2981.2507262993176,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 314.80357837417336,
			"height": 671.111111111111,
			"seed": 1157805389,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "1043e42b46cb78906aa88553e62753c8be1c54ab",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 134,
			"versionNonce": 2069195078,
			"isDeleted": false,
			"id": "1-J8fN5YIoccX5A4yvDig",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1328.357958469477,
			"y": 2970.139615188206,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 394.90411731528496,
			"height": 667.7777777777779,
			"seed": 1588364643,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "84807b01215c66921f72101aafa5b772afb95ca6",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 79,
			"versionNonce": 503658010,
			"isDeleted": false,
			"id": "dE7cS8QQnVaSXNevP6wYX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 934.7664794465263,
			"y": 2977.917392965985,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 349.94819994819994,
			"height": 677.7777777777778,
			"seed": 257651021,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "22ba6437d03b159118657e441abb25a72af6f6bc",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 18,
			"versionNonce": 413421702,
			"isDeleted": false,
			"id": "d2S9kCad",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 987.4160520960988,
			"y": 3669.028504077096,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 86.03994750976562,
			"height": 25,
			"seed": 909034125,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "+std迁移",
			"rawText": "+std迁移",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "+std迁移",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 15,
			"versionNonce": 1860920026,
			"isDeleted": false,
			"id": "DneM9qXz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 687.4160520960988,
			"y": 3669.028504077096,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 113.53996276855469,
			"height": 25,
			"seed": 1158897379,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "没有std迁移",
			"rawText": "没有std迁移",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "没有std迁移",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 11,
			"versionNonce": 1377062854,
			"isDeleted": false,
			"id": "3OnBbIQk",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 1529.6382743183208,
			"y": 3661.250726299318,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 40,
			"height": 25,
			"seed": 622683725,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "原图",
			"rawText": "原图",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "原图",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 12,
			"versionNonce": 1139668890,
			"isDeleted": false,
			"id": "JKqlfaNx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 407.41605209609884,
			"y": 3661.250726299318,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 80,
			"height": 25,
			"seed": 1573385997,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "目标图像",
			"rawText": "目标图像",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "目标图像",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 22,
			"versionNonce": 868378374,
			"isDeleted": false,
			"id": "xP0Hgbue",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -161.47283679278985,
			"y": 3807.9173929659846,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 258.8199768066406,
			"height": 25,
			"seed": 1174778243,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487444,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "亮度不做迁移, 只迁移肤色!!!!",
			"rawText": "亮度不做迁移, 只迁移肤色!!!!",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "亮度不做迁移, 只迁移肤色!!!!",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 333,
			"versionNonce": 759166042,
			"isDeleted": false,
			"id": "MrGgubfP2cjY3FwxwY5Et",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 265.71013641507284,
			"y": 3721.085726204925,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 395.51165398005537,
			"height": 516.46910155648,
			"seed": 2062139011,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "632f74d8263393f604ed6f170f7a661176c78edb",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 139,
			"versionNonce": 1043043910,
			"isDeleted": false,
			"id": "kBucXPNYcRhRQEIP5ZmSR",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -176.86172568167876,
			"y": 4335.670278968873,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 667,
			"height": 664,
			"seed": 850665305,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "4716b3142356e4e0e427830a30900c93a9e23ef8",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 72,
			"versionNonce": 1018452250,
			"isDeleted": false,
			"id": "raqw3qeJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -73.12363044358335,
			"y": 5022.619912668508,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 260,
			"height": 25,
			"seed": 728845303,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "将视频人物皮肤迁移到人脸上",
			"rawText": "将视频人物皮肤迁移到人脸上",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "将视频人物皮肤迁移到人脸上",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 114,
			"versionNonce": 1512889734,
			"isDeleted": false,
			"id": "RR3d-bTFU3Ul-_MetWMgK",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 575.7112403284601,
			"y": 4337.858007906602,
			"strokeColor": "transparent",
			"backgroundColor": "transparent",
			"width": 559.7905759162302,
			"height": 733.3333333333331,
			"seed": 44406041,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "db7c4e765520927ab13b3759f09aaa97572475c3",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 110,
			"versionNonce": 1371416026,
			"isDeleted": false,
			"id": "51wALotB",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 755.606528286575,
			"y": 5081.191341239936,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 240,
			"height": 25,
			"seed": 281597335,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "人脸皮肤迁移到视频人物上",
			"rawText": "人脸皮肤迁移到视频人物上",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "人脸皮肤迁移到视频人物上",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 59,
			"versionNonce": 1292057798,
			"isDeleted": false,
			"id": "Tk5mhurx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -165.73077330072647,
			"y": 5174.076123124718,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 1257.2384033203125,
			"height": 75,
			"seed": 1819508386,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": "https://github.com/yihua7/NeRF-Texture",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "更好的皮肤:\nhttps://github.com/yihua7/NeRF-Texture\nhttps://devashi-choudhary.medium.com/texture-synthesis-generating-arbitrarily-large-textures-from-image-patches-32dd49e2d637",
			"rawText": "更好的皮肤:\nhttps://github.com/yihua7/NeRF-Texture\nhttps://devashi-choudhary.medium.com/texture-synthesis-generating-arbitrarily-large-textures-from-image-patches-32dd49e2d637",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "更好的皮肤:\nhttps://github.com/yihua7/NeRF-Texture\nhttps://devashi-choudhary.medium.com/texture-synthesis-generating-arbitrarily-large-textures-from-image-patches-32dd49e2d637",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "text",
			"version": 59,
			"versionNonce": 1701862042,
			"isDeleted": false,
			"id": "cJ42naKi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -165.16259148254483,
			"y": 5333.588027886622,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 461.5995788574219,
			"height": 50,
			"seed": 1698823230,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "blender hair:\nhttps://www.youtube.com/watch?v=_-d0HaT5f1g",
			"rawText": "blender hair:\nhttps://www.youtube.com/watch?v=_-d0HaT5f1g",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "blender hair:\nhttps://www.youtube.com/watch?v=_-d0HaT5f1g",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "text",
			"version": 141,
			"versionNonce": 743158790,
			"isDeleted": false,
			"id": "9XyxiPaV",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -1257.2038130743517,
			"y": 5823.307232606382,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 349.89984130859375,
			"height": 75,
			"seed": 33923624,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "arkit to flame:\n①使用flame拟合arkit脸, 再进行形变. \n②通过特征点进行对齐, 形变",
			"rawText": "arkit to flame:\n①使用flame拟合arkit脸, 再进行形变. \n②通过特征点进行对齐, 形变",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "arkit to flame:\n①使用flame拟合arkit脸, 再进行形变. \n②通过特征点进行对齐, 形变",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "text",
			"version": 411,
			"versionNonce": 1797493466,
			"isDeleted": false,
			"id": "slhZdDOw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -503.5851723180572,
			"y": 6224.362899340434,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 605.7640380859375,
			"height": 25,
			"seed": 1762601568,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807561564,
			"link": "https://docs.unrealengine.com/5.1/en-US/live-link-plugin-development-in-unreal-engine/",
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "🌐[[unreal livelink face importer 基于表情基实现面部整体驱动]]",
			"rawText": "[unreal livelink face importer 基于表情基实现面部整体驱动](https://docs.unrealengine.com/5.1/en-US/live-link-plugin-development-in-unreal-engine/)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[unreal livelink face importer 基于表情基实现面部整体驱动]]",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "text",
			"version": 389,
			"versionNonce": 1375945542,
			"isDeleted": false,
			"id": "G1aZzoRI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -4146.026943949057,
			"y": -451.74653959690187,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 378.2395935058594,
			"height": 25,
			"seed": 2116618805,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "RBF based face animation retargeting",
			"rawText": "RBF based face animation retargeting",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "RBF based face animation retargeting",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "image",
			"version": 176,
			"versionNonce": 892992538,
			"isDeleted": false,
			"id": "dyHNLPEN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -4151.679767198248,
			"y": -217.04596172517404,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 199.45411990216184,
			"height": 41.69379907559315,
			"seed": 54348,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "ACDBpnhaz9XkxqeyJBcIf",
					"type": "arrow"
				}
			],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "7f64417dda1392fc2f3429e9d79fbc7e4240d0c7",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "text",
			"version": 390,
			"versionNonce": 1351019142,
			"isDeleted": false,
			"id": "RSpoAnBM",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3850.609397878273,
			"y": -298.6394577046079,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 127.40950012207031,
			"height": 13.863995816075864,
			"seed": 462730139,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"fontSize": 11.091196652860692,
			"fontFamily": 1,
			"text": "相同shape, 转换拓扑结构",
			"rawText": "相同shape, 转换拓扑结构",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "相同shape, 转换拓扑结构",
			"lineHeight": 1.25,
			"baseline": 9
		},
		{
			"type": "text",
			"version": 246,
			"versionNonce": 261581018,
			"isDeleted": false,
			"id": "RB1lGLY8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3858.424846002714,
			"y": -202.98008044245694,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 141.21983337402344,
			"height": 12.01082444803508,
			"seed": 104782395,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"fontSize": 9.608659558428064,
			"fontFamily": 1,
			"text": "相同的拓扑, shape deform 映射",
			"rawText": "相同的拓扑, shape deform 映射",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "相同的拓扑, shape deform 映射",
			"lineHeight": 1.25,
			"baseline": 8
		},
		{
			"type": "text",
			"version": 380,
			"versionNonce": 1720953286,
			"isDeleted": false,
			"id": "PRcqshOm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -4145.364141894052,
			"y": -417.0768664635088,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 585.7642211914062,
			"height": 64.04096549079172,
			"seed": 2081859899,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"fontSize": 12.808193098158343,
			"fontFamily": 1,
			"text": "X_012 对应的是不同人头id, 其中0是程序内部id, 2表示arkit mesh序列对应的人头id, 1是目标人头的id\nT表示template, 是程序的内部数据\nmeanA 表示Arkit的无表情状态\nmeanB 表示Flame无表情状态",
			"rawText": "X_012 对应的是不同人头id, 其中0是程序内部id, 2表示arkit mesh序列对应的人头id, 1是目标人头的id\nT表示template, 是程序的内部数据\nmeanA 表示Arkit的无表情状态\nmeanB 表示Flame无表情状态",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "X_012 对应的是不同人头id, 其中0是程序内部id, 2表示arkit mesh序列对应的人头id, 1是目标人头的id\nT表示template, 是程序的内部数据\nmeanA 表示Arkit的无表情状态\nmeanB 表示Flame无表情状态",
			"lineHeight": 1.25,
			"baseline": 59
		},
		{
			"type": "image",
			"version": 310,
			"versionNonce": 1026112922,
			"isDeleted": false,
			"id": "J22dQhgp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -4151.754169905008,
			"y": -111.87443180286112,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 322.9984520086745,
			"height": 17.944358444926362,
			"seed": 54110,
			"groupIds": [],
			"roundness": null,
			"boundElements": [
				{
					"id": "ACDBpnhaz9XkxqeyJBcIf",
					"type": "arrow"
				}
			],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "6224e1aa9605347104e90d0bc748f16a2e57f503",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "image",
			"version": 282,
			"versionNonce": 1934000390,
			"isDeleted": false,
			"id": "i5UViej4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -4157.504764571876,
			"y": -332.24015741630416,
			"strokeColor": "#000000",
			"backgroundColor": "transparent",
			"width": 376.83527911569917,
			"height": 64.85592340863666,
			"seed": 65217,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487445,
			"link": null,
			"locked": false,
			"status": "pending",
			"fileId": "fbce96bdfeb9587a1d220fb239e3a97ece647287",
			"scale": [
				1,
				1
			]
		},
		{
			"type": "line",
			"version": 208,
			"versionNonce": 723679834,
			"isDeleted": false,
			"id": "q8khw3z8die7oLW7LwX8c",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3972.533049018827,
			"y": -276.18300253619526,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 41.351088057634115,
			"height": 155.0665802161255,
			"seed": 1794602965,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1693807487445,
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
					41.351088057634115,
					20.183269170987728
				],
				[
					22.6446434601321,
					155.0665802161255
				]
			]
		},
		{
			"type": "line",
			"version": 198,
			"versionNonce": 1780248646,
			"isDeleted": false,
			"id": "xBY8ROcFMsHGdDbtyI8dN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -3939.550633544286,
			"y": -295.38172199152507,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 61.53435722862105,
			"height": 175.24984938711322,
			"seed": 1067506805,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1693807487445,
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
					61.53435722862105,
					16.73734516618498
				],
				[
					48.735210925067804,
					175.24984938711322
				]
			]
		},
		{
			"type": "arrow",
			"version": 202,
			"versionNonce": 676732698,
			"isDeleted": false,
			"id": "ACDBpnhaz9XkxqeyJBcIf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -4061.6347982858706,
			"y": -168.86708352947983,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 2.953649146974385,
			"height": 48.735210925067975,
			"seed": 1158559509,
			"groupIds": [],
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "dyHNLPEN",
				"focus": 0.08003778995510118,
				"gap": 6.3319786578976505
			},
			"endBinding": {
				"elementId": "J22dQhgp",
				"focus": -0.4666037997767369,
				"gap": 8.229620024013911
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
					-2.953649146974385,
					48.735210925067975
				]
			]
		},
		{
			"type": "text",
			"version": 105,
			"versionNonce": 1190295430,
			"isDeleted": false,
			"id": "9YXvVwvz",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -151.92798857428426,
			"y": 5481.987307485647,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 95.37606811523438,
			"height": 20,
			"seed": 310627028,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "3D 人头重建",
			"rawText": "3D 人头重建",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "3D 人头重建",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 73,
			"versionNonce": 825699290,
			"isDeleted": false,
			"id": "IwZiuq0S",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -58.4123887266054,
			"y": 5537.749626016386,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 43.60011291503906,
			"height": 20,
			"seed": 2045721708,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Hifi3d",
			"rawText": "Hifi3d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Hifi3d",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 133,
			"versionNonce": 33920710,
			"isDeleted": false,
			"id": "OvczzAbu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 211.00799604651957,
			"y": 5563.8780390211,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 75.296142578125,
			"height": 20,
			"seed": 1581895252,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "color loss",
			"rawText": "color loss",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "color loss",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 139,
			"versionNonce": 1004052634,
			"isDeleted": false,
			"id": "GZd0yv9t",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 211.00799604651957,
			"y": 5596.313475738495,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 119.64823913574219,
			"height": 20,
			"seed": 1222964436,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "perceptual loss",
			"rawText": "perceptual loss",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "perceptual loss",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 136,
			"versionNonce": 66244102,
			"isDeleted": false,
			"id": "NmpLNn4L",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 214.94524559024956,
			"y": 5735.054650136598,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 105.37623596191406,
			"height": 20,
			"seed": 1850382572,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "landmark loss",
			"rawText": "landmark loss",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "landmark loss",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 101,
			"versionNonce": 65895770,
			"isDeleted": false,
			"id": "wZH05pph",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -58.4123887266054,
			"y": 5573.747336130489,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 63.60014343261719,
			"height": 20,
			"seed": 1271709420,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "Hifi3d++",
			"rawText": "Hifi3d++",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "Hifi3d++",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 157,
			"versionNonce": 431430982,
			"isDeleted": false,
			"id": "rx48cmjE",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 211.00799604651957,
			"y": 5531.442602303706,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 81.13616943359375,
			"height": 20,
			"seed": 624441172,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "depth loss",
			"rawText": "depth loss",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "depth loss",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 88,
			"versionNonce": 1455997466,
			"isDeleted": false,
			"id": "doXDzFP9",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -62.91210249086822,
			"y": 5597.933297613401,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 78.53018188476562,
			"height": 19.188823840283966,
			"seed": 480979796,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 7.6755295361135865,
			"fontFamily": 1,
			"text": "将人头拆分成几个部分,\n增强表达能力",
			"rawText": "将人头拆分成几个部分,\n增强表达能力",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "将人头拆分成几个部分,\n增强表达能力",
			"lineHeight": 1.25,
			"baseline": 16
		},
		{
			"type": "text",
			"version": 36,
			"versionNonce": 1756333190,
			"isDeleted": false,
			"id": "NIuaUGPw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -122.53330986734994,
			"y": 5640.118114153365,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 52.304107666015625,
			"height": 20,
			"seed": 270673516,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "FLAME",
			"rawText": "FLAME",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "FLAME",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 26,
			"versionNonce": 1599958746,
			"isDeleted": false,
			"id": "dt6rQLG4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -79.78602910685362,
			"y": 5707.27522517674,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 83.95217895507812,
			"height": 20,
			"seed": 584591828,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "SynergyNet",
			"rawText": "SynergyNet",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "SynergyNet",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 45,
			"versionNonce": 1654195142,
			"isDeleted": false,
			"id": "CfiuI0LZ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 28.207101235452967,
			"y": 5535.499769134255,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 54.49610900878906,
			"height": 40,
			"seed": 298133996,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "deep3d\n+ opt",
			"rawText": "deep3d\n+ opt",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "deep3d\n+ opt",
			"lineHeight": 1.25,
			"baseline": 34
		},
		{
			"type": "text",
			"version": 525,
			"versionNonce": 1916699546,
			"isDeleted": false,
			"id": "oeNQESXe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -84.28574287111644,
			"y": 5858.35423172011,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 111.44024658203125,
			"height": 20,
			"seed": 924533484,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "DAD-3DHeads",
			"rawText": "DAD-3DHeads",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "DAD-3DHeads",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 83,
			"versionNonce": 965778182,
			"isDeleted": false,
			"id": "NUH8HSDQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -79.78602910685362,
			"y": 5742.674090363855,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 75.88816833496094,
			"height": 20,
			"seed": 1216087892,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "SPECTRE",
			"rawText": "SPECTRE",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "SPECTRE",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 93,
			"versionNonce": 1503592538,
			"isDeleted": false,
			"id": "wkhjOafi",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -79.78602910685362,
			"y": 5777.35938396338,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 94.33970642089844,
			"height": 20,
			"seed": 1023338708,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": "https://github.com/Zielon/MICA",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[MICA]]",
			"rawText": "[MICA](https://github.com/Zielon/MICA)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[MICA]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 7,
			"versionNonce": 1410550342,
			"isDeleted": false,
			"id": "j4klPttw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -79.78602910685362,
			"y": 5673.303503164803,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 44.0640869140625,
			"height": 20,
			"seed": 1406118380,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "DECA",
			"rawText": "DECA",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "DECA",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 159,
			"versionNonce": 559015194,
			"isDeleted": false,
			"id": "sswZWHLI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -307.99562286668913,
			"y": 5779.728613278685,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 214.93844604492188,
			"height": 30.82222368779302,
			"seed": 1610904148,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 12.328889475117208,
			"fontFamily": 1,
			"text": "直接根据arkface特征推断flame coeff\n后期可以再加入优化步骤",
			"rawText": "直接根据arkface特征推断flame coeff\n后期可以再加入优化步骤",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "直接根据arkface特征推断flame coeff\n后期可以再加入优化步骤",
			"lineHeight": 1.25,
			"baseline": 25
		},
		{
			"type": "text",
			"version": 191,
			"versionNonce": 1090392454,
			"isDeleted": false,
			"id": "ko5KAEs2",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -77.52523065634841,
			"y": 5932.6703350506605,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 118.64378356933594,
			"height": 20,
			"seed": 376984300,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": "https://github.com/TimoBolkart/TEMPEH",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐[[TEMPEH]]",
			"rawText": "[TEMPEH](https://github.com/TimoBolkart/TEMPEH)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐[[TEMPEH]]",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 125,
			"versionNonce": 1657418202,
			"isDeleted": false,
			"id": "OIPwhEqw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 169.4083528944302,
			"y": 5776.862278644193,
			"strokeColor": "#1971c2",
			"backgroundColor": "transparent",
			"width": 129.8242645263672,
			"height": 20,
			"seed": 1170634836,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487446,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "MediaPipe(dense)",
			"rawText": "MediaPipe(dense)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "MediaPipe(dense)",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"type": "text",
			"version": 145,
			"versionNonce": 730722502,
			"isDeleted": false,
			"id": "6sKti1Y7",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -321.62293476863624,
			"y": 5744.840550349961,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 224.7945556640625,
			"height": 15.06412172443265,
			"seed": 1974719444,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487447,
			"link": null,
			"locked": false,
			"fontSize": 12.05129737954612,
			"fontFamily": 1,
			"text": "添加了嘴部动作的loss, 能够进行嘴型对齐",
			"rawText": "添加了嘴部动作的loss, 能够进行嘴型对齐",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "添加了嘴部动作的loss, 能够进行嘴型对齐",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "text",
			"version": 147,
			"versionNonce": 286975642,
			"isDeleted": false,
			"id": "H8kOmjM1",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -308.6862576963807,
			"y": 5711.655161338523,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 217.55752563476562,
			"height": 13.760162553463733,
			"seed": 221136980,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487447,
			"link": null,
			"locked": false,
			"fontSize": 11.008130042770986,
			"fontFamily": 1,
			"text": "人脸特征点+pose更准确, 特别对于极端case",
			"rawText": "人脸特征点+pose更准确, 特别对于极端case",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "人脸特征点+pose更准确, 特别对于极端case",
			"lineHeight": 1.25,
			"baseline": 9
		},
		{
			"type": "text",
			"version": 254,
			"versionNonce": 1331685382,
			"isDeleted": false,
			"id": "BYZJ47li",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -300.2492943883881,
			"y": 5932.703600007932,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 184.69300842285156,
			"height": 15.66441031724321,
			"seed": 1759160044,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487447,
			"link": null,
			"locked": false,
			"fontSize": 12.531528253794567,
			"fontFamily": 1,
			"text": "基于多视图几何, 需要相机内外参",
			"rawText": "基于多视图几何, 需要相机内外参",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "基于多视图几何, 需要相机内外参",
			"lineHeight": 1.25,
			"baseline": 10
		},
		{
			"type": "text",
			"version": 32,
			"versionNonce": 1819342662,
			"isDeleted": false,
			"id": "4jtg7RK5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": -144.45654192986876,
			"y": 6017.583195963312,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 343.98406982421875,
			"height": 20,
			"seed": 1411483177,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487447,
			"link": null,
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "混合方案: 将脖子设计成半透明, 与背景进行混合",
			"rawText": "混合方案: 将脖子设计成半透明, 与背景进行混合",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "混合方案: 将脖子设计成半透明, 与背景进行混合",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"id": "j8DOyZSd",
			"type": "text",
			"x": 177.68870274809512,
			"y": 6200.802618851214,
			"width": 664.4654541015625,
			"height": 60,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 1246259654,
			"version": 101,
			"versionNonce": 145852442,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1693807487447,
			"link": null,
			"locked": false,
			"text": "metahuman face control rig export:\ndemo: https://blenderartists.org/t/metahuman-rig-for-blender-implement-demo/1446967\ndetail: https://www.youtube.com/watch?v=aHHkNSBVA9s",
			"rawText": "metahuman face control rig export:\ndemo: https://blenderartists.org/t/metahuman-rig-for-blender-implement-demo/1446967\ndetail: https://www.youtube.com/watch?v=aHHkNSBVA9s",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "left",
			"verticalAlign": "top",
			"baseline": 54,
			"containerId": null,
			"originalText": "metahuman face control rig export:\ndemo: https://blenderartists.org/t/metahuman-rig-for-blender-implement-demo/1446967\ndetail: https://www.youtube.com/watch?v=aHHkNSBVA9s",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 5,
			"versionNonce": 1157038938,
			"isDeleted": true,
			"id": "iJuahQ2m",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"angle": 0,
			"x": 232.47202765218333,
			"y": 5427.516049614377,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 338.0682373046875,
			"height": 20,
			"seed": 1661879012,
			"groupIds": [],
			"roundness": null,
			"boundElements": [],
			"updated": 1693807487447,
			"link": "https://zhuanlan.zhihu.com/p/495507933",
			"locked": false,
			"fontSize": 16,
			"fontFamily": 1,
			"text": "🌐https://zhuanlan.zhihu.com/p/495507933",
			"rawText": "https://zhuanlan.zhihu.com/p/495507933",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "🌐https://zhuanlan.zhihu.com/p/495507933",
			"lineHeight": 1.25,
			"baseline": 14
		},
		{
			"id": "To6oXe8f",
			"type": "text",
			"x": -21.06129725190476,
			"y": 6229.552618851214,
			"width": 639.2975463867188,
			"height": 20,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "dashed",
			"roughness": 0,
			"opacity": 100,
			"groupIds": [],
			"roundness": null,
			"seed": 433547162,
			"version": 3,
			"versionNonce": 991829638,
			"isDeleted": true,
			"boundElements": null,
			"updated": 1693807487447,
			"link": "",
			"locked": false,
			"text": "https://docs.unrealengine.com/5.1/en-US/live-link-plugin-development-in-unreal-engine/",
			"rawText": "https://docs.unrealengine.com/5.1/en-US/live-link-plugin-development-in-unreal-engine/",
			"fontSize": 16,
			"fontFamily": 1,
			"textAlign": "left",
			"verticalAlign": "top",
			"baseline": 14,
			"containerId": null,
			"originalText": "https://docs.unrealengine.com/5.1/en-US/live-link-plugin-development-in-unreal-engine/",
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
		"currentItemStrokeStyle": "dashed",
		"currentItemRoughness": 0,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 16,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 812.9362972519046,
		"scrollY": -4981.915900101214,
		"zoom": {
			"value": 0.8000000000000002
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