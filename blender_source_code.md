
# Blender Source code
## Project Compile On Linux/Docker
参考: https://wiki.blender.org/wiki/Building_Blender/Linux/Arch

* archlinux预先装一些必要的包
    ```bash
    FROM archlinux:latest
    RUN pacman -Sy \
        && pacman -Sy --noconfirm libxext libsm libxrender fontconfig gnu-free-fonts \
        glu core/libxcrypt-compat gdk-pixbuf2 pixman libthai glibc python base-devel git \
        subversion cmake libx11 libxxf86vm libxcursor libxi libxrandr libxinerama mesa \
        vulkan-devel wayland wayland-protocols libxkbcommon-x11 dbus linux-headers icu openvdb draco opensubdiv
    ```

* 启动docker
    ```bash
    sudo docker run --gpus all -it --rm -e --net=host --env="DISPLAY" -v /home/wegatron/win-data/opensource_code/blender:/code -v /tmp/.X11-unix:/tmp/.X11-unix zsw-dev /bin/bash
    ```

* 安装开发包(依赖库)
    svn上的库比较陈旧, 直接安装系统库.
    ```bash
    ./build_files/build_environment/install_linux_packages.py --all
    ```

<!-- * 预编译的第三方依赖库: 
    https://svn.blender.org/svnroot/bf-blender/trunk/lib/
    更新oidn: https://www.openimagedenoise.org/downloads.html
    更新openpgl: https://github.com/OpenPathGuidingLibrary/openpgl/archive/refs/tags/v0.5.0.zip -->

* 使用系统的库
    -DWITH_LIBS_PRECOMPILED=ON
* Shader预编译(保证shader代码是正确的):
    CMAKE option WITH_GPU_SHADER_BUILDER=On.
    Only shaders that are part of the SHADER_CREATE_INFOS and .do_static_compilation(true) is set, will be compiled.

## Project Compile On Windows


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
    * `source/blender/draw/engines/eevee_next/eevee_material.cc`
        `material_create_info_ammend`, `material_pass_get` 调用`material_shader_get` 获取Material对应的GPUMaterial(此处利用shader uuid, 保证每一个Material的每种类型只有一个GPUMaterial)
    <!-- * `source/blender/draw/engines/eevee/eevee_shaders.cc`. 
        `EEVEE_shaders_material_shaders_init` 初始化, 构建基础的code lib.
        `EEVEE_material_default_get`/`EEVEE_material_get` 获取Material对应的GPUMaterial(此处利用shader uuid, 保证每一个Material的每种类型只有一个GPUMaterial) -->
    * `source/blender/gpu/intern/gpu_codegen.cc` 根据node tree组装shader源码, 
        `GPU_generate_pass` 根据codegen的hash值进行cache
        `GPU_pass_compile`中调用`GPU_shader_create_from_info`创建shader.
    * `source/blender/draw/engines/eevee_next/eevee_shader.cc`
        调用backend创建shader(没有shader cache). `source/blender/gpu/intern/gpu_shader.cc` : GPU_shader_create

参考: [blender中添加自定义节点](https://zhuanlan.zhihu.com/p/508277873)

Q1: 如何实现既支持数值, 又支持从纹理采样?
    通过code gen根据nodetree组装shader code

Q2: gpu_shader_material_principled.glsl在哪里被用到? (Material, Nodetree从哪里来?)

Q3: 在blender源码中大量使用了裸指针, 为什么?

Q4: gpu material的uuid如何生成?
    uuid只是代表material是在何种geometry+pipeline类型下.


### NodeTree System

bNode

bNodeSocket

bNodeLink

Q: node中的shader/c++代码如何体现?

Q: node link如何与shader对应起来?

## Ray Tracying

光线追踪去噪, 包括oidn(Intel Open Image Denoise)和Optix.
源码: intern/cycles/integrator/denoiser.h

使用[OpenPGL](https://github.com/OpenPathGuidingLibrary/openpgl)(包含了STOA的基于ML的算法)进行path guiding, 提高采样质量.