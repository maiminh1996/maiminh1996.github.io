---
layout: post
title: "Installing OpenCV"
subtitle: "Build and Run Computer Vision Applications"
date: 2022-07-31
author: "MAI Minh"
# catalog: true
tags: installing opencv image-processing computer-vision python c++ cmake
categories: test-posts
disqus_comments: true
toc:
  sidebar: left
---


---

### Introduction

OpenCV is a powerful computer vision library used by developers worldwide. In this tutorial, we will walk you through the steps to install/ upgrade/ uninstall any version of [OpenCV](https://github.com/opencv/opencv/releases) on Linux by building from sources or using package manager, focusing on Python and C++ languages.

### Install 

#### Build from sources
To build OpenCV from sources, follow these steps:

Create/ activate the Python environment and make sure to install NumPy in the environment.
```bash
conda create -n test_opencv python=3.9
conda activate test_opencv
which python
# /home/$(whoami)/anaconda3/envs/test_opencv/bin/
python --version
# Python 3.9.17
pip install numpy
```

Update and upgrade the system packages, and install essential build tools and libraries needed for OpenCV.
```bash
sudo apt update
sudo apt upgrade
```

```bash
sudo apt install build-essential
sudo apt install gcc cmake git wget unzip

sudo apt install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt install libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
sudo apt install libtiff5-dev libeigen3-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev
```

<!--
sudo apt install ibgtk2.0-dev sphinx-common yasm libfaac-dev libopencore-amrnb-dev libgstreamer-plugins-base1.0-dev libavutil-dev libavfilter-dev libavresample-dev libjasper1
-->

Clone the official [`opencv/opencv releases`](https://github.com/opencv/opencv/releases) and [`opencv/opencv_contrib tags`](https://github.com/opencv/opencv_contrib/tags) repositories and checkout the desired version.
```bash
git clone https://github.com/opencv/opencv ~/opencv
git clone https://github.com/opencv/opencv_contrib ~/opencv_contrib
cd ~/opencv/ && git pull origin master && git checkout <version>
cd ~/opencv_contrib/ && git pull origin master && git checkout <version>
```

If desired, customize the build configuration using CMake (python module for example). Adjust the options based on our specific requirements.
```bash
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
# General configuration for OpenCV 3.4.16 =====================================
# --   Version control:               3.4.16
# 
# ...
# 
# --   C/C++:
# --     Built as dynamic libs?:      YES
# --     C++11:                       YES
# 
# ...
# 
# --   Python 3:
# --     Interpreter:                 /home/$(whoami)/anaconda3/envs/test_opencv/bin/python3 (ver 3.9.17)
# --     Libraries:                   /home/$(whoami)/anaconda3/envs/test_opencv/lib/libpython3.9.so (ver 3.9.17)
# --     numpy:                       /home/$(whoami)/.local/lib/python3.9/site-packages/numpy/core/include (ver 1.23.4)
# --     install path:                /home/$(whoami)/anaconda3/envs/test_opencv/lib/python3.9/site-packages/cv2/python-3.9
# 
# ...
# 
# Install to:                    /usr/local
```

Start the build process using make, and then install OpenCV to the system.
```bash
make -j$(nproc --all) # jcore check cores: grep 'cpu cores' /proc/cpuinfo | uniq hoac nproc --
# [100%] Linking CXX shared module ../../lib/python3/cv2.cpython-39-x86_64-linux-gnu.so
sudo make install
# -- Installing: 
# -- Set runtime path of "..." to "/usr/local/lib"
# -- Installing: /home/$(whoami)/anaconda3/envs/test_opencv/lib/python3.9/site-packages/cv2/python-3.9/cv2.cpython-39-x86_64-linux-gnu.so
# -- Set runtime path of "/home/$(whoami)/anaconda3/envs/test_opencv/lib/python3.9/site-packages/cv2/python-3.9/cv2.cpython-39-x86_64-linux-gnu.so" to "/usr/local/lib"
```

Configure the dynamic linker to look for shared libraries in the OpenCV installation path, and verify the installed version.
```bash
# Add /usr/local/lib into cache /etc/ld.so.cache 
# by modifying /etc/ld.so.conf or /etc/ld.so.conf.d/opencv.conf file
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
# Update cache /etc/ld.so.cache
sudo ldconfig
# Check opencv shared files in cache
# ldconfig -p | grep opencv
# Or using LD_LIBRARY_PATH
# echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"' >> ~/.bashrc

# /usr/local/lib/pkgconfig/opencv
pkg-config --modversion opencv
# 3.4.16
pkg-config --modversion opencv4 
# /usr/local/lib/pkgconfig/opencv4
```

If we want to use OpenCV in other Python env, create a symbolic link the shared file `~/opencv/build/lib/python3/cv2.cpython-39-x86_64-linux-gnu.so` to the Python bindings in our pip/ anaconda environment.
```bash
ln -s ~/opencv/build/lib/python3/cv2.cpython-38-x86_64-linux-gnu.so ~/anaconda3/envs/test_opencv/lib/python3.9/site-packages/cv2.so
python -c "import cv2; print(cv2.__version__)"
# 3.4.16
```

Note that we can use the following Python command to find the location where the cv2 package is installed:
```
python -c "import cv2; print(cv2.__file__)"
```

--- 

In summary, my bash script [opencv.sh](https://maiminh1996.github.io/assets/scripts/opencv.sh) simplifies the installation and upgrade of OpenCV. By executing the script with the desired OpenCV version, we can build OpenCV from sources with custom configurations, enabling us to leverage the latest features and capabilities in our computer vision projects.
```bash
# Download opencv.sh
wget --no-check-certificate --content-disposition https://maiminh1996.github.io/assets/scripts/opencv.sh -O opencv.sh

# Run this script for install opencv <version>=4.6.0
chmod +x opencv.sh
./opencv.sh <version>
```

--- 

#### Package manager

Alternatively, we can use pip or conda to manage packages:
```bash
conda activate test_opencv
which python
# /home/$(whoami)/anaconda3/envs/test_opencv/bin/python
```

```bash
pip install opencv-python==<version>
pip uninstall opencv-contrib-python==<version>
```

### Upgrade

Activate the Python environment and ensure we have NumPy installed in the environment.
```bash
conda activate test_opencv
which python
# /home/$(whoami)/anaconda3/envs/test_opencv/bin/
python --version
# Python 3.9.17
pip install numpy
```
Next, upgrade to the desired version of OpenCV from [OpenCV Releases](https://github.com/opencv/opencv/releases). Use the following commands to download the upgrade script and execute it.
```bash
wget --no-check-certificate --content-disposition https://maiminh1996.github.io/assets/scripts/opencv.sh -O opencv.sh

chmod +x opencv.sh
./opencv.sh <version>
```

### Uninstall

<!--
If we installed OpenCV using the package manager `apt`, we can remove the packages using the following command:
```bash
apt list --installed | grep opencv
sudo apt purge remove *opencv*
```
-->

If we built OpenCV from source and still have the build folder, run the following commands to uninstall:
```bash
cd ~/opencv/build
sudo make uninstall
```

If we no longer have the build directory, we can manually remove OpenCV files and configurations:
```bash
sudo find / \
  \( -path /snap -o \
     -path /proc -o \
     -path /var -o \
     -path /tmp -o \
     -path /run \) -prune \
  -o -iname "*opencv*" | grep -i opencv
sudo find / \
  \( -path /snap -o \
     -path /proc -o \
     -path /var -o \
     -path /tmp -o \
     -path /run \) -prune \
  -o -iname "*cv2*.so" | grep -i cv2
```
```bash
sudo rm -rf /usr/local/bin/*opencv*
sudo rm -rf /usr/local/include/*opencv*
sudo rm -rf /usr/local/lib/*opencv*
sudo rm -rf /usr/local/lib/cmake/*opencv*
sudo rm -rf /usr/local/lib/pkgconfig/*opencv*
sudo rm -rf /usr/local/share/licenses/*opencv*
sudo rm -rf /usr/local/share/*opencv*
sudo rm -rf /usr/local/share/*OpenCV*
sudo rm -rf /etc/ld.so.conf.d/*opencv*
sudo rm -rf /usr/bin/*opencv*
sudo rm -rf /usr/include/*opencv*
sudo rm -rf /usr/lib/*opencv*
sudo rm -rf /usr/lib/x86_64-linux-gnu/cmake/opencv*
sudo rm -rf /usr/lib/pkgconfig/*opencv*
sudo rm -rf /usr/lib/x86_64-linux-gnu/pkgconfig/*opencv*
sudo rm -rf $(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")/*opencv*
sudo rm -rf $(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")/*cv2*
# /home/$(whoami)/anaconda3/envs/test_opencv/lib/python3.9/site-packages/*opencv*
# /home/$(whoami)/anaconda3/envs/test_opencv/lib/python3.9/site-packages/*cv2*
# sudo find /home/$(whoami)/anaconda3/envs/test_opencv/lib/ -iname "*opencv*" -exec rm -i {} \;
# sudo find /home/$(whoami)/anaconda3/envs/test_opencv/lib/ -iname "*cv2*" -exec rm -i {} \;
```

Also, remove any Python-related files:
```bash
pip uninstall opencv-python
pip uninstall opencv-contrib-python
conda uninstall opencv-python
conda uninstall opencv-contrib-python
```

### Conclusion

We have successfully installed, upgraded, and uninstalled OpenCV on your Linux system. We now have a fully functional OpenCV installation for our Python and C++ projects. Additionally, managing different versions of OpenCV is now more straightforward, allowing you to switch between versions as needed.

Note that building from sources provides control over configuration, multiple versions, and integration with custom libraries. However, it's complex and requires maintenance. Meanwhile, using package manager (pip/ conda) offers simplicity, dependency resolution, and easy updates. But limited customization and potential version conflicts. So, choose based on our needs: build for control and flexibility, or use a package manager for convenience and quick setup.

### References

1. OpenCV Releases: [github.com/opencv/opencv/releases](https://github.com/opencv/opencv/releases)
2. OpenCV Contrib Tags: [github.com/opencv/opencv_contrib/tags](https://github.com/opencv/opencv_contrib/tags)
3. OpenCV 3.4.16 Installation in Linux: [docs.opencv.org/3.4.16/d7/d9f/tutorial_linux_install.html](https://docs.opencv.org/3.4.16/d7/d9f/tutorial_linux_install.html)

### Appendix 

#### Errors

##### Could not find a package configuration file provided by "OpenCV"

Could not find a package configuration file provided by "OpenCV" with any of the following names: `OpenCVConfig.cmake`, `opencv-config.cmake`

Add the installation prefix of "OpenCV" to `CMAKE_MODULE_PATH` or `CMAKE_PREFIX_PATH` or set `OpenCV_DIR` to a directory containing one of the above files.  If "OpenCV" provides a separate development package or SDK, be sure it has been installed.

```bash
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/modules)
set(CMAKE_PREFIX_PATH /usr/local/lib/cmake) # "path_to_cmake"
```

<!--
##### Some dynamically linked libraries not being found

Fix it by updating the cache for the linker
```bash
sudo ldconfig
```
[`sudo ldconfig`](https://www.quora.com/What-is-Sudo-Ldconfig-in-Linux) updates the cache for the linker in a UNIX environment with libraries found in the paths specified in `/etc/ld.so.conf`.

We usually use this if we get errors about some dynamically linked libraries not being found when starting a program although they are actually present on the system. We might need to add their paths to `/etc/ld.so.conf` first, though.

### libstdc++.so.6: version `GLIBCXX_3.4.30' not found

import cv2<br>
ImportError: /home/$(whoami)/anaconda3/envs/test_opencv/bin/../lib/libstdc++.so.6: version `GLIBCXX_3.4.30' not found (required by /usr/local/lib/libopencv_objdetect.so.3.4)
```bash
ls -la /home/$(whoami)/anaconda3/envs/test_opencv/lib/libstdc++.so
lrwxrwxrwx 1 root root 40 Jul 29 02:32 /home/$(whoami)/anaconda3/envs/test_opencv/lib/libstdc++.so -> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
```

```bash
ldd /usr/local/lib/libopencv_objdetect.so.3.4
	linux-vdso.so.1 (0x00007ffeb035a000)
	libopencv_calib3d.so.3.4 => /usr/local/lib/libopencv_calib3d.so.3.4 (0x00007f7ad1dc1000)
	libopencv_imgproc.so.3.4 => /usr/local/lib/libopencv_imgproc.so.3.4 (0x00007f7ad17b0000)
	libopencv_core.so.3.4 => /usr/local/lib/libopencv_core.so.3.4 (0x00007f7ad1435000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f7ad131d000)
	libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f7ad10f3000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f7ad10d1000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f7ad0ea9000)
	libopencv_flann.so.3.4 => /usr/local/lib/libopencv_flann.so.3.4 (0x00007f7ad0e2c000)
	libtbb.so => /usr/local/lib/libtbb.so (0x00007f7ad0def000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f7ad0dd3000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f7ad1fa7000)
```
```bash
strings /lib/x86_64-linux-gnu/libstdc++.so.6  | grep GLIBCXX
GLIBCXX_3.4
GLIBCXX_3.4.1
GLIBCXX_3.4.2
GLIBCXX_3.4.3
GLIBCXX_3.4.4
GLIBCXX_3.4.5
GLIBCXX_3.4.6
GLIBCXX_3.4.7
GLIBCXX_3.4.8
GLIBCXX_3.4.9
GLIBCXX_3.4.10
GLIBCXX_3.4.11
GLIBCXX_3.4.12
GLIBCXX_3.4.13
GLIBCXX_3.4.14
GLIBCXX_3.4.15
GLIBCXX_3.4.16
GLIBCXX_3.4.17
GLIBCXX_3.4.18
GLIBCXX_3.4.19
GLIBCXX_3.4.20
GLIBCXX_3.4.21
GLIBCXX_3.4.22
GLIBCXX_3.4.23
GLIBCXX_3.4.24
GLIBCXX_3.4.25
GLIBCXX_3.4.26
GLIBCXX_3.4.27
GLIBCXX_3.4.28
GLIBCXX_3.4.29
GLIBCXX_3.4.30
GLIBCXX_DEBUG_MESSAGE_LENGTH
```
-->