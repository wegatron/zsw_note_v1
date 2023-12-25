# Blender Source code
## Blender 编译
预编译的第三方库下载: https://svn.blender.org/svnroot/bf-blender/trunk/lib/win64_vc15/

## 与渲染相关的代码模块

| 代码目录 | 描述 |
| --- | --- |
| /source/blender/gpu/ | 通用的GPU backend 和 通用的gpu shader node(function) |
| /source/blender/draw/	| viewport绘制 和 EEVE渲染引擎(包括EEVEE和EEVEE next下一个版本, 可以获得更写实的效果, 并且支持了一些新的特性: 光线追踪、实时displacement...) |

在eevee/shaders/infos中描述了shader源码的使用.