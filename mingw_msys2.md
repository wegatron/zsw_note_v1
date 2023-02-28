---
tag: tools
---
# mingw + msys windows 配置
## 环境配置流程
1. 下载并更新msys2: https://www.msys2.org/
```bash
# 更新msys2
pacman -Syu
```
2. 安装mingw-w64-x64_x86/mingw-w64_i686
```bash
pacman -S base-devel mingw-w64-x86_64-toolchain nasm yasm
```
3. 启动编译命令行
* 启动VS Command Prompt:
```bash
# search 'command prompt' for vs 2017
C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Visual Studio 2012\Visual Studio Tools
# search 'visual studio tools' for vs 2013
C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\Shortcuts
```
* 启动msys环境
```bash
E:/win_exec/msys64/msys2_shell.cmd -mingw32 # or -ming64
# 设置环境变量
export PATH="/c/Program Files (x86)/Microsoft Visual Studio 12.0/VC/bin/":E:/win_exec/msys64/mingw32/bin:$PATH
```

## 相关说明
1. MinGW32和MinGW-w64
>MinGW32先开发，只能编译32位程序； 
>MinGW-w64从MinGW32发展而来，支持编译64和32位位程序，同时可以进行交叉编译。

2. MinGW-w64类型 
>x86_64: 支持在x64和x86上运行 
>i686: 支持在x86上运行

3. i386/i686/x86_64区别
>i386 适用于intel和AMD所有32位的cpu，以及采用X86架构的32的cpu。
>X86_64 适用于intel和AMD采用X86架构的64位cpu，兼容32位。
>I686 只是i386的一个子集,支持的cpu从Pentium 2 (686)开始,之前的型号不支持

## pacman 命令
```bash
pacman -S <packge-name>     # 安装软件
pacman -U <gz-file>         # 安装本地包，其扩展名为 pkg.tar.gz
pacman -Syu                 # 同步Msys2源，并更新 
pacman -Sy                  # 仅同步源 
pacman -Su                  # 更新系统
pacman -Sy <packge-name>    # 同步源后再安装软件
pacman -R <packge-name>     # 该命令将只删除包，不包含该包的依赖。
pacman -Rs <packge-name>    # 在删除包的同时，也将删除其依赖。
pacman -Rd <packge-name>    # 在删除包时不检查依赖。
pacman -Ss <keywords>       # 这将搜索含关键字的包。
pacman -Qi <packge-name>    # 查看有关包的信息。
```

## FFMPEG编译流程
### x264编译
```bash
./configure --prefix=../build --host=i686-w64-mingw32 --enable-shared --disable-thread --disable-avs --extra-ldflags=-Wl,--output-def=libx264.def
make install
# lib 文件生成
cp ./libx264.def ../build/lib/
cd ../build/lib
#若要生成64位lib文件则输入如下命令：
lib /machine:i386 /def:libx264.def
```

## Reference
[Msys2+MinGW-w64配置介绍](https://blog.csdn.net/yehuohan/article/details/52090282)
[win10下编译ffmpeg和x264](https://www.jianshu.com/p/5f175dec9109)