---
tag: summary/code_note
---
# filament

代码结构:

```
.
├─backend
│  ├─include
│  │  ├─backend #后端/系统接口的封装
│  │  │   BufferDescriptor.h
│  │  │   DriverEnums.h
│  │  │   Handle.h
│  │  │   PipelineState.h
│  │  │   PixelBufferDescriptor.h
│  │  │   Platform.h
│  │  │   PresentCallable.h
│  │  │   TargetBufferInfo.h
│  │  └─private
│  │      └─backend
│  ├─src
│  │  ├─android
│  │  ├─metal
│  │  ├─noop
│  │  ├─opengl
│  │  └─vulkan
│  └─test
├─benchmark
├─docs
│  └─doxygen
├─include
│  └─filament #与渲染相关的通用封装
│  │   Box.h
│  │   Camera.h
│  │   Color.h
│  │   ColorGrading.h
│  │   DebugRegistry.h
│  │   Engine.h
│  │   Exposure.h
│  │   Fence.h
│  │   FilamentAPI.h
│  │   Frustum.h
│  │   IndexBuffer.h
│  │   IndirectLight.h
│  │   LightManager.h
│  │   Material.h
│  │   MaterialInstance.h
│  │   RenderableManager.h
│  │   Renderer.h
│  │   RenderTarget.h
│  │   Scene.h
│  │   Skybox.h
│  │   Stream.h
│  │   SwapChain.h
│  │   Texture.h
│  │   TextureSampler.h
│  │   TransformManager.h
│  │   VertexBuffer.h
│  │   View.h
│  │   Viewport.h
└─filament
├─src
│  ├─components
│  ├─details
│  ├─fg2
│  │  └─details
│  └─materials
│      ├─antiAliasing
│      ├─bloom
│      ├─colorGrading
│      ├─dof
│      └─ssao
└─test
```

## 渲染配置系统
### 材质
这里使用了构建者模式, 材质既包含了:
* 渲染状态模式: BlendingMode, CullingMode, DepthWriteEnabled ...
* 材质相关的参数: Texture

这里, 对于平台相关的材质特性(如shader), 每一个平台在材质文件中都有自己的单独的一份.

Material的类设计:
```c++
/**
 * @brief 材质属性对应的渲染配置.
 * MaterialParser中书材质属性, 这里则是渲染配置. 如culling mode, blend mode. 
 */
class UTILS_PUBLIC Material : public FilamentAPI
{
public:
    
    /*
     * @brief 构造者, 用来从文件中解析得到Material, 这里不同的平台其Material的表示可能会有所不同
     * Material根据MaterialParser的进行更详细的属性设置
     */
    class Builder : public BuilderBase<BuilderDetails> {
        friend struct BuilderDetails;
    public:
        /**
         * Specifies the material data. The material data is a binary blob produced by
         * libfilamat or by matc.
         *
         * @param payload Pointer to the material data, must stay valid until build() is called.
         * @param size Size of the material data pointed to by "payload" in bytes.
         */
        Builder& package(const void* payload, size_t size);

        /**
         * Creates the Material object and returns a pointer to it.
         *
         * @param engine Reference to the filament::Engine to associate this Material with.
         *
         * @return pointer to the newly created object or nullptr if exceptions are disabled and
         *         an error occurred.
         *
         * @exception utils::PostConditionPanic if a runtime error occurred, such as running out of
         *            memory or other resources.
         * @exception utils::PreConditionPanic if a parameter to a builder function was invalid.
         */
        Material* build(Engine& engine);
    private:
        friend class FMaterial;
    };

    //! Returns this material's default instance.
    MaterialInstance* getDefaultInstance() noexcept;
};

/**
 * @brief 从文件中解析得到数据.
 * 在解析时, 先由ChunkContainer读取得到键值对, 上层通过
 * `MaterialParser::MaterialParserDetails::getFromSimpleChunk` 函数获取值.
 */
class MaterialParser {};

/**
 * @brief Material应用接口, 渲染状态相关的设置: uniform, sampler.
 */
class UTILS_PUBLIC MaterialInstance : public FilamentAPI {};
```

这里所有的Class都只是接口, 由一个FClass继承来进行具体实现.

可以通过编辑如下JSON文件, 来定义[Material](), 后续使用`matc`来生成二进制文件:

```json
material {
    // material properties
}

vertex {
    // vertex shader, optional
}

fragment {
    // fragment shader
}
```

一个实例:
```json
material {
    name : "Textured material",
    parameters : [
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
    shadingModel : lit,
    blending : opaque
}

fragment {
    void material(inout MaterialInputs material) {
        prepareMaterial(material);
        material.baseColor = texture(materialParams_texture, getUV0());
        material.metallic = materialParams.metallic;
        material.roughness = materialParams.roughness;
    }
}
```

Shader的读取和使用?

## 底层API封装



## 渲染绘制的封装

