---
layout: post
title: "Installing OpenCV"
subtitle: "OpenCV"
date: 2022-07-31
author: "MAI Minh"
header-img: "img/"
header-style: text
catalog: true
tags: [installing, opencv, image processing, computer vision]
permalink: /distilled/opencv/installing-opencv.html
# katex: true
mathjax: true
---

Installing OpenCV for both Python and C++ in Linux

### Installing

#### ├── C++

Crawling this bash script [opencv.sh](https://maiminh1996.github.io/scripts/opencv.sh) into `opencv.sh` file.
```bash
# Download opencv.sh
wget --no-check-certificate --content-disposition https://maiminh1996.github.io/scripts/opencv.sh -O opencv.sh

# Run this script for install opencv version 4.6.0
chmod +x opencv.sh  
./opencv.sh 4.6.0
```

Here is the content of the `opencv.sh` file.
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
```

#### └── Python

```bash
pip install opencv-python
# pip3 install opencv-python3
```

### Uninstalling

#### ├── C++

If we installed OpenCV from package manager, it's best to remove those packages. 
```bash
# Check opencv 
apt list --installed | grep opencv
sudo apt remove opencv
```

If we built it, and we still got the build folder, run this cmds. This will remove uninstalling `/usr/local/...opencv...`
```bash
cd ~/opencv/build
sudo make uninstall

cd 
rm -rf ~/opencv ~/opencv_contrib
```
If we don't have the build directory, we'll find the OpenCV files in `/usr/local/lib` and `/usr/local/include`. Don't forget to remove `/usr/local/lib/pkgconfig/opencv.pc` and run `sudo ldconfig`.
```bash
sudo rm -rf /usr/local/lib/*opencv*
sudo rm -rf /usr/local/include/*opencv*
sudo rm -rf /usr/local/lib/cmake/*opencv*
sudo rm -rf /usr/local/lib/pkgconfig/*opencv* # opencv.pc
sudo rm -rf /usr/local/share/*opencv*
sudo rm -rf /usr/local/share/*OpenCV*

sudo rm -rf /usr/lib/x86_64-linux-gnu/cmake/opencv*
sudo rm -rf /usr/lib/pkgconfig/*opencv* # opencv.pc
sudo rm -rf /usr/include/*opencv* # opencv4/
sudo rm -rf /usr/lib/x86_64-linux-gnu/pkgconfig/*opencv* # opencv4.pc

sudo ldconfig
```

#### └── Python

```bash
# uninstall python installed by pip3 install opencv-python3, the python built from source (c++) is another one
sudo pip uninstall opencv-python
sudo pip3 uninstall opencv-python3
pip uninstall opencv-contrib-python
sudo rm -rf /usr/local/lib/python3.6/dist-packages/cv2/
```

### References

[OpenCV Releases](https://opencv.org/releases.html)

[OpenCV Installation in Linux](https://docs.opencv.org/4.x/d7/d9f/tutorial_linux_install.html#tutorial_linux_install_detailed_basic_download)

[How to Install OpenCV in Ubuntu 16.04 LTS for C / C++](http://www.codebind.com/cpp-tutorial/install-opencv-ubuntu-cpp/)

### Appendix 

#### Errors

##### Some dynamically linked libraries not being found


Fix it by updating the cache for the linker
```bash
sudo ldconfig
```
[`sudo ldconfig`](https://www.quora.com/What-is-Sudo-Ldconfig-in-Linux) updates the cache for the linker in a UNIX environment with libraries found in the paths specified in `/etc/ld.so.conf`.

We usually use this if we get errors about some dynamically linked libraries not being found when starting a program although they are actually present on the system. We might need to add their paths to `/etc/ld.so.conf` first, though.


##### Unable to locate package `libjasper-dev`

Fix it by installing `libjasper1` and `libjasper-dev`
```bash
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt update
sudo apt install libjasper1 libjasper-dev
```


##### No package 'opencv' found

If `pkg-config --modversion opencv` return No package 'opencv' found, 
`/usr/lib/pkgconfig/opencv.pc` or `/usr/local/lib/pkgconfig/opencv.pc`. 

Crawling this bash script [fix_opencv_not_found.sh](https://maiminh1996.github.io/scripts/fix_opencv_not_found.sh) into `fix_opencv_not_found.sh` file.
```bash
# Download opencv.sh
wget --no-check-certificate --content-disposition https://maiminh1996.github.io/scripts/fix_opencv_not_found.sh -O fix_opencv_not_found.sh

# Run this script for install opencv version 4.6.0
chmod +x fix_opencv_not_found.sh  
./fix_opencv_not_found 4.6.0
```

##### Could not find a package configuration file provided by "OpenCV"

Could not find a package configuration file provided by "OpenCV" with any of the following names: `OpenCVConfig.cmake`, `opencv-config.cmake`

Add the installation prefix of "OpenCV" to `CMAKE_MODULE_PATH` or `CMAKE_PREFIX_PATH` or set `OpenCV_DIR` to a directory containing one of the above files.  If "OpenCV" provides a separate development package or SDK, be sure it has been installed.

```bash
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/modules)
set(CMAKE_PREFIX_PATH /usr/local/lib/cmake) # "path_to_cmake"
```