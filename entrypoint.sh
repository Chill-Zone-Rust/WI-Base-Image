#!/bin/bash

cd /home/container


# Copy conf file if it doesn't exist
FILE=server.conf
if [ ! -f "$FILE" ]; then
  copy /temp/server.conf.default $FILE
fi

nginx -g "daemon off;"
