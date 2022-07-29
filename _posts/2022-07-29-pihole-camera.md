---
layout: post
title: "Pihole Camera"
subtitle: "Pihole Camera, Geometry and 3D Understanding"
date: 2022-07-29
author: "MAI Minh"
header-img: "img/aditya-vyas-EPmJtn_lYs0-unsplash.jpg"
catalog: true
# header-style: text
tags: [image processing, camera, calibration]
katex: true
---
Updating ...

# Camera Model

## Pihole camera
> The simplest camera model is pinhole model which decribes the mathematical relationship of the projection of points in 3d-space onto a image plane.

<img src="/img/camera/pinhole_camera.png" alt="drawing" width="500"/>


### Issues with pinhole camera:
<img src="/img/camera/diff_lens.png" alt="drawing" width="300"/>

- Larger aperture $\rightarrow$  greater number of light rays that pass through the aperture $\rightarrow$  blur
- Smaller aperture $\rightarrow$  fewer number of light rays that pass through the aperture $\rightarrow$  darkness (+ diffraction)

$\rightarrow$ Solution: add a lens to replace the aperture! Lens: an optical element that focuses light by means of refraction

### Lenses

### Thin lens model



https://stanfordasl.github.io/aa274a/pdfs/lecture/lecture_7.pdf

## Perspective projection


Project a point $P_{W}$ in world coord ($OXYZ$) into a point $p(u, v)$ in pixel coord:

1. [Project a point $P_{W}$ in world coord into a point $P_{C}$ in cam coord](#1-project-a-point-in-world-coord-into-a-point-in-cam-coord)
2. [Project $P_{C}$ into a point $p(x, y)$ in the image plane](#2-project-the-point-in-cam-coord-into-a-point-in-the-image-plane)
3. [Project $p(x, y)$ into a pixel $(u, v)$ in pixel coord](#3-project-the-point-in-the-image-plane-into-a-pixel-in-pixel-coord)

### 1 Project a point in world coord into a point in cam coord
> Goal: Projecting $P_{W}(X_{W}, Y_{W}, Z_{W})$ (World coord) $\rightarrow$ $P_{C}(X_{C}, Y_{C}, Z_{C})$ (Cam coord). <br>Assumption: pinhole camera model (all results also hold under thin lens model, assuming camera is focused at ∞)

<img src="/img/camera/cam_world_coord.png" alt="drawing" width="500"/>

We have $P_{C} = t + RP_{W}$, where $t$ and $R$ are the translation vector the rotation matrix relating camera and world frames respectively. Presentation in in homogeneous coordinates:

$$
\begin{pmatrix}
P_{C}\\ 
1
\end{pmatrix}_{(4\times1)}
=
\begin{bmatrix}
R & t\\ 
1 & 1
\end{bmatrix}_{(4\times4)} 
\begin{pmatrix}
P_{W}\\ 
1
\end{pmatrix}_{(4\times1)}
$$

$\rightarrow$ Requiements `extrinsics parameters`: translation vector $t$ (3 params) and the rotation matrix $R$ (3 params).

### 2 Project the point in cam coord into a point in the image plane
> Goal: Projecting $P_{C}(X_{C}, Y_{C}, Z_{C})$ (World coord) $\rightarrow$ $p(x, y)$ (image plane)

<img src="/img/camera/cam_coord_image_plane.png" alt="drawing" width="500"/>

We have

$$
\begin{pmatrix}
x\\
y
\end{pmatrix}
=
\begin{pmatrix}
f\frac{X_{C}}{Z_{C}}\\
f\frac{Y_{C}}{Z_{C}}
\end{pmatrix}
$$

### 3 Project the point in the image plane into a pixel in pixel coord
> Goal: Projecting $p(x, y)$ (image plane) $\rightarrow$ $(u, v)$ (pixel coord)

Actual origin of the camera coordinate system is usually at a corner (e.g., top left, bottom left)

$$
\begin{pmatrix}
\widetilde{x}\\
\widetilde{y}
\end{pmatrix}
=
\begin{pmatrix}
f\frac{X_{C}}{Z_{C}} + \widetilde{x}_{0}\\
f\frac{Y_{C}}{Z_{C}} + \widetilde{y}_{0}
\end{pmatrix}
$$

Converting from image coordinates ($\widetilde{x}, \widetilde{x}$) to pixel coordinates $(u, v)$

$$
\begin{pmatrix}
u\\
v
\end{pmatrix}
=
\begin{pmatrix}
k_{x}\widetilde{x}\\
k_{x}\widetilde{y}
\end{pmatrix}
=
\begin{pmatrix}
k_{x}f\frac{X_{C}}{Z_{C}} + k_{x}\widetilde{x}_{0}\\
k_{y}f\frac{Y_{C}}{Z_{C}} + k_{y}\widetilde{y}_{0} 
\end{pmatrix}
=
\begin{pmatrix}
\alpha \frac{X_{C}}{Z_{C}} + u_{0}\\
\beta f\frac{Y_{C}}{Z_{C}} + v_{0} 
\end{pmatrix}
$$

where $k_{x}$ and $k_{y}$ be the number of pixels per unit distance in image coordinates in the x and y directions, respectively. 

$\rightarrow$ Requiements `intrinsics parameters`:
- $f$: **focal length** (distance between the lens and the focal point)
- $\alpha$: **aspect ratio** (1 unless pixels are not square)
- ($u_{0}, v_{0}$): **principal point** ((0,0) unless optical axis doesn’t intersect projection plane at origin)
- $\gamma$: **skew** (0 unless pixels are shaped like rhombi/parallelograms)

<!-- Finally, from both equations we have:

![img](/img/projection_image2.png)

with `\alpha` aspect ratio = 1, `s` skew = 0, `(cx, cy)` = (0, 0):

![img](/img/projection_image3.png)

convert from image coordinates (sx, sy) to pixel coordinates (u, v)

Let kx and ky be the number of pixels per unit distance in image coordinates in the x and y directions, respectively

https://stanfordasl.github.io/aa274a/pdfs/lecture/lecture_8.pdf


### Homogeneous coordinates
- Goal: represent the transformation as a linear mapping
- Key idea: introduce homogeneous coordinates -->

**Degrees of freedom**: 
- Intrinsics parameters:
- Extrinsics parameters: 
<!-- - 4 for K (or 5 if we also include skewness), 3 for R, and 3 for t. Total is 10 (or 11 if we include skewness) -->


REF:
- [cs4670/2015sp/lectures/lec15_projection_web.pdf](https://www.cs.cornell.edu/courses/cs4670/2015sp/lectures/lec15_projection_web.pdf)
- [lec15_projection_web.pdf](../doc/lec15_projection_web.pdf)
