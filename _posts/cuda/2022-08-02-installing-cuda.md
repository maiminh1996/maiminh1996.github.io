---
layout: post
title: "Installing CUDA"
subtitle: "GPGPU"
date: 2022-08-02
author: "MAI Minh"
header-img: "img/"
header-style: text
catalog: true
tags: [cuda, installing, gpgpu, deep learning]
permalink: /distilled/cuda/installing-cuda.html
katex: true
mathjax: true
---

<b>[Completed] Last modified: </b>
<script>document.write( document.lastModified );</script>


# CUDA

## Direct link
- [CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive)
- [Table 3. CUDA Toolkit and Corresponding Driver Versions](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#title-new-features)
- [NVIDIA Driver Downloads](https://www.nvidia.com/Download/index.aspx?lang=en-us)
- [cuDNN Archive](https://developer.nvidia.com/rdp/cudnn-archive)


## Some terms
### CUDA Compilers: nvcc

### CUDA Developer Tools
- nvprof and Visual Profiler
- CUPTI
- Nsight Compute
- Compute Sanitizer
- CUDA-GDB

### CUDA Libraries
ex (11.x releases.)
- cuBLAS Library
- cuFFT Library
- cuRAND Library
- cuSOLVER Library
- cuSPARSE Library
- Math Library
- NVIDIA Performance Primitives (NPP)
- nvJPEG Library

### [GPUs architecture and Compute Capability](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#compute-capabilities)
The compute capability of a device is represented by a version number, also sometimes called its "SM version" (SM: Streaming multiprocessors). This version number identifies the features supported by the GPU hardware and is used by applications at runtime to determine which hardware features and/or instructions are available on the present GPU. 

List NVIDIA GPUs architecture Compute Capability: 
- Tesla (2006) --> CC: 1.x
- Fermi (2010) --> CC: 2.x
- Kepler (2012) --> CC: 3.x
- Maxwell (2014) --> CC: 5.x
- Pascal (2016) --> CC: 6.x
- Volta (2018) --> CC: 7.x
- Turing (late 2018), an incremental update based on the Volta architecture. --> CC: 7.5
- Ampere (2020) --> CC: 8.x
- Hopper (2022) --> CC: 9.x

Check NVIDIA GPU **Compute Capability**
- [Latest NVIDIA GPU](https://developer.nvidia.com/cuda-gpus)
- [Older NVIDIA GPU](https://developer.nvidia.com/cuda-legacy-gpus)
- Example: some gpus that I used
  - GeForce: GeForce RTX 2070 (Turing) --> : 7.5; GeForce GTX 1080 Ti (pascal) --> 6.1; GeForce RTX 3080 Ti (Ampere) --> 8.6
  - NVIDIA Data Center Products: NVIDIA A100 (Ampere) --> 8.0; V100 (Volta) --> 7.0

The compute capability comprises a major revision number X and a minor revision number Y and is denoted by X.Y.
- Devices with the same major revision number X are of the same core architecture. 
- The minor revision number Y corresponds to an incremental improvement to the core architecture, possibly including new features.

Note: **The compute capability version of a particular GPU should not be confused with the CUDA version** (for example, CUDA 7.5, CUDA 8, CUDA 9), which is the version of the CUDA software platform. The CUDA platform is used by application developers to create applications that run on many generations of GPU architectures, including future GPU architectures yet to be invented. While new versions of the CUDA platform often add native support for a new GPU architecture by supporting the compute capability version of that architecture, new versions of the CUDA platform typically also include software features that are independent of hardware generation. 

The Tesla and Fermi architectures are no longer supported starting with CUDA 7.0 and CUDA 9.0, respectively.  

### [CUDA envronment variables](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#env-vars)
- CUDA_VISIBLE_DEVICES
```python
import os
os.environ["CUDA_VISIBLE_DEVICES"] = "0"
```
```bash
export CUDA_VISIBLE_DEVICES='0'
```

### Architecture
Check `uname -m && cat /etc/*release`
- x86_64: is for 64-bit Intel x86 (also referred as amd64).
- x86: is for 32-bit Intel x86 architectures (also referred as i386 or i686).
- armv7: is the 32-bit ARMv7 architecture.
- aarch64: is for the 64-bit ARMv8 architecture.
- ppc64le: is for the IBM P8 Little Endian architecture.

### Installer type

The same installer may be offered in 2 versions: local and network.
- The local installer is self-contained and includes every component. It is a large file that only needs to be downloaded from the internet once and can be installed on multiple systems. It is the recommended type of installer with low-bandwidth internet connections.
- The network installer is a small installer client that will only download the required components during the installation. It is faster to download but requires re-downloading each component with each new installation.

## Preinstallation

Check a `CUDA Toolkit` version requiements (replace X.Y by the cuda version https://docs.nvidia.com/cuda/archive/X.Y/cuda-installation-guide-linux/index.html#system-requirements) by seeing its [`Versioned Online Documentation`](https://developer.nvidia.com/cuda-toolkit-archive) (https://docs.nvidia.com/cuda/archive/X.Y/cuda-installation-guide-linux/index.html#pre-installation-actions) and then `Installation Guide for Linux` to check:
- **CUDA-capable GPU**: `lspci | grep -i nvidia` (all card are listed in [cuda-gpus](https://developer.nvidia.com/cuda-gpus))
- **A supported version of Linux**: `uname -m && cat /etc/*release` with a **gcc compiler**: `gcc --version` and toolchain. Ex:
  - cuda 11.0 supports for Ubuntu 20.04; Ubuntu 18.04.z (z<=4); Ubuntu 16.04 (z<=6)
  - however cuda 11.4.0  only supports for Ubuntu 20.04.2 LTS; Ubuntu 18.04.z (z <= 5) LTS
- **Kernel**. It is best to manually ensure the correct version of the kernel headers and development packages are installed prior to installing the CUDA Drivers, as well as whenever you change the kernel version. The version of the kernel your system `uname -r`, install `sudo apt-get install linux-headers-$(uname -r)`
```bash
# example
lspci | grep -i nvidia # 01:00.0 VGA compatible controller: NVIDIA Corporation Device 1f14 (rev a1)
uname -m && cat /etc/*release # x86_64 (Architecture), Ubuntu 18.04.6 LTS (distribution)
gcc --version # 7.5.0
sudo apt-get install linux-headers-$(uname -r)
```

## Installation

Choose the right version (by matching the information system machine to cuda requiements above) to download and install. 

**CUDA Toolkit** contains **CUDA driver** and **tools needed** to create, build and run a CUDA application as well as libraries, header files, and other resources. 

- Download in [`CUDA Toolkit`](https://developer.nvidia.com/cuda-toolkit-archive). It has [2 different installation mechanism](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#choose-installation-method):
  - distribution-specific packages (RPM and Deb packages) (**recommended**)
  - distribution-independent package (runfile packages)

- Check download `md5sum <file>`

- Check to install cuda https://docs.nvidia.com/cuda/archive/X.Y/cuda-installation-guide-linux/index.html#ubuntu-installation or https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu-installation
  - `sudo apt-get install cuda # Ubuntu`
  - `sudo apt-get install cuda-drivers-<branch>`
```bash
# Install cuda following
# https://developer.nvidia.com/cuda-X-Y-download-archive
# Ex: https://developer.nvidia.com/cuda-11-7-1-download-archive
# https://docs.nvidia.com/cuda/cuda-quick-start-guide/index.html#ubuntu-x86_64-deb
sudo dpkg -i dev.file
sudo apt-key add /var/cuda.../7..
sudo apt update
# sudo touch /etc/apt/sources.list.d/cuda-10-2-local-10.2.89-440.33.01.list
# sudo echo > deb file:///var/cuda-repo-10-2-local-10.2.89-440.33.01 /
# release file found in /var/cuda...
# apt search cuda # several cuda, so need to presise
sudo apt-get install cuda # default, may be not the version we want
# sudo apt-get install # cuda-10-2
```
Add path in `~/.bashrc`
```bash
export PATH=/usr/local/cuda/bin:${PATH:+:${PATH}}
export CUDA_PATH=/usr/local/cuda
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```
Reboot the system to load the NVIDIA drivers
```bash
sudo reboot
```

Check installing
```bash
nvcc -V # cuda toolkit version
nvidia-smi # driver and the max cuda toolkit version may be installed using this driver but this is not the current installed cuda toolkit version (see cuda version, cuda driver)
# reboot and retry
# If it doesn't work, sometimes this is due to a secure boot option of your motherboard, disable it and test again

# if get error: E: Failed to fetch file:/var/cuda-repo-ubuntu1604-11-2-local/
# sudo rm /etc/apt/sources.list.d/cuda-ubuntu1604-11-2-local.list

# Use the toolkit to check your CUDA capable devices
# cuda-install-samples-8.0.sh ~/.
# cd ~/NVIDIA_CUDA-8.0_Samples/1_Utilities/deviceQuery
# make
# # shutdown -r now
# # Test cuda
# cd ~/NVIDIA_CUDA-8.0_Samples/1_Utilities/deviceQuery
# ./deviceQuery
```

- A driver that is compatible with the CUDA Toolkit

[Which GPUs are supported by the driver](https://docs.nvidia.com/deploy/cuda-compatibility/index.html)
![](/img/gpu_driver.png)

GPU (nom, HW generation, CC) --> Check driver supported (from oldest) --> Ex: GeForce RTX 3080 Ti (Ampere) --> Ampere --> driver >= 450.36.06 + any cuda version supported (see table below to choose the driver supported cuda version)
- driver 450.36.06 + <= cuda 11.0.1 RC
- driver 470.82.01 + <= cuda 11.4 update 4

[Table 3. CUDA Toolkit and Corresponding Driver Versions](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#title-new-features)

![](/img/CUDA_Toolkit_and_Corresponding_Driver_Versions.png)

Install a driver (if needed): Download a [NVIDIA Driver Downloads](https://www.nvidia.com/Download/index.aspx?lang=en-us)
- GPU Product
- Operating System
```bash
# after successful download .run file driver
chmod +x <file>
sudo ./<file>
```

Applications built against any of the older CUDA Toolkits always continued to function on newer drivers due to binary backward compatibility.

[Do I need to uninstall my older driver first?](https://www.nvidia.com/en-gb/drivers/drivers-faq/#installing): No. It used to be the case that an uninstall was first required. Today the recommended method is to overinstall the newer driver on top of your older driver. This will allow you to maintain any current NVIDIA Control Panel settings or profiles. 

- Install cuDNN libs (for deep learning-based application)
```bash
# cuDNN
# Download cuDNN corresponding to cuda version here https://developer.nvidia.com/rdp/cudnn-archive
cd Downloads/
tar -zxvf cudnn-X.Y-linux-x64-v5.1.tgz 
mv cuda/ cudaX.Y
sudo cp cudaX.Y/include/* /usr/local/cuda-X.Y/include/
sudo cp cudaX.Y/lib64/* /usr/local/cuda-X.Y/lib64/
sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
```
Check cuDNN version
```bash
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
cat /usr/local/cuda/include/cudnn_version.h | grep 
CUDNN_MAJOR -A 2 # for recent version
```
docs: [Installing cuDNN on Linux](https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#install-linux)

If existing errors:
- The driver relies on an automatically generated `xorg.conf` file at `/etc/X11/xorg.conf`. If a custom-built `xorg.conf` file is present, this functionality will be disabled and the driver may not work. You can try removing the existing `xorg.conf` file, or adding the contents of `/etc/X11/xorg.conf.d/00-nvidia.conf` to the xorg.conf file. The xorg.conf file will most likely need manual tweaking for systems with a non-trivial GPU configuration. 

## Uninstallation

Uninstall a Toolkit runfile installation, a Driver runfile installation

```bash
sudo /usr/local/cuda-X.Y/bin/cuda-uninstaller
sudo /usr/bin/nvidia-uninstall
```

Uninstall an RPM/Deb installation (my case)

```bash
# sudo apt-get --purge remove <package_name> # Ubuntu
sudo apt-get remove --purge nvidia*
```

Removing CUDA Toolkit and Driver (Ubuntu and Debian)
- remove CUDA Toolkit
```bash
sudo apt-get --purge remove "*cuda*" "*cublas*" "*cufft*" "*cufile*" "*curand*" "*cusolver*" "*cusparse*" "*gds-tools*" "*npp*" "*nvjpeg*" "nsight*" 
```

- remove NVIDIA Drivers: 
```bash
sudo apt-get --purge remove "*nvidia*" && sudo apt-get autoremove
```

```bash
# summarizing
sudo apt-get --purge remove "*cuda*" "*cublas*" "*cufft*" "*cufile*" "*curand*" "*cusolver*" "*cusparse*" "*gds-tools*" "*npp*" "*nvjpeg*" "nsight*" 
sudo rm -rf /var/cuda-repo-X.Y.../
sudo rm -rf /usr/local/cuda-X.Y/ 
sudo apt-get --purge remove "*nvidia*" && sudo apt-get autoremove
```

## Some successful configurations
- GeForce GTX 1080 Ti/PCIe/SSE2: python3.6, Pytorch 1.0.2, cuda 10.0, driver nvidia-410, cudnn 7.4.2


## Multi cuda version on the one machine

Switch cuda by create a symbolic link into `/usr/local/cuda`
```bash
sudo ln -s cuda-X.Y cuda
ls -l /usr/local # see cuda folder ref to cuda-X.Y
```
In `~/.bashrc`
```bash
export PATH=/usr/local/cuda/bin:${PATH:+:${PATH}}
export CUDA_PATH=/usr/local/cuda
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

## Errors

- when cuda is false CUDA unavailable when pytorch 1.3.0

installed with cudatoolkit 10.1
Ref: <https://github.com/pytorch/pytorch/issues/28321>

```bash
pip install torch==1.3.1+cu100 torchvision==0.4.2+cu100 -f https://download.pytorch.org/whl/torch_stable.html
```

- If unable to locate nvidia-410
--> system setting --> soft and update --> choose the best serveur --> retry

- failed call to cuInit: CUDA_ERROR_UNKNOWN

```bash
sudo apt-get install nvidia-modprobe
reboot
```

- if get error: E: Failed to fetch file:/var/cuda-repo-ubuntu1604-11-2-local/

```bash
sudo rm /etc/apt/sources.list.d/cuda-ubuntu1604-11-2-local.list
```

# REFERENCES
- [CUDA Toolkit Documentation](https://docs.nvidia.com/cuda/)
- [MultiCUDA: Multiple Versions of CUDA on One Machine](https://medium.com/@peterjussi/multicuda-multiple-versions-of-cuda-on-one-machine-4b6ccda6faae)
- [Multiple Version of CUDA Libraries On The Same Machine](https://blog.kovalevskyi.com/multiple-version-of-cuda-libraries-on-the-same-machine-b9502d50ae77)
- [CUDA C++ Programming Guide](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#cuda-general-purpose-parallel-computing-architecture)