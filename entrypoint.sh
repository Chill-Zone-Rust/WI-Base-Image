#!/bin/bash

cd /var/www/pterorust-wi

# php artisan key:generate
# php artisan migrate --seed --force

# php artisan view:clear
# php artisan config:clear

nginx -g "daemon off;"
