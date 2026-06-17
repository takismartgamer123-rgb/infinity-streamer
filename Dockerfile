FROM jrottenberg/ffmpeg:4.4-ubuntu

# نركبو Node.js
RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

WORKDIR /app
COPY video.mp4 .
COPY start.sh .

RUN chmod +x start.sh
RUN echo "const http=require('http');http.createServer((req,res)=>res.end('INFINITY GEN 24/7 Live')).listen(process.env.PORT||3000);" > server.js

# هذا السطر هو الحل: نلغو ENTRYPOINT تاع FFmpeg
ENTRYPOINT []

# ضرك CMD يخدم نورمال
CMD ["./start.sh"]
