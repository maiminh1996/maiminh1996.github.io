---
layout: post
title: "SLS-Fusion: Sparse LiDAR and Stereo Fusion (SLS-Fusion) for Depth Estimation and 3D Object Detection"
subtitle: "by Nguyen Anh Minh MAI, Pierre Duthon, Louahdi Khoudour, Alain Crouzil, Sergio A. Velastin."
date: 2022-07-29
author: "MAI Minh"
# header-img: "img/aditya-vyas-EPmJtn_lYs0-unsplash.jpg"
catalog: false
no-catalog: true
no-featured-tags: true
header-style: text
# permalink: /pihole-camera
katex: true
mathjax: true
sidebar: false
header-mask: 0.2
hide-in-nav: true
---
### [[Paper](https://ieeexplore.ieee.org/document/9569023)] [[GitHub](https://github.com/maiminh1996/SLS-Fusion)]
<!-- <img src="/img/camera/diff_lens.png" alt="drawing" width="300"/> -->
![](/img/slsfusion.png)

### Introduction

This work is based on our [paper](https://ieeexplore.ieee.org/document/9569023), which is published in ICPRS 2021. We proposed a novel 3D object detector taking stereo camera and LiDAR as input. You can also check our [project webpage](https://github.com/maiminh1996/SLS-Fusion) for a deeper introduction.

In this repository, we release code and data for training and testing our SLS-Fusion network on stereo camera and point clouds (64 beams and 4 beams).


### Abstract

The ability to accurately detect and localize objects is recognized as being the most important for the perception of self-driving cars. From 2D to 3D object detection, the most difficult is to determine the distance from the ego-vehicle to objects. Expensive technology like LiDAR can provide a precise and accurate depth information, so most studies have tended to focus on this sensor showing a performance gap between LiDAR-based methods and camera-based methods. Although many authors have investigated how to fuse LiDAR with RGB cameras, as far as we know there are no studies to fuse LiDAR and stereo in a deep neural network for the 3D object detection task. This paper presents SLS-Fusion, a new approach to fuse data from 4-beam LiDAR and a stereo camera via a neural network for depth estimation to achieve better dense depth maps and thereby improves 3D object detection performance. Since 4-beam LiDAR is cheaper than the well-known 64-beam LiDAR, this approach is also classified as a low-cost sensors based method. Through evaluation on the KITTI benchmark, it is shown that the proposed method significantly improves depth estimation performance compared to a baseline method. Also when applying it to 3D object detection, a new state of the art on low-cost sensor based method is achieved.

### Citation
If you find our work useful in your research, please consider citing:
  
    @INPROCEEDINGS{nammai_icprs_2021,
        author={Mai, N.-A.-M. and Duthon, P. and Khoudour, L. and Crouzil, A. and Velastin, S. A.},
        booktitle={11th International Conference of Pattern Recognition Systems (ICPRS 2021)}, 
        title={Sparse LiDAR and Stereo Fusion (SLS-Fusion) for Depth Estimation and 3D Object Detection}, 
        year={2021},
        volume={2021},
        number={},
        pages={150-156},
        doi={10.1049/icp.2021.1442}}

### Contact

Any feedback is very welcome! Please contact us at <mainguyenanhminh1996@gmail.com>
