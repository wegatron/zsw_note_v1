---
tag: algorithms
---
参考: https://colab.research.google.com/drive/1YOLXsb4JUOD1wt5TXB2ln78koocm-bu8?usp=sharing#scrollTo=088kv4mN3Fz8

docker运行:
```bash
sudo docker run --gpus all --rm -v /home/wegatron/win-data/opensource_code:/opensource_code -ti ca04e7f7c8e5 /bin/bash
```
docker中环境配置:
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh
./Miniconda3-py39_4.11.0-Linux-x86_64.sh -b -f -p /usr/local

pip install -U torch torchvision cython moviepy psutil scipy tensorboard ipykernel opencv-contrib-python opencv-python fvcore
conda install -y -c conda-forge pybind11 ceres-solver eigen gtest gflags glog av

apt install \
    git \
    cmake \
    vim \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libdouble-conversion-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libatlas-base-dev \
    libfreeimage-dev \
    protobuf-compiler \
    libprotobuf-dev \
    libglew-dev \
    libglvnd-dev \
    libopencv-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libcgal-qt5-dev \
    libgtk2.0-dev \

# for source code
git clone https://github.com/facebookresearch/detectron2 detectron2
pip install -e detectron2
apt install libfmt-dev nlohmann-json-dev
git clone https://github.com/facebookresearch/robust_cvd.git cvd2
mkdir -p /content/cvd2/lib/build && cd /content/cvd2/lib/build
```

```bash
cd cvd2
python main.py
--video_file family_run.mov \
--path output/family_run_output \
--save_intermediate_depth_streams_freq 1 \
--num_epochs 0 --post_filter \
--opt.adaptive_deformation_cost 10 \
--frame_range 0-10 \
--save_depth_visualization
```

add search path
```cmake
list(APPEND CMAKE_PREFIX_PATH "/opt/conda/include")
list(APPEND CMAKE_PREFIX_PATH "/opt/conda/lib")
```