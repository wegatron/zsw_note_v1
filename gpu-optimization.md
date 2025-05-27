## Shader 的编译、加载和执行
* AOT 编译：
    * 定义：在程序运行前（如开发阶段或安装时）将高级代码（如 HLSL/GLSL）或中间表示（如 SPIR-V/DXIL）预先编译为目标 GPU 的本地机器码（如 NVIDIA PTX、AMD GCN/ROCm、Intel GPU ISA）。
    * 优点：减少运行时开销，提高性能稳定性。
    * 应用场景：游戏引擎的着色器预编译、移动端 GPU 驱动优化（如 Vulkan 的离线编译）。

* JIT 编译：
    * 定义：在程序运行时动态将中间表示（如 SPIR-V/DXIL）编译为目标 GPU 的本地机器码。
    * 优点：适配不同硬件（如不同型号的 GPU），支持动态分支优化。
    * 应用场景：Direct3D/Vulkan 运行时编译、复杂着色器动态优化。

## Uber Shader
多分支, 但事实上只执行一个分支, 存在的性能问题:
1. loop unrolling
    提取额外的指令级并行性
2. unused code removal
    需要分配所有的寄存器

* uniform buffer
    * GPU Memory
    * CPU Memory
        驱动层去支持编译优化
* specialization constants(vulkan)/Function specialization(metal)
    常量真正起作用的时间，是在驱动程式进行JIT编译时，不是在编译Shader中间字节码或者创建PSO时，所以这是一个需要驱动层支持的功能