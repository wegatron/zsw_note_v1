---
tag: programming_language/c++
---
## c++ 静态库和动态库

* 静态库可以简单看成是一组目标文件(.o/.obj文件)的集合(Linux下ar, windows vs下lib.exe).
    静态库在链接时被用到的代码会被"拷贝"到执行程序中.
    静态库更新后, 对应的可执行程序需要重新生成.
* 动态库则与可执行程序一样是一个ELF(Linux), PE(Windows)文件. 动态库需要指定导出的函数/类.
    多个程序可以共用一个动态库, 库代码更新时(只要函数/类)的定义没变, 只需替换动态库即可.

```c++
#if WIN32
#ifdef XXLIB_EXPORTS
#   define UTILS_PUBLIC __declspec(dllexport)
#else
#   define UTILS_PUBLIC __declspec(dllimport)
#endif
#else
#if __has_attribute(visibility)
#    define UTILS_PUBLIC  __attribute__((visibility("default")))
#else
#    define UTILS_PUBLIC  
#endif
#endif
```

### 参考资料
[C++静态库与动态库的区别](https://blog.csdn.net/sinat_20265495/article/details/52502673)
[浅谈静态库和动态库](https://zhuanlan.zhihu.com/p/71372182)