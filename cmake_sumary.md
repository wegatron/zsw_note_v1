---
tag: programming/tools
---
# common.cmake
获取编译器的相关信息,并保存到相应的字段, 作为后缀添加到库或者可执行程序, 用来标记库或程序是由哪种编译器编所编译的, 避免混淆.
```cmake

if(NOT DEFINED BITS)
  if(${CMAKE_SIZEOF_VOID_P} MATCHES "8")
	set(BITS "x64")
  else(${CMAKE_SIZEOF_VOID_P} MATCHES "8")
	set(BITS "32")
  endif(${CMAKE_SIZEOF_VOID_P} MATCHES "8")
endif(NOT DEFINED BITS)

#refere to https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B
if(MSVC)
  if(${MSVC_VERSION} MATCHES "1500")
    set(COMPILER "msvc2008")
  endif(${MSVC_VERSION} MATCHES "1500")
  if(${MSVC_VERSION} MATCHES "1600")
	set(COMPILER "msvc2010")
  endif(${MSVC_VERSION} MATCHES "1600")
  if(${MSVC_VERSION} MATCHES "1700")
    set(COMPILER "msvc2012")
  endif(${MSVC_VERSION} MATCHES "1700")
  if(${MSVC_VERSION} MATCHES "1800")
	set(COMPILER "msvc2013")
  endif(${MSVC_VERSION} MATCHES "1800")
  if(${MSVC_VERSION} MATCHES "1900")
	set(COMPILER "msvc2015")
  endif(${MSVC_VERSION} MATCHES "1900")
  if(${MSVC_VERSION} GREATER 1900)
    set(COMPILER "msvc2017")
  endif(${MSVC_VERSION} GREATER 1900)
endif(MSVC)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm.*|ARM.*)")
  set(PLATFORM "arm")
else(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm.*|ARM.*)")
  set(PLATFORM "x86")
endif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm.*|ARM.*)")

set(CMAKE_DEBUG_POSTFIX _${PLATFORM}_${COMPILER}_${BITS}d)
set(CMAKE_RELEASE_POSTFIX _${PLATFORM}_${COMPILER}_${BITS})
```
# cmake_self.cmake
用来指定本地机器上的一些库的位置(for windows).
```cmake
# 因为机器上有不同版本的qt,设置当前使用的qt版本，只对vs有效.
set(ACTIVE_QT_DIR "D:/usr/qt5.9/5.9.6/msvc2017_64")
set(CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH};${ACTIVE_QT_DIR}")

set(VTK_DIR "D:/usr/VTK/lib/cmake/vtk-8.0")
set(FLANN_ROOT "d:/usr/FLANN")
set(EIGEN_INCLUDE_DIRS "D:/usr/eigen-3.3.5")
set(G2O_ROOT "D:/usr/g2o")
set(BOOST_ROOT "d:/usr/boost_1_68_0")
set(PCL_DIR "d:/usr/pcl1.8.1")
list(APPEND CMAKE_MODULE_PATH "d:/usr/cmake_modules")
list(APPEND CMAKE_PREFIX_PATH "d:/usr/pcl1.8.1/cmake")
list(APPEND CMAKE_PREFIX_PATH "D:/usr/opencv3.4.1/opencv/build")

# 对于无法安装cuda的机器,直接将cuda的库保存到一个目录并设置好该变量即可找到cuda
#set(CUDA_TOOLKIT_ROOT_DIR "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v7.0")
# set(ENV{LIBRARY_INSTALL_PATH} ${CMAKE_SOURCE_DIR}/../package)
#set(3rd_libs_dir ${CMAKE_SOURCE_DIR}/3rd)
```

# 主要文件 CMakeLists.txt
该文件的基本写法
```cmake
cmake_minimum_required(VERSION 3.10)
project(xxx)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall -march=native")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall")

# 在linux上, 启用在可执行程序的目录下搜索依赖库
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-rpath='$ORIGIN',--enable-new-dtags")

set(app_name xxx)

include($ENV{HOME}/usr/cmake_modules/cmake_self.cmake)
include($ENV{HOME}/usr/cmake_modules/common.cmake)

# 设置编译输出的路径
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin)

file(GLOB headers *.h *.hpp)
file(GLOB src *.cpp)

add_executable(${app_name}
${headers}
${src}
)

target_link_libraries(${app_name}
...
)

# 可执行程序的后缀需要额外设置
set_target_properties(${app_name} PROPERTIES
DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
RELEASE_POSTFIX ${CMAKE_RELEASE_POSTFIX}
COMPILE_FLAGS "/MP")

# configure the project to set some debug parameters in VS
configure_file(${CMAKE_SOURCE_DIR}/vs.user.in ${app_name}.vcxproj.user)

# 设置启动项目, 必须在最外层的CMAKELists.txt中设置
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${app_name})

# 可执行程序安装的基本设置
install(TARGETS ${app_name} RUNTIME DESTINATION .)
install(CODE 
"include(BundleUtilities)
fixup_bundle(${CMAKE_INSTALL_PREFIX}/${app_name}${CMAKE_RELEASE_POSTFIX}.exe \"\" \"${path}\")")
```



# 一些基本的库的find
* Boost
```cmake
find_package(Boost COMPONENTS system filesystem REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIRS})
# target_link_libraries(${app_name} ${Boost_LIBRARIES})
```

* Qt
```cmake
# 自动moc, uic 和 rcc
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
file(GLOB ui_files *.ui)
file(GLOB resource_files *.qrc)
# 在配置lib或exe时需要将resource 文件和 ui 文件添加进去
# add_executable(${app_name} ${headers} ${ui_files} ${resource_files})
find_package(Qt5 COMPONENTS Core Gui Widgets REQUIRED)
# target_link_libraries(${app_name} Qt5::Core Qt5::Gui Qt5::Widgets)
```

