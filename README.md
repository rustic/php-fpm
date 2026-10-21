# php-fpm

## Docker images for PHP based on the official images

This container follows the Wordpress recommendations for additional PHP modules, error reporting and Opcache configuration.

- rustic/php-fpm on GitHub [https://github.com/rustic/php-fpm](https://github.com/rustic/php-fpm)
- rustic/php-fpm on DockerHub [https://hub.docker.com/r/rustic/php-fpm](https://hub.docker.com/r/rustic/php-fpm)

## License and Architecture

![GitHub](https://img.shields.io/github/license/rustic/php-fpm?style=for-the-badge) \
![Arch](https://img.shields.io/badge/Arch-linux%2Famd64-green?style=for-the-badge)
![Arch](https://img.shields.io/badge/Arch-linux%2Farm64-green?style=for-the-badge)

## Latest Release

![Docker Image Version (latest semver)](https://img.shields.io/docker/v/rustic/php-fpm?sort=semver&style=for-the-badge)

## Current Releases

![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/8.5-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/8.4-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/8.3-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/8.2-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/8.1-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/8.0-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/7.4-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/7.3-fpm-alpine?style=for-the-badge)

Includes the following additional PHP modules:

### Core Extensions

- bcmath
- bz2
- calendar
- exif
- gd *(with freetype, jpeg, and webp support)*
- gettext
- intl
- mysqli
- opcache *(built-in on PHP 8.5+)*
- pdo_mysql
- soap
- sockets
- xsl
- zip

### Caching Extensions

- apcu *(in-memory key-value store)*
- memcached *(with igbinary serialization)*
- redis *(with igbinary serialization and lzf compression)*

### Image Processing

- imagick *(with igbinary serialization)*

### Serialization

- igbinary *(faster drop-in replacement for PHP's native serializer, used by imagick, memcached and redis)*

### PHP ini Configuration

The following configuration is applied out of the box:

### Opcache

- `opcache.memory_consumption=128`
- `opcache.interned_strings_buffer=8`
- `opcache.max_accelerated_files=4000`
- `opcache.revalidate_freq=2`

### APCu

- `apc.enabled=1`
- `apc.shm_size=64M`
- `apc.ttl=7200`

### Error Logging

- Errors logged to stderr, display off, production-safe settings

## Usage

An example Docker Compose file:

```yaml
services:
  nginx:
    image: nginx:latest
    volumes:
      - ./conf.d/nginx:/etc/nginx/conf.d
      - ./html:/var/www/html
  php-fpm:
    image: rustic/php-fpm:latest
    user: "101:101"
    volumes:
      - ./html:/var/www/html
      - ./phpextras.ini:/usr/local/etc/php/conf.d/phpextras.ini
```
