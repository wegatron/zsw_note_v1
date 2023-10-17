---
tag: programming/tools
---
## Target
1. 抠像, occlusion
    __front camera:__
    [Using AVFoundation’s AVCapturePhotoOutput, your app can find out whether a particular camera configuration supports the delivery of a portrait effect mattes to still images, and opt in to have them delivered on a per-photo request basis. AVCapturePhotoOutput delivers photo results using an in-memory wrapper object called AVCapturePhoto.](https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/enhancing_live_video_by_leveraging_truedepth_camera_data)

    __🍎rear camera with lidar:__
    [use segmentationBuffer and estimatedDepthData to implement people occlusion yourself.](https://developer.apple.com/documentation/arkit/arconfiguration/3089121-framesemantics)
 
2. 将人物移动到相同场景的同一个位置.
    [ARBodyAnchor](https://developer.apple.com/documentation/arkit/arbodytrackingconfiguration) + 场景scanning

3. 自拍效果，您可以在脸部网格上渲染半透明的纹理，以实现虚拟纹身或脸部涂料等效果，或者进行化妆，留胡须或胡须，或者用珠宝，面具遮盖网格， 帽子和眼镜。

4. 面部捕捉，您可以实时捕捉面部表情并将其用作将表情投影到虚拟角色或游戏中角色的装备。


## Apple Arkit
1. 🍋scanning & reconstruction (point cloud, mesh)
    demo
2. 🍋Location anchor
3. sematic information
    * 🍋classification
    * motion capture
    * tracking
    * 🍋people occlution
    >We have a new property on ARConfiguration called FrameSemantics.
    This will give you different kinds of semantic information of what's in the current frame.
    You can also check if a certain semantic is available on the specific configuration or device with an additional method on the ARConfiguration.
    Specific for people occlusion, there are two methods available that you can use. One option is person segmentation.
    This will-- you provide just with the segmentation of people rendered on top of the camera image.
    That's the best choice if you know that people will always be standing upfront and your virtual content will always be behind those people.

### Framework & API Reference
* [ARConfiguration](https://developer.apple.com/documentation/arkit/arconfiguration)
    不同的业务需求使用不同的configuration实体(algorithm flow), 并可以进行一些功能是否启用的配置.
* [ARSession](https://developer.apple.com/documentation/arkit/arsession)
    算法流的构建, 并管理硬件以及算法流程的(SLAM)状态:
    1. 管理硬件(camera, gps, lidar, gryo)
    2. 根据configuration, 组建并管理算法流程
* [ARAnchor](https://developer.apple.com/documentation/arkit/aranchor)

* [ARFrame](https://developer.apple.com/documentation/arkit/arframe)
    ARFrame获取的两种方式: 推送式(为ARSession注册`delegate`), 主动获取`currentFrame`.

## Apple Realitykit
RealityKit provides photo-realistic rendering, camera effects, animations, physics, and a lot more. It was built from the ground up specifically for AR.

1. physics interaction between virtual objects and real ones
2. rendering
    * occlusion
    * real and virtual illumination both real and unreal object
    >And ARKit uses your face as a light probe to estimate lighting conditions, and generates spherical harmonics coefficients that you can apply to your rendering.
3. Face tracking, 

## 参数
Lidar 60HZ
Front depth image 15HZ

## AR相关的信息、资料
* [Spark AR Studio](https://sparkar.facebook.com/ar-studio/)
    face book的AR 滤镜制作/设计工具(无需写代码)

* [ARCore Depth API1](https://developers.googleblog.com/2020/06/a-new-wave-of-ar-realism-with-arcore-depth-api.html)

* [ARCore Depth API2](https://www.infoq.com/news/2020/06/ARCore-depth-api-released/)
    两个project: [lines-of-play](https://github.com/googlecreativelab/lines-of-play), [arcore-depth-lab](https://github.com/googlesamples/arcore-depth-lab/)


## 其他
双摄深度图判断:
```c++
AVCapturePhotoOutput* photoOutput = [[AVCapturePhotoOutput alloc] init];
 if ([photoOutput isDepthDataDeliverySupported]) {
            
       }
```

## Reference
🍅[Explore Arkit4 Notes](https://www.wwdcnotes.com/notes/wwdc20/10611/)
[app galary](https://github.com/olucurious/Awesome-ARKit)