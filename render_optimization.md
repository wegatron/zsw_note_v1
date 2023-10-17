---
tag: graphics_api
---
## Frame Buffer Fetch/Program Blending
一个 pass 渲染好的 image 要被统一存到一个 Framebuffer 中，随后在第二个 pass 中再被分散到不同的 shader 中去，这对于 tile-based renderer 平台是致命的：对于上述提到的那些”只会被同一个位置的像素所利用“的适用情形，这些像素本可以在每个 tile 的高速片上内存直接被下一个 pass 使用，但由于要统一存放在 VRAM 的 framebuffer 中，每个 tile 的片上内存数据一直在被收集-分散-收集-分散，tile memory 几乎起不到任何作用，极大的浪费了性能，加大了数据传输所导致的带宽消耗（在移动端直接带来一个致命问题：发热降频），完全违背移动端 TBR 架构的初衷。

subpass 就解决了这个问题。后一个 subpass 所使用的 attachments 的像素可以直接从前一个 subpass 的 attachments 中的对应位置读取，从而免去了收集的过程。当然需要注意的是，下一个subpass不能对临近像素进行采样了，只能使用同一位置的像素信息。这些 attachments 便被称为 input attachments。

### vulkan、metal实现
详细参考: https://zhuanlan.zhihu.com/p/131392827

备注: 启用subpass, fragment buffer fetch则会实现在tiled上快速读绘制结果, 对于vulkan、metal可以更进一步, 实现memory less 0内存.

### Opengl(es)实现
在opengl es$\le$3.0, 不支持subpass, 支持framebuffer fetch. 仅需在shader中获fbo中的结果即可.
opengl es$\ge$3.1之后, 支持subpass, 暂不做研究.

### shader
* es$\le$3.0版本, es3.1以后, 支持subpass. 在shader:
    ```c++
    #ifdef GL_EXT_shader_framebuffer_fetch
        #extension GL_EXT_shader_framebuffer_fetch : require
        vec4 frameBufferColor(int index)
        {
            return gl_LastFragData[index];
        }
    #else
        #ifdef GL_ARM_shader_framebuffer_fetch
        #extension GL_ARM_shader_framebuffer_fetch : require
        vec4 frameBufferColor(int index)
        {
            return gl_LastFragDataARM[index];
        }
        #else
            vec4 frameBufferColor(int index)
            {
                return vec4(0.0);
            }
        #endif
    #endif
    ```

* es$\ge$3.1 + vulkan subpass
```c++
#version 310 es
precision mediump float;

layout(input_attachment_index = 0, set = 0, binding = 0) uniform mediump subpassInput uSubpass0;
layout(input_attachment_index = 1, set = 0, binding = 1) uniform mediump subpassInput uSubpass1;
layout(location = 0) out vec3 FragColor;
layout(location = 1) out vec4 FragColor2;

void main()
{
    FragColor.rgb = subpassLoad(uSubpass0).rgb + subpassLoad(uSubpass1).rgb;
}
```

### spirv-cross shader转义
        extra_args += ['--glsl-remap-ext-framebuffer-fetch', '0', '0']
        extra_args += ['--glsl-remap-ext-framebuffer-fetch', '1', '1']
        extra_args += ['--glsl-remap-ext-framebuffer-fetch', '2', '2']
        extra_args += ['--glsl-remap-ext-framebuffer-fetch', '3', '3']


## Reference
* [游戏引擎随笔 0x11：现代图形 API 特性的统一：Attachment Fetch](https://zhuanlan.zhihu.com/p/131392827)
* [从一个小bug看MSAA depth resolve](http://aicdg.com/ue4-msaa-depth/)