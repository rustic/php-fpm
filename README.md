# php-fpm
### Docker images for PHP based on the official images.
This container follows the Wordpress recommendations for additional PHP modules, error reporting and Opcache configuration.

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