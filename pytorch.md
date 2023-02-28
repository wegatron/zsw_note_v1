---
tag: programming_language/python
---
## 一、CUDA/cudnn/CUDA Toolkit/NVCC区别简介
* CUDA：为“GPU通用计算”构建的运算平台。
* CUDNN：为深度学习计算设计的软件库。
* CUDA Toolkit (nvidia)： CUDA完整的工具安装包，其中提供了 Nvidia 驱动程序、开发 CUDA 程序相关的开发工具包等可供安装的选项。包括 CUDA 程序的编译器、IDE、调试器等，CUDA 程序所对应的各式库文件以及它们的头文件.
* CUDA Toolkit (Pytorch)： CUDA不完整的工具安装包，其主要包含在使用 CUDA 相关的功能时所依赖的动态链接库。不会安装驱动程序。（NVCC 是CUDA的编译器，只是 CUDA Toolkit 中的一部分）。 可通过Anaconda安装.

## pytorch 安装

查看cuda版本, 根据cuda版本和所需pytorch版本安装pytorch.

```bash
nvcc --version
```

## Reference
[一文讲清楚CUDA、CUDA toolkit、CUDNN、NVCC关系](https://blog.csdn.net/qq_41094058/article/details/116207333)