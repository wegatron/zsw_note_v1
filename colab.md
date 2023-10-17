---
tags:
 - programming/tools
---
## colab environment setup

安装anaconda

```jupter
!pip install -q condacolab
import condacolab
condacolab.install()

# refer to https://pypi.org/project/condacolab/
!mamba env update -n base -f environment.yml
!mamba install openmm
```

colab环境一般会预先安装各种常用的库, 因此可以省略这些库的安装.
比如: numpy pytorch opencv-python pandas ...


## colab 代码调试

初始化:
```python
!pip install -Uqq ipdb
import ipdb
```

设置breakpoint, 在代码中添加:
```python
ipdb.set_trace()
```

[Debugging in Google Colab notebook](https://zohaib.me/debugging-in-google-collab-notebook/)