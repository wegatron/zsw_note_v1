---
tag: programming_language
---
# iOS Objective-C And Swift

## Objective-C中的基本概念
### Interface & Implementation
```objective-c
@import 
#import
#include
@interface MyObject : NSObject {
    int memberVar1; // 实体变量
    id  memberVar2;
}
@property (nonatomic, strong) id<protocols> memberName; // 表示遵循protocol

+(return_type) class_method; // 类方法

-(return_type) instance_method1; // 实例方法
@end
```

## Objective-C Memory Management
通过NSObject实现引用计数, 以两种方式来管理.
* "Manual Retain-Release" or MRR (手动)
    * 对象创建(new, alloc, copy, mutableCopy)时引用计数为1.
    * 在两种情况下使用`retain`来增加引用计数:
        ① 有些函数会要求传入对象的所有权(函数退出时可能需要手动release一次);
        ② 保证对象是有效的.
    * 使用`release`来减少引用计数.

* 🥝"Automatic Reference Counting" or ARC (自动)
    自动的方式使用相同的机制实现引用计数, 在编译阶段自动插入代码来维护引用计数. (推荐使用)
    ```objective-c
    @autoreleasepool { ... }
    ```

## 深入理解 Objective-c
使用命令行编译, 理解objective-c的类, example code:
```objective-c
#include <AppKit/AppKit.h>
int main (int argc, char **argv) {
    @autoreleasepool {
        // 创建一个 NSObject 的实例对象
        NSObject *obj = [[NSObject alloc] init];
    }
    return 0;
}
```

```objective-c
#include <AppKit/AppKit.h>

@interface HHStaff : NSObject {
    NSString *name;
}

- (void)doInstanceStaffWork; // 对象方法
+ (void)doClassStaffWork;    // 类方法

@end

@interface HHManager : HHStaff {
    NSInteger officeNum;
}

- (void)doInstanceManagerWork; // 对象方法
+ (void)doClassManagerWork;    // 类方法
@end

int main (int argc, char **argv) {
    @autoreleasepool {
        // 创建实例对象
        HHManager *mgr = [[HHManager alloc] init];
    }
    return 0;
}
```

```bash
# 编译
gcc -arch arm64 -g main.m -lobjc -framework Foundation -framework Cocoa -framework AppKit -o main

# 将objective-c 转化为c++metal
clang -rewrite-objc main.m -o main.cpp
```

## Bridge

1. `__bridge`
    CF和OC对象转化时只涉及对象类型不涉及对象所有权的转化

    ```c++
    //Image I/O 从 NSBundle 读取图片数据
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)
    [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"]], NULL);
    ```

2. `__bridge_transfer`
    常用在CF对象转化成OC对象时，将CF对象的所有权交给OC对象，此时ARC就能自动管理该内存,作用同CFBridgingRelease()


3. `__bridge_retained`
    与__bridge_transfer 相反，常用在将OC对象转化成CF对象，且OC对象的所有权也交给CF对象来管理，即OC对象转化成CF对象时，涉及到对象类型和对象所有权的转化，作用同CFBridgingRetain()

## Swift

## reference
[The Objective-C Language](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocDefiningClasses.html#//apple_ref/doc/uid/TP30001163-CH12-SW2)
[objective-c turtorial](https://www.tutorialspoint.com/objective_c/objective_c_memory_management.htm)
[What does id<…> mean in Objective-C?](https://stackoverflow.com/questions/19812515/what-does-id-mean-in-objective-c)
[ios application](https://www.tutorialspoint.com/ios/ios_first_iphone_application.htm)
[Objective-C Property Attributes](https://academy.realm.io/posts/tmi-objective-c-property-attributes/#:~:text=Strong%20just%20means%20you%20have,and%20released%20back%20into%20memory.)
[深入理解 Objective-C Class](https://www.jianshu.com/p/241e8be676a9)
[Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html)
[🏂🏽 Objective-C MemoryMangement](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmRules.html#//apple_ref/doc/uid/20000994-BAJHFBGH)
[🏂🏽 Objective-C MemoryManagemegt of Core Fundation](https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFMemoryMgmt/Concepts/Ownership.html#//apple_ref/doc/uid/20001148-CJBEJBHH)
[🐿 禅与 Objective-C 编程艺术](https://objc-zen-book.books.yourtion.com/Chapter02/03-nil-and-bool-checks.html)