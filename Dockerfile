FROM php:8.3-fpm-alpine3.22

ARG PUID=1000
ARG PGID=1000

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN set -eux; \
  apk add --no-cache \
  curl \
  nano \
  shadow \
  openssl-dev; \
  apk add --no-cache --virtual .build-deps \
  build-base \
  autoconf \
  linux-headers; \
  groupmod -o -g ${PGID} www-data; \
  usermod -o -u ${PUID} -g www-data www-data; \
  apk del .build-deps; \
  rm -rf /tmp/pear /var/cache/apk/*

WORKDIR /var/www/html

USER www-data