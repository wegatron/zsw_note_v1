---
tag: tools
---
## Nvidia GPU Architecture

![](rc/nvidia-gpu-architecture.png)

Pascal: GTX 10x0系列
Turing: GTX 16x0系列, GTX 20x0系列, T4(colab)
Ampere: GTX 30x0系列
Ada Lovelace: GTX40x0系列


## cuda

* CUDA是显卡厂商NVIDIA推出的运算平台。CUDA™是一种由NVIDIA推出的通用并行计算架构，是一种并行计算平台和编程模型，该架构使GPU能够解决复杂的计算问题。CUDA英文全称是Compute Unified Device Architecture。

* CUDA Toolkit 主要包含了CUDA-C和CUDA-C++编译器(NVCC)、一些科学库和实用程序库、CUDA和library API的代码示例、和一些CUDA开发工具。

* cuDNN 全称为NVIDIA CUDA® Deep Neural Network library，是NVIDIA专门针对深度神经网络中的基础操作而设计基于GPU的加速库。

根据官方文档, cuda与需要与显卡驱动相兼容(cuda用到了显卡驱动中的动态库). 

ubuntu install cuda 11.5(在我本地的机器上, 显卡驱动会自动切换到495, 切换回更高级则会卸载cuda):

```bash
# https://developer.nvidia.com/cuda-11-5-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.5.0/local_installers/cuda-repo-ubuntu2004-11-5-local_11.5.0-495.29.05-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-5-local_11.5.0-495.29.05-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-5-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
```


## Reference
[NVIDA GPU架构演进(2022年更新)])(https://blog.csdn.net/daijingxin/article/details/115042353)
[CUDA Compatibility](https://docs.nvidia.com/deploy/cuda-compatibility/index.html)