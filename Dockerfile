FROM nginx:latest

# Add PHP repository
RUN apt-get update && apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2 wget
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -

# Install PHP 8.0
RUN apt-get update && apt-get install -y php8.0 php8.0-fpm php8.0-mysql php8.0-curl php8.0-gd php8.0-mbstring php8.0-xml php8.0-zip

# Entrypoint
CMD ["nginx", "-g", "daemon off;"]
