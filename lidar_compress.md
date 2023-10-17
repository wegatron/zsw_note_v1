---
tag: projects
---
# 需求目标
每天5000m, 数据量小于400MB, 0.3m一帧, 共16667帧, 要求:24kb/fps;
40帧数据量小于960kb, 156kb的头部, 剩下的数据不得超过804kb
性能要求: 2.6fps(最快速度0.8m/s, 每0.3米一帧), 工控机 cpu峰值<+10%
精度要求: n_diff<1000, diff>0.02m

# Performance
测试: ①压缩率; ②数据损失程度; ③性能.
测试方法: 
1. 使用构图软件, 按照0.3米或旋转10°采集一帧的方式, 采集了实验室内和东信科技园内的激光数据. 使用不同的参数进行对数据进行压缩, 记录不同参数下数据的精度以及压缩率.

2. 集成到定位软件中, 在实验室内和东信科技园内, 以不同的参数跑定位, 记录CPU和内存的使用情况.

## 工控机CPU和内存占用
测试的工控机的配置如下:
SYSTEM: windows 7 sp1 32 bits
CPU: Intel(R) Atom(TM) CPU N2600 @ 1.6GHZ
MEMORY: 4G
经过测试发现在工控机上, 当速度设置为`fast`以下时, 一段时间内会占用较多CPU, 故而这里速度选择测试`fast`,和`veryfast`配置.

在实验室内cpu和内存占用:

<center>
<img src="fast_performance_in_lab.png" width="100%" height="100%">
</center>

<center>
<img src="veryfast_performance_in_lab.png" width="100%" height="100%">
</center>

在室外类似:
<center>
<img src="fast_performance_in_ec.png" width="100%" height="100%">
</center>

## 压缩率&精度
数据精度如下:

<center>
<img src="quality_in_lab.png" width="100%" height="100%">
</center>

<center>
<img src="quality_in_ec.png" width="100%" height="100%">
</center>

40帧的总数据量情况如下:
<center>
<img src="compress_ratio.png" width="100%" height="100%">
</center>


### 总结
在`speed=fast`的情况下，在工控机上的cpu和内存占用可以接受. 为了保证数据质量建议配置如下
室内:
>1. `speed=fast`, `crf=33`
>2. `speed=veryfast`, `crf=30`

室外+室外通用:

>`speed=fast`, `crf=35`

当前默认为通用配置, 可在`StarLoc3D.ini`的`RunMode`修改配置:
```ini
[RunMode]
lasser3d_compress_crf = 35
lasser3d_compress_speed = veryfast
lasser3d_compress_max_frame = 40
```