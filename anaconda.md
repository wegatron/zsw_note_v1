---
tag: programming_language/python
---
# Python版本管理
## Anaconda和conda
conda可以理解为一个工具，也是一个可执行命令，其核心功能是包管理与环境管理
Anaconda则是一个打包的集合，里面预装好了conda、某个版本的python、众多packages、科学计算工具等等，所以也称为Python的一种发行版.
## 基本命令

* 创建环境
    ```bash
    conda create -n [env_name] python=3.6
    conda create -n [env_name] --clone [base_name]
    conda evn create -f requirement.yaml
    ```

    创建环境时可能同时需要requirements.yaml(conda)和requirements.txt(pip). requirements.yaml的格式如下：
    ```yaml
    name: audio2mesh # 环境的名字
    channels: # 用到的channels
    - huggingface
    - pytorch
    - fastai
    - https://mirrors.sustech.edu.cn/anaconda-extra/cloud/nvidia/ #nvidia
    - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ #conda-forge
    - defaults
    dependencies:
    - python=3.10 # python版本
    - pytorch>=2.0.0 # 各个包的版本
    - torchvision>=0.15.0
    - torchaudio==2.0.0
    - pytorch-cuda==11.8  
    - pytorch-lightning
    - ...
    ```

* 环境管理
	* 删除
		```bash
		conda env remove -n [ENV_NAME]
	   ```
	 * 根据requirement.yml更新	   
		```bash
		conda env update --file env.yml --prune
	    ```
	   * list package
		  ```bash
		  conda list
		  ```

* 工具更新命令
    ```bash
    # 工具自身更新
    conda update conda
    conda update anaconda
    conda update anaconda-navigator
    ```

## 镜像
国内的一些源:
* 清华大学镜像
    ```yaml
    channels:
        - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
        - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
        - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
        - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
    ```

* 上海交通大学镜像
    ```yaml
    channels:
        - https://mirrors.sjtug.sjtu.edu.cn/anaconda/pkgs/main/
        - https://mirrors.sjtug.sjtu.edu.cn/anaconda/pkgs/free/
        - https://mirrors.sjtug.sjtu.edu.cn/anaconda/cloud/conda-forge/
    ```

* 中国科学技术大学镜像
    ```yaml
    channels:
        - https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
        - https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
        - https://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
    ```
* nvidia镜像
    ```yaml
    https://mirrors.sustech.edu.cn/anaconda-extra/cloud/nvidia/
    ```

将其他路径添加到env路径

```bash
conda config --add envs_dirs /big_partition/users/user/.conda/envs
```

## micromamba
强烈推荐使用micromamba(c++实现, 单个可执行程序)替换conda, 依赖关系处理速度特别快.
```bash
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
```

设置micromamba的environment
```bash
micromamba shell init -p [your path]
```