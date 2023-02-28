---
tag: tools
---
# Docker 小记
## 基本概念&原理

## 安装
```bash
# 安装必要包
sudo apt install apt-transport-https ca-certificates curl software-properties-common
# 为国内的 azure 仓库添加 GPG Key
curl -fsSL https://mirror.azure.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# 添加 docker 仓库到 Apt 源
sudo add-apt-repository "deb [arch=amd64] https://mirror.azure.cn/docker-ce/linux/ubuntu focal stable"
# 安装
sudo apt update
sudo apt install docker-ce docker-compose
```

## 常用命令
### 镜像管理
1. 列出已经下载的镜像: `docker image ls`
2. 镜像获取: `docker pull`
    国内镜像加速:
    * [Azure 中国镜像](https://dockerhub.azk8s.cn)
    * [阿里云加速器(需登录账号获取)](https://cr.console.aliyun.com/cn-hangzhou/mirrors)
    * [网易云加速器](https://hub-mirror.c.163.com)
    指定镜像源:
    ```bash
    docker pull dockerhub.azk8s.cn/library/node
    ```
3. 镜像删除: `docker image rm [repository_name:tag]`

### 容器运行和管理
1. 新建一个容器并启动: `docker run [options] [image] [...]`
    ```bash
    ## 执行一条命令
    docker run ubuntu:18.04 /bin/echo 'Hello world'

    ## 打开伪终端 -t
    ## 打开标准输入流 -i
    ## 这里不会执行完
    docker run -ti ubuntu:18.04 /bin/bash # 执行bash
    docker run -dit ubuntu:18.04 # 默认的entrypoint
    docker run -p 127.0.0.1:80:8080/tcp ubuntu bash # 将容器的8080端口映射到宿主机的80端口
    ```
    执行完毕后容器被终止.


2. 启动一个处于终止状态的容器: `docker container start [name]`

3. 终止容器: `docker container stop [name]`

4. 进入容器(执行容器中的一个命令比如进入bash): `docker exec`(从终端退出, 不会终止), `docker attach`
    ```bash
    docker exec -it 6914
    docker attach -it 6914 #进入
    ```

4. 列出所有容器: `docker container ls -a`

4. 删除处于终止状态的容器: `docker container rm`

5. 清理所有属于终止状态的容器: `docker container prune`


## Docker file
### FROM命令
FROM 指定基础镜像, 是必备的指令，并且必须是第一条指令. dockerhub上的一些常用的基础镜像:
service: `nginx`、`redis`、`mongo`、`mysql`、`httpd`、`php`、`tomcat`. 
basic system: `ubuntu`、`debian`、`centos`、`fedora`、`alpine` 

### RUN命令
Dockerfile 中每一个指令都会建立一层，RUN 也不例外。每一个 RUN 的行为，就和刚才我们手工建立镜像的过程一样：新建立一层，在其上执行这些命令，执行结束后，commit 这一层的修改，构成新的镜像。

错误写法, 构建过多层:
```bash
FROM debian:stretch

RUN apt-get update
RUN apt-get install -y gcc libc6-dev make wget
RUN wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz"
RUN mkdir -p /usr/src/redis
RUN tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1
RUN make -C /usr/src/redis
RUN make -C /usr/src/redis install
```

正确写法:
```bash
FROM debian:stretch

RUN buildDeps='gcc libc6-dev make wget' \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
    && mkdir -p /usr/src/redis \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && make -C /usr/src/redis \
    && make -C /usr/src/redis install \
    && rm -rf /var/lib/apt/lists/* \
    && rm redis.tar.gz \
    && rm -r /usr/src/redis \
    && apt-get purge -y --auto-remove $buildDeps
```

### 将container保存到image
```bash
docker save [container]
```

### VOLUME命令
容器运行时应该尽量保持容器存储层不发生写操作, 对于需要动态改动的数据应当保存于卷(volume)中. 在Docker file中通过`VOLUME`命令来指定某些目录挂载为匿名卷(无法指定挂载到的宿主机目录, 因此会默认挂载到宿主机的/var/lib/docker/volumes下的一个随机名称的目录下). 

```bash
Step 6 : VOLUME /var/lib/mysql
---> Running in 0c842ec90849
---> 214e3dccd0f2
```

通过inspect该镜像生成的容器可以发现挂载配置:
```
"Mounts": [
    {
        "Name": "8827c361d103c1272907da0b82268310415f8b075b67854f27dbca0b59a31a1a",
        "Source": "/mnt/sda1/var/lib/docker/volumes/8827c361d103c1272907da0b82268310415f8b075b67854f27dbca0b59a31a1a/_data",
        "Destination": "/var/lib/mysql",
        "Driver": "local",
        "Mode": "",
        "RW": true,
        "Propagation": ""
    }
]
```

在运行时, run的-v可以指定挂载到宿主机的哪个目录.
```bash
docker run --name mysql -v ~/volume/mysql/data:/var/lib/mysql -d mysql:5.7
```

## Docker镜像构建
命令: `docker build [选项] <上下文路径/URL/->`(这里上下文路径为`.`, 上下文路径对拷贝文件等命令有效), 实例:
```bash
$ docker build -t nginx:v3 .
Sending build context to Docker daemon 2.048 kB
Step 1 : FROM nginx
 ---> e43d811ce2f4
Step 2 : RUN echo '<h1>Hello, Docker!</h1>' > /usr/share/nginx/html/index.html
 ---> Running in 9cdc27646c7b
 ---> 44aa4490ce2c
Removing intermediate container 9cdc27646c7b
Successfully built 44aa4490ce2c
```

## Docker运行Nvidia

安装`nvidia-toolkit`:
对于mint需要根据`os-release`, 以及nvidia官网, 查看Identifier, linux mint20.3对应的是`ubuntu20.04`
```bash
#distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
distribution=ubuntu20.04 \
    && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
    && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

运行docker:
```bash
sudo docker run --gpus all --rm -v /home/wegatron/win-data/opensource_code:/opensource_code -ti ca04e7f7c8e5 /bin/bash
```

测试
```bash
nvidia-smi
```

在使用gcc编译包含有cuda头文件的cpp文件的时候出现cuda_runtime_api.h中未定义某类变量的错误 [参考](https://blog.csdn.net/mingyuan_liu/article/details/106210424)
```bash
/usr/local/cuda/include/cuda_runtime_api.h:9580:60: error: ‘cudaGraphExec_t’ was not declared in this scope
 extern __host__ cudaError_t CUDARTAPI cudaGraphExecDestroy(cudaGraphExec_t graphExec);
                                                             ^~~~~~~~~~~~~~~
 /usr/local/cuda/include/cuda_runtime_api.h:9580:60: note: suggested alternative: ‘cudaGraphExecUpdate’
extern __host__ cudaError_t CUDARTAPI cudaGraphExecDestroy(cudaGraphExec_t graphExec);
                                                             ^~~~~~~~~~~~~~~
                                                             cudaGraphExecUpdate
/usr/local/cuda/include/cuda_runtime_api.h:9600:56: error: ‘cudaGraph_t’ was not declared in this scope
 extern __host__ cudaError_t CUDARTAPI cudaGraphDestroy(cudaGraph_t graph);
 ^~~~~~~~~~~
/usr/local/cuda/include/cuda_runtime_api.h:9600:56: note: suggested alternative: ‘cudaError_t’
 extern __host__ cudaError_t CUDARTAPI cudaGraphDestroy(cudaGraph_t graph);
                                                         ^~~~~~~~~~~
                                                         cudaError_t
 src/caffe/CMakeFiles/caffe.dir/build.make:503: recipe for target 'src/caffe/CMakeFiles/caffe.dir/blob.cpp.o' failed
 make[2]: *** [src/caffe/CMakeFiles/caffe.dir/blob.cpp.o] Error 1
CMakeFiles/Makefile2:426: recipe for target 'src/caffe/CMakeFiles/caffe.dir/all' failed
make[1]: *** [src/caffe/CMakeFiles/caffe.dir/all] Error 2
Makefile:129: recipe for target 'all' failed
```
原因： /usr/include在gcc中的搜索优先级高于其他路径，因此当cuda_runtime_api.h在/usr/local/cuda/include文件夹下，而driver_types.h在/usr/include存在，则会优先去匹配/usr/include下的driver_types.h文件，从而造成两个文件冲突.

## 编译器

```bash
docker run --rm -v e:/opensource_code:/code -p 127.0.0.1:4000:4000 -ti 1d503e41c3c0 /bin/bash
gdbserver :4000 ./xxx
```

提交镜像
```bash
docker commit -a "wegatron" -m "install ***" -p [container id] [rep:tag]
```

## Reference
[docker小记](https://yeasy.gitbooks.io/docker_practice/content/image/build.html)
[docker volume](https://www.binss.me/blog/learn-docker-with-me-about-volume/)
[docker使用GPU总结](https://blog.csdn.net/weixin_43975924/article/details/104046790)