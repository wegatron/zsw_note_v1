---
tag: programming_language/c++
---
# G++常用编译链接选项小记
G++编译选项可以在CMakeLists.txt中设置, 例如:
```cmake
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}  -Wall -march=native")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -march=native")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall -march=native")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -march=native")
```


## 链接配置项

## 编译性能优化选项
* `-march=native`
此选项可以让编译器根据本机器的cpu的架构信息, 进行指令集层次的优化, 构建专为此种cpu上运行的可执行程序(不同的cpu指令集不同). 例如, 启用AVX指令. `-mtune`也类似(在一些老的机器上使用之:i386 and i486), 不过更弱些, 不考虑指令集. 还有`-mcpu`则被废弃.

* `-O`
`-O`有七个等级: `-O0`, `-O1`, `-O2`, `-O3`, `-Os`, `-Og`, `-Ofast`.
`O2`: 推荐的优化级别, 开始使用AVX和SSE, 但默认不启用YMM寄存器.
`O3`: 最高的优化级别, 完全启用AVX和SSE, 并启用`-ftree-vectorize`, 一些循环被矢量化.

备注: 当下CMake默认Release默认使用`-O3`

[compiler Explorer](https://godbolt.org/) 用来分析编译产生的汇编代码

## 编译c++文件

# Reference
[15个常用的gcc 命令选项](https://blog.csdn.net/typename/article/details/8170213)
[gcc中-march与-arch的使用](https://blog.csdn.net/listener51/article/details/80468021)
[常用GCC 编译优化选项](https://wiki.gentoo.org/wiki/GCC_optimization/zh-cn)