# php-fpm
### Docker images for PHP based on the official images.
This container follows the Wordpress recommendations for additional PHP modules, error reporting and Opcache configuration.

### License and Architechture
![GitHub](https://img.shields.io/github/license/rustic/php-fpm?style=for-the-badge) \
![Arch](https://img.shields.io/badge/Arch-linux%2Famd64-green?style=for-the-badge)
![Arch](https://img.shields.io/badge/Arch-linux%2Farm%2fv7-green?style=for-the-badge)
![Arch](https://img.shields.io/badge/Arch-linux%2Farm64-green?style=for-the-badge)

### Latest Release
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/rustic/php-fpm?sort=semver&style=for-the-badge)

### Current Releases
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/8.1-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/8.0-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/7.4-fpm-alpine?style=for-the-badge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/rustic/php-fpm/7.3-fpm-alpine?style=for-the-badge)


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
    image: rustic/php-fpm:latest
    user: "101:101"
    volumes:
      - ./html:/var/www/html
      - ./phpextras.ini:/usr/local/etc/php/conf.d/phpextras.ini
```
