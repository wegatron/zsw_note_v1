## PS4 Graphics Basic

1. 资源
	* Texture
	* Buffer
	* Shader(VS/PS/CS)
	* Pipeline
	* Command Buffer/Queue
2. 命令
	* Resource Binding
	* Draw
	* Dispatch
	* Synchronization
3. 初始化
	* Window/Surface/Swapchain
	* Present/render loop
## PS4 - PS5
### **1. 硬件架构差异**

| **特性**    | **PS4 (Jaguar/GCN 1.0)** | **PS5 (Zen 2/RDNA 2)**            |
| --------- | ------------------------ | --------------------------------- |
| **GPU**   | 1.84 TFLOPS (18CU GCN)   | 10.3 TFLOPS (36CU RDNA2)          |
| **光线追踪**  | 无硬件支持                    | 专用 RT Core (加速BVH遍历/射线求交)         |
| **显存带宽**  | 176 GB/s (GDDR5)         | 448 GB/s (GDDR6)                  |
| **存储I/O** | 机械硬盘 (~100 MB/s)         | 定制 SSD (5.5 GB/s 原始, 8-9 GB/s 压缩) |
| **几何处理**  | 传统 VS/GS 管线              | 硬件级网格着色器 (Mesh Shaders)           |

---
### **2. 图形 API 核心区别**

#### **API 功能扩展**

- **PS4 (GNM/GNMX)**:
    - 基于 GCN 1.0 的固定功能管线
    - 手动管理资源同步 (如 `sceGxmFlushUniformBuffer`)
    - 传统资源绑定 (`register(c#)`)
- **PS5 (GNMX2)**:
    - **RDNA2 特性支持**:
        - 波前 (Wave32/Wave64) 优化
        - 异步计算队列重组 (更细粒度 CU 分配)
    - **新渲染管线**:
        - 光线追踪 API (`RT_AS_Build` 等)
        - 网格/放大着色器 (`[meshshader]`, `[amplificationshader]`)
    - **资源绑定**:
        - Bindless 资源 (Descriptor Heap)
        - 动态采样器反馈 (Sampler Feedback)

#### **着色器语言 (PSSL)**
使用了原版的hlsl, 对部分函数进行了重定义
```hlsl
// PS4 传统顶点着色器
#pragma PSSL target=gcn
void main(
    in float4 pos : POSITION,
    uniform sampler2D tex : register(s0)
) { ... }

// PS5 网格着色器示例
#pragma PSSL target=rdna2 wavesize=32
[meshshader(maxvertices=128)]
void MS_Main(
    out triangles MeshPayload payload
) {
    // 动态生成几何体
}
```
---

### **3. 内存与资源管理**

这里tls是什么??>? 对malloc进行了重载

- **PS4**:
    
    - 显存分 "Garlic" (快速) 和 "Onion" (慢速) 区域
    - 开发者需手动分配内存池 (`sceGxmMemoryMap`)
- **PS5**:
    
    - **统一内存架构** (LocalVRAM + SSD 直连)
    - **流式加载优化**:
        - Kraken 解压硬件加速
        - 通过 `PS5FileAsyncRead` 实现亚毫秒级纹理加载
    - **显存虚拟化** (Granularity 降低至 64KB)

---

### **4. 开发工具链差异**

| **工具**      | **PS4**                          | **PS5**                                          |
| ----------- | -------------------------------- | ------------------------------------------------ |
| **GPU 调试器** | Razor (基础命令跟踪)                   | Razor+ (支持RT Core和网格着色器可视化)                      |
| **性能分析**    | PlayStation Performance Analyzer | PS5 Profiler (集成 SSD I/O 延迟分析)                   |
| **帧捕获**     | 仅支持离线捕获 (`.razortrace`)          | 实时帧回放 + 光线追踪调试视图                                 |
| **底层API**   | GNM/GNMX                         | GNMX2(波前优化/异步计算队列重组/光线追踪/mesh shader/bindless/等) |

---

### **5. 性能优化关键点**

#### **PS4 瓶颈与对策**

- **瓶颈**: CPU 单线程性能弱 (Jaguar 核心)
- **优化**: 多线程渲染 (`sceGxmCreateRenderTarget` 分块并行)

#### **PS5 优化方向**

4. **光线追踪**:
    - 混合渲染管线 (传统 + RT)
    - 使用 `RT_AS_Compaction` 减少 BVH 内存占用
5. **几何处理**:
    - 用网格着色器替代传统 LOD 系统
6. **数据流**:
    - 利用 SSD 实现无级纹理流送 (`VirtualTextureStreaming` API)
7. **并行性**:
    - Wave32 优化 (RDNA2 下 Wave32 比 Wave64 效率更高)

