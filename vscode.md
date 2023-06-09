---
tag: tools
---
## git
gitlen, gitkaren的插件

## python 环境配置
1. 安装`Python IntelliSense(Pylance), Lighting Debuging`插件.
2. 选择python环境`CTRL`+`SHIFT`+`P`, `python:Select Interpreter`.
3. 添加运行参数. 切换到调试界面, 修改configuration
    ```json
    {
        // Use IntelliSense to learn about possible attributes.
        // Hover to view descriptions of existing attributes.
        // For more information, visit: 
        // https://go.microsoft.com/fwlink/?linkid=830387
        "version": "0.2.0",
        "configurations": [
            {
                "name": "Python: Current File",
                "type": "python",
                "request": "launch",
                "program": "${file}",
                "console": "integratedTerminal",
                "args":["-p", "linux"],
                "justMyCode": true
            }
        ]
    }
    ```

## C++/CMake 环境配置

1. 安装插件
    * CMake
    * CMake Tools

2. 点击下方statusbar上的`CMake`选择`tool-kit`进行编译.
    选择一次之后, 默认会使用之前选择的`tool-kit`, 若想改换其他`took-kit`, 则可以通过命令`CTRL`+`SHIFT`+`P`, `cmake: select kit`进行配置

3. cmake 参数设置
    与cmake-gui的用法一样, 在configure完成之后, 通过命令 `cmake: Edit CMake Cache` 对cmake参数进行修改.

4. 调试环境配置
    configure完成之后, 在下方`task bar`上进行编译. 
    * 对于没有输入参数以及环境变量设置的程序, 可以直接点击`task bar`上的调试按钮进行调试. 
    * 通过右边的工具栏, 打开调试工具栏目, 点击右上方齿轮按钮, 进行调试环境json设置.
		若没有该选项(可能是个bug), 可以在当前目录下创建`.vscode/launch.json`
        ```json
        {
        // Use IntelliSense to learn about possible attributes.
        // Hover to view descriptions of existing attributes.
        // For more information, visit: 
        // https://go.microsoft.com/fwlink/?linkid=830387
        "version": "0.2.0",
        "configurations": [
            {
                "name": "(gdb) Launch",
                "type": "cppdbg",
                "request": "launch",
                // Resolved by CMake Tools:
                "program": "${command:cmake.launchTargetPath}",
                "args": [],
                "stopAtEntry": false,
                "cwd": "${workspaceFolder}",
                "environment": [
                    {
                        // add the directory where our target 
                        // was built to the PATHs
                        // it gets resolved by CMake Tools:
                        "name": "PATH",
                        "value": "$PATH:${command:cmake.launchTargetDirectory}"
                    },
                    {
                        "name": "OTHER_VALUE",
                        "value": "Something something"
                    }
                ],
                "externalConsole": true,
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ]
            }
        }        
```
使用Clang + lldb， linux安装`clang libc++ libc++abi`
在使用cmake生成项目时:
```bash
cmake .. `-DCMAKE_C_COMPILER=clang-10 -DCMAKE_CXX_COMPILER=clang-10'`
```
一般在linux上, 由于很多第三方库编译时使用的是libstdc++(g++的库), 所以还是链接libstdc++.
vscode安装codelldb插件.
clang用来编译比g++运行更高效(但是代码规范要求更高, 很多代码可能编译不过), 对于debug程序需要在cmake上加入`-fno-limit-debug-info` .
```
{
    "name": "debug lunch",
    "type": "lldb",
    "request": "launch",
    // Resolved by CMake Tools:
    "program": "${command:cmake.launchTargetPath}",
    "args": [],
    "cwd": "${workspaceFolder}"
}
```
使用CMakePreset.json后需要在cacheVariables中指定CMAKE_BUILD_TYPE="Debug"才能用vscode进行调试.

gdb命令, 需要在debug console中添加 `-exec` 然后再输入gdb命令.

memory break point
```
-exec watch *(int*)0xb79b90
```

clang 使用`libc++`:
```cmake
if (NOT APPLE AND ${CMAKE_CXX_COMPILER} MATCHES "(C|c?)lang")
    add_link_options(-stdlib=libc++)
    add_compile_options(-stdlib=libc++)
endif()
```

windows上配置调试
```
"configurations": [
      {
        "name": "C/C++: cl.exe build and debug active file",
        "type": "cppvsdbg",
        "request": "launch",
        "program": "${command:cmake.launchTargetPath}",
        "args": [],
        "stopAtEntry": false,
        "cwd": "${workspaceFolder}",
        "environment": [
            {
                "name": "PATH",
                "value": "$PATH:${command:cmake.launchTargetDirectory}"
            }
        ],
        "externalConsole": false
      }
    ]
```

## clang-format

* `Ctrl` + `Shift` + `P`  -> User Settings -> 搜索 `clang`, Formatting -> clang fallback style(后备style文件, 若style文件找不到则使用该文件) LLVM, style(优先使用) LLVM

使用clang-format command line format 文件:
```
clang-format -i --style=LLVM *.h
```

## 搜索消失

若搜索栏与`explore`显示在一起, 进入`Explore`, 在搜索区域上右键, `reset search...`.

其他, 在左侧`activity`栏中右键, `search`上打钩.

## 文件过滤(不显示)

`file` -> `settings` -> `files exclude`