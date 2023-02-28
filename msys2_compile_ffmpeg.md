---
tag: programming_language/c++
---
## msys2 编译 ffmpeg for win32 visual studio 2013
所需工具
* Visual Studio 2013
* YASM
* [MSYS2](https://www.msys2.org/)
    ```bash
    pacman -Syu #两次, 更新所有包
    pacman -S make gcc diffutils #安装所需的编译工具
    mv [you_path]/usr/bin/link.exe [you_path]/usr/bin/link_ori.exe #将link改名, 防止误用
    pacman -S yasm # 安装yasm
    # 64位则安装对应toolchain
    # pacman -S mingw-w64-x86_64-toolchain
    pacman -S mingw-w64-i686-toolchain #安装编译所需toolchain for x264
    pacman -S nasm #安装编译所需 for x264
    ```

<!-- * [YASM](http://yasm.tortall.net/Download.html) (需要下载:for general use on 64-bit Windows)
    下载完后放入一个目录, 在环境变量设置阶段设置进去即可 -->

### 环境变量配置
根据官网的说法, 打开`msys2_shell.cmd`然后运行`C:\workspace\windows\msys64\msys_shell.bat`即可, 但尝试了不work. 
方法一:
1. 参考[1], 首先找到Visualstudio 2013的command prompt(若开始菜单中没有, 可找到Visual Studio 2013的快捷方式, 一般在同一文件夹下), 通过该prompt打开`msys2_shell.cmd`. 

2. 环境变量还是要手动设置. 根据Visualstudio 2013 command prompt中PATH的情况, 设置环境变量(去掉那些`%SYSTEM...%`, `;`改为`:`, 修改反斜杠等操作):
    ```bash
    export PATH="/c/Program Files (x86)/Microsoft Visual Studio 12.0/Common7/IDE/CommonExtensions/Microsoft/TestWindow:/c/Program Files (x86)/Microsoft SDKs/F#/3.1/Framework/v4.0/:/c/Program Files (x86)/MSBuild/12.0/bin:/c/Program Files (x86)/Microsoft Visual Studio 12.0/Common7/IDE/:/c/Program Files (x86)/Microsoft Visual Studio 12.0/VC/BIN:/c/Program Files (x86)/Microsoft Visual Studio 12.0/Common7/Tools:/c/Windows/Microsoft.NET/Framework/v4.0.30319:/c/Program Files (x86)/Microsoft Visual Studio 12.0/VC/VCPackages:/c/Program Files (x86)/HTML Help Workshop:/c/Program Files (x86)/Microsoft Visual Studio 12.0/Team Tools/Performance Tools:/c/Program Files (x86)/Windows Kits/8.1/bin/x86:/c/Program Files (x86)/Microsoft SDKs/Windows/v8.1A/bin/NETFX 4.5.1 Tools/:/c/Windows/system32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/System32/WindowsPowerShell/v1.0/:/c/Windows/System32/OpenSSH/:/c/Program Files/Microsoft SQL Server/110/Tools/Binn/:/c/Program Files/NVIDIA Corporation/NVIDIA NvDLISR:/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/e/win_exec/msys2_64/usr/bin":$PATH
    ```

方法二(参照[4]):
1. 将`msys2_shell.cmd`做如下改动:
    ```
    Among them:
    rem set MSYS2_PATH_TYPE=inherit
    The "rem" annotation is deleted and becomes:
    set MSYS2_PATH_TYPE=inherit
    ```
2. 在Visualstudio 2013的command prompt中执行如下命令
    ```bash
    #这里编译32位库, 若要编译64位库则为
    #msys2_shell.cmd -mingw64
    msys2_shell.cmd -mingw32
    ```

检查
```bash
link
# 输出如下:
# Microsoft (R) Incremental Linker Version 12.00.40629.0
# Copyright (C) Microsoft Corporation.  All rights reserved.
# usage: LINK [options] [files] [@commandfile]
# options:
# ...
cl
# 输出如下:
# Microsoft (R) C/C++ Optimizing Compiler Version 18.00.40629 for x86
# Copyright (C) Microsoft Corporation.  All rights reserved.
# usage: cl [ option... ] filename... [ /link linkoption... ]
```

## 编译ffmpeg
下载x264
```bash
git clone https://code.videolan.org/videolan/x264.git
git checkout -b stable remotes/origin/stable
```

编译x264
```bash
# 这里使用--host=i686-w64-mingw32与msys2_shell.cmd -mingw32对应
# 若要编译64位库, 则--host=x86_64-w64-mingw32
# 使用静态库无法编译过去
# ./configure --prefix=/usr/local/x264 --enable-static --enable-strip \ 
# --enable-pic --host=i686-w64-mingw32 --enable-shared
./configure --prefix=/usr/local/x264 --enable-strip \
--enable-pic --host=i686-w64-mingw32 --enable-shared --extra-ldflags=-Wl,--output-def=libx264.def
make
```
这里有个坑, 使用静态库时, 在config ffmpeg时会报错, 有些gcc的库需包含进来, 而ffmpeg默认是不包含的, 因此这里使用动态链接库.

编译ffmpeg
```bash
# 使用msvc toolchain编译相对简单
./configure --toolchain=msvc --enable-shared --enable-libx264 \
--prefix=tmp_install --enable-gpl --extra-cflags='-I/usr/local/x264/include' \
--extra-ldflags='-LIBPATH:/usr/local/x264/lib'
# make
make install -j
```

## Reference
[[1] msys2 compiler setting issue](https://github.com/telegramdesktop/tdesktop/issues/2704)
[[2] ffmpeg官网](https://pracucci.com/compile-ffmpeg-on-windows-with-visual-studio-compiler.html)
[[3] ffmpeg的centos、msys2、msvc编译](https://www.cnblogs.com/Bob-wei/p/8435000.html)
[[4] win10 msys2 vs2015 ffmpeg3.3.3 compiler](https://codar.club/blogs/win10-msys2-vs2015-ffmpeg3.3.3-compiler-with-x264-aac.html)
[[5] ⭐️window10 compile ffmpeg](https://www.jianshu.com/p/5f175dec9109)