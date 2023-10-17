---
tag: programming/cpp
---
# 从汇编角度优化C++代码性能

## 编译命令参数

* c++得到汇编代码
    可以使用如下命令来得到c++代码对应的汇编代码:

    ```bash
    gcc -O3 -fomit-frame-pointer -fverbose-asm -S main.cpp -o /tmp/main.S
    ```

    // armv8 自动矢量化
    ```bash
    ./android_sdk/ndk/21.2.6472646/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android26-clang++ -target armv8 -mfloat-abi=hard -O3 -S tmp.cpp -o tmp.S
    ```

    也可以使用在线的工具: https://godbolt.org/

* `-march=native`
    让编译器自动判断当前支持的指令(如AVX), 若不加入, 则使用保守的策略. 若加入则可能对程序移植到其他机器上可能无法运行.

## 减少程序的分支
>Jumps/branches are expensive. Minimize their use whenever possible

分支预判, 帮助编译器进行指令预读取:
```c++
// compatibility with non-clang compilers...
#ifndef __has_attribute
#define __has_attribute(x) 0
#endif
#ifndef __has_builtin
#define __has_builtin(x) 0
#endif

#if __has_builtin(__builtin_expect)
#   ifdef __cplusplus
#      define MATH_LIKELY( exp )    (__builtin_expect( !!(exp), true ))
#      define MATH_UNLIKELY( exp )  (__builtin_expect( !!(exp), false ))
#   else
#      define MATH_LIKELY( exp )    (__builtin_expect( !!(exp), 1 ))
#      define MATH_UNLIKELY( exp )  (__builtin_expect( !!(exp), 0 ))
#   endif
#else
#   define MATH_LIKELY( exp )    (exp)
#   define MATH_UNLIKELY( exp )  (exp)
#endif
```

## 访存优化
* 数据存放位置 全局、堆、栈?
    * 栈上(访存速度很快), 包含局部变量, 函数参数等
        >If there are no big arrays, then it is almost certain that this part of the memory is mirrored in the level-1 data cache, where it is accessed quite fast.

    * 全局和static
        程序启动时就会被初始化, 并能够在任意时刻被访问. 但正是因为可能在任意时刻被访问, 缓存会变得低效.
        >The advantage of static data is that it can be initialized to desired values before the program
        starts. The disadvantage is that the memory space is occupied throughout the whole
        program execution, even if the variable is only used in a small part of the program. This
        makes data caching less efficient.

        合理减少全局变量的使用，对于多个函数需要访问同一个变量,可以将变量作为一个类的成员.

    * 堆

* 将需要同时用到的数据和函数放到一起. AOT or TOA, 同时需要考虑是否利于矢量化.
    将可能需要同时访问的数据打包到一起，比如顶点的Attribute: position, normal

* 减少局部变量，当局部变量很少的时候可以保存在寄存器中, 从而提升速度. (在for循环中，简单的局部变量如int速度比使用全局的要快, 无关性更好, 保存在寄存器中的话.)

* 合理选择遍历的顺序, 2D, 行优先、列优先、Block优先.


## 矢量化/SIMD



## 类型转换的开销
float, int 使用不同的寄存器, cast需要拷贝.
> Integer and floating point instructions often operate on different registers, so a cast requires a copy.
short 和 char 也同样需要一个通用大小的寄存器, 而且在保存时需要额外的开销.

在机器上进地址计算时, 也可能需要进行类型转换:

```c++
int func(int * a, int b)
{
    return a[b];
}

// 对应的汇编代码, 需要先转换类型
func(int*, int):                             # @func(int*, int)
    movsxd  rax, esi
    mov     eax, dword ptr [rdi + 4*rax]
    ret

// 使用std::size_t
int func(int * a, std::size_t b)
{
    return a[b];
}

// 对应的汇编代码
func(int*, unsigned long):                             # @func(int*, unsigned long)
    mov     eax, dword ptr [rdi + 4*rsi]
    ret
```


## 合理利用查表
内存的寻址也很耗时，综合考虑是否查表

## 构造函数
* 简化默认构造函数
* 使用初始化列表
>Use constructor initializer lists. (Use Color::Color() : r(0), g(0), b(0) {} rather than Color::Color() { r
= g = b = 0; } .)

## 延后局部变量的定义
变量定义时一般需要调用构造函数, 被使用时才去定义, 可减少不必要的开销.

## 减少动态内存的申请
动态内存的申请通常需要调用锁,所以很影响并行的效率. 就算是单线程的程序,在堆上申请内存也比在栈上申请更慢(系统需要寻找一个合适大小的memory block)
>The process of dynamic allocation and deallocation of memory takes much more
time than other kinds of storage.

