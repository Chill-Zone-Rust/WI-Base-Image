#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $(NF-2);exit}'`

# Create template file if it doesn't exist
FILE=server.conf
if [ ! -f "$FILE" ]; then
  echo "listen ${NGINX_PORT};" > $FILE
fi

# Copy nginx config file to nginx folder
cp server.conf /etc/nginx/templates/server.template

# Run the Server
${STARTUP}
