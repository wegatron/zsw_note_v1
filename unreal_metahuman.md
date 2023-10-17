---
tags:
- cg/tools
- digital_human
---

## Linux install Quixel Bridge
[官网](https://www.unrealengine.com/en-US/linux)直接下载, Linux_Unreal_Engine_5.1.0.zip, Linux_Bridge_5.1.0_2022.1.0.zip. 将后者内容覆盖到前者对应目录中去即可.

## Mesh to MetaHuman
其基本原理是对输入的mesh进行关键点检测, 拟合得到一个metahuman head.

用来将Mesh转为MetaHuman, [官方文档](https://docs.metahuman.unrealengine.com/en-US/mesh-to-metahuman-quick-start-in-unreal-engine/)
当下只支持windows: https://www.unrealengine.com/marketplace/en-US/product/metahuman-plugin
![[rc/ue_mesh2metahuman.png]]

安装完成后, 需要在unreal editor->plugin启用该插件
![[rc/ue_enable_plugin.png]]

## 参考
[Unreal MetaHuman Documentation](https://docs.metahuman.unrealengine.com/en-US/)

Quixel Bridge plugin doc:
https://docs.unrealengine.com/5.0/en-US/quixel-bridge-plugin-for-unreal-engine/
epic game launcher(只支持windows) 需要参考如下方式进行安装:
https://www.youtube.com/watch?v=clh9qjYOqqA