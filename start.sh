#!/bin/sh
node server.js &
ffmpeg -re -loop 1 -framerate 1 -i video.mp4 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf scale=854:480 -c:v libx264 -preset ultrafast -tune stillimage -b:v 400k -maxrate 400k -bufsize 800k -pix_fmt yuv420p -g 2 -c:a aac -b:a 64k -shortest -f flv rtmp://a.rtmp.youtube.com/live2/$YT_STREAM_KEY
