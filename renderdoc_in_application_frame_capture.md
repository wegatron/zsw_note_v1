---
tag: cg/graphics_api
---

# RenderDoc In-Application Frame Capture

## Motivation

1. 我们现在的App XiaoYing、VivaCut中使用RenderDoc等工具抓帧结果不稳定.
    
    1. 会抓到额外的绘制, 例如UI
        
    2. 想要抓取的绘制结果可能是黑屏
        
2. 使用In-Application Frame Capture可以在程序中写代码进行进行精细地控制.
    
3. 可以更有效地抓取offscreen的绘制结果.
    

选取RenderDoc对各类GPU支持友好.

## Android接入

Demo: http://gitlab.quvideo.com/xyaicg/kernel/libxyrhi/-/tree/dev/android/in_application_frame_capture

简单来说, 就是不再链接 Android GLES的动态库, 转而链接RenderDoc的动态库: _libVkLayer_GLES_RenderDoc.so_

文件位置, 从renderdoc apk中获取

配置方式:

[demo code in CMakeLists.txt](http://gitlab.quvideo.com/xyaicg/kernel/libxyrhi/-/blob/dev/android/in_application_frame_capture/app/src/main/cpp/CMakeLists.txt#L37)

```C++
add_library(renderdoc SHARED IMPORTED)

# you can find libVkLayer_GLES_RenderDoc.so in renderdoc_1.24/share/renderdoc/plugins/android/*.apk
set_target_properties(renderdoc PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../../../../../../3rd/renderdoc/${ANDROID_ABI}/libVkLayer_GLES_RenderDoc.so)

target_link_libraries( # Specifies the target library.
        opengles_demo
        kiwi_backend_ext
        kiwi_backend
        kiwi_utils
        renderdoc # 这里链接了renderdoc的库原本是链接GLESv2 EGL
        android
        ${log-lib})
```

在Java代码中load renderdoc的动态库:

[code in demo](http://gitlab.quvideo.com/xyaicg/kernel/libxyrhi/-/blob/dev/android/in_application_frame_capture/app/src/main/java/com/zsw/opengles_demo/RendererJNI.java#L15)

```C++
    // Used to load the 'opengles_demo' library on application startup.
    static {
        System.loadLibrary("VkLayer_GLES_RenderDoc");
        System.loadLibrary("opengles_demo");
    }
```

在代码中使用:

```C++
driver->initRenderDocCapture(); // 只需要初始化一次
driver->beginCapture(); // 开始抓帧
driver->endCapture(); // 结束抓帧
```

抓帧后文件存放在 `Android`-> `data`->`com.`**`.`** -> `files`-> `RenderDoc`目录下.
## Linux

_libVkLayer_GLES_RenderDoc.so 替换为 librenderdoc.so_

文件位置: renderdoc_1.24/bin/./../lib/librenderdoc.so