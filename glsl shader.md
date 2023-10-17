---
tag: graphics_api
---

## Uniform Buffer

参考: [Vulkan教程 - 17 描述符与内存对齐 - 捉不住的鼬鼠)](# Vulkan教程 - 17 描述符与内存对齐)
Vulkan要求你结构体中的数据在内存中以一种特殊方式对齐，例如：

* 标量必须是N对齐的(如对32位浮点数来说就是4个字节)
* vec2必须是2N对齐的(8个字节)
* vec3和vec4必须4N对齐(16字节)
* 内嵌结构体必须由它的成员的基础对齐值来对齐, 会多达16的倍数
* mat4矩阵必须要有和vec4一样的对齐值

例如以下的uniform buffer在c++中需要对对齐做特殊标记:
```c++
layout(binding = 0) uniform UniformBufferObject { 
	vec2 foo;  
	mat4 model; 
	mat4 view; 
	mat4 proj; 
} ubo;
```
```c++
struct UniformBufferObject {
	glm::vec2 foo;
	alignas(16) glm::mat4 model;
	glm::mat4 view;
	glm::mat4 proj;
};
```

此外, 在opengl中, uniform buffer的最小大小, 以及其绑定时的最小offset