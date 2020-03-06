FROM arm32v7/php:7.4-fpm-alpine
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
    libtool \
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
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
    --with-webp=/usr/include/ \
    --with-xpm=/usr/include/ \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    exif \
    gd \
    gettext \
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