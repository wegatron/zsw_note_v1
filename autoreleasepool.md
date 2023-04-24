```c++
#import <Foundation/Foundation.h>
#include <stdio.h>

@interface Student : NSObject

@property (nonatomic, strong) NSString *student_name_;
@property (nonatomic, assign) int id_;

- (void)dealloc;

@end

@implementation Student

@synthesize student_name_ = _student_name_, id_ = _id_;

- (void)dealloc {
    printf("deallocated %d\n", _id_);
}

@end

void function(Student *stu)
{
    Student * stua = stu;
}


extern void _objc_autoreleasePoolPrint();

int main(int argc, char * argv[])
{
    //@autoreleasepool {
        for (int i=0; i<10; ++i)
        {
            //@autoreleasepool{
            Student *stu = [Student new];
            stu.student_name_ = @"张三";
            stu.id_ = i;
            _objc_autoreleasePoolPrint();
            //}
        }
        printf("done!!!\n");
        {
            Student *stu = [Student new];
            stu.student_name_ = @"张三";
            stu.id_ = 111;
            function(stu);
        }
    //}
    printf("finish!!!\n");
    return 0;
}
```

```c++
#import <Foundation/Foundation.h>
#include <stdio.h>

@interface Student : NSObject

@property (nonatomic, strong) NSString *student_name_;
@property (nonatomic) char * data_array_;
@property (nonatomic, assign) int id_;

- (void)dealloc;
- (instancetype)initWithName:(NSString *)name id:(int)id;

@end

@implementation Student

@synthesize student_name_ = _student_name_, id_ = _id_, data_array_ = _data_array_;

- (void)dealloc {
    free(_data_array_);
    printf("deallocated %d\n", _id_);
}

- (instancetype)initWithName:(NSString *)name id:(int)id {
    self = [super init];
    if (self) {
        _student_name_=name;
        _id_ = id;
        //_data_array_ = (char*)malloc(100000);
    }
    return self;
}

@end

void function(Student *stu)
{
    Student * stua = stu;
}


extern void _objc_autoreleasePoolPrint();

int main(int argc, char * argv[])
{
    //@autoreleasepool {
            Student * stu = [Student new];
            //Student *stu = [[Student alloc]initWithName: @"John" id:0];
            _objc_autoreleasePoolPrint();
    //}
    printf("finish!!!\n");
    return 0;
}
```
实验下来, 这里`autoreleasepool`加不加结果是一样的. 在for循环下一个循环开始前, 上一个循环的变量就会被析构. 与翻译的cpp代码感觉理解上不太一致!!! 所以push和pop的时机到底是怎么样的???

>在Objective-C ARC模式下，即使一个对象的所有强引用都被释放，这个对象也不会立即被释放和回收内存，而是等待系统在适当的时候自动释放和回收内存。具体的规则如下：
>1.  对象会在其所有强引用被释放后立即调用dealloc方法，但是并不会立即释放内存。
>2.  对象的dealloc方法实现中可以执行一些释放内存的操作，例如释放指针、关闭文件等。但是dealloc方法不能直接释放对象本身的内存，因为对象可能在其他地方还有弱引用。
>3.  当对象没有任何强引用时，会被加入到系统的自动释放池中。自动释放池会在适当的时候（例如runloop周期结束）释放其中的所有对象，包括对象本身和其中包含的所有对象。
>4.  对象被加入到自动释放池后，并不意味着对象会立即被释放。实际上，自动释放池只是对对象释放时机的一种控制机制，而对象的释放时机还受到其他因素的影响，例如系统内存的使用情况等。
 from chat gpt  待验证

总之，在Objective-C ARC模式下，即使一个对象的所有强引用都被释放，对象也不会立即被释放和回收内存。对象会在所有强引用被释放后立即调用dealloc方法，然后被加入到系统的自动释放池中，等待自动释放池在适当的时候释放其中的所有对象。


## Reference
* [搞懂Objective-C中的ARC](https://www.jianshu.com/p/ed84101e0efe) 最重要
* [自动释放池的前世今生](https://draveness.me/autoreleasepool/#AutoreleasePoolPage)
* [detail](https://juejin.cn/post/6877085831647985677#heading-39)
* cmake file
	```cmake
	cmake_minimum_required(VERSION 3.10)
	project(zsw_test)
	set(CMAKE_CXX_STANDARD 17)
	set(app_name zsw_test)
	# 设置编译输出的路径
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
	set(CMAKE_XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC "YES")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fobjc-arc") # 对于mm文件必须加这行才能启用ARC
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fobjc-arc")
	#file(GLOB headers *.h *.hpp)
	#file(GLOB src *.cpp *.mm)
	add_executable(${app_name}
	[main.mm](http://main.mm)
	)
	target_link_libraries(${app_name} "-framework CoreFoundation -framework Cocoa")
	```