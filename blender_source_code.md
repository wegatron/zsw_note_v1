# Blender Source code
## Blender 编译
预编译的第三方库下载: https://svn.blender.org/svnroot/bf-blender/trunk/lib/win64_vc15/
更新oidn: https://www.openimagedenoise.org/downloads.html

## 与渲染相关的代码模块

| 代码目录 | 描述 |
| --- | --- |
| /source/blender/gpu/ | 通用的GPU backend 和 通用的gpu shader node(function) |
| /source/blender/draw/	| viewport绘制 和 EEVE渲染引擎(包括EEVEE和EEVEE next下一个版本, 可以获得更写实的效果, 并且支持了一些新的特性: 光线追踪、实时displacement...) |

在eevee/shaders/infos中描述了shader源码的使用.

Shader编译:
1. CMAKE option WITH_GPU_SHADER_BUILDER=On.
2. Only shaders that are part of the SHADER_CREATE_INFOS and .do_static_compilation(true) is set, will be compiled.

## EEVEE Principled bsdf
shader代码: source/blender/gpu/shaders/material/gpu_shader_material_principled.glsl
c++源码: source/blender/nodes/shader/nodes/node_shader_bsdf_principled.cc : node_shader_gpu_bsdf_principled

* node_declare定义了该节点向外暴露的信息

* principle bsdf包含多个子模块, 通过flag进行开关


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


参考: [blender中添加自定义节点](https://zhuanlan.zhihu.com/p/508277873)

## Ray Tracying

光线追踪去噪, 包括oidn(Intel Open Image Denoise)和Optix.
源码: intern/cycles/integrator/denoiser.h

使用[OpenPGL](https://github.com/OpenPathGuidingLibrary/openpgl)(包含了STOA的基于ML的算法)进行path guiding, 提高采样质量.