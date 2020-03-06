FROM php:7.3-fpm-alpine
RUN apk add --no-cache --virtual .build-dependencies \
    autoconf \
    bzip2-dev \
    freetype-dev \
    g++ \
    gettext-dev \
    icu-dev \
    imagemagick-dev \
    libgcrypt-dev \
    libgpg-error-dev \
    libjpeg-turbo-dev \    
    libpng-dev \
    libwebp-dev \
    libxml2-dev \
    libxpm-dev \
    libxslt-dev \
    libzip-dev \
    make \
    pcre-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-webp-dir=/usr/include/ \
    --with-xpm-dir=/usr/include/ \
    && docker-php-ext-configure zip \
    --with-libzip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    exif \
    gettext \
    gd \
    intl \
    mysqli \
    opcache \
    pdo_mysql \
    soap \
    sockets \
    xsl \
    zip \
    && apk del --no-cache .build-dependencies \
    && docker-php-source delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* /var/tmp/* \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" 