* Vtk
```cmake
find_package(VTK REQUIRED)
include_directories(${VTK_INCLUDE_DIRS})
# ${VTK_LIBRARIES} for link
```

* PCL
```cmake
find_package(PCL 1.8 REQUIRED COMPONENTS common features filters kdtree ml octree registration io segmentation visualization)
include_directories(${PCL_INCLUDE_DIRS})
add_definitions(${PCL_DEFINITIONS})
# for link ${PCL_LIBRARIES}
```

* G2O
官方的FindG2O.cmake有问题，会不断地添加第三方库如Boost,导致链接的库list过长, 从而链接程序无法正常工作, 修改参考我的github.
```cmake
find_package(G2O REQUIRED)
include_directories(${G2O_INCLUDE_DIR})
include_directories(${G2O_INCLUDE_DIR}/g2o/EXTERNAL/csparse)
# for link ${G2O_LIBRARIES}
```

* opencv
```cmake
#opencv
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
# ${OpenCV_LIBS}
```

* openmp
```cmake
#openmp
find_package(OpenMP REQUIRED)
target_link_libraries(${app} OpenMP::OpenMP_CXX)
```

# 一些有用的命令
* 代码分组 for `vs`
```cmake
# 最简单的是已有文件列表，直接打包成组, 可以有多级组, 之间用\\分开
source_group(src\\utils FILES ${utils_src})
# 复杂一点是用正则表达式分组
source_group(src\\utils REGULAR_EXPRESSION  ".*/src/")
```

* 添加目录列表中的源代码并按照目录分组 for `vs`
```cmake
# directories list
set(sub_dirs "dir_a" "dir_b" "dir_c")
foreach(dir ${sub_dirs})
    file(GLOB dir_headers ${dir}/*.h ${dir}/*.hpp)
    file(GLOB dir_src ${dir}/*.cpp)
    list(APPEND header ${dir_headers})
    list(APPEND src ${dir_src})
    source_group(headers\\${dir} FILES ${dir_headers})
    source_group(src\\${dir} FILES ${dir_src})
endforeach()
```

* 项目分组 for `vs`
```cmake
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_target_properties(${app_name} PROPERTIES FOLDER Test)
```

* 使用了Qt的项目的安装
使用了Qt的项目，除了动态链接的库外, 还需要对应的Qt的platform的相关文件, 可以在cmake中加入如下命令来进行自动拷贝
```cmake
install(CODE
"execute_process(COMMAND ${ACTIVE_QT_DIR}/bin/windeployqt.exe \"--release\" \"--plugindir\" \"${CMAKE_INSTALL_PREFIX}\" \"--no-translations\" \"--no-system-d3d-compiler\" \"${CMAKE_INSTALL_PREFIX}/${app_name}${CMAKE_RELEASE_POSTFIX}.exe\")")
```

## GLSL编译
```cmake
function(add_shader target glsl_shader_path)
	set(current-output-path ${glsl_shader_path}.spv)
	add_custom_command(
		OUTPUT ${current-output-path}
		COMMAND Vulkan::glslc -o ${current-output-path} ${glsl_shader_path}
		DEPENDS ${glsl_shader_path}
		IMPLICIT_DEPENDS CXX ${glsl_shader_path}
		VERBATIM)
	set_source_files_properties(${current-output-path} PROPERTIES GENERATED TRUE)
	target_sources(${target} PRIVATE ${current-output-path})
endfunction(add_shader)

file(GLOB shaders_files shaders/*.vert shaders/*.frag)

foreach(shader_file ${shaders_files})
	add_shader(render ${shader_file})
endforeach(shader_file)
```

参考: https://zhuanlan.zhihu.com/p/95771200
https://github.com/ARM-software/vulkan-sdk/blob/master/Sample.cmake



CMake Build Type

RelWithDebugInfo

```
string( REPLACE "/DNDEBUG" "" CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}") # windows
if (CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
	string( REPLACE "-DNDEBUG" "" CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}") #gcc/ clang
else
```

## Android
```bash
cmake
-Hpath/to/cmakelists/folder
-Bpath/to/generated/ninja/project/debug/ABI
-DANDROID_ABI=ABI                               // For example, arm64-v8a
-DANDROID_PLATFORM=platform-version-string      // For example, android-16
-DANDROID_NDK=android-sdk/ndk/ndk-version
-DCMAKE_TOOLCHAIN_FILE=android-sdk/ndk/ndk-version/build/cmake/android.toolchain.cmake
-G Ninja
```


# 一些问题和注意点
1. 问题: 在linux机器上编译完成后, 只会到编译时的绝对路径下寻找链接库, 无法从当前目录下去寻找动态链接库.
    编译时指定可以从`LD_LIBRARY_PATH`中搜索动态链接库:
    
    ```cmake
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-rpath='$ORIGIN',--enable-new-dtags")
    set(CMAKE_INSTALL_PATH_USE_LINK_PATH TRUE)
    ```
    这里`Wl`指的是启用`,`连接的这种表示方法, `-rpath=$ORIGIN`表示将可执行程序的当前目录加入到`rpath`中, `--enable-new-dtags`表示使用新的格式(旧的格式不支持在`rpath`中搜索动态链接库).
    
    设置`LD_LIBRARY_PATH`启动
    ```bash
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./
    ```
    参考:[How executable look for dynamic library](https://unix.stackexchange.com/questions/22926/where-do-executables-look-for-shared-objects-at-runtime)