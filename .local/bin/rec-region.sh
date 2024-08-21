#!/bin/bash

ffmpeg -init_hw_device vaapi=foo:/dev/dri/renderD128 -f x11grab -hwaccel vaapi -hwaccel_device foo -select_region 1 -draw_mouse 1 -framerate 60 -show_region 1 -video_size 1920x1080 -c:v h264 -i :0.0 /home/ebn/output.mp4

