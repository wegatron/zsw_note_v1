---
tag: programming_language/python
---
# Python版本管理
## Anaconda和conda
这里先解释下conda、anaconda这些概念的差别.
conda可以理解为一个工具，也是一个可执行命令，其核心功能是包管理与环境管理.包管理与pip的使用类似，环境管理则允许用户方便地安装不同版本的python并可以快速切换.可以把 conda 看作是 pip + virtualenv + PVM (Python Version Manager) + 一些必要的底层库，也就是一个更完整也更大的集成管理工具.

Anaconda则是一个打包的集合，里面预装好了conda、某个版本的python、众多packages、科学计算工具等等，所以也称为Python的一种发行版.其实还有Miniconda，顾名思义，它只包含最基本的内容——python与conda，以及相关的必须依赖项，对于空间要求严格的用户，Miniconda是一种选择.

## 基本命令
注意这里为了与ros共存, 将.bashrc中的conda初始化注释掉了, 因此使用conda之前打开.bashrc中的注释

```bash
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/wegatron/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/wegatron/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/wegatron/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/wegatron/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
```

更新命令
```bash
# 工具自身更新
conda update conda
conda update anaconda
conda update anaconda-navigator
```

激活环境
```bash
conda activate [env_name]
```

创建环境
```bash
conda create -n [env_name] python=3.6

# 根据env.yml创建环境
conda env create -f env.yml

# 安装env.yml中的包, --prune uninstalls dependencies which were removed from env.yml
conda env update --file env.yml --prune
```

拷贝环境

```
conda create -n [env_name] --clone [base_name]
```

删除环境
```bash
conda env remove -n [ENV_NAME]
```

list包
```bash
conda list # 列举当前环境下所有包
conda list -n [env_name] # 列举指定环境下所有包
```

安装package
```bash
conda install -n [env_name] [package_name]
```

使用pip安装到指定environment下(pip可能与conda不兼容, 不推荐使用)
```bash
activate [env_name]
[env_name_path]/pip install [package name]
```

清除索引缓存，保证用的是镜像站提供的索引
```bash
conda clean -i
```

当安装被意外中断时, 再次安装可能会出现`segmentation fault`, 此时可以清理掉所有缓存:
```bash
conda clean -a
```

国内的一些源:
* 清华大学镜像
    ```
    channels:
        - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
        - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
        - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
        - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
    ssl_verify: true
    ```

* 上海交通大学镜像
    ```
    channels:
        - https://mirrors.sjtug.sjtu.edu.cn/anaconda/pkgs/main/
        - https://mirrors.sjtug.sjtu.edu.cn/anaconda/pkgs/free/
        - https://mirrors.sjtug.sjtu.edu.cn/anaconda/cloud/conda-forge/
    ssl_verify: true
    ```

* 中国科学技术大学镜像
    ```
    channels:
        - https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
        - https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
        - https://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
    ssl_verify: true
    ```

anaconda-navigator在linux上不是很好用, 不推荐.
__最佳的安装方法__: 在[conda的官网](https://anaconda.org/anaconda/repo)上搜索相应的包, 然后根据命令安装.
常用的包:
```bash
conda install -y -c anaconda numpy
conda install -y -c conda-forge matplotlib
conda install -y -c open3d-admin open3d
conda install -y -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/linux-64/ pytorch torchvision
conda install -y -c conda-forge tqdm vtk pandas scikit-learn pyntcloud
conda install -y -c conda-forge tensorboardx protobuf fire
```

## cuda安装
ubuntu 18.04 使用源中的驱动即可, 然后根据官网的安装教程, 使用network deb的方式安装即可.