---
tag: programming/cpp
---
# C++  Interface to python by boost
## CMake 配置
首先CMake需要包含的库`boost`中的`python`模块, 以及`python`.
```cmake
# python
find_package(PythonInterp REQUIRED)
find_package(PythonLibs REQUIRED)
include_directories(${PYTHON_INCLUDE_DIRS})
```
这里我用的是anaconda python 3.7
![python](python.png)

添加boost的python模块, 不同版本的boost对应不同的python版本, 这里我用的是boost1.68
```cmake
# boost add python module
find_package(Boost COMPONENTS  filesystem python37 REQUIRED)
add_definitions(-DBOOST_PYTHON_STATIC_LIB) # 这里必须使用静态库
# add_definitions(-DBOOST_SYSTEM_NO_DEPRECATED)
include_directories(${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIRS})
```

与`add_executable`和`add_library`不同, 了生成`pyd`文件需专用宏:
```cmake
PYTHON_ADD_MODULE(${name} ${files})
target_link_libraries(${name}
...
${Boost_LIBRARIES}
${PYTHON_LIBRARIES})
```

__注意: 这里`module`的name必须和生成的pyd文件名一致.__

一个坑, 当CMake中同时使用`pcl`和`boost python`时, 将`boost python`放在`find pcl`之后. 不然`boost python`会被移除.

## 导出c++中的类以及接口
导出类的函数中:`init`是构造函数(必须导出), 其他需要导出的函数以`.def`开头, 第一个参数是在python中使用的名字, 第二个参数是函数指针:
```c++
#include <boost/python.hpp>

class range_image_encorder
{
public:
	range_image_encorder(int width, int height, int low_crf, std::string speed_setting,
		std::string high_h264_filepath, std::string low_h264_filepath);
	bool encode_one_frame(std::string range_img_data_filepath);
	void done();
private:
	int width_;
	int height_;
	std::shared_ptr<h264_encoder_ffmpeg> high_encorder_;
	std::shared_ptr<h264_encoder_ffmpeg> low_encorder_;
};

BOOST_PYTHON_MODULE(range_image_codec) {
	using namespace boost::python;
	class_<range_image_encorder>("range_image_encorder",
        init<int, int, int, std::string, std::string, std::string>())
        .def("encode_one_frame", &range_image_encorder::encode_one_frame)
        .def("done", &range_image_encorder::done);

    class_<range_image_decorder>("range_image_decorder",
        init<int, int, std::string, std::string>())
        .def("decode_one_frame", &range_image_decorder::decode_one_frame);
}
```

## 在python中使用
生成对应的pyd文件后, 需要配置环境变量`path`, 使得pyd依赖的dll能够被找到, 并将pyd文件放到工作目录下, 即可进行`import` 使用.
```python
import range_image_codec

codec = range_image_codec.range_image_decorder(16, 1800, 
file_dir+'/high_'+str(self.index_)+'.h264', 
file_dir+'/low_'+str(self.index_)+'.h264');

codec.decode_one_frame(tmp_data_file)
```

## Numpy中的数据在python 与 c++之间传递
https://zhuanlan.zhihu.com/p/56360503