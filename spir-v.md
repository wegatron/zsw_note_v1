---
tag: graphics_api
---
## SPIR-V
一种中间二进制码, 可以通过高层语言如glsl, hlsl生成.
> SPIR-Visa Khronos-standard intermediatelanguagethat providesan alternativefor distributing shaders.

SPIR-V以二进制模块为单位, 一个模块包含一个或多个函数, 构成一个独立的pipline stage, 比如vertex shader.

SPIR-V Shader介绍: https://www.khronos.org/assets/uploads/developers/library/2016-vulkan-devday-uk/3-Intro-to-spir-v-shaders.pdf

## 相关工具

### glslangValidator
官方提供的glsl shading language前端, 完成: 词法分析、语法分析、语义分析、中间代码产生(AST).
> An OpenGL GLSL and OpenGL|ES GLSL (ESSL) front-end for reference validation and translation of GLSL/ESSL into an internal abstract syntax tree (AST).

支持的glsl版本: https://www.khronos.org/opengles/sdk/tools/Reference-Compiler/

同时也支持hsls编译生成spir-v抽象语法树(AST).

glslangValidator可以包含spirv-tools, 来保证通过hlsl生成的spir-v能够在vulkan上是合法的且大小尽可能小.
> If you wish to assure that SPIR-V generated from HLSL is legal for Vulkan, wish to invoke -Os to reduce SPIR-V size from HLSL or GLSL, or wish to run the integrated test suite, install spirv-tools with this:

*以命令行形式使用.*

```bash
# 将glsl编译成spir-v, 这个-V表示vulkan, 若是opengl 则是-G
glslangValidator -V -o texture_shader_vert.spv shader_texture.vert
glslangValidator -V -o texture_shader_frag.spv shader_texture.frag

# 将spir-v转译成glsl的不同版本, --es, --no-es表示GLSL or GLSL ES.
spirv-cross --version 310 --es texture_shader_vert.spv --output parse.vert

#支持fragment buffer fetch
spirv-cross --version 310 --es \
--glsl-remap-ext-framebuffer-fetch 0 0 \
--glsl-remap-ext-framebuffer-fetch 1 1 \
--glsl-remap-ext-framebuffer-fetch 2 2 \
--glsl-remap-ext-framebuffer-fetch 3 3 \
texture_shader_vert.spv --output parse.vert

# 将spir-v转译成msl
spirv-cross --msl --msl-version 2.1 \
../samples/data/shaders/texture_quad.spv --output ../samples/data/shaders/texture_quad.msl

# 支持fragment buffer fetch
spirv-cross --msl --msl-ios --msl-version 2.1  --msl-framebuffer-fetch ff.spirv --output ff.msl
```

### SPIRV-Cross
将spir-v转换为其他类型的语言, 包括: 指定版本的glsl(glsl es), msl, 

*主要以代码API形式使用, CLI只提供简单功能.*

### spirv-tools
一些其他重要的功能, 比如: spir-v二进制的解析, 验证, 优化等.
>The SPIR-V Tools project provides an API and commands for processing SPIR-V modules.

*CLI和代码API形式使用*

```bash
spirv-dis initialize.spv
```

### Shaderc
封装了glslangValidator和SPIRV-Tools, 提供类似GCC和Clang的使用方式, 更好的与构建系统相结合(如CMake).
[shaderc github page](https://github.com/google/shaderc)

```bash
glslc shader.vert -o vert.spv
glslc shader.frag -o frag.spv
```

[vulkan 不再支持单独默认的uniform](https://github.com/KhronosGroup/GLSL/blob/master/extensions/khr/GL_KHR_vulkan_glsl.txt)
最新版本的glsllangValidator已经支持(待验证):
https://github.com/KhronosGroup/glslang/issues/2158
https://github.com/KhronosGroup/glslang/issues/2126

## glsl es
一些常用的标记
`layout`
`location`
`in`, `out`

## Reference

16位浮点数支持: https://zhuanlan.zhihu.com/p/406621755

glslc test.frag -o test.spv
spirv-cross --version 300 --es --remap u_subpass0 get_frag_func0 4 --remap u_subpass1 get_frag_func1 4 test.spv --output test_inv.frag

CB3D510326AB
FA25761701BF
7DADE8999F31