---
tag: projects
---

# 激光数据压缩算法
## 需求目标
每天5000m, 数据量小于400MB, 0.3m一帧, 共16667帧, 要求:24kb/fps;
40帧数据量小于960kb, 156kb的头部, 剩下的数据不得超过804kb
性能要求: 2.6fps(最快速度0.8m/s, 每0.3米一帧), 工控机 cpu峰值<+10%
精度要求: n_diff<1000, diff>0.02m

## 算法调研
* 将激光数据转化为RangeImage, 再用图像的压缩方法压缩数据.
[Effective Compression of Range Data Streams](http://www2.informatik.uni-freiburg.de/~stachnis/pdf/nenci14iros.pdf) [h.264视频压缩]
3D Point Cloud Compression using Conventional Image Compression for Efficient Data Transmission [全景图片压缩]

* 点云的形式压缩
Real-time compression of point cloud streams [octree]

* 其他方法
Compact encoding of robot-generated 3d maps for effcient wireless transmission
A novel real time algorithm for remote sensing lossless data compression based on enhanced dpcm

基于激光数据本身的特性(多线旋转), 我们认为将其转化为range image并采用视频的压缩方式(利用时间空间相关性), 可以尽可能地减少数据量. 经过调查, h264视频压缩方式具有较高的压缩比和性能.

## h.264压缩
由于激光数据需要两个字节来存储深度信息, 而x.264只能压缩一个字节/每像素的图片序列, 故而将深度信息拆分为高位和低位两部分, 分别压缩:
```c++
/**
 * \brief split the laser data into two range image.
 * As depth data from typical range sensor requires 2byte to store distance, but x.264 only support 1byte per pixel.
 * So split the depth data as high and low part then x.264 can be used to compress the data.
 * \param depth depth data, 1800 x 16 by default
 * \param high high part of the depth data
 * \param low low part of the depth data
 */
void split_high_low(
	const std::vector<unsigned short> &depth,
	std::vector<unsigned char> &high,
	std::vector<unsigned char> &low);
```

### h264 第三方库的选择
* x264
    * 号称最好的h264编码库
    * 只提供了编码算法, 解码算法需要使用另外的库如FFmpeg
    * 网上能找到相关使用的方法, 但资料不多
* FFmpeg
    * 包含了各种编码解码算法(包括x264), 提供了统一的接口
    * example相对更多

这里, 使用预编译的FFmpeg库, 编译FFmpeg需要用mingw配置过程复杂.
FFmpeg windows prebuild version(已经包含libx264)
从官网下载: ffmpeg-4.1-win64-dev.zip(开发所需的头文件和export lib), ffmpeg-4.1-win64-shared.zip(动态库)

#### 一些参考过的资料

>使用统一的封装进行encode和decode, FFmpeg-libavcodec(支持x.264).
https://stackoverflow.com/questions/3553003/how-to-encode-h-264-with-libavcodec-x264
https://ffmpeg.org/doxygen/trunk/encode__video_8c_source.html
https://code.i-harness.com/en/q/3636eb
https://stackoverflow.com/questions/27870545/decode-h264-video-using-libavcodec-c
windows下编译ffmpeg和x264
https://www.jianshu.com/p/5f175dec9109
windows下vs版本的x264
https://github.com/ShiftMediaProject/x264/releases
直接使用x264进行压缩
https://stackoverflow.com/questions/2940671/how-does-one-encode-a-series-of-images-into-h264-using-the-x264-c-api
编码加速
https://stackoverflow.com/questions/12257328/speeding-up-x264-encoding-c-code-with-libavcodec?rq=1
x264相关参数
https://trac.ffmpeg.org/wiki/Encode/H.264
https://lists.ffmpeg.org/pipermail/libav-user/2015-April/008027.html

压缩解压精度损失对比
直接对比两张组合在一起的range_image的depth即可.


### Imp & Test

### 实现接口
激光数据压缩类, 初始化时设置好长、宽, 和crf值等参数, 然后可以调用`encode_one_frame`函数, 将一张深度图编码到视频文件中, 当该类析构时, 写出文件.
```c++
class h264_encoder_ffmpeg final
{
public:
	/**
	 * \brief constructor of h264 lasser3d range image encoder
	 * \param width vertical angle numbers
	 * \param height horizontal angle numbers
	 * \param crf crf value of h264
	 * \param speed_setting ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow
	 * \param file_path output h264 file path
	 */
	h264_encoder_ffmpeg(const int width, const int height, const int crf, const std::string &speed_setting, const std::string &file_path);

	/**
	 * \brief encode range image, one byte per pixel
	 * \param data pixel data
	 */
	void encode_one_frame(unsigned char *data);

	/**
	 * \brief deconstruct the encoder, write the final frame close the file. 
	 */
	~h264_encoder_ffmpeg();
	int width_; //!< vertical angle numbers
	int height_; //!< horizontal angle numbers
private:
	int frame_id_;
	int crf_; //!< h264 crf value in (0, ), 0 for high byte, and 20 is suggested for low byte.
	std::string file_path_; //!< h264 file path
	bool init_suc_; //!< for check if init is success
	AVCodecContext *c_;
	FILE *f_;
	AVPacket *pkt_;
	AVFrame * frame_;
};
```

激光数据压缩, 对外接口, 将系统中的3d激光数据转化为高位和低位的`range image`, 然后利用`h264_encoder_ffmpeg`进行编码, 每隔一段时间新启h264文件进行写出(防止意外状况导致数据不可用).
```c++
class lasser3d_packer final
{
public:
	lasser3d_packer(const int time_elapse, const int low_crf, 
		const std::string &speed_setting, const std::string &file_dir);
	void pack(Laser3dSensorDataChannelPolar* laser3d_polar_data);
	void set_file_dir(const std::string &file_dir) { file_dir_ = file_dir; }
private:
	void check_write_new_file();
	void init_new_file();
	// head info
	std::ofstream head_ofs_;
	// lasser3d range image compress
	int width_;
	int height_;
	int low_crf_; //!< crf value of low byte
	int time_elapse_; //!< time elapse for one h264 file, in milliseconds
	std::chrono::high_resolution_clock::time_point start_time_; //!< time point of the first frame
	std::unique_ptr<h264_encoder_ffmpeg> high_encoder_;
	std::unique_ptr<h264_encoder_ffmpeg> low_encoder_;
	std::string speed_setting_;
	std::string file_dir_;
	int file_id_;
};

```

### Performance
测试: ①压缩率; ②数据损失程度; ③性能.
测试方法: 
1. 使用构图软件, 按照0.3米或旋转10°采集一帧的方式, 采集了实验室内和东信科技园内的激光数据. 使用不同的参数进行对数据进行压缩, 记录不同参数下数据的精度以及压缩率.

2. 集成到定位软件中, 在实验室内和东信科技园内, 以不同的参数跑定位, 记录CPU和内存的使用情况.

#### 工控机CPU和内存占用
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

在室外性能类似:
<center>
<img src="fast_performance_in_ec.png" width="100%" height="100%">
</center>

#### 压缩率&精度
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

## Reference & Resources
[关于x.264的使用](
https://stackoverflow.com/questions/2940671/how-does-one-encode-a-series-of-images-into-h264-using-the-x264-c-api)
[YUV420的介绍](https://en.wikipedia.org/wiki/YUV#Y%E2%80%B2UV420p_(and_Y%E2%80%B2V12_or_YV12)_to_RGB888_conversion)
[x264 prebuild library](https://github.com/ShiftMediaProject/x264/releases)
[FFempeg-libavcodec的使用(封装了各种codec包括x264)](https://ffmpeg.org/doxygen/trunk/encode__video_8c_source.html)