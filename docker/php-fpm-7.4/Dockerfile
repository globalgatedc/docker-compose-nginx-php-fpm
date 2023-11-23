FROM php:7.4-fpm-alpine

# Install required extensions
RUN apk add --no-cache \
  libbz2 \
  curl-dev \
  libcurl \
  libjpeg-turbo \
  libjpeg-turbo-dev \
  libmcrypt \
  libmcrypt-dev \
  libpng \
  libpng-dev \
  libxml2 \
  libxml2-dev \
  libzip \
  oniguruma-dev \
  libzip-dev && \
  docker-php-ext-install \
  bcmath \
  opcache \
  zip && \
  docker-php-ext-configure gd && \
  docker-php-ext-install -j$(nproc) \
  gd \
  pdo_mysql \
  mbstring \
  curl \
  json \
  soap \
  xml \
  xmlrpc && \
  apk update && \
  apk del gcc g++

# Enable the installed extensions
RUN docker-php-ext-enable \
  bcmath \
  opcache \
  zip \
  gd \
  pdo_mysql \
  mbstring \
  curl \
  json \
  soap \
  xml \
  xmlrpc

WORKDIR /var/www

# Start php-fpm
CMD ["php-fpm"]
