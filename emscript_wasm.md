环境安装, 参考: https://emscripten.org/docs/getting_started/downloads.html

```bash
# Get the emsdk repo
git clone https://github.com/emscripten-core/emsdk.git
# Enter that directory
cd emsdk
git pull
./emsdk install latest
./emsdk activate latest
```

cmake配置:
"CMAKE_TOOLCHAIN_FILE": "/home/wegatron/win-data/opensource_code/emsdk/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake"