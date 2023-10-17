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

## sed 命令
sed 是一种在线编辑器，它一次处理一行内容.

```bash
sed [options] commands [inputfile...]
```

__options__

| 选项  | 作用 |
|------|------|
| -n | 使用安静(silent)模式。在一般 sed 的用法中，所有来自 STDIN 的数据一般都会被列出到终端上。但如果加上 -n 参数后，则只有经过sed 特殊处理的那一行(或者动作)才会被列出来 |
| -i  | 直接修改读取的文件内容, 而不是输出到终端 |
| -r | sed 的动作支持的是延伸型正规表示法的语法。(默认是基础正规表示法语法) |


__commands__
command 字符串编辑命令的组合.
| 选项  | 操作 |
|------|------|
| s | 替换(一般使用最多) |
| a | 新增 |
| d | 删除 |

__examples__

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
```bash
# 将当前目录下, 除了.git中的所有文件中的 TARGET_OS_OSX修改为TARGET_OS_MACCATALYST
# 这里g表示全部替换, 若是没有g, 则只替换一个/行
grep -rl "TARGET_OS_OSX" ./ --exclude-dir=.git | \
xargs sed -i 's/TARGET_OS_OSX/TARGET_OS_MACCATALYST/g'

grep -rl "SDKROOT = macosx" ./ --exclude-dir=.git | \
xargs sed -i 's/SDKROOT = macosx/SDKROOT = iphoneos/g'
```
## 不同文件多次执行
```bash
find ./ -name=project.pbxproj -exec git stage {} \;
```
## 同步文件内容
```bash
# -v verbose
# -r --recursive 对子目录以递归模式处理
# -u --update 仅仅进行更新, 也就是跳过所有已经存在于DST, 并且文件时间晚于要备份的文件, 不覆盖更新的文件.
rsync -vru [src] [dst]
```

gdb print long string
```bash
call (void)puts(stage._code)
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