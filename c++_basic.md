---
tag: programming_language/c++
---
## c++ 静态库和动态库

* 静态库可以简单看成是一组目标文件(.o/.obj文件)的集合(Linux下ar, windows vs下lib.exe).
    静态库在链接时被用到的代码会被"拷贝"到执行程序中.
    静态库更新后, 对应的可执行程序需要重新生成.
* 动态库则与可执行程序一样是一个ELF(Linux), PE(Windows)文件. 动态库需要指定导出的函数/类.
	动态库在编译时需要添加`fPIC`选项, 生成位置无关的代码(jump ), 因为动态库在运行时被加载, 其被加载的内存位置不固定.
	本质上, `fPIC`与`non-fPIC`的区别在于, access global data, jump label的不同.
	比如一条 access global data 的指令，
	non-PIC 的形势是：ld r3, var1
	PIC 的形式则是：ld r3, var1-offset@GOT,意思是从 GOT 表的 index 为 var1-offset 的地方处
	指示的地址处装载一个值,即var1-offset@GOT处的4个 byte 其实就是 var1 的地址。这个地址只有在运行的时候才知道，是由 dynamic-loader(ld-linux.so) 填进去的。
	再比如 jump label 指令
	non-PIC 的形势是：jump printf ，意思是调用 printf。
	PIC 的形式则是：jump printf-offset@GOT,
	意思是跳到 GOT 表的 index 为 printf-offset 的地方处指示的地址去执行，
	这个地址处的代码摆放在 .plt section，
	每个外部函数对应一段这样的代码，其功能是呼叫dynamic-loader(ld-linux.so) 来查找函数的地址(本例中是 printf)，然后将其地址写到 GOT 表的 index 为 printf-offset 的地方，
	同时执行这个函数。这样，第2次呼叫 printf 的时候，就会直接跳到 printf 的地址，而不必再查找了。
	
	GOT 是 data section, 是一个 table, 除专用的几个 entry，每个 entry 的内容可以再执行的时候修改；
	PLT 是 text section, 是一段一段的 code，执行中不需要修改。
	每个 target 实现 PIC 的机制不同，但大同小异。比如 MIPS 没有 .plt, 而是叫 .stub，功能和 .plt 一样。
	可见，动态链接执行很复杂，比静态链接执行时间长;但是，极大的节省了 size，PIC 和动态链接技术是计算机发展史上非常重要的一个里程碑。
	可以在: https://godbolt.org/ 上进行试验
	```c++
	int width = 100;
	int add(int a, int b)
	{
		return a + b;
	}
	int func(int a)
	{
		int res = 0;
		for (auto i=0; i<width; ++i) //加了fPIC width会使用GOTPCREL进行取值
		res = add(res, i); //加了fPIC add会使用PLT进行定位
		return res;
	}
	```

		
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