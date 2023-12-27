
# Blender Source code
## Project Compile
预编译的第三方库下载: https://svn.blender.org/svnroot/bf-blender/trunk/lib/win64_vc15/
更新oidn: https://www.openimagedenoise.org/downloads.html

Shader编译:
1. CMAKE option WITH_GPU_SHADER_BUILDER=On.
2. Only shaders that are part of the SHADER_CREATE_INFOS and .do_static_compilation(true) is set, will be compiled.

## Blender Rendering

| 代码目录 | 描述 |
| --- | --- |
| `source/blender/gpu/` | 通用的GPU backend 和 通用的gpu shader node(function) |
| `source/blender/draw/`| viewport绘制 和 EEVE渲染引擎(包括EEVEE和EEVEE next下一个版本, 可以获得更写实的效果, 并且支持了一些新的特性: 光线追踪、实时displacement...) |

`source/blender/draw/eevee/shaders/infos`, `source/blender/gpu/shaders/infos` 等中描述了shader源码的使用.

### EEVEE Principled BSDF Node 全链路

shader代码: `source/blender/gpu/shaders/material/gpu_shader_material_principled.glsl`
c++源码: `source/blender/nodes/shader/nodes/node_shader_bsdf_principled.cc`

* node_declare 定义了该节点UI向外暴露的信息

* principle bsdf 包含多个子模块, 通过flag进行开关

    ```c++
    static int node_shader_gpu_bsdf_principled(GPUMaterial *mat,
                                            bNode *node,
                                            bNodeExecData * /*execdata*/,
                                            GPUNodeStack *in,
                                            GPUNodeStack *out) {
        ...                                                         
        bool use_diffuse = socket_not_zero(SOCK_SHEEN_WEIGHT_ID) ||
                            (socket_not_one(SOCK_METALLIC_ID) &&
                            socket_not_one(SOCK_TRANSMISSION_WEIGHT_ID));
        eGPUMaterialFlag flag = GPU_MATFLAG_GLOSSY;
        if (use_diffuse) {
        flag |= GPU_MATFLAG_DIFFUSE;
        }
        ...
        GPU_material_flag_set(mat, flag);
        return GPU_stack_link(mat,
                            node,
                            "node_bsdf_principled",
                            in,
                            out,
                            GPU_constant(&use_diffuse_f),
                            GPU_constant(&use_coat_f),
                            GPU_constant(&use_refract_f),
                            GPU_constant(&use_multi_scatter),
                            GPU_uniform(&use_sss));
    }
    ``` 

* Shader code assemble
    * `source/blender/draw/engines/eevee/eevee_shaders.cc`. 
        `EEVEE_shaders_material_shaders_init` 初始化, 构建基础的code lib.
        `EEVEE_material_default_get`/`EEVEE_material_get` 获取material对应的shader(在此过程中用到了cache).
    * `source/blender/draw/engines/eevee_next/eevee_shader.cc`
        调用backend创建shader(没有shader cache). `source/blender/gpu/intern/gpu_shader.cc` : GPU_shader_create
* Graphics pipeline and rendering(defered? or not)

参考: [blender中添加自定义节点](https://zhuanlan.zhihu.com/p/508277873)

Q: 如何实现既支持数值, 又支持从纹理采样?

Q: gpu_shader_material_principled.glsl在哪里被用到?

## Ray Tracying

光线追踪去噪, 包括oidn(Intel Open Image Denoise)和Optix.
源码: intern/cycles/integrator/denoiser.h

使用[OpenPGL](https://github.com/OpenPathGuidingLibrary/openpgl)(包含了STOA的基于ML的算法)进行path guiding, 提高采样质量.