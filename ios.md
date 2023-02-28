---
tag: tools
---
## 常用命令
ios需要编译支持各架构的包, device和simulator的包各包含不同的架构, 因此需要合并.
```bash
lipo -create ./d/libvt2d.a ./s/libvt2d.a -output ./c/libvt2d.a  # 合并库
lipo -info  XXX.a # 显示所支持的平台
lipo -remove arm64 libvt2d.a -output libvt2d_s.a # 移除一个平台支持
```

打包:
```bash
./build_producer.py -t all -p ios
```



cmake - 3.11版本以上, xcode - 12.2版本以上, 编译 mac Big Sur universal库:

利用宏`CMAKE_OSX_ARCHITECTURES` 

```cmake
cmake .. "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64"
```

下载container
`windows` -> `device and simulator` 

## corner stone安装
首先安装, 然后设置:

```bash
xattr -cr /path to application app
```

## TODO

To: shuangluo@apple.com
1. guidedfilter的问题
2. 关于iosLidar的一些效果展示

## 参考资料
[coretext reference online](https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/CoreText_Programming/Overview/Overview.html)
[swift ui book online](https://www.hackingwithswift.com/books/ios-swiftui/integrating-core-image-with-swiftui)
[apple swift tutorial](https://developer.apple.com/tutorials/swiftui/creating-and-combining-views)