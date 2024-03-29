---
layout: post
title: "3D Object Detection with SLS-Fusion Network in Foggy Weather Conditions"
subtitle: "by Nguyen Anh Minh MAI, Pierre Duthon, Louahdi Khoudour, Alain Crouzil, Sergio A. Velastin."
date: 2022-07-29
author: "MAI Minh"
header-img: "img/"
header-style: text
catalog: false
no-catalog: true
no-featured-tags: true
header-style: text
permalink: /publications/multifogkitti.html
# katex: true
mathjax: true
sidebar: false
# header-mask: 0.2
hide-in-nav: true
---
### [[Paper](https://www.mdpi.com/1424-8220/21/20/6711)] [[GitHub](https://github.com/maiminh1996/MultifogKITTI)]
<!-- <img src="/img/camera/diff_lens.png" alt="drawing" width="300"/> -->
![](/img/sensors.png)

### Introduction

This work is based on our [paper](https://doi.org/10.3390/s21206711), which is published in SENSORS. We proposed a novel synthetic dataset augmented on KITTI dataset for foggy weather conditions. You can also check our [project webpage](https://maiminh1996.github.io/MultifogKITTI/) for a deeper introduction.

In this repository, we release code and data for training and testing our SLS-Fusion network on stereo camera and point clouds (64 beams and 4 beams) on both KITTI and Multifog KITTI datasets.


### Abstract

The role of sensors such as cameras or LiDAR (Light Detection and Ranging) is crucial for the environmental awareness of self-driving cars. However, the data collected from these sensors are subject to distortions in extreme weather conditions such as fog, rain, and snow. This issue could lead to many safety problems while operating a self-driving vehicle. The purpose of this study is to analyze the effects of fog on the detection of objects in driving scenes and then to propose methods for improvement. Collecting and processing data in adverse weather conditions is often more difficult than data in good weather conditions. Hence, a synthetic dataset that can simulate bad weather conditions is a good choice to validate a method, as it is simpler and more economical, before working with a real dataset. In this paper, we apply fog synthesis on the public KITTI dataset to generate the Multifog KITTI dataset for both images and point clouds. In terms of processing tasks, we test our previous 3D object detector based on LiDAR and camera, named the Spare LiDAR Stereo Fusion Network (SLS-Fusion), to see how it is affected by foggy weather conditions. We propose to train using both the original dataset and the augmented dataset to improve performance in foggy weather conditions while keeping good performance under normal conditions. We conducted experiments on the KITTI and the proposed Multifog KITTI datasets which show that, before any improvement, performance is reduced by 42.67% in 3D object detection for Moderate objects in foggy weather conditions. By using a specific strategy of training, the results significantly improved by 26.72% and keep performing quite well on the original dataset with a drop only of 8.23%. In summary, fog often causes the failure of 3D detection on driving scenes. By additional training with the augmented dataset, we significantly improve the performance of the proposed 3D object detection algorithm for self-driving cars in foggy weather conditions.

### Download our Multifog KITTI dataset

The training and testing part of our Multifog KITTI datasets (SENSORS 2021) are organized as follows:
- Training (7,481 frames): 
    - [[image_2](https://drive.google.com/file/d/1oPuAX1-dRisN4eBcTcA-XUvdLoaO7HfX/view?usp=sharing)] (.png, 4,3 GB)
    - [[image_3](https://drive.google.com/file/d/1MXJXzTz5X0HnPtrxsEsSxI8EUx13voJc/view?usp=sharing)] (.png, 4,1 GB)
    - [[velodyne_64beams](https://drive.google.com/file/d/1-0siAOrslNqqKdOqRstJgCm9rE7sPpxF/view?usp=sharing)] (.bin, 10,7 GB)
    - [[velodyne_4beams](https://drive.google.com/file/d/1EoK3IsCq_bqFNZ4kqHn8qvd5JLpu5Chc/view?usp=sharing)] (.bin, 98 MB)
    - [[visibility_level]](https://drive.google.com/file/d/1ggn3RWfp488b3MrRJv13MV6W-CHpYNeX/view?usp=sharing) (.txt, 20m to 80m visibility level)
- Testing (7,518 frames):  
    - [[image_2]()] (.png, )
    - [[image_3]()] (.png, )
    - [[velodyne_64beams](https://drive.google.com/drive/folders/13yAdun4EcMT7_4BCxIMQUgz3qYpstqSo?usp=sharing)] (.bin, 10,9 GB)
    - [[velodyne_4beams]()] (.bin, )
    - [[visibility_level](https://drive.google.com/file/d/1EE-IrCgIFvpwk5k0QModJi9Ngol1Mvrd/view?usp=sharing)] (.txt, 20m to 80m visibility level)

If you want to work on sparse LiDAR, please refer [here](../sparse_lidar_kitti_datasets/) for LiDAR 2 beams, LiDAR 4 beams, 8 beams, 16 beams, 32 beams based on LiDAR 64 beams (KITTI dataset).

### Citation
If you find our work useful in your research, please consider citing:
  
```txt
@article{nammai_sensors_2021,
    AUTHOR = {Mai, Nguyen Anh Minh and Duthon, Pierre and Khoudour, Louahdi and Crouzil, Alain and Velastin, Sergio A.},
    TITLE = {3D Object Detection with SLS-Fusion Network in Foggy Weather Conditions},
    JOURNAL = {Sensors},
    VOLUME = {21},
    YEAR = {2021},
    NUMBER = {20},
    ARTICLE-NUMBER = {6711},
    URL = {https://www.mdpi.com/1424-8220/21/20/6711},
    PubMedID = {34695925},
    ISSN = {1424-8220},
    ABSTRACT = {},
    DOI = {10.3390/s21206711}
}
```

```txt
@inproceedings{nammai_icprs_2021,
    author={Mai, Nguyen Anh Minh and Duthon, P. and Khoudour, L. and Crouzil, A. and Velastin, S. A.},
    booktitle={11th International Conference of Pattern Recognition Systems (ICPRS 2021)}, 
    title={Sparse LiDAR and Stereo Fusion (SLS-Fusion) for Depth Estimation and 3D Object Detection}, 
    year={2021},
    volume={2021},
    number={},
    pages={150-156},
    doi={10.1049/icp.2021.1442}}
```

### Contact

Any feedback is very welcome! Please contact us at mainguyenanhminh1996 AT gmail DOT com
