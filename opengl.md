---
tag: graphics_api
---
OpenGL and OpenGL ES 基本知识

opengl是台式机版本，而opengl es是用于嵌入式系统（如手机）的，其内存和性能方面的限制要大于计算机。 opengl es将更难使用。 OpenGL是2D和3D图形API，将成千上万的应用程序带到各种各样的计算机平台上。 OpenGL ES是桌面OpenGL 的明确定义的子集.

OpenGL ES在桌面机上运行, 需要安装相关的emulator/sdk.


### OpenGL加载库
 让程序在不同系统/平台上使用同一个头文件, 并不需要链接opengl库. 在运行的时候加载opengl动态库并解析、加载符号. 当然也可以直接include opengl头文件, 并链接动态库比如:
 ```c++
#define GL_GLEXT_PROTOTYPES
#include <GL/gl.h>
#include <GL/glext.h>
 ```
* Glad, OpenGL Loading Library

* [gl3w](https://github.com/skaslev/gl3w) is the easiest way to get your hands on the functionality offered by the OpenGL core profile specification. 

* GLEW, opengl loading library.

### 窗口环境库

* glfw3, **GLFW** is an Open Source, multi-platform library for OpenGL, OpenGL ES and Vulkan development on the desktop. It provides a simple API for creating windows, contexts and surfaces, receiving input and events.

* EGL 可以不需要窗口, 或者由程序员自己利用系统API创建窗口, 并创建OpenGL Context.

## Linux OpenGL

[EGL Eye: OpenGL Visualization without an X Server](https://developer.nvidia.com/blog/egl-eye-opengl-visualization-without-x-server/)

[Pro Tip: Linking OpenGL for Server-Side Rendering](https://developer.nvidia.com/blog/linking-opengl-server-side-rendering/)

[A New Linux OpenGL ABI](https://www.x.org/wiki/Events/XDC2013/XDC2013AndyRitgerVendorNeutralOpenGL/linux-opengl-abi-presentation.pdf)