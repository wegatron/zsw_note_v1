---
tag: programming/cpp
---
## ubuntu g++多版本安装和切换
多版本g++安装
```bash
sudo apt install gcc-7 g++-7 gcc-8 g++-8 gcc-9 g++-9

# 使用下面的命令设置g++默认版本的优先顺序, 这里g++-9设置为90
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/gcov gcov /usr/bin/gcov-7

# 切换g++版本
sudo update-alternatives --config gcc
```

```
Selection    Path            Priority   Status
------------------------------------------------------------
* 0            /usr/bin/gcc-9   90        auto mode
  1            /usr/bin/gcc-7   70        manual mode
  2            /usr/bin/gcc-8   80        manual mode
  3            /usr/bin/gcc-9   90        manual mode

Press  to keep the current choice[*], or type selection number: 
```

## static assert

```c++
static_assert ( bool_constexpr , message )  (since C++11)
static_assert ( bool_constexpr )    (since C++17)
```
当表达式失败时, 编译报错, 信息为mesage.
example in Eigen, 在矩阵assignment时, 使用static_assert判断矩阵大小是否一致:
```c++
EIGEN_STATIC_ASSERT_SAME_MATRIX_SIZE(ActualDstTypeCleaned,Src)
```

## 编译器优化控制

`__builtin_expect`帮助编译器, 优化分支预判:

```c++
#if __has_builtin(__builtin_expect)
#   ifdef __cplusplus
#      define UTILS_LIKELY( exp )    (__builtin_expect( !!(exp), true ))
#      define UTILS_UNLIKELY( exp )  (__builtin_expect( !!(exp), false ))
#   else
#      define UTILS_LIKELY( exp )    (__builtin_expect( !!(exp), 1 ))
#      define UTILS_UNLIKELY( exp )  (__builtin_expect( !!(exp), 0 ))
#   endif
#else
#   define UTILS_LIKELY( exp )    (!!(exp))
#   define UTILS_UNLIKELY( exp )  (!!(exp))
#endif

// 用法
if (UTILS_LIKELY(mFreeSpace >= requiredSize)) { ... } else { ... }
while (UTILS_LIKELY(base)) { ... }
```

这里`__builtin_expect( !!(expx), true ))` 两次取反, 原因为: 取一次为反, 取两次为正, 保证`!!(exp)`是bool值.


`#pragma nounroll` 告诉编译器, 不要展开循环(循环展开可能导致编译结果太大):

```c++
if (target == GL_UNIFORM_BUFFER || target == GL_TRANSFORM_FEEDBACK_BUFFER) {
    auto& indexedBuffer = state.buffers.targets[targetIndex];
    #pragma nounroll // clang generates >1 KiB of code!!
    for (GLsizei i = 0; i < n; ++i) {
        #pragma nounroll
        for (auto& buffer : indexedBuffer.buffers) {
            if (buffer.name == buffers[i]) {
                buffer.name = 0;
                buffer.offset = 0;
                buffer.size = 0;
            }
        }
    }
```

## c++ memory model
* memory_order_seq_cst
  顺序一致性，也是 __默认__ 的选项，这个选项不允许reorder，那么也会带来一些性能损失.
* Release-Acquire ordering
  在这种模型下，store()使用memory_order_release，而load()使用memory_order_acquire。这种模型有两种效果，第一种是可以限制 CPU 指令的重排：
  * 在store()之前的所有读写操作，不允许被移动到这个store()的后面。
  * 在load()之后的所有读写操作，不允许被移动到这个load()的前面。
  除此之外，还有另一种效果：假设 Thread-1 store()的那个值，成功被 Thread-2 load()到了，那么 Thread-1 在store()之前对内存的所有写入操作，此时对 Thread-2 来说，都是可见的。
