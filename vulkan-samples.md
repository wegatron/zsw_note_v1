---
tag: graphics_api
---
# vulkan samples note

## vulkan sample 的启动/运行流程

```c++
// 1. 初始化时, 将argument传入
vkb::UnixPlatform platform{vkb::UnixType::Linux, argc, argv};


// 2. 通过插件start sample, 设置需要启动的application
// start_sample.cpp
void StartSample::init(const vkb::CommandParser &parser)
{
	if (parser.contains(&sample_cmd))
	{
		// Launch Sample
		auto *sample = apps::get_sample(parser.as<std::string>(&sample_cmd));
		if (sample != nullptr)
		{
			vkb::Window::OptionalProperties properties;
			std::string title = "Vulkan Samples: " + sample->name;
			properties.title                      = title;
			platform->set_window_properties(properties);
			platform->request_application(sample);
		}
	}
    ...
}

// 3. 在appication确定之后, platform main_loop 在第一次调用时, 将调用 platform::start_app
// 在其中将调用 active_app->prepare(*this)
bool Application::prepare(Platform &_platform)
{
    ...
}

// 4. 渲染一帧, 在platform main_loop中, 会调用platform::update, 由其计算间隔时间delta_time
// 而后调用active_app->update(delta_time) 渲染一帧
void Application::update(float delta_time)
{
    ...
}
```

##  Texture Loading
### Common
...

swapchain
frame buffer

* prepare()
    * 创建swapchain以及其中的vkimage.
    * 创建semaphores.acquired_image_ready, 等待swapchain中获取下一个index的vkimage
    * 创建semaphores.render_complete, 等待渲染完成, 以进行present

* prepare_frame()
    从swapchain中获取下一个index的vkimage

* submit_frame()


### Load Texture

* load_texture()
    加载ktx纹理(支持不同种类的纹理结构2D texture, cube map array等. 以及不同种类的纹理压缩方式.), 但例子中没有用到压缩. 

    这里提到: __通常情况下图片保存的是SRGB__

    创建Image分为两种: GPU only(需要使用staging buffer进行拷贝, 可以将mipmap数据同时拷贝到vkimage中), 或是VK_MEMORY_PROPERTY_HOST_COHERENT_BIT, 可以直接拷贝. 这里使用的都是optimal_tiling, 也是直接拷贝原始图片数据(没有进行对齐之类的操作).

    在加载时加入了两个barrier, 一个用来等待cpu写数据到staging buffer, 另一个用来等待staging buffer将数据拷贝到vkimage.

* setup_descriptor_set_layout()
    设置sescriptor_set_layout, pipeline_layout.

* prepare_pipeline()
    各种state, 在vulkan中state可以是静态写死在pipeline_create_info中, 也可以是dynamic的, 在pipeline_create_info.pDynamicState标记.
    TODO, how to set dynamically?
    ```c++
	pipeline_create_info.pVertexInputState   = &vertex_input_state;
	pipeline_create_info.pInputAssemblyState = &input_assembly_state;
	pipeline_create_info.pRasterizationState = &rasterization_state;
	pipeline_create_info.pColorBlendState    = &color_blend_state;
	pipeline_create_info.pMultisampleState   = &multisample_state;
	pipeline_create_info.pViewportState      = &viewport_state;
	pipeline_create_info.pDepthStencilState  = &depth_stencil_state;
	pipeline_create_info.pDynamicState       = &dynamic_state;
	pipeline_create_info.stageCount          = static_cast<uint32_t>(shader_stages.size());
	pipeline_create_info.pStages             = shader_stages.data();    
    ```

* setup_descriptor_pool() && setup_descriptor_set_layout()
    descriptor_pool是一个池子, 里边定义了不同种Descriptor以及其可用的count. 例如, 一个pool中可能包含1个uniform buffer descriptor和一个combined image sampler descriptor.
    通过, vkAllocateDescriptorSets来从pool中申请一个descriptor_set, 再通过vkUpdateDescriptorSets(VkWriteDescriptorSet)进行更新.

