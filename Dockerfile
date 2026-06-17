FROM jrottenberg/ffmpeg:4.4-ubuntu

WORKDIR /app
COPY video.mp4 .

# سيرفر وهمي باش Render ما يرقدش
RUN echo "const http=require('http');http.createServer((req,res)=>res.end('INFINITY GEN 24/7 Live')).listen(process.env.PORT||3000);" > server.js

# بث صورة ثابتة 1fps = زيرو CPU
CMD sh -c "node server.js & ffmpeg -re -loop 1 -framerate 1 -i video.mp4 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf scale=854:480 -c:v libx264 -preset ultrafast -tune stillimage -x264-params keyint=2:min-keyint=2 -b:v 400k -maxrate 400k -bufsize 800k -pix_fmt yuv420p -g 2 -c:a aac -b:a 64k -shortest -f flv rtmp://a.rtmp.youtube.com/live2/$YT_STREAM_KEY"