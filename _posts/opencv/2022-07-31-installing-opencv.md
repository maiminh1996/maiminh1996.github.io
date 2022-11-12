---
layout: post
title: "Installing OpenCV"
subtitle: "OpenCV (Part 1)"
date: 2022-07-31
author: "MAI Minh"
header-img: "img/"
header-style: text
catalog: true
tags: [installing, opencv, image processing, computer vision]
permalink: /distilled/opencv/installing-opencv.html
katex: true
mathjax: true
---

<b>[Completed] Last modified: </b>
<script>document.write( document.lastModified );</script>

# Goal 
> Installing OpenCV for both Python and C++ in Linux

# Opencv

## Installing

### ├── C++

Crawling this bash scrips [URL] = [maiminh1996.github.io/scripts/opencv.sh](/scripts/opencv.sh) into `opencv.sh` file.
```bash
# Download opencv.sh
wget --no-check-certificate --content-disposition [URL] -O opencv.sh
# curl [URL] > opencv.sh
```
Or coping this script below into `opencv.sh` file.
```bash
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
cd opencv
mkdir -p build && cd build
# cmake -D BUILD_TIFF=ON -D WITH_CUDA=OFF -D ENABLE_AVX=OFF -D WITH_OPENGL=OFF -D WITH_OPENCL=OFF -D WITH_IPP=OFF -D WITH_TBB=ON -D BUILD_TBB=ON -D WITH_EIGEN=OFF -D WITH_V4L=OFF -D WITH_VTK=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules /opt/opencv/
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
# exit
# cd ~
# echo "***** finished *****"
```
Then run these following cmds:
```bash
vim opencv.sh # open open.sh and choose the desired opencv version in step 3. get opencv
chmod +x opencv.sh  
./opencv.sh
# sudo -s 
# sh opencv.sh
pkg-config --modversion opencv # check opencv version if installing success
```

### └── Python

```bash
pip install opencv-python
# pip3 install opencv-python3
```

## Uninstalling

### ├── C++

- If you installed OpenCV from package manager, it's best to remove those packages. 

```bash
# Check opencv 
apt list --installed | grep opencv
sudo apt remove opencv
```
- If you built it yourself, and you still got the build folder, run `sudo make uninstall` from the OpenCV build directory. This will remove uninstalling `/usr/local/...opencv...`
- If you don't have the build directory, you'll find the OpenCV files in `/usr/local/lib` and `/usr/local/include`. Don't forget to remove `/usr/local/lib/pkgconfig/opencv.pc` and run `sudo ldconfig`.

```bash
cd /usr/local/lib
rm -rf *opencv*
cd /usr/local/include
rm -rf *opencv*
rm /usr/local/lib/pkgconfig/opencv.pc # check version
sudo ldconfig
```

### └── Python

```bash
# uninstall python installed by pip3 install opencv-python3, the python built from source (c++) is another one
sudo pip uninstall opencv-python
sudo pip3 uninstall opencv-python3
pip uninstall opencv-contrib-python
sudo rm -rf /usr/local/lib/python3.6/dist-packages/cv2/
```

# REFERENCES
- [OpenCV Releases](https://opencv.org/releases.html)
- [OpenCV Installation in Linux](https://docs.opencv.org/4.x/d7/d9f/tutorial_linux_install.html#tutorial_linux_install_detailed_basic_download)
- [How to Install OpenCV in Ubuntu 16.04 LTS for C / C++](http://www.codebind.com/cpp-tutorial/install-opencv-ubuntu-cpp/)

# Notes

### What is `sudo ldconfig` in Linux

<https://www.quora.com/What-is-Sudo-Ldconfig-in-Linux>

`ldconfig` updates the cache for the linker in a UNIX environment with libraries found in the paths specified in `/etc/ld.so.conf`. sudo executes it with superuser rights so that it can write to `/etc/ld.so.cache`.

**You usually use this if you get errors about some dynamically linked libraries not being found when starting a program although they are actually present on the system**. You might need to add their paths to `/etc/ld.so.conf` first, though.

### Getting error: unable to locate package `libjasper-dev`
```bash
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt update
sudo apt install libjasper1 libjasper-dev
```