FROM php:7.4-fpm

# Install required extensions
RUN apt-get update && \
  apt-get install -y \
  libbz2-dev \
  libcurl4-openssl-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng-dev \
  libxml2-dev \
  libonig-dev \
  libzip-dev && \
  rm -rf /var/lib/apt/lists/* && \
  docker-php-ext-install \
  bcmath \
  opcache \
  zip && \
  docker-php-ext-configure gd && \
  docker-php-ext-install -j$(nproc) \
  gd && \
  docker-php-ext-install -j$(nproc) \
  pdo_mysql \
  mbstring \
  curl \
  json \
  soap \
  xml \
  xmlrpc

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

# Start php-fpm
CMD ["php-fpm"]
