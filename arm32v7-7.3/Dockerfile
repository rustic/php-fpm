FROM arm32v7/php:7.3-fpm-alpine
RUN apk add --no-cache \
    bzip2 \
    gd \
    gettext \
    libxslt \
    libzip \
    icu-libs \
    imagemagick \
    && apk add --no-cache --virtual .build-dependencies \
    autoconf \
    g++ \
    libtool \
    make \
    pcre-dev \
    imagemagick-dev \
    freetype-dev \
    libpng-dev \
    libzip-dev \
    icu-dev \
    bzip2-dev \
    gettext-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-turbo-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    exif \
    gettext \
    mysqli \
    opcache \
    pdo_mysql \
    soap \
    sockets \
    xsl \
    && apk del --no-cache .build-dependencies \
    freetype-dev \
    libpng-dev \
    libzip-dev \
    icu-dev \
    bzip2-dev \
    gettext-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-turbo-dev \
    autoconf \
    g++ \
    libtool \
    make \
    pcre-dev \
    imagemagick-dev \
    && docker-php-source delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* /var/tmp/* \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" 
