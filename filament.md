---
tag: summary/code_note
---
## filament 源码分析

### 编译
编译前需要安装 libc++, libc++abi
Android
```bash
cmake ../../ -DCMAKE_TOOLCHAIN_FILE=/home/wegatron/opt/android_sdk/ndk/21.4.7075529/build/cmake/android.toolchain.cmake -DANDROID_PLATFORM=android-30 -DANDROID_NDK=/home/wegatron/opt/android_sdk/ndk/21.4.7075529 -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI="arm64-v8a" -DCMAKE_INSTALL_PREFIX="/home/wegatron/win-data/usr/android"
```

修改`filament/backend/CMakeLists.txt`

```cmake
if (EGL OR ANDROID)
        list(APPEND SRCS src/opengl/platforms/PlatformEGL.cpp)
endif()
```

Linux:
```bash
cmake -S . -B build_linux -DCMAKE_C_COMPILER=clang-12 -DCMAKE_CXX_COMPILER=clang-12
```
修改CMakeLists.txt, 添加:
```cmake
add_link_options(-stdlib=libc++)
add_link_options(-lm)
add_compile_options(-stdlib=libc++)
```
### filament android使用
demo: https://github.com/k-konovalov/Android-Filament-C-Example/blob/main/app_filament_980/src/main/cpp/hello_filament.cpp

### filament overview

filament整体架构:
![[rc/filament_structure.svg]]

第一层 [工具、example、App]
* Tools主要是材质或模型的处理优化工具. 比如: 材质编译工具`matc`, 材质编辑器`tungsten`(未有成熟的Release).

第二层 [用户接口]
* Engine, 虚拟渲染资源创建销毁管理, 并利用JobSystem, 发送命令到下一层.
* Virtual Rendering Resource, 虚拟渲染资源.
* 场景级别的抽象, 包括View(后处理如抗锯齿、雾等, Viewport, Camera等), Scene(场景中的物体), Entity(被绘制的物体+light等).

第三层 [支撑组件]
* Backend/RHI
    * Platform 系统和窗口的抽象
    * Rendering Resource/Setting抽象, 例如: Texture, Buffer, SwapChain, RenderTarget
    * Driver 创建销毁渲染资源
    * Context 跟踪管理渲染资源以及渲染状态设置. Vulkan/Metal(数据Device, CommandQueue...), OpenGl(OpenGL状态控制).
* Frame Graph 渲染帧图, 一帧渲染的整个pipline.
* Material 材质的定义和解析
* JobSystem 任务系统

除了此部分之外, 对于Android, 还有特定的JNI导出`android/filament-android`.

