---
tag: programming/tools
---

## ffmpeg decode video:

截取视频的前250帧输出视频:
```bash
ffmpeg -i input.mp4 -frames:v 250 output.mp4
```
每隔1秒, 将视频转化为图片:

```bash
ffmpeg -i input.mp4 -vf fps=1 out%03d.png
```

将图片序列转化为视频:

```bash
ffmpeg -framerate 30 -pattern_type glob -i '*.png' -c:v libx264 -pix_fmt yuv420p out.mp4
ffmpeg -framerate 30 -pattern_type sequence -start_number 108699 -i MySlate_15_iPhone_cal.%6d.jpeg -c:v libx264 -pix_fmt yuv420p out.mp4
```

ffmpeg 横向拼接视频:
```bash
ffmpeg \
    -i out1.mp4 \
    -i out2.mp4 \
    -filter_complex "[0:v]pad=iw*2:ih*1[a];[a][1:v]overlay=w" \
    out.mp4
```

ffmpeg 将mp4转化为gov
```
ffmpeg -i input.mp4 -c:v libtheora -q:v 7 -c:a libvorbis -q:a 4 output.ogv
```
列出大文件
```bash
find . -type f -size +100M
```

## gdown 下载google drive 文件

需要下载的链接: `https://drive.google.com/file/d/1jUB5yD7DP97-EqqU2A9mmr61JpNwZBVK/view`, 这里标志符为:`1jUB5yD7DP97-EqqU2A9mmr61JpNwZBVK`.

```bash
gdown https://drive.google.com/uc?id=标识符
```


对于大文件可能会出错, 使用如下方式下载:
```python
gdown.download(
    "https://drive.google.com/uc?export=download&confirm=pbef&id=1ghvzYXdmiCuX5I757id73jWuRLMCzXAX",
    "ckpt/00000189-checkpoint.pth.tar"
)
```

对于带有`confirm=t`的文件, 可以使用(curl支持断点续传):
```bash
curl -L -o data/my-file.h5 'https://drive.google.com/uc?id=my-file-id-here&confirm=t
```

## sed 修改文件

```bash
## -i表示edit files in place
# add line, 1i表示在第一行插入
sed -i '1i zzz' file

# remove line, 1d表示删除第一行
sed -i '1d' file

# 插入多行
sed -i '/the specific line/i \
#this\
##is my\
text' file

# 删除多行
sed -i 'M,Nd' file

# 字符串替换
sed -i 'M,Ns/old/new/g' file
```

scp拷贝文件

```bash
scp /path/to/file username@a:/path/to/destination
```

查询磁盘空间:

```bash
df -h
du -sh [dir] #查询目录空间占用
```