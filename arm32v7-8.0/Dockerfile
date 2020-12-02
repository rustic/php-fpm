FROM arm32v7/php:8.0-fpm-alpine
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
    && mkdir -p /usr/src/php/ext/imagick \
    && curl -fsSL https://github.com/Imagick/imagick/archive/c5b8086b5d96c7030e6d4e6ea9a5ef49055d8273.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1 \
    && docker-php-ext-install imagick \
    && runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
    && apk add --virtual .wordpress-phpexts-rundeps $runDeps \
    && echo 'opcache.memory_consumption=128' > /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo 'opcache.interned_strings_buffer=8' >> /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo 'opcache.max_accelerated_files=4000' >> /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo 'opcache.revalidate_freq=2' >> /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo 'opcache.fast_shutdown=1' >> /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR' > /usr/local/etc/php/conf.d/error-logging.ini \
    && echo 'display_errors = Off' >> /usr/local/etc/php/conf.d/error-logging.ini \
    && echo 'display_startup_errors = Off' >> /usr/local/etc/php/conf.d/error-logging.ini \
    && echo 'log_errors = On' >> /usr/local/etc/php/conf.d/error-logging.ini \
    && echo 'error_log = /dev/stderr' >> /usr/local/etc/php/conf.d/error-logging.ini \
    && echo 'log_errors_max_len = 1024' >> /usr/local/etc/php/conf.d/error-logging.ini \
    && echo 'ignore_repeated_errors = On' >> /usr/local/etc/php/conf.d/error-logging.ini \
    && echo 'ignore_repeated_source = Off' >> /usr/local/etc/php/conf.d/error-logging.ini \
    && echo 'html_errors = Off' >> /usr/local/etc/php/conf.d/error-logging.ini \
    && apk del .build-dependencies \
    && docker-php-source delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* /var/tmp/* \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" 