* memory_order_relaxed
  没有任何约束

 [@高并发编程--多处理器编程中的一致性问题(上)](https://zhuanlan.zhihu.com/p/48157076)
 [@理解 C++ 的 Memory Order](http://senlinzhan.github.io/2017/12/04/cpp-memory-order/)

## unaligned access

> Complete object types have alignment requirements which place restrictions on the addresses at which objects of that type may be allocated. An alignment is an implementation-defined integer value representing the number of bytes between successive addresses at which a given object can be allocated.

完整的数据类型有对齐要求, 该要求限制了可以分配该类型对象的地址. 在指针转换时需要特别注意.
参考: [unaligned access in c/c++](https://blog.quarkslab.com/unaligned-accesses-in-cc-what-why-and-solutions-to-do-it-properly.html)


## 内存布局对齐分配释放
字节对齐的细节和编译器实现相关，但一般而言，满足三个准则：
* (结构体)变量的首地址能够被其(最宽)基本类型成员的大小所整除；
* 结构体每个成员相对于首地址的偏移量都是成员大小的数倍，如有需要,编译器会在成员之间加上填充字节(internal adding)
* 结构体的总大小为结构体最宽基本类型成员大小的数倍，如有需要,编译器会在最末一个成员之后加上填充字节(trailing padding)

缓存行对齐
数据跨越两个cache line，意味着两次load或两次store。如果数据结构是cache line对齐的那么久可以减少不必要的cache load次数(如cache line为64, 64bit的数据若对齐则一次load, 若不对齐, 则有可能横跨两个cache line).

另外, 一般将同类的(易变的和只读的)数据分开, 在并行时最好也能考虑到cache [伪共享](https://zhuanlan.zhihu.com/p/352537447)的问题(即两个线程(不同的cpu)对同一个cache 进行修改, 会产生大量的cache miss).

```c++
// every object of type struct_float will be aligned to alignof(float) boundary
// (usually 4)
struct alignas(float) struct_float {
    // your definition here
};
 
// every object of type sse_t will be aligned to 256-byte boundary
struct alignas(256) sse_t
{
    float sse_data[4];
};
 
// the array "cacheline" will be aligned to 128-byte boundary
alignas(128) char cacheline[128];
```

| 操作 | c++标准 | 解释 |
| --- | --- | --- |
| `alignas([input_bytes])` | c++11 attribute | 一个元素或者一个类对象必须对齐到的内存边界 |
| `alignof([type])` | c++11 函数 | 得到一个元素或者一个类对象中最大的那个元素的内存对齐边界 |
| `std::max_align_t` | c++11 值 | std::malloc返回的内存地址, 对齐大小不能小于std::max_align_t的对齐大小 |
| `aligned_alloc(input_bytes)` | c++11 函数 | 规定了分配空间的起始地址对齐的位置 |

![[rc/cpu_cacheline_size.JPG]]

__`alignas`用来修饰类型, 使之在`new`时就能够按照给定的内存对齐方式申请空间. 而`aligned_alloc`则是申请一个指定大小的内存块.__

对于`alignas`超过`std::max_align_t`的类型, 在使用stl container时, 需要自定义allocator. 在c++17中扩展了operator new, 不需要再自定义allocator.

```c++
inline void* aligned_alloc(size_t size, size_t align) noexcept {
    assert(align && !(align & align - 1));

    void* p = nullptr;

    // must be a power of two and >= sizeof(void*)
    while (align < sizeof(void*)) {
        align <<= 1u;
    }

#if defined(WIN32)
    p = ::_aligned_malloc(size, align);
#else
    ::posix_memalign(&p, align, size);
#endif
    return p;
}

inline void aligned_free(void* p) noexcept {
#if defined(WIN32)
    ::_aligned_free(p);
#else
    ::free(p);
#endif
}
```

自主管理内存

好处:
① 减少内存碎片, 提高访问速度.
② 更好的局部性
③ SIMD向量指令如(AVX)需要内存对齐.

BTW, 自主管理内存的好处:
① 对于频繁申请释放, 可以减少系统调用.
② 对于online运行的程序, 可以加日志, 方便后续调试或优化.



更多更详细的资料, 参考[游戏引擎开发新感觉！(6) c++17内存管理](https://zhuanlan.zhihu.com/p/96089089)

## Lock
SpinLock
mutex
condition variable


## 模板类的高级设置

```c++
std::enable_if
```
[@游戏引擎开发新感觉！(6) c++17内存管理](https://zhuanlan.zhihu.com/p/96089089)

## 类的一些设置

* 使用`delete`将默认函数删除

* 使用`noexcept`来表示该函数不会产生异常.
    

```c++
// Allocators can't be copied
HeapAllocator(const HeapAllocator& rhs) = delete;
HeapAllocator& operator=(const HeapAllocator& rhs) = delete;

// Allocators can be moved
HeapAllocator(HeapAllocator&& rhs) noexcept = default;
HeapAllocator& operator=(HeapAllocator&& rhs) noexcept = default;
```

## 常用的设计模式

* 构造者模式.

    例如, 在filament中每一种资源都有一个自己的构造者, 

    ```c++
    class UTILS_PUBLIC IndexBuffer : public FilamentAPI {
        class Builder : public BuilderBase<BuilderDetails> {
            friend struct BuilderDetails;
        public:
            Builder() noexcept;
            Builder(Builder const& rhs) noexcept;
            Builder(Builder&& rhs) noexcept;
            ~Builder() noexcept;
            Builder& operator=(Builder const& rhs) noexcept;
            Builder& operator=(Builder&& rhs) noexcept;
            Builder& indexCount(uint32_t indexCount) noexcept;
            Builder& bufferType(IndexType indexType) noexcept;
            IndexBuffer* build(Engine& engine);
        private:
            friend class FIndexBuffer;
        };
    };
    ```

    构造者中, 设置完参数后返回该类对的引用, 从而可以连写进行设置, 最红通过build完成构造.

    ```c++
    // 使用
    app.ib = IndexBuffer::Builder()
                    .indexCount(3)
                    .bufferType(IndexBuffer::IndexType::USHORT)
                    .build(*engine);
            
    ```


## 一些有用的类型
* std::string_view
  c++17特性, string_view顾名思义, 就是string的view(笑). std::string_view记录了字符串起始地址与长度, 实现差不多相当于std::pair<char*, size_t>. 可以指向字符串中间的一部分, 所以不一定是`\0`结尾. 注意不能用std::string_view隐式构造std::string, 但反过来是可以的.

  std::string_view还有很多其他用法, 比如以前经常会纠结, 函数参数是用const char*还是const std::string&, 两者不太兼容. 现在可以用std::string_view啦, 用值传才是正确的用法.

  ```c++
  void printValue(std::string_view name);
  ``` 

  注意"std::string_view"不拥有字符串的所有权, 因此只能作为临时变量, 否则可能造成野指针.

* std::map<std::string, int, std::less<>>
  c++14特性, 使用`std::less<>`, 则只需要可以比较就能够根据key搜索value, 并不一定是要相同类型.
  ```c++
  std::map<std::string, int> map_old;
  auto iter = map_old.find(std::string_view("key0")); // 编译失败

  std::map<std::string, int, std::less<>> map_new;
  auto iter2 = map_new.find(std::string_view("key0")); // 正常
  ```

* std::variant
  c++17特性. 实例子: 一元二次方程的求根公式, 根可能是一个, 也有可能是两个, 也有可能没有根.
  ```c++
  using Two = std::pair<double, double>;
  using Roots = std::variant<Two, double, void*>;

  Roots FindRoots(double a, double b, double c)
  {
      auto d = b*b-4*a*c;

      if (d > 0.0)
      {
          auto p = sqrt(d);
          return std::make_pair((-b + p) / 2 * a, (-b - p) / 2 * a);
      }
      else if (d == 0.0)
          return (-1*b)/(2*a);
      return nullptr;
  }

  struct RootPrinterVisitor
  {
      void operator()(const Two& roots) const
      {
          std::cout << "2 roots: " << roots.first << " " << roots.second << '\n';
      }
      void operator()(double root) const
      {
          std::cout << "1 root: " << root << '\n';
      }
      void operator()(void *) const
      {
          std::cout << "No real roots found.\n";
      }
  };

  TEST_F(TestFindRoot) {
      std::visit(RootPrinterVisitor(), FindRoots(1, -2, 1)); //(x-1)*(x-1)=0
      std::visit(RootPrinterVisitor(), FindRoots(1, -3, 2)); //(x-2)*(x-1)=0
      std::visit(RootPrinterVisitor(), FindRoots(1, 0, 2));  //x*x - 2 = 0
  }
  ```
  `std::visit`获取到`std::variant`实际存储的类型的时间复杂度为O(1), 性能不会随着`std::varant`中类型的增多而降低.
  [@使用std::variant](https://zhuanlan.zhihu.com/p/57530780)

  可以配合`std::monostate`来使用, `std::monostate`表示空(variant的index为无效的0).

## 多线程
* std::async
    在实现时仍然会创建新的线程, 参考:https://ddanilov.me/std-async-implementations/, 线程创建耗时或许是0.5ms
* [CTPL](https://github.com/vit-vit/CTPL)
    线程常驻, 用于接收任务

## c++ 编程规范
[华为方舟编译规范](https://www.bookstack.cn/read/openarkcompiler/d2d6358058bab8c5.md)