>There is no reason to use dynamic memory allocation
when the size of an array or the number of objects is known at compile time or a reasonable
upper limit can be defined.

## 循环的优化
* 对于大部分复杂的循环, 考虑提前退出可以避免很多不必要的计算. 或者将一个循环拆分，以减少不必要的计算(如得分表优化的例子, 先选出最近点，后计算与最近点的关系). 对于简单的循环，添加退出分支可能会导致效率变低.

* 循环的展开
    ```c++
    for(int i=0; i<100; ++i) { a[i] = b[i] + 1; }
    // change to
    for(int i=0; i<100; i+=4)
    {
        a[i] = b[i] + 1;
        a[i+1] = b[i+1] + 1;
        a[i+2] = b[i+2] + 1;
        a[i+3] = b[i+3] + 1;
    }
    ```

## 数学公式的优化
在纸上优化数学公式，避免不必要的计算或者重复计算.
* 乘法比除法快(如果多次使用除x,可以先计算1/x)，并使用乘法

## int, 32位浮点, 64位浮点的计算量差异并不大
>* On modern CPUs, floating-point operations have essentially the same throughput as integer operations.
In compute-intensive programs like ray tracing, this leads to a negligable difference between integer and
floating-point costs. This means, you should not go out of your way to use integer operations.
> * Double precision floating-point operations may not be slower than single precision floats, particularly on
64-bit machines. I have seen ray tracers run faster using all doubles than all floats on the same machine. I
have also seen the reverse

# 一些与程序performance相关的基本知识
## CISC和RISC平台的优劣
>The CISC instruction set may actually be better than RISC in situations where code caching is critical.

## 32位和64位程序的优劣
>The 64-bit systems can improve the performance by 5-10% for some CPU-intensive applications with many function calls.

64位程序的优势:
* 64位程序可用的寄存器数量比32多一倍
* 64位程序函数参数通过寄存器传递(32位程序通过栈传递)
* 64位程序在申请和释放大块内存时效率更高
* 64位可用SSE2指令集合

劣势:
* 指针使用64位表示, 影响cache的命中率
* 一些指令的长度更长

![x64寄存器](rc/x64_registers.png)

* 寄存器
    浮点数和整型使用不同类型的寄存器.
    >Floating point variables use a different kind of registers. There are eight floating point
    registers available in 32-bit operating systems and sixteen in 64-bit operating systems.

* volatile
    保证变量不被优化保存到寄存器中, 可用来测试保证有些b表达式被优化.
    >The effect of the keyword volatile is that it makes sure the variable is stored in memory
    rather than in a register and prevents all optimizations on the variable. This can be useful in
    test situations to avoid that some expression is optimized away.

## 编译优化

* `-O1`
* `-O2`
* `-O3`

### 固定值预计算/常量折叠
```c++
int func()
{
    int a = 32;
    int b = 10;
    return a+b;
}

//汇编代码
func():
    mov     eax, 42
    ret
```

### 循环展开
当循环内的代码过于简单时, 时间大部分消耗在判断循环是否结束上, 很是浪费. 通过循环展开可以消除这种情况. 该过程编译器自动会做, 不建议手动.

```c++
void func(float * a)
{
    for(auto i=0; i<1024; ++i)
    {
        a[i] = i;
    }
}

// 汇编代码
.LCPI0_0:
        .long   0                               # 0x0
        .long   1                               # 0x1
        .long   2                               # 0x2
        .long   3                               # 0x3
.LCPI0_1:
        .long   4                               # 0x4
        .long   4                               # 0x4
        .long   4                               # 0x4
        .long   4                               # 0x4
.LCPI0_2:
        .long   8                               # 0x8
        .long   8                               # 0x8
        .long   8                               # 0x8
        .long   8                               # 0x8
.LCPI0_3:
        .long   12                              # 0xc
        .long   12                              # 0xc
        .long   12                              # 0xc
        .long   12                              # 0xc
.LCPI0_4:
        .long   16                              # 0x10
        .long   16                              # 0x10
        .long   16                              # 0x10
        .long   16                              # 0x10
func(float*):                              # @func(float*)
        movdqa  xmm0, xmmword ptr [rip + .LCPI0_0] # xmm0 = [0,1,2,3]
        xor     eax, eax
        movdqa  xmm1, xmmword ptr [rip + .LCPI0_1] # xmm1 = [4,4,4,4]
        movdqa  xmm2, xmmword ptr [rip + .LCPI0_2] # xmm2 = [8,8,8,8]
        movdqa  xmm3, xmmword ptr [rip + .LCPI0_3] # xmm3 = [12,12,12,12]
        movdqa  xmm4, xmmword ptr [rip + .LCPI0_4] # xmm4 = [16,16,16,16]
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
        movdqa  xmm5, xmm0
        paddd   xmm5, xmm1
        cvtdq2ps        xmm6, xmm0
        cvtdq2ps        xmm5, xmm5
        movups  xmmword ptr [rdi + 4*rax], xmm6
        movups  xmmword ptr [rdi + 4*rax + 16], xmm5
        movdqa  xmm5, xmm0
        paddd   xmm5, xmm2
        movdqa  xmm6, xmm0
        paddd   xmm6, xmm3
        cvtdq2ps        xmm5, xmm5
        cvtdq2ps        xmm6, xmm6
        movups  xmmword ptr [rdi + 4*rax + 32], xmm5
        movups  xmmword ptr [rdi + 4*rax + 48], xmm6
        add     rax, 16
        paddd   xmm0, xmm4
        cmp     rax, 1024
        jne     .LBB0_1
        ret
```


