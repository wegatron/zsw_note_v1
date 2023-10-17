---
tag: programming/objective-c
---
## 代码分析
### 第一份代码
```c++
// 在析构时会打印输出: deallocated [id]
@autoreleasepool
{
    for(int i=0; i<3; ++i)
    {
        printf("init %d\n", i);
        Student *stu = [Student new];
        stu.student_name_ = @"张三";
        stu.id_ = i;  
    }
    _objc_autoreleasePoolPrint();
}
printf("finish!!!\n");
```

output:
```bash
init 0
deallocated 0
init 1
deallocated 1
init 2
deallocated 2
objc[5397]: ##############
objc[5397]: AUTORELEASE POOLS for thread 0x104e04580
objc[5397]: 0 releases pending.
objc[5397]: [0x1]  ................  PAGE (placeholder)
objc[5397]: [0x1]  ################  POOL (placeholder)
objc[5397]: ##############
finish!!!
```
实验下来, 这里`autoreleasepool`加不加结果是一样的. 在for循环下一个循环开始前, 上一个循环的变量就会被析构. 
将oc代码转译为c代码, 加与不加`@autoreleasepool`几乎无区别
```bash
clang -fobjc-arc -rewrite-objc main.m -o main.c
```
```c
/* @autoreleasepool */ { 
__AtAutoreleasePool __autoreleasepool; 
for (int i=0; i<10; ++i)
{
    Student *stu = ((Student *(*)(id, SEL))(void *)objc_msgSend)(
        (id)objc_getClass("Student"), sel_registerName("new"));
    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)stu, 
        sel_registerName("setStudent_name_:"), 
        (NSString *)&__NSConstantStringImpl__var_folders_cx_skw0y8c945g5d97875rg_z700000gn_T_main2_473b6b_mi_0);
    ((void (*)(id, SEL, int))(void *)objc_msgSend)((id)stu, sel_registerName("setId_:"), (int)i);
    _objc_autoreleasePoolPrint();
}
}
```
### 部分第二份代码
参考: [搞懂Objective-C中的ARC](https://www.jianshu.com/p/ed84101e0efe)
```c++
{
    NSString *const_str = @"常量string-no-release";
    NSString *stack_str = [NSString stringWithFormat: @"111"];
    NSString *heap_str_release = [[NSString alloc] initWithFormat:@"堆区string-release"];
    NSString *heap_str_autorelease = [NSString stringWithFormat:@"堆区string-autorelease"];

    printf("const_str size: %lu\n", malloc_size((__bridge const void *)const_str)); // const_str size: 0
    printf("stack_str size: %lu\n", malloc_size((__bridge const void *)stack_str)); // stack_str size: 0
    printf("heap_str_release size: %lu\n", malloc_size((__bridge const void *)heap_str_release)); // heap_str_release size: 64
    printf("heap_str_autorelease size: %lu\n", malloc_size((__bridge const void *)heap_str_autorelease));// heap_str_autorelease size: 64
    
    weak_str_release = heap_str_release;
    weak_str_autorelease = heap_str_autorelease;
    _objc_autoreleasePoolPrint();
}

// weak_str_release: (null)
NSLog(@"weak_str_release: %@\n", weak_str_release);

// weak_str_autorelease: 堆区string-autorelease
NSLog(@"weak_str_autorelease: %@\n", weak_str_autorelease);
_objc_autoreleasePoolPrint();
```
- 字面量创建的直接存储在常量区
- alloc出来的小string直接存储在栈区
- alloc出来的大string存储在堆区并且作用域结束前直接插入release
- 通过stringWithFormat工厂方法创建的对象则在其后插入autorelease, 这是因为工厂方法里面通过alloc分配堆内存, 到返回出来以后其作用域已经结束, 所以只能延迟释放了, 否则没有办法返回非空对象

## MRC retain, release, autorelease
参考:
[YW浣熊的iOS — Retain vs. Release vs. Autorelease](https://medium.com/@yw.raccoon/yw%E6%B5%A3%E7%86%8A%E7%9A%84ios-retain-vs-release-vs-autorelease-bf5c368ba371)
[搞懂Objective-C中的ARC](https://www.jianshu.com/p/ed84101e0efe)

> 由于所有开发者在MRC的世界都需要自己retain以及release, 但有时候并不能因为物件被使用完毕就把他释放掉, 所以为了解决这个问题, iOS提供了「autorelease」
> 
> autorelease只会触发在下一个run loop, 也就是说, 在这一轮run loop中, 他会先为这个物件打一个标签, 并告诉这个物件,「在下一轮的[run loop](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html#//apple_ref/doc/uid/10000057i-CH16-SW1) 才需要被release, 这一轮run loop就先留着待命.  

```c++
NSString *heap_str_autorelease = [NSString stringWithFormat:@"堆区string-autorelease"];
// 在末尾插入了 [[NSString stringWithFormat:@"堆区string-autorelease"] autorelease]
```
值得一提的是，**即便编译器插入autorelease关键字，也不一定会将这个对象放入** autoreleasepool. 为了减轻autoreleasePool的负担, 苹果做了优化.
参考: [iOS 内存管理思考 - autorelease](https://minosjy.com/2021/09/12/18/439/)
苹果引入了(**objc_autoreleaseReturnValue** / **objc_retainAutoreleaseReturnValue**) 用以修饰创建的对象, (**objc_retainAutoreleasedReturnValue** / **objc_unsafeClaimAutoreleasedReturnValue**）用以修饰被赋值的对象.


## autoreleasepool 实现原理
参考: [自动释放池的前世今生](https://draveness.me/autoreleasepool/#AutoreleasePoolPage) [autorleasepool detail](https://juejin.cn/post/6877085831647985677#heading-39)


## 结论

什么时候会添加`autorelease`标记呢？
 在其他函数中创建对象, 并返回时. 例如使用工厂方法创建对象.
 在同一个函数中, 不同作用域之间 __不会__ 添加.


第二份代码
```c++
Student * createStudent(NSString * name, int id)
{
    Student * stu = [[Student alloc] initWithName: name id: id]; 
    return stu;
}

int i = 0;
//@autoreleasepool
{
    Student * heap_stu_release = [[Student alloc] initWithName: @"张三-student-release" id: i];        
    Student * heap_stu_autorelease = createStudent(@"李四-student-auto-release",  i+1);
    Student * heap_stu_release_2 = [[Student alloc] initWithName: @"王五-student-release" id: i+2];
    
    weak_stu_release = heap_stu_release;
    weak_stu_autorelease = heap_stu_autorelease;
    strong_stu_release = heap_stu_release_2;
    _objc_autoreleasePoolPrint();
}

NSLog(@"weak_stu_release: %p\n", weak_stu_release);
NSLog(@"weak_stu_autorelease: %p\n", weak_stu_autorelease);
NSLog(@"strong_stu_release: %p\n", strong_stu_release);
_objc_autoreleasePoolPrint();
```

debug 模式下output:
```bash
const_str size: 0
stack_str size: 0
heap_str_release size: 64
heap_str_autorelease size: 64
heap_stu_release size: 32
heap_stu_autorelease size: 32
objc[6096]: ##############
objc[6096]: AUTORELEASE POOLS for thread 0x105164580
objc[6096]: 2 releases pending.
objc[6096]: [0x12380a000]  ................  PAGE  (hot) (cold)
objc[6096]: [0x12380a038]    0x6000017b8280  __NSCFString
objc[6096]: [0x12380a040]    0x6000002bacc0  Student
objc[6096]: ##############
deallocated 0
2023-05-06 11:15:28.555 test_2[6096:72918] weak_str_release: (null)
2023-05-06 11:15:28.556 test_2[6096:72918] weak_str_autorelease: 堆区string-autorelease
2023-05-06 11:15:28.556 test_2[6096:72918] weak_stu_release: 0x0
2023-05-06 11:15:28.556 test_2[6096:72918] weak_stu_autorelease: 0x6000002bacc0
2023-05-06 11:15:28.556 test_2[6096:72918] strong_stu_release: 0x6000002bace0
objc[6096]: ##############
objc[6096]: AUTORELEASE POOLS for thread 0x105164580
objc[6096]: 2 releases pending.
objc[6096]: [0x12380a000]  ................  PAGE  (hot) (cold)
objc[6096]: [0x12380a038]    0x6000017b8280  __NSCFString
objc[6096]: [0x12380a040]    0x6000002bacc0  Student
objc[6096]: ##############
finish!!!
deallocated 2
```

在release模式下, 编译器会进行优化, **即便编译器插入autorelease关键字，也不一定会将这个对象放入** autoreleasepool. release模式下output:
```bash
const_str size: 0
stack_str size: 0
heap_str_release size: 64
heap_str_autorelease size: 64
heap_stu_release size: 32
heap_stu_autorelease size: 32
objc[6429]: ##############
objc[6429]: AUTORELEASE POOLS for thread 0x102a38580
objc[6429]: 1 releases pending.
objc[6429]: [0x15480a000]  ................  PAGE  (hot) (cold)
objc[6429]: [0x15480a038]    0x600000df8280  __NSCFString
objc[6429]: ##############
deallocated 1
deallocated 0
2023-05-06 11:41:18.240 test_2[6429:83328] weak_str_release: (null)
2023-05-06 11:41:18.241 test_2[6429:83328] weak_str_autorelease: 堆区string-autorelease
2023-05-06 11:41:18.241 test_2[6429:83328] weak_stu_release: 0x0
2023-05-06 11:41:18.241 test_2[6429:83328] weak_stu_autorelease: 0x0
2023-05-06 11:41:18.241 test_2[6429:83328] strong_stu_release: 0x6000018face0
objc[6429]: ##############
objc[6429]: AUTORELEASE POOLS for thread 0x102a38580
objc[6429]: 1 releases pending.
objc[6429]: [0x15480a000]  ................  PAGE  (hot) (cold)
objc[6429]: [0x15480a038]    0x600000df8280  __NSCFString
objc[6429]: ##############
finish!!!
deallocated 2
```

## How to do?


## 附件资源
文档中的完整代码: https://github.com/wegatron/autorelease_pool_test


## Reference
* [搞懂Objective-C中的ARC](https://www.jianshu.com/p/ed84101e0efe) 最重要
* [YW浣熊的iOS — Retain vs. Release vs. Autorelease](https://medium.com/@yw.raccoon/yw%E6%B5%A3%E7%86%8A%E7%9A%84ios-retain-vs-release-vs-autorelease-bf5c368ba371) 重要
* [自动释放池的前世今生](https://draveness.me/autoreleasepool/#AutoreleasePoolPage)
* [detail](https://juejin.cn/post/6877085831647985677#heading-39)