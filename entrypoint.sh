#!/bin/bash
cd /home/container

# Create template file if it doesn't exist
FILE=server.conf
if [ ! -f "$FILE" ]; then
  echo "listen ${NGINX_PORT};" > $FILE
fi

# Copy nginx config file to nginx folder
cp server.conf /etc/nginx/conf.d/default.conf

# Run the Server
${STARTUP}
