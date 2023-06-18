#!/bin/bash
version=$1
echo "prefix=/usr/local
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib64

Name: opencv
Description: The opencv library
Version:${version}
Cflags: -I${includedir}/opencv4
Libs: -L${libdir} -lopencv_stitching -lopencv_objdetect -lopencv_calib3d -lopencv_features2d -lopencv_highgui -lopencv_videoio -lopencv_imgcodecs -lopencv_video -lopencv_photo -lopencv_ml -lopencv_imgproc -lopencv_flann -lopencv_core" >> /usr/lib/pkgconfig/opencv.pc