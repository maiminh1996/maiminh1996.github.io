---
layout: post
title: "Camera and LiDAR analysis for 3D object detection in foggy weather conditions"
subtitle: "by Nguyen Anh Minh MAI, Pierre Duthon, Pascal Housam Salmane, Louahdi Khoudour, Alain Crouzil, Sergio A. Velastin."
date: 2022-07-29
# author: "MAI Minh"
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
### [[Paper](https://ieeexplore.ieee.org/document/9854073)] [[GitHub](https://github.com/maiminh1996/camera_LiDAR_analysis)]
<!-- <img src="/img/camera/diff_lens.png" alt="drawing" width="300"/> -->
<!-- ![](/img/sensors.png) -->

### Introduction
<!-- 
This work is based on our [paper](https://doi.org/10.3390/s21206711), which is published in SENSORS. We proposed a novel synthetic dataset augmented on KITTI dataset for foggy weather conditions. You can also check our [project webpage](https://maiminh1996.github.io/MultifogKITTI/) for a deeper introduction.

In this repository, we release code and data for training and testing our SLS-Fusion network on stereo camera and point clouds (64 beams and 4 beams) on both KITTI and Multifog KITTI datasets. -->


### Abstract
<!-- 
The role of sensors such as cameras or LiDAR (Light Detection and Ranging) is crucial for the environmental awareness of self-driving cars. However, the data collected from these sensors are subject to distortions in extreme weather conditions such as fog, rain, and snow. This issue could lead to many safety problems while operating a self-driving vehicle. The purpose of this study is to analyze the effects of fog on the detection of objects in driving scenes and then to propose methods for improvement. Collecting and processing data in adverse weather conditions is often more difficult than data in good weather conditions. Hence, a synthetic dataset that can simulate bad weather conditions is a good choice to validate a method, as it is simpler and more economical, before working with a real dataset. In this paper, we apply fog synthesis on the public KITTI dataset to generate the Multifog KITTI dataset for both images and point clouds. In terms of processing tasks, we test our previous 3D object detector based on LiDAR and camera, named the Spare LiDAR Stereo Fusion Network (SLS-Fusion), to see how it is affected by foggy weather conditions. We propose to train using both the original dataset and the augmented dataset to improve performance in foggy weather conditions while keeping good performance under normal conditions. We conducted experiments on the KITTI and the proposed Multifog KITTI datasets which show that, before any improvement, performance is reduced by 42.67% in 3D object detection for Moderate objects in foggy weather conditions. By using a specific strategy of training, the results significantly improved by 26.72% and keep performing quite well on the original dataset with a drop only of 8.23%. In summary, fog often causes the failure of 3D detection on driving scenes. By additional training with the augmented dataset, we significantly improve the performance of the proposed 3D object detection algorithm for self-driving cars in foggy weather conditions. -->


### Citation
If you find our work useful in your research, please consider citing:
  
    @INPROCEEDINGS{nammai_icprs_2022,
    author={Minh Mai, Nguyen Anh and Duthon, Pierre and Salmane, Pascal Housam and Khoudour, Louahdi and Crouzil, Alain and Velastin, Sergio A.},
    booktitle={2022 12th International Conference on Pattern Recognition Systems (ICPRS)}, 
    title={Camera and LiDAR analysis for 3D object detection in foggy weather conditions}, 
    year={2022},
    volume={},
    number={},
    pages={1-7},
    doi={10.1109/ICPRS54038.2022.9854073}}