### 将与循环无关的代码移到循环外
```c++
void func(float *__restrict a, float *__restrict b, float dt)
{
    for(auto i=0; i<1024; ++i)
        a[i] = b[i] * (dt * dt); // 这里dt*dt会被预计算(移动到循环外)
}


void func(float *__restrict a, float *__restrict b, float dt)
{
    for(auto i=0; i<1024; ++i)
        a[i] = b[i] * dt * dt; // 这里由于乘法顺序, dt*dt不会被预先计算
}
```

对于循环中特殊的`if`分支也会移动到外部:
```c++
void other();
void func(float * a)
{
    for(auto i=0; i<1024; ++i)
    {
        // 当i=0,1,2,3,4,5,6,1023时, 能够矢量化成功, 部分会被移动到for外部
        if(i == 1)
        {
            other();
        } else {
            a[i] = i+1;
        }
    }
}
```

### 化简
```c++
int func(int a, int b)
{
    int c = a + b;
    int d = a - b;
    return (c+d)/2;
}

// 汇编代码, 直接返回a
func(int, int):
    mov     eax, edi
    ret
```

代码尽量写得简单, 使得编译器生成的抽象语法树不那么复杂, 代码过于复杂，涉及的语句数量过多时，编译器会放弃优化！ 例如:
```c++
int func()
{
    int sum = 0;
    for(int i=0; i<100; ++i)
    {
        sum += i;
    }

    return sum;
}

// 优化结果
func():
    mov     eax, 4950
    ret


// 以下代码编译器不会进行优化
int func()
{
    std::array<int, 100> arr;
    for(std::size_t i=0; i<100; ++i)
    {
        arr[i] = i;
    }

    int ret = 0;
    for(auto i=0; i<100; ++i)
    {
        ret += arr[i];
    }

    return ret;
}

int func()
{
    std::vector<int> data;
    for(int i=0; i<100; ++i)
    {
        data.emplace_back(i);
    }

    return std::reduce(data.begin(), data.end());
}
```

### 内联
使用内联, 让编译器视野更大, 从而更有机会优化.
`inline`关键词没有任何意义. 在现代编译器中, 完全由编译器决定.
这里所谓的内联是指, 将函数调用和函数定义存放在同一个文件中.

```c++
int other(int a);
int func() {
    return other(233);
}

// 汇编代码
func():
    mov     edi, 233
    jmp     other(int)
```

### 指针别名问题
`__restric`可以用来表示输入的指针, 其所使用到的内存不会有重合.
```c++

// 为了覆盖b==c情况, 汇编代码会非常复杂
void func(int * a, int *b, int *c)
{
    *c = *a;
    *c = *b;
}

// 使用__restric关键字来告诉编译器
void func(int *__restric a, int *__restric b, int *__restric c)
{
    *c = *a;
    *c = *b;
}

// __restrict 只需要加在所有具有写入访问的指针（这里是 c）上，就可以优化成功
```

* 合并写入
中间不能有间隙
```c++
void func(int *a)
{
    a[0] = 111;
    a[1] = 222;
    a[2] = 333;
    a[3] = 444;
}

// 汇编代码
func(int*):
    movdqa  xmm0, XMMWORD PTR .LC0[rip]
    movups  XMMWORD PTR [rdi], xmm0
    ret
.LC0:
    .long   111
    .long   222
    .long   333
    .long   444
```

数组清零和拷贝
```c++
void func(int * a, int n)
{
    for(auto i=0; i<n; ++i)
    {
        // 这里只有在a[i] = 0时才会被用到, 若令a[i] = 1则会矢量化赋值
        // 另外, memset还会绕过缓存, 直接写入, 因此少一次读取过程的时间消耗
        a[i] = 0;
    }
}

//汇编代码调用memset
func(int*, int):
    test    esi, esi
    jle     .L1
    mov     esi, esi
    lea     rdx, [0+rsi*4]
    xor     esi, esi
    jmp     memset
.L1:
        ret


void func(int *__restrict a, int *__restrict b, int n)
{
    for(auto i=0; i<n; ++i)
    {
        a[i] = b[i];
    }
}

//汇编代码
func(int*, int*, int):
    test    edx, edx
    jle     .L1
    mov     edx, edx
    sal     rdx, 2
    jmp     memcpy
.L1:
    ret
```

### 自动矢量化
* 矢量化基础
    除了自行编写SIMD代码外, 编译器在编译代码时也会帮我们将一些不太复杂的代码优化成SIMD实现.
    x64中我们可以通过查看汇编代码如果是`p*`的指令, 说明矢量化成功, `s*`指令说明矢量化失败.
    ```c++
    // 汇编代码
    addss %xmm1, %xmm0 // 第一个s表示标量(向量使用p表示), 第二个s表示单精度浮点数. 一个float加法
    addsd %xmm1, %xmm0 // 一个double加法
    addps %xmm1, %xmm0 // 四个float加法
    addpd %xmm1, %xmm0 // 两个double加法

    paddd ...
    ```

    对于ARM, android, 在编译时需要加上`-target armv8  -mfloat-abi=hard`, 自动开启矢量优化.
    arm中矢量化的汇编代码应该是`v*`
    ```c++
    vldr    s0, [r3]
    vadd.f32 s0, s2, s0
    ```

* SIMD加速数据填充:
    ```c++
    void func(int *a)
    {
        for(auto i=0; i<1024; ++i)
        {
            a[i] = i;
        }
    }

    // 汇编代码
    func(int*):
            movdqa  xmm0, XMMWORD PTR .LC0[rip]
            movdqa  xmm2, XMMWORD PTR .LC1[rip]
            lea     rax, [rdi+4096]
    .L2:
            movdqa  xmm1, xmm0
            add     rdi, 16
            paddd   xmm0, xmm2 // 矢量化相加4个int
            movups  XMMWORD PTR [rdi-16], xmm1
            cmp     rax, rdi
            jne     .L2
            ret
    .LC0:
            .long   0
            .long   1
            .long   2
            .long   3
    .LC1:
            .long   4
            .long   4
            .long   4
            .long   4
    ```

    ```c++
    void func(int *__restrict a, int *__restrict b, int n)
    {
        for(auto i=0; i<n; ++i)
        {
            a[i] += b[i];
        }
    }
    ```

* SIMD数组求和
    ```c++
    int func(int *a)
    {
        int ret = 0;
        for(auto i=0; i<1024; ++i)
        {
            ret += a[i];
        }
        return ret;
    }

    // 汇编代码, 打字可以看到循环展开, 分批计算, 求和
    func(int*):                              # @func(int*)
            pxor    xmm0, xmm0
            xor     eax, eax
            pxor    xmm1, xmm1
    .LBB0_1:                                # =>This Inner Loop Header: Depth=1
            movdqu  xmm2, xmmword ptr [rdi + 4*rax]
            paddd   xmm2, xmm0
            movdqu  xmm0, xmmword ptr [rdi + 4*rax + 16]
            paddd   xmm0, xmm1
            movdqu  xmm1, xmmword ptr [rdi + 4*rax + 32]
            movdqu  xmm3, xmmword ptr [rdi + 4*rax + 48]
            movdqu  xmm4, xmmword ptr [rdi + 4*rax + 64]
            paddd   xmm4, xmm1
            paddd   xmm4, xmm2
            movdqu  xmm2, xmmword ptr [rdi + 4*rax + 80]
            paddd   xmm2, xmm3
            paddd   xmm2, xmm0
            movdqu  xmm0, xmmword ptr [rdi + 4*rax + 96]
            paddd   xmm0, xmm4
            movdqu  xmm1, xmmword ptr [rdi + 4*rax + 112]
            paddd   xmm1, xmm2
            add     rax, 32
            cmp     rax, 1024
            jne     .LBB0_1
            paddd   xmm1, xmm0
            pshufd  xmm0, xmm1, 238                 # xmm0 = xmm1[2,3,2,3]
            paddd   xmm0, xmm1
            pshufd  xmm1, xmm0, 85                  # xmm1 = xmm0[1,1,1,1]
            paddd   xmm1, xmm0
            movd    eax, xmm1
            ret
    ```

* 指针别名问题
    ```c++
    // 这里编译器会考虑a与b所指向的数组是否会有重合, 例如b = a+1
    // 因此需要生成两份代码
    void func(int *a, int *b)
    {
        for(auto i=0; i<1024; ++i)
            a[i] = b[i] + 1;
    }

    // 使用__restrict来解决该问题
    void func(int *__restrict a, int *b)
    {
        for(auto i=0; i<1024; ++i)
            a[i] = b[i] + 1;
    }

    // 或者使用omp 无视指针别名 强制矢量化
    void func(int *a, int *b)
    {
        #pragma omp simd
        for(auto i=0; i<1024; ++i)
            a[i] = b[i] + 1;
    }
    ```

* 在for循环内调用非内联函数, 或者随机/跳跃访问均会使得编译器自动矢量化失败.
    ```c++
    void func(float *a)
    {
        float ret = 0;
        for(auto i=0; i<1024; ++i)
        {
            ret += a[i];
            other(); // 调用其他非内联函数, 就算other()什么都不做, 都无法矢量化
        }
    }

    // 部分矢量化成功, 很艰难
    void func(float *a)
    {
        for(auto i=0; i<1024; ++i)
        {
            a[i * 2] += 1;
        }
    }


    // 矢量化失败
    void func(float *a, int *b)
    {
        for(auto i=0; i<1024; ++i)
        {
            a[b[i]] += 1;
        }
    }
    ```

* 数据结构对矢量化的影响
    ```c++
    struct MyVec
    {
        float x;
        float y;
    };

    MyVec a[1024];

    void func()
    {
        for(auto i=0; i<1024; ++i)
        {
            a[i].x *= a[i].y;
        }
    }

    // 矢量化成功, 汇编代码
    func():                               # @func()
            mov     rax, -8192
    .LBB0_1:                                # =>This Inner Loop Header: Depth=1
            movaps  xmm0, xmmword ptr [rax + a+8208]
            movaps  xmm1, xmmword ptr [rax + a+8192]
            movaps  xmm2, xmm1
            shufps  xmm2, xmm0, 136                 # xmm2 = xmm2[0,2],xmm0[0,2]
            shufps  xmm1, xmm0, 221                 # xmm1 = xmm1[1,3],xmm0[1,3]
            mulps   xmm1, xmm2
            movss   dword ptr [rax + a+8192], xmm1
            movaps  xmm0, xmm1
            shufps  xmm0, xmm1, 85                  # xmm0 = xmm0[1,1],xmm1[1,1]
            movss   dword ptr [rax + a+8200], xmm0
            movaps  xmm0, xmm1
            unpckhpd        xmm0, xmm1                      # xmm0 = xmm0[1],xmm1[1]
            movss   dword ptr [rax + a+8208], xmm0
            shufps  xmm1, xmm1, 255                 # xmm1 = xmm1[3,3,3,3]
            movss   dword ptr [rax + a+8216], xmm1
            add     rax, 32
            jne     .LBB0_1
            ret
    a:
            .zero   8192

    //---------------------------------------------------------------------------------

    struct MyVec
    {
        float x;
        float y;
        float z;
    };

    MyVec a[1024];

    void func()
    {
        for(auto i=0; i<1024; ++i)
        {
            a[i].x *= a[i].y;
        }
    }

    //矢量化失败, 汇编代码
    func():                               # @func()
            mov     rax, -12288
    .LBB0_1:                                # =>This Inner Loop Header: Depth=1
            movss   xmm0, dword ptr [rax + a+12292] # xmm0 = mem[0],zero,zero,zero
            mulss   xmm0, dword ptr [rax + a+12288]
            movss   dword ptr [rax + a+12288], xmm0
            movss   xmm0, dword ptr [rax + a+12304] # xmm0 = mem[0],zero,zero,zero
            mulss   xmm0, dword ptr [rax + a+12300]
            movss   dword ptr [rax + a+12300], xmm0
            add     rax, 24
            jne     .LBB0_1
            ret
    a:
            .zero   12288
    ...
    ```

## 访存优化


# 参考资料
* https://github.com/parallel101/course/tree/master/04
* https://github.com/parallel101/course/tree/master/07
* https://people.cs.clemson.edu/~dhouse/courses/405/papers/optimize.pdf
* Optimizing software in C++ An optimization guide for Windows, Linux and Mac platforms(By Agner Fog. Technical University of Denmark)