### ECS 系统
参考: [Filament解析4·ECS](https://zhuanlan.zhihu.com/p/144543664)
#### 构建模式——规约
对外可见的类(接口)不包含真正实现, 由F开头的同名类进行实现.
接口、实现分离, 隐藏了细节. 很好地支持动态链接, 后续的改动不需要重新编译链接.
```c++
class XXX : public FailamentAPI
{
public:
	// builder 用来记录创建XXX对象所需的配置参数
	// 配置参数保存在struct BuilderDetails中
	// BuilderBase中包含BuilderDetails的属性
	// BuilderDetails在FXXX的cpp中定义, 外部不可见
	class Builder : public BuilderBase<BuilderDetails>
	{
		// 各种设置参数的函数
		Builder &YYY();
		...
		
		// 根据Builder中设置的配置参数, 构建XXX对象
		// 由引擎去调用XXXManager的create函数
		// 最终会调用FXXX的create函数
		Result build(Engine& engine, utils::Entity entity);
	};

};

class FXXX : public XXX
{
public:
	// 真正创建 Entity (ECS模式)
	void create(
        const XXX::Builder& UTILS_RESTRICT builder,
        Entity entity);
};
```
#### ECS entity的创建
```c++
// 由EntityManager负责Entity的创建和销毁
// Entity只是一个全局唯一的id
class EntityManager
{
public:
	void create(size_t n, Entity* entities);
	void destroy(size_t n, Entity* entities);
};

// 在filament中有四种entity, 对应于engine中的四个Manager
class FEngine : public Engine
{
public:
	...
private:
	FRenderableManager mRenderableManager;
    FTransformManager mTransformManager;
    FLightManager mLightManager;
    FCameraManager mCameraManager;
};

// 以FRenderableManager为例
class FRenderableManager
{
public:

	// free-up all resources
	void terminate() noexcept;

	// 由engine调用, 垃圾回收
	// 删除死亡的entity, 所拥有的component
	void gc(utils::EntityManager& em) noexcept;

	// 删除entity拥有的component
	void destroy(utils::Entity e) noexcept;

	void create(const RenderableManager::Builder& builder, 
				utils::Entity entity);
	
	bool hasComponent(utils::Entity e) const noexcept {
		return mManager.hasComponent(e);
	}

	// 在manager的map中查询是否存在该entity, 若存在, 返回index
	// 不存在返回0
	Instance getInstance(utils::Entity e) const noexcept {
		return mManager.getInstance(e);
	}
};
```
FRenderableManager创建entity
```c++
void FRenderableManager::create(
    const RenderableManager::Builder& UTILS_RESTRICT builder,
    Entity entity) {
    ...
	// 添加一个新的entity
    Instance ci = manager.addComponent(entity);

	// 添加components
	setPrimitives(ci, { rp, size_type(entryCount) });
	...
}
```
在FRenderableManager中, Sim类定义了该类entity所能够拥有的component类型:
```c++
using Base = utils::SingleInstanceComponentManager<
    Box,                             // AABB
    uint8_t,                         // LAYERS
    MorphWeights,                    // MORPH_WEIGHTS
    uint8_t,                         // CHANNELS
    uint16_t,                        // INSTANCE_COUNT
    Visibility,                      // VISIBILITY
    utils::Slice<FRenderPrimitive>,  // PRIMITIVES
    Bones,                           // BONES
    utils::Slice<MorphTargets>       // MORPH_TARGETS
>;

struct Sim : public Base {
    using Base::gc;
    using Base::swap;
    ...
};
```

#### ECS 系统的更新
将entity加入到场景中
```c++
void FScene::addEntity(Entity entity) {
    mEntities.insert(entity);
}
```

当renderJob运行时会进入到FScene::prepare. 
遍历场景中所有alive的entity, 并将数据更新到mRenderableData(SOA数据结构)中.
```c++
void FScene::prepare(const mat4& worldOriginTransform, bool shadowReceiversAreCasters) noexcept {
// TODO: can we skip this in most cases? Since we rely on indices staying the same,
// we could only skip, if nothing changed in the RCM.
FEngine& engine = mEngine;
EntityManager& em = engine.getEntityManager();
FRenderableManager& rcm = engine.getRenderableManager();
FTransformManager& tcm = engine.getTransformManager();
FLightManager& lcm = engine.getLightManager();
// go through the list of entities, and gather the data of those that are renderables
auto& sceneData = mRenderableData;
auto& lightData = mLightData;
auto const& entities = mEntities;

...

for (Entity e : entities) {
    if (!em.isAlive(e)) {
        continue;
    }
    // we know there is enough space in the array
    sceneData.push_back_unsafe(
        ri,                             // RENDERABLE_INSTANCE
        worldTransform,                 // WORLD_TRANSFORM
        visibility,                     // VISIBILITY_STATE
        rcm.getSkinningBufferInfo(ri),  // SKINNING_BUFFER
        rcm.getMorphingBufferInfo(ri),  // MORPHING_BUFFER
        worldAABB.center,               // WORLD_AABB_CENTER
        0,                              // VISIBLE_MASK
        rcm.getChannels(ri),            // CHANNELS
        rcm.getInstanceCount(ri),       // INSTANCE_COUNT
        rcm.getLayerMask(ri),           // LAYERS
        worldAABB.halfExtent,           // WORLD_AABB_EXTENT
        {},                             // PRIMITIVES
        0,                              // SUMMED_PRIMITIVE_COUNT
        {},                             // UBO
        scale                           // USER_DATA
    );        
}    
}
```

这里sceneData是一个SOA数据结构
```c++
using RenderableSoa = utils::StructureOfArrays<
  utils::EntityInstance<RenderableManager>,   // RENDERABLE_INSTANCE
  math::mat4f,                                // WORLD_TRANSFORM
  FRenderableManager::Visibility,             // VISIBILITY_STATE
  FRenderableManager::SkinningBindingInfo,    // SKINNING_BUFFER
  FRenderableManager::MorphingBindingInfo,    // MORPHING_BUFFER
  math::float3,                               // WORLD_AABB_CENTER
  VisibleMaskType,                            // VISIBLE_MASK
  uint8_t,                                    // CHANNELS
  uint16_t,                                   // INSTANCE_COUNT
  uint8_t,                                    // LAYERS
  math::float3,                               // WORLD_AABB_EXTENT
  utils::Slice<FRenderPrimitive>,             // PRIMITIVES
  uint32_t,                                   // SUMMED_PRIMITIVE_COUNT
  PerRenderableData,                          // UBO
  // FIXME: We need a better way to handle this
  float                                       // USER_DATA
  >;
```

[filament SOA的数据结构](https://blog.csdn.net/qq_16555407/article/details/123619365)(代码较为复杂, 简单的可以是一个struct有数量相同的各种类型的array). 为了支持多种类型的数据渲染, 可以包含不同类型的RenderableSoa.



### 🍉 FrameGraph

#### 渲染循环

有app::run调用渲染主循环. 首先进行渲染准备.包括:
1. 遍历entity, 抽取渲染数据 renderableSOA
2. 对renderable进行可见性剔除.
3. 关照数据准备(包括更新光照的uniform, IBL设置等)
![[Pasted image 20230804181856.png]]


```c++
void FRenderer::renderJob(ArenaScope& arena, FView& view) {
    ...
    // 
    view.prepare(engine, driver, arena, svp, cameraInfo, getShaderUserTime(), needsAlphaChannel);  
}
```

### 主体库 filament [第二层]

不同层次渲染数据以及其管理的抽象. 

![[rc/filament_source_structure_src_detail.png]]

#### 细说Material

官方文档第4小节, 专门介绍, 材料的文件格式`.filament`. JSON类似文件格式, 允许c++注释+key没有双引号. 包含`material`, `vertex`, `fragment`三部分.
在写filament中, 还定义了一些额外常用的API, 如`getTime()`见文档4.5节.

一个例子:

```json
material {
    name : "Textured material",
    parameters : [ //这里表示input uniform参数
        {
           type : sampler2d,
           name : texture
        },
        {
           type : float,
           name : metallic
        },
        {
            type : float,
            name : roughness
        }
    ],
    requires : [
        uv0
    ],
    shadingModel : lit, // 光照模式
    blending : opaque // 混合模式
}

fragment {
    void material(inout MaterialInputs material) {
        prepareMaterial(material); // 初始化 4.4.1
        material.baseColor = texture(materialParams_texture, getUV0());
        material.metallic = materialParams.metallic;
        material.roughness = materialParams.roughness;
    }
}
```

`matc`工具用来编译和验证`.filament`材质文件, 输出`.mat`文件. `matc`的一些参数:

| Flag | Value | Usage |
| ---- | ---- | ---- |
| __-o, --output__ | [path] | Specify the output file path |
| __-p, --platform__ | desktop/mobile/all | Select the target platform(s) |
| __-a, --api__ | opengl/vulkan/metal/all | Specify the target graphics API |
| __-S, --optimize-size__ | N/A | 不仅做性能优化, 且做文件大小优化 |
| __-r, --reflect__ | parameters | 将参数解析出来以JSON格式打印输出 |

Material在编译之后, 其实是成为了一个二进制的键值对. 在解析时`MaterialParser`通过库`filflat`, 来解析出数据. 根据解析的数据, 构建`FMaterial`.

```c++
class FMaterial : public Material {
    FMaterial(FEngine& engine, const Material::Builder& builder); // 参数的设置
    backend::Handle<backend::HwProgram> getProgram(uint8_t variantKey) const noexcept; // shader
}
```

__TODO Question: 对于有多个pass的material如何处理?__

### Backend/RHI

backend包括两部分:

* 图形渲染API抽象
    * Engine, 用户调用接口. 生成命令提交给JobSystem.
    * Context, 上下文(图形资源、图形CommandQueue, CommandBuffer, State, SwapChain等).
    * Driver, 图形API抽象调用(创建/销毁抽象的图形资源、状态设置)
    * 资源抽象 图形资源的封装

* 平台窗口系统中间层抽象
    平台窗口系统中间抽象, 在各个platform*.*中定义和实现.    

![[rc/filament_backend.png | 300]]![[rc/filament_backend_opengl.jpg|300]]

#### 初始化

在filament中, `opengl context`, `vulkan/metal device`是怎么创建的?

在platform中封装了各个平台+窗口系统下, 各个图形API Driver的创建和销毁. 其中, Opengl由于其设计思想比较古老, 还添加了swapchain以及makecurrent等函数.

![[rc/filament_platform.svg]]

几个重要的platform:
* PlatformWGL中, platform在创建的时候直接创建窗口, 并得到窗口的opengl context.

* PlatformEGLAndroid

* PlatformVkWindows, 

* PlatformVkAndroid

* platformMetal, 直接创建Device.


🍉 在PC(Windows/Linux/MAC)上, vulkan/opengl虽然链接的库不同, 但其有统一的标准. filament使用bluevk, blueopengl实现运行时加载.
动态加载动态库可以得到函数名和指针, 为了在使用时无差别, 使用汇编伪指令定义了每个opengl api函数. 对于移动端(ios/android)则任然使用各自的头文件.

```c++
struct {
    void** api_call;
    const char* api_name;
} g_gl_stubs[] = {
    { &__blue_glCore_glMultiDrawArraysIndirectBindlessCountNV, "glMultiDrawArraysIndirectBindlessCountNV" },
    { &__blue_glCore_glCopyTexImage1D, "glCopyTexImage1D" },
...
};

for (unsigned int i = 0; i < blueCoreNumFunctions; i++) {
    *g_gl_stubs[i].api_call = loadFunction(g_gl_stubs[i].api_name);
    ...
}
```

```
extrn __blue_glCore_glMultiDrawArraysIndirectBindlessCountNV: qword
glMultiDrawArraysIndirectBindlessCountNV proc
    mov r11, __blue_glCore_glMultiDrawArraysIndirectBindlessCountNV
    jmp r11
glMultiDrawArraysIndirectBindlessCountNV endp
```

🥝 这个地方自动生成各个函数指针定义, 以及加载的代码是不是更通熟易懂?

在创建了platform之后, 再使用OpenGLDriverFactory根据platform和context, 创建Driver. Driver图形API的真正抽象.

![[rc/filament_rendering_resources_class.svg]]


#### 资源创建

资源创建的过程:

![[rc/filament_rendering_resource.svg]]

在引擎构建时, 创建一个driver线程, 在该线程内相关图形API命令(execute函数).

```c++
FEngine* FEngine::create(Backend backend, Platform* platform, void* sharedGLContext) {
    ...
    // start the driver thread
    instance->mDriverThread = std::thread(&FEngine::loop, instance);

    // wait for the driver to be ready
    instance->mDriverBarrier.await();
    ...
}

int FEngine::loop() {
    ...
    while (true) {
        // looks like thread affinity needs to be reset regularly (on Android)
        JobSystem::setThreadAffinityById(id);
        if (!execute()) {
            break;
        }
    }
    ...    
}

bool FEngine::execute() {
    // wait until we get command buffers to be executed (or thread exit requested)
    auto buffers = mCommandBufferQueue.waitForCommands();
    if (UTILS_UNLIKELY(buffers.empty())) {
        return false;
    }

    // execute all command buffers
    for (auto& item : buffers) {
        if (UTILS_LIKELY(item.begin)) {
            mCommandStream.execute(item.begin);
            mCommandBufferQueue.releaseBuffer(item);
        }
    }

    return true;    
}
```

在filament中, 大部分操作都需要用到`Engine`, 调用其相关函数, 但仔细看代码可以发现, `Engine`类其实只是构建了虚拟的资源, 并不真正干活.

```c++
template <typename T>
inline T* FEngine::create(ResourceList<T>& list, typename T::Builder const& builder) noexcept {
    T* p = mHeapAllocator.make<T>(*this, builder);
    list.insert(p);
    return p;
}
```

🍉 这个地方咋一看, 申请虚拟资源就完了, 看CommandQueue, 也找不到其怎么将command存入的地方.
以前看到的的任务队列都是标准的生产者消费者模式, 有一个push任务的接口, 一个执行任务的线程.

这里, 使用`CircularBuffer`, 命令被暂存在buffer中, 当执行`CommandQueue::flush`时, 将buffer中的命令才被加入任务队列(CommandQueue只允许单个线程往里边放任务和flush).

```c++
// 在虚拟的图形资源中会往buffer中添加相关命令
FVertexBuffer::FVertexBuffer(FEngine& engine, const VertexBuffer::Builder& builder)
{
    ...
    FEngine::DriverApi& driver = engine.getDriverApi(); // 这里driver是CommandStream
    mHandle = driver.createVertexBuffer(
            mBufferCount, attributeCount, mVertexCount, attributeArray, backend::BufferUsage::STATIC);    
    ...
}

// CommandStream以CircleBuffer的数据来源
void FEngine::init() {
    ...
    mCommandStream = CommandStream(*mDriver, mCommandBufferQueue.getCircularBuffer());
    ...
}

// 将buffer中的命令放入queue
void CommandBufferQueue::flush() noexcept {
    SYSTRACE_CALL();

    CircularBuffer& circularBuffer = mCircularBuffer;
    
    // end of this slice
    void* const head = circularBuffer.getHead();

    // beginning of this slice
    void* const tail = circularBuffer.getTail();

    std::unique_lock<utils::Mutex> lock(mLock);
    mCommandBuffersToExecute.push_back({ tail, head });
    ...
}
```

在Driver的类中, 定义了图形资源的handler
```c++
class OpenGLDriver final : public backend::DriverBase {
    ...
    struct GLVertexBuffer : public backend::HwVertexBuffer {
        using HwVertexBuffer::HwVertexBuffer;
        struct {
            // 4 * MAX_VERTEX_ATTRIBUTE_COUNT bytes
            std::array<GLuint, backend::MAX_VERTEX_ATTRIBUTE_COUNT> buffers{};
        } gl;
    };
};
```

```c++
FVertexBuffer::FVertexBuffer(FEngine& engine, const VertexBuffer::Builder& builder)
{
    FEngine::DriverApi& driver = engine.getDriverApi();
    mHandle = driver.createVertexBuffer(
            mBufferCount, attributeCount, mVertexCount, attributeArray, backend::BufferUsage::STATIC);
}

// 真实的createVertexBuffer函数展开后如下.
// 每一层的抽象图形API都有自己的一套实现方式, 直到真正的XXXDriver.cpp
VertexBufferHandle createVertexBuffer(uint8_t bufferCount, uint8_t attributeCount, uint32_t vertexCount,
                                      AttributeArray attributes, BufferUsage usage)
{
    mDriver->debugCommand("createVertexBuffer");
    VertexBufferHandle result = mDriver->createVertexBufferS();
    using Cmd = CommandType<decltype(&Driver::createVertexBufferR)>::Command<&Driver::createVertexBufferR>;

    // 在创建命令时已经把命令放入command buffer
    void* const p = allocateCommand(CommandBase::align(sizeof(Cmd)));
    new(p) Cmd(mDispatcher->createVertexBuffer_, // 函数指针
                VertexBufferHandle(result), std::move(bufferCount), std::move(attributeCount), std::move(vertexCount),
                std::move(attributes), std::move(usage));
    return result;
}
```

#### 资源使用

#### 其他

* 🥝 filament的RHI设计感觉有点复杂. 其中包括了系统平台的统一以及图形API的统一. 而Qt有其天然的优势: 早就统一了系统和窗口平台(此部分不用关注), 因此其RHI的设计相对独、清晰.

* filament如何编译android/ios版本? 在cmake时使用特定的toolchain. 在代码的Windows.md中有详细说明.

* 如何区分OpenGL和OpenGLES的? OpenGL和OpenGL ES函数相同, 只是库不一样.


### JobSystem

在`Engine`构建时, 根据系统配置, 自动创建`JobSystem`. JobSystem构成一颗树结构, 只有子任务全部结束后, 父任务才算结束.
```c++
// userThreadCount = 0, adoptableThreadsCount = 1
JobSystem::JobSystem(const size_t userThreadCount, const size_t adoptableThreadsCount)
{
    if (threadPoolCount == 0) {
        // default value, system dependant
        int hwThreads = std::thread::hardware_concurrency();
        if (UTILS_HAS_HYPER_THREADING) {
            // For now we avoid using HT, this simplifies profiling.
            // TODO: figure-out what to do with Hyper-threading
            // since we assumed HT, always round-up to an even number of cores (to play it safe)
            hwThreads = (hwThreads + 1) / 2;
        }
        // make sure we have at least one thread in the thread pool
        hwThreads = std::max(2, hwThreads);
        // one of the thread will be the user thread
        threadPoolCount = hwThreads - 1;
    }

    #pragma nounroll
    for (size_t i = 0, n = states.size(); i < n; i++) {
        ...
        if (i < hardwareThreadCount) {
            // don't start a thread of adoptable thread slots
            state.thread = std::thread(&JobSystem::loop, this, &state);
        }        
    }
}

// 使用
{
    auto *prepareVisibleLightsJob = js.runAndRetain(js.createJob(nullptr,
        [&frustum = mCullingFrustum, &engine, scene](JobSystem& js, JobSystem::Job*) {
            FView::prepareVisibleLights(
                engine.getLightManager(), js, frustum, scene->getLightData());
    }));
    js.waitAndRelease(prepareVisibleLightsJob);
}
```

__filament中的渲染资源创建和销毁则通过command, 在engine中开启了一个单独的线程处理.__

### 🍉 内存管理

为什么不用c++默认的内存管理方式? $\to$ [游戏引擎开发新感觉！(6) c++17内存管理](https://zhuanlan.zhihu.com/p/96089089)

Memory Areana, 一块巨大连续的内存, 申请一次, 多次使用(CPU, GPU均有此优化的思想).

> An arena is just a large, contiguous piece of memory that you allocate once and then use to manage memory manually by handing out parts of that memory. 

__new operator和operator new__

new operator类似于`malloc`用来申请内存, 可以被重载. 而operator new, 除了申请内存外, 还执行类对象的构造函数.

#### 内存对齐
refer to advance_c++_skills.md

#### 自主管理内存
```c++
// file allocators.h
#ifndef NDEBUG

// on Debug builds, HeapAllocatorArena needs LockingPolicy::Mutex because it uses a
// TrackingPolicy, which needs to be synchronized.
using HeapAllocatorArena = utils::Arena<
        utils::HeapAllocator,
        utils::LockingPolicy::Mutex,
        utils::TrackingPolicy::DebugAndHighWatermark>;

using LinearAllocatorArena = utils::Arena<
        utils::LinearAllocator,
        utils::LockingPolicy::NoLock,
        utils::TrackingPolicy::DebugAndHighWatermark>;

#else

// on Release builds, HeapAllocatorArena doesn't need a LockingPolicy because HeapAllocator is
// intrinsically synchronized as it relies on heap allocations (i.e.: malloc/free)
using HeapAllocatorArena = utils::Arena<
        utils::HeapAllocator,
        utils::LockingPolicy::NoLock>;

using LinearAllocatorArena = utils::Arena<
        utils::LinearAllocator,
        utils::LockingPolicy::NoLock>;

#endif
```

定义了3中allocator:

* `LinearAllocator` 比如command
    * 申请的内存地址线性递增. (在初始化时申请了一大块内存buffer).
    * 类似栈的方式(内存只能从顶部开始释放), 后申请的内存要先被释放.
    
* `HeapAllocator`
    使用系统的malloc和free, 在堆上申请和释放内存.

* `PoolAllocator`.
    用来分配小于指定大小的内存块. 允许无序释放.

⚠️ allocator在释放内存时, 不执行析构函数. 如何防止内存泄漏?

Trivial destructor
The destructor for class T is trivial if all of the following is true:

* The destructor is not user-provided (meaning, it is either implicitly declared, or explicitly defined as defaulted on its first declaration)
* The destructor is not virtual (that is, the base class destructor is not virtual)
* All direct base classes have trivial destructors
* All non-static data members of class type (or array of class type) have trivial destructors

A trivial destructor is a destructor that performs no action. Objects with trivial destructors don't require a delete-expression and may be disposed of by simply deallocating their storage. All data types compatible with the C language (POD types) are trivially destructible.

在ArenaScope于析构函数不是trival destructor的类需要执行析构函数.

```c++
// std::is_trivially_destructible<T>::value
if (std::is_trivially_destructible<T>::value) {
    o = mArena.template make<T, ALIGN>(std::forward<ARGS>(args)...);
    } else {
        void* const p = (Finalizer*)mArena.alloc(sizeof(T), ALIGN, sizeof(Finalizer));
        if (p != nullptr) {
            o = new(p) T(std::forward<ARGS>(args)...);
            f->finalizer = &destruct<T>;
            f->next = mFinalizerHead;
            mFinalizerHead = f;
        }
    }
}
```

在Arena中则通过`std::enable_if`不允许申请:
```c++
template <typename T,
    typename = typename std::enable_if<std::is_trivially_destructible<T>::value>::type>
    T* alloc(size_t count, size_t alignment = alignof(T), size_t extra = 0) { ... }
```

在申请内存时, 默认使用最大的scalar的大小(`alignof`是一个POD中最大的那个内存及其大小):

```c++
void* alloc(size_t size, size_t alignment = alignof(std::max_align_t), size_t extra = 0) {
    // this allocator doesn't support 'extra'
    assert(extra == 0);
    return aligned_alloc(size, alignment);
}
```


### 其他

#### 一些值得借鉴的写法

🍉 detail 和 implementation分离
在filament代码很多类都有一个加前缀F的实现类. 这些实现类头文件在details目录下. 通过`upcast`引用实现类的实现, 如camera类中:

```c++
void Camera::setProjection(double fovInDegrees, double aspect, double near, double far,
        Camera::Fov direction) noexcept {
    upcast(this)->setProjection(fovInDegrees, aspect, near, far, direction);
}
```

`upcast`的定义:

```c++
#define FILAMENT_UPCAST(CLASS)                                      \
    inline F##CLASS& upcast(CLASS& that) noexcept {                 \
        return static_cast<F##CLASS &>(that);                       \
    }                                                               \
    inline const F##CLASS& upcast(const CLASS& that) noexcept {     \
        return static_cast<const F##CLASS &>(that);                 \
    }                                                               \
    inline F##CLASS* upcast(CLASS* that) noexcept {                 \
        return static_cast<F##CLASS *>(that);                       \
    }                                                               \
    inline F##CLASS const* upcast(CLASS const* that) noexcept {     \
        return static_cast<F##CLASS const *>(that);                 \
    }
```

🍉 构建者模式和工厂模式


🍉 资源对象的不允许拷贝, 不允许在堆上创建

```c++
class UTILS_PUBLIC FilamentAPI {

    // disallow copy and assignment
    FilamentAPI(FilamentAPI const&) = delete;
    FilamentAPI(FilamentAPI&&) = delete;
    FilamentAPI& operator=(FilamentAPI const&) = delete;
    FilamentAPI& operator=(FilamentAPI&&) = delete;


    // allow placement-new allocation, don't use "noexcept", to avoid compiler null check
    static void *operator new     (size_t, void* p) { return p; }

    // prevent heap allocation
    static void *operator new     (size_t) = delete;
    static void *operator new[]   (size_t) = delete;
    static void  operator delete  (void*)  = delete;
    static void  operator delete[](void*)  = delete;
};
```

#### 异常管理机制

#### 🍉 版本管理
Filament使用三个数字来定义一个版本:
* __most significant__ number, 当API不再向后兼容, 或者引入一套新的API.

* __middle number__, 当材质系统不再向后兼容. 此时需要对材质文件进行重新编译.
    
    另外, 在`MaterialEnums.h`文件中, 定义了`MATERIAL_VERSION`, 运行时检测材质版本是否对应, 需要同步更新.

* __least significant__, 每次Release版本更新时的版本号, 其他两个更新时重置为0.

值得借鉴的有两点:

* material 的版本管理

* material 文件定义了一个人类友好的格式(易读和理解), 在compile来转变为机器友好的格式(高效加载, 以及渲染优化).

#### 混合和半透明


## 参考资料
[filament Material]()
[游戏引擎开发新感觉！(6) c++17内存管理](https://zhuanlan.zhihu.com/p/96089089)
[《STL源码剖析》提炼总结：空间配置器(allocator)](https://zhuanlan.zhihu.com/p/34725232)