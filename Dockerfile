FROM nginx:latest

# Add PHP repository
RUN apt-get update && apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2 wget unzip
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -

# Install PHP 8.0
RUN apt-get update && apt-get install -y php8.0 php8.0-fpm php8.0-mysql php8.0-curl php8.0-gd php8.0-mbstring php8.0-xml php8.0-zip

# RUN mkdir -p /var/www/pterorust-wi
WORKDIR /var/www/pterorust-wi

# Copy pterorust.zip to container
COPY pterorust.zip .
RUN unzip pterorust.zip
RUN rm pterorust.zip

RUN chmod -R 755 storage/* bootstrap/cache/
RUN chown -R www-data:www-data *

RUN mkdir /etc/crontabs
RUN echo "* * * * * php /var/www/pterorust-wi/artisan schedule:run >> /dev/null 2>&1" >> /etc/crontabs/www-data

# Copy server.conf into nginx
COPY server.conf /etc/nginx/conf.d/default.conf

# USER www-data

ENV SERVER_PORT=8123

STOPSIGNAL SIGTERM

# Entrypoint
COPY entrypoint.sh /
CMD [ "/bin/bash", "/entrypoint.sh" ]
