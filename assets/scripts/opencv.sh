#!/bin/bash
echo "***** Install OpenCV (02/02/2022) *****"
echo "***** 1. Updating & Upgrading in Ubuntu *****"
sudo apt-get update
sudo apt-get upgrade

echo "***** 2. Installing Dependencies *****"
sudo apt install build-essential
sudo apt install gcc cmake git wget unzip

sudo apt install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt install libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
sudo apt install libtiff5-dev libeigen3-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev
# sudo apt install ibgtk2.0-dev sphinx-common yasm libfaac-dev libopencore-amrnb-dev \
#       libgstreamer-plugins-base1.0-dev libavutil-dev libavfilter-dev libavresample-dev libjasper1

echo "***** 3. Getting OpenCV *****"
# sudo -s
# 1. Cloning current branch (current opencv version)
# cd /opt # install in opt
git clone https://github.com/opencv/opencv ~/opencv
git clone https://github.com/opencv/opencv_contrib ~/opencv_contrib
cd ~/opencv/ && git pull origin master && git checkout $1
cd ~/opencv_contrib/ && git pull origin master && git checkout $1
# 2. Change to other versions
# Option 1: checkout
# git checkout 3.4
# Option 2: Download released version https://opencv.org/releases.html
# wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.16.zip
# wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.16.zip
# unzip opencv.zip
# unzip opencv_contrib.zip
# ls -s opencv-3.4.16 opencv # create symbolic link
# ls -s opencv_contrib-3.4.16 opencv_contrib

echo "***** 4. Building and Installing OpenCV *****"
# Change to a specific version. e.g. 3.4.16
# git checkout 3.4
cd ~/opencv/
mkdir -p build && cd build
cmake -D BUILD_TIFF=ON \
      -D WITH_CUDA=OFF \
      -D ENABLE_AVX=OFF \
      -D WITH_OPENGL=OFF \
      -D WITH_OPENCL=OFF \
      -D WITH_IPP=OFF \
      -D WITH_TBB=ON \
      -D BUILD_TBB=ON \
      -D WITH_EIGEN=OFF \
      -D WITH_V4L=OFF \
      -D WITH_VTK=OFF \
      -D BUILD_TESTS=OFF \
      -D BUILD_PERF_TESTS=OFF \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
      -D PYTHON3_EXECUTABLE=$(which python) \
      -D PYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
      -D PYTHON3_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
      -D PYTHON_DEFAULT_EXECUTABLE=$(which python) \
      ~/opencv/
# run from this cmd if /opencv/build/Makefile exited
# git pull
make -j$(nproc --all) # jcore check cores: grep 'cpu cores' /proc/cpuinfo | uniq hoac nproc --all
sudo make install # make global
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
echo "***** Finished *****"
# Check opencv version
pkg-config --modversion opencv 
pkg-config --modversion opencv4
python -c "import cv2; print(cv2.__version__)"