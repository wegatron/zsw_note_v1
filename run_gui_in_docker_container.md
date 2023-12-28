---
tag: programming/tools
---
## 在Docker容器中运行GUI程序
Windows需要安装[VcXsrv](https://sourceforge.net/projects/vcxsrv/)
创建容器(安装一些必要GUI库):

```bash
FROM ubuntu:latest

RUN apt update \
    && apt install -y libgtk2.0-0 \
    && apt install -y libsm6
```

```bash
FROM archlinux:latest

RUN pacman -Sy \
    && pacman -Sy --noconfirm libxext libsm libxrender fontconfig gnu-free-fonts glu core/libxcrypt-compat gdk-pixbuf2 pixman libthai glibc
```

```bash
docker build . -t arch_gtk:zsw
```

运行命令
```bash
docker run -it --rm -e DISPLAY="host.docker.internal:0.0" -v e:/data/volumes:/var/lib/data a773e0dcb44d /var/lib/data/eureqa/eureqa.sh
```

for linux
在宿主机器上允许本地用户访问
```bash
xhost +local:
```

用完后可以去除:
```bash
xhost -local:
```
```bash
sudo docker run -it --rm -e --net=host --env="DISPLAY" -v /home/wegatron/opt/Faceform_Wrap_2023.6.4_Linux:/wrap -v /tmp/.X11-unix:/tmp/.X11-unix 19d365edb7b6 /bin/bash
```


这里, `DISPLAY`设置的是XServer服务器的位置, 参考[这个帖子](https://stackoverflow.com/questions/24319662/from-inside-of-a-docker-container-how-do-i-connect-to-the-localhost-of-the-mach#:~:text=docker%20run%20%2D%2Dnetwork%3D%22host%22&text=Such%20a%20container%20will%20share,opened%20on%20the%20docker%20host.)
>  If you are using Docker-for-mac or Docker-for-Windows 18.03+, just connect to your mysql service using the host host.docker.internal (instead of the 127.0.0.1 in your connection string)

使用volume挂载磁盘.

## Reference
[Docker for Windows运行GUI程序](https://www.cnblogs.com/larva-zhh/p/10531824.html)

