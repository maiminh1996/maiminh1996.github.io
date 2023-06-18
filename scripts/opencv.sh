#!/bin/bash
# opencv.sh
echo "***** Install OpenCV (02/02/2022) *****"
echo "***** 1. Updating & Upgrading in Ubuntu *****"
sudo apt-get update
sudo apt-get upgrade

echo "***** 2. Installing Dependencies *****"
sudo apt-get install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python3.6-dev python3-numpy libtbb2 libtbb-dev
sudo apt-get install libjpeg-dev libpng-dev libtiff5-dev libdc1394-22-dev libeigen3-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev sphinx-common libtbb-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenexr-dev libgstreamer-plugins-base1.0-dev libavutil-dev libavfilter-dev libavresample-dev libjasper-dev

echo "***** 3. Getting OpenCV *****"
cd # install in home, choose a release
# sudo -s
# 1. Cloning current branch (current opencv version)
# cd /opt # install in opt
git clone https://github.com/opencv/opencv
git clone https://github.com/opencv/opencv_contrib
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
# cd ~/opencv/ && git checkout 3.4.16
cd ~/opencv/ && git checkout $1
cd ~/opencv_contrib/ && git checkout $1
# Change to a specific version. e.g. 3.4.16
# git checkout 3.4
cd ~/opencv/
mkdir -p build && cd build
cmake -D BUILD_TIFF=ON -D WITH_CUDA=OFF -D ENABLE_AVX=OFF -D WITH_OPENGL=OFF -D WITH_OPENCL=OFF -D WITH_IPP=OFF -D WITH_TBB=ON -D BUILD_TBB=ON -D WITH_EIGEN=OFF -D WITH_V4L=OFF -D WITH_VTK=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules ~/opencv/
# run from this cmd if /opencv/build/Makefile exited
# git pull
make -j$(nproc --all) # jcore check cores: grep 'cpu cores' /proc/cpuinfo | uniq hoac nproc --all
# make -j4

echo "***********************************"
sudo make install
echo "***********************************"
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
echo "***********************************"
sudo ldconfig
echo "***** Finished *****"
pkg-config --modversion opencv # check opencv version