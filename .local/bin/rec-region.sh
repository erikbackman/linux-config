#!/bin/bash

[ ! "$1" ] && { echo "Usage: $0 filename"; exit 1; }

ffmpeg -framerate 30 -f x11grab $(slop -f "-video_size %wx%h -i :0.0+%x,%y") -c:a aac -c:v libx264 "$1"

