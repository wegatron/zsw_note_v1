---
tags:
  - digital_human
---

## Linux Maya install
下载: 我的baidu云盘->soft->maya_linux_2023
[Linux install Maya2023](https://www.autodesk.com/support/technical/article/caas/tsarticles/ts/77DVRQ8wFRltRxWlSY4HVt.html)

根据patched->readme.txt进行进一步安装

## DNA-Calib使用
先根据README配置环境
```bash
#add MetaHuman DNA Calibration location to `MAYA_MODULE_PATH` system variable
export MAYA_MODULE_PATH=.../MetaHuman-DNA-Calibration

#If running on Linux, please make sure to append the LD_LIBRARY_PATH with absolute path to the `lib/Maya2022/linux` or `lib/Maya2023/linux` directory before running
export LD_LIBRARY_PATH=.../opensource_code/MetaHuman-DNA-Calibration/lib/Maya2023/linux

#MAYA_PLUGIN
export MAYA_PLUG_IN_PATH=.../opensource_code/MetaHuman-DNA-Calibration/lib/Maya2023/linux
```
在使用前还需要设置python的module path:
```python
from os import path as ospath
from sys import path as syspath
from sys import platform

ROOT_DIR = "/home/wegatron/win-data/opensource_code/MetaHuman-DNA-Calibration"
MAYA_VERSION = "2023"  # or 2023
ROOT_LIB_DIR = f"{ROOT_DIR}/lib/Maya{MAYA_VERSION}"
if platform == "win32":
    LIB_DIR = f"{ROOT_LIB_DIR}/windows"
elif platform == "linux":
    LIB_DIR = f"{ROOT_LIB_DIR}/linux"
else:
    raise OSError(
        "OS not supported, please compile dependencies and add value to LIB_DIR"
    )

# Adds directories to path
syspath.insert(0, ROOT_DIR)
syspath.insert(0, LIB_DIR)

import dna_viewer

dna_viewer.show()
```

## Export CTRL_expression blend shape
参考: additional_assemble_script.py:connect_expressions
```python
connect_expression(
	"CTRL_L_brow_down", # 原始名字
	"ty",
	0.0, 1.0, # min-max 原始range, 无用
	0.0, 1.0, # map range, 有用
	"CTRL_expressions", # 目标名字前缀
	"browDownL", # 目标名字后缀
	0.0, 1.0 # 目标的值
)
```

使用unreal导出CTRL_expressions_...
1. 先将live link数据bake animation sequence
	![[Pasted image 20231025184920.png]]

2. 导出Animation2fbx
	![[Pasted image 20231025185120.png]]
	不要勾选export morph target, 否则导入blender时会出问题
	![[Pasted image 20231025185149.png]]