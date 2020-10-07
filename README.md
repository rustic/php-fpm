# php-fpm
### Docker images for PHP based on the official images.
This container follows the Wordpress recommendations for additional PHP modules, error reporting and Opcache configuration.

### Latest
[![](https://images.microbadger.com/badges/version/rustic/php-fpm.svg)](https://microbadger.com/images/rustic/php-fpm "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/rustic/php-fpm:7.4-fpm-alpine.svg)](https://microbadger.com/images/rustic/php-fpm:7.4-fpm-alpine "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/rustic/php-fpm:arm32v7-7.4-fpm-alpine.svg)](https://microbadger.com/images/rustic/php-fpm:arm32v7-7.4-fpm-alpine "Get your own version badge on microbadger.com")

### Supported
[![](https://images.microbadger.com/badges/version/rustic/php-fpm:7.3-fpm-alpine.svg)](https://microbadger.com/images/rustic/php-fpm:7.3-fpm-alpine "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/rustic/php-fpm:arm32v7-7.3-fpm-alpine.svg)](https://microbadger.com/images/rustic/php-fpm:arm32v7-7.3-fpm-alpine "Get your own version badge on microbadger.com")

### Testing
[![](https://images.microbadger.com/badges/version/rustic/php-fpm:8.0-fpm-alpine.svg)](https://microbadger.com/images/rustic/php-fpm:8.0-fpm-alpine "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/rustic/php-fpm:arm32v7-8.0-fpm-alpine.svg)](https://microbadger.com/images/rustic/php-fpm:arm32v7-8.0-fpm-alpine "Get your own version badge on microbadger.com")

Includes the following additional PHP modules: 
- bcmath
- bz2
- calendar
- exif
- gd
- gettext
- imagick
- intl
- mysqli
- opcache
- pdo_mysql
- soap
- sockets
- xsl
- zip

### Usage
An example Docker Compose file:

```yaml
version: '3.6'
services:
  nginx:
    image: nginx:latest
    volumes:
      - ./conf.d/nginx:/etc/nginx/conf.d
      - ./html:/var/www/html
  php-fpm:
    image: rustic/php-fpm:7.4-fpm-alpine
    user: "101:101"
    volumes:
      - ./html:/var/www/html
      - ./phpextras.ini:/usr/local/etc/php/conf.d/phpextras.ini
```