* build_command_buffers()
    ```c++
    VkRenderPassBeginInfo render_pass_begin_info    = vkb::initializers::render_pass_begin_info();
	render_pass_begin_info.renderPass               = render_pass;
	render_pass_begin_info.renderArea.offset.x      = 0;
	render_pass_begin_info.renderArea.offset.y      = 0;
	render_pass_begin_info.renderArea.extent.width  = width;
	render_pass_begin_info.renderArea.extent.height = height;
	render_pass_begin_info.clearValueCount          = 2;
	render_pass_begin_info.pClearValues             = clear_values;
    ```

    有三个地方用到了width, height: render area, viewport, scissor. [三者的区别](https://stackoverflow.com/questions/42501912/can-someone-help-me-understand-viewport-scissor-renderarea-framebuffer-size):
    
    * viewport涉及到ndc坐标如何转换到像素坐标.
    * scissor, 用来描述被绘制的区域(不影响坐标转换).
    * render area是framebuffer中会被影响(值会被改变的区域, 需要应用程序确保不会超过render area), 可以供底层进行优化, 比如有些tiles可以不被包含.


    这里录制命令的时候, framebuffer-draw_cmd_buffer

* 其他
    shader中使用了`texture(sampler, uv, lod_bais)`, 用到了lod计算. ui也可以借鉴.

## texture mipmap gen
通过线性滤波的方式, 从上一层拷贝到下一层. `vkCmdBlitImage`.

## subpasses

在场景的代码中, 用到了类似ECS的思想, 将素材: image, buffer, material等都作为components. 通过引用这些components, 组建scene.

### gltf文件
参考: https://docs.fileformat.com/3d/gltf/
gltf可以是一个json文件加上其引用的一些文件. subpasses加载的gltf:

```bash
sponza01.gltf # 总的json文件
*.ktx # 纹理image数据
Sponza01.bin # buffer, 主要来存储mesh数据
```

gltf文件中定义了一个node列表, node可以是mesh、camera. 通过index引用node组建一个或多个scene.
一个mesh可以包含多个primitive/submesh, 不同的primitive/submesh可以包含不同的属性集合normal,position, 但拥有同一个局部坐标系.

```
tiny_gltf_model
├── accessors
├── animations
├── buffers
├── bufferViews
├── materials # 引用images
├── meshes
│   ├── mesh[0]
│   │    ├── primitives[0] # 这里会引用material
│   │    ├── primitives[1]
│   ├── mesh[1]
├── nodes # 引用mesh、camera、light
├── textures
├── images
├── skins
├── samplers
├── cameras
├── scenes # 引用node
├── lights
├── ...
```

### 渲染流程
1. prepare加载gltf模型, 并构建场景scene:

```c++
Subpasses::prepare(vkb::Platform &platform)
{
    load_scene("scenes/sponza/Sponza01.gltf"); // 加载gltf 构建scene

    // render pass 在构建时传入scene
    // subpass 的方式绘制
	render_pipeline = create_one_renderpass_two_subpasses();

    // multipass 的方式绘制
	geometry_render_pipeline = create_geometry_renderpass();
	lighting_render_pipeline = create_lighting_renderpass();    
}
```


2. 遍历获取所有需要绘制的submesh进行绘制, 函数如下:

```c++
Subpasses::draw_subpasses // subpass的方式
Subpasses::draw_renderpasses // multiple render pass的方式
```

3. vkb::GeometrySubpass


4. vkb::LightingSubpass


5. vkb::RenderPipeline

## vkb framework

1. 使用vma创建buffer/image, 调用堆栈.

    ```c++
    // 这里没有额外使用VK_MEMORY_PROPERTY_HOST_COHERENT_BIT, 使用手动刷新.
    // 现在对于没有cache的内存, 默认时coherent的
    // Host memory accesses to uncached memory are slower than to 
    // cached memory, however uncached memory is always host coherent.
    
    // 在此处进行memory种类的选择:
    // VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT
    // VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT >>> cpu写,gpu 读取
    // VK_MEMORY_DEVICE_LOCAL | VK_MEMORY_PROPERTY_HOST_CACHED_BIT >>> gpu写,cpu读
    // https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/blob/\
    // 73d13a83ede142fa030d84e603a313831fcc424a/include/vk_mem_alloc.h#L3656
    vmaFindMemoryTypeIndex(
        VmaAllocator allocator,
        uint32_t memoryTypeBits,
        const VmaAllocationCreateInfo* pAllocationCreateInfo,
        uint32_t* pMemoryTypeIndex)

    VmaAllocator_T::AllocateMemory(
        const VkMemoryRequirements& vkMemReq,
        bool requiresDedicatedAllocation,
        bool prefersDedicatedAllocation,
        VkBuffer dedicatedBuffer,
        VkBufferUsageFlags dedicatedBufferUsage,
        VkImage dedicatedImage,
        const VmaAllocationCreateInfo& createInfo,
        VmaSuballocationType suballocType,
        size_t allocationCount,
        VmaAllocation* pAllocations)

    vmaCreateBuffer(
        VmaAllocator allocator,
        const VkBufferCreateInfo* pBufferCreateInfo,
        const VmaAllocationCreateInfo* pAllocationCreateInfo,
        VkBuffer* pBuffer,
        VmaAllocation* pAllocation,
        VmaAllocationInfo* pAllocationInfo)

    vkb::core::Buffer::Buffer(
    	Device const &device,
    	VkDeviceSize size,
    	VkBufferUsageFlags buffer_usage,
    	VmaMemoryUsage memory_usage,
    	VmaAllocationCreateFlags flags,
    	const std::vector<uint32_t> &queue_family_indices)
    ```

2. sg::image, 加载纹理.

    ```c++
    image = std::make_unique<sg::Image>(
        gltf_image.name,
        std::move(gltf_image.image),
        std::move(mipmaps));
    image->create_vk_image(device);
    ```

## 思考
是否可以通过配置文件的形式, 组建进行渲染管线, 流程. json/xml格式的文件如何在编译阶段转化为c/c++代码.

