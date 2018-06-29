#!/bin/bash
selenium_port=${SELENIUM_PORT:-4444}
vnc_port=${VNC_PORT:-5900}
echo "vnc port: ${vnc_port}"
echo "selenium port: ${selenium_port}"
docker run -d -p ${selenium_port}:4444 -p ${vnc_port}:5900 -v /dev/shm:/dev/shm selenium/standalone-chrome-debug
