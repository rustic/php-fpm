ARG VERSION
ARG VCS_REF

# ============================================================
# STAGE 1: Builder - compiles all extensions, never shipped
# ============================================================
FROM php:$VERSION-fpm-alpine AS builder

# Parallel compile jobs for docker-php-ext-install.
# 2 is safe under qemu emulation; override with --build-arg JOBS=$(nproc) on native builders.
ARG JOBS=2

RUN apk add --no-cache --virtual .build-dependencies \
    autoconf \
    bzip2-dev \
    freetype-dev \
    g++ \
    gettext-dev \
    icu-dev \
    imagemagick-dev \
    libjpeg-turbo-dev \
    libmemcached-dev \
    libpng-dev \
    libtool \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    linux-headers \
    make \
    oniguruma-dev \
    pcre-dev \
    zlib-dev

# Configure extensions that need it
RUN docker-php-ext-configure gd \
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
        --with-webp=/usr/include/ \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure intl

# Install extensions that require compilation
RUN docker-php-ext-install -j${JOBS} \
    bcmath \
    bz2 \
    calendar \
    exif \
    gd \
    gettext \
    intl \
    mysqli \
    pdo_mysql \
    soap \
    sockets \
    xsl \
    zip

# Install opcache only on PHP < 8.5 (built in from 8.5 onward)
RUN if php -r 'exit(version_compare(PHP_VERSION, "8.5.0", ">=") ? 0 : 1);'; then \
        echo "PHP 8.5+: opcache is built in, skipping"; \
    else \
        docker-php-ext-install opcache; \
    fi

# Install igbinary first - imagick, memcached and redis use it if present
RUN pecl install igbinary \
    && docker-php-ext-enable igbinary

# Install imagick via PECL
RUN pecl install imagick-3.8.1 \
    && docker-php-ext-enable imagick

# Install APCu
RUN pecl install apcu \
    && docker-php-ext-enable apcu

# Install Memcached with igbinary serialization
RUN pecl install --configureoptions 'enable-memcached-igbinary="yes"' memcached \
    && docker-php-ext-enable memcached

# Install Redis with igbinary and lzf support
RUN pecl install --configureoptions 'enable-redis-igbinary="yes" enable-redis-lzf="yes"' redis \
    && docker-php-ext-enable redis

# Scan for runtime deps and write them to a file for the final stage to consume
RUN scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
        | tr ',' '\n' \
        | sort -u \
        | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
        > /tmp/rundeps

# ============================================================
# STAGE 2: Final - pristine base image, only artifacts copied
# ============================================================
FROM php:$VERSION-fpm-alpine AS final

# Redeclare args so they're in scope for this stage
ARG VERSION
ARG VCS_REF

LABEL org.opencontainers.image.title="rustic/php-fpm" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$VCS_REF

# Copy compiled extension .so files from builder
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/

# Copy extension ini files that docker-php-ext-enable created
COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Copy the runtime deps list and install only those
COPY --from=builder /tmp/rundeps /tmp/rundeps
RUN apk add --no-cache --virtual .phpexts-rundeps $(cat /tmp/rundeps) \
    && rm /tmp/rundeps

# PHP ini tuning (opcache, APCu, error logging) and production php.ini as base
RUN printf '%s\n' \
        'opcache.memory_consumption=128' \
        'opcache.interned_strings_buffer=8' \
        'opcache.max_accelerated_files=4000' \
        'opcache.revalidate_freq=2' \
        > /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && printf '%s\n' \
        'apc.enabled=1' \
        'apc.shm_size=64M' \
        'apc.ttl=7200' \
        'apc.enable_cli=0' \
        > /usr/local/etc/php/conf.d/apcu-recommended.ini \
    && printf '%s\n' \
        'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR' \
        'display_errors = Off' \
        'display_startup_errors = Off' \
        'log_errors = On' \
        'error_log = /dev/stderr' \
        'log_errors_max_len = 1024' \
        'ignore_repeated_errors = On' \
        'ignore_repeated_source = Off' \
        'html_errors = Off' \
        > /usr/local/etc/php/conf.d/error-logging.ini \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
