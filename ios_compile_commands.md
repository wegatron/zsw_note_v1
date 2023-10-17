---
tag: programming/tools
---
## 常用命令
ios需要编译支持各架构的包, device和simulator的包各包含不同的架构, 因此需要合并.
```bash
lipo -create ./d/libvt2d.a ./s/libvt2d.a -output ./c/libvt2d.a  # 合并库
lipo -info  XXX.a # 显示所支持的平台
lipo -remove arm64 libvt2d.a -output libvt2d_s.a # 移除一个平台支持
```