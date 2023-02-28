---
tag: programming_language/python
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