FROM alpine:3.14

LABEL maintainer="devs@convenia.com.br"
LABEL company="Convenia"
ARG ENVIRONMENT=development
RUN apk --update add php8 php8-common php8-fpm php8-bcmath php8-bz2 php8-calendar php8-ctype php8-exif php8-gd php8-gettext php8-gmp php8-mysqlnd \
    php8-opcache php8-pcntl php8-pdo_mysql php8-pdo_sqlite php8-phar php8-sockets php8-xsl php8-zip \
    php8-pecl-igbinary php8-pecl-xdebug php8-pecl-redis php8-pecl-mongodb \
    supervisor nginx nginx-mod-http-headers-more sqlite git openssh curl
RUN ln -s /usr/bin/php8 /usr/bin/php
COPY convenia/php/getcomposer.sh /tmp/
RUN sh /tmp/getcomposer.sh && rm /tmp/getcomposer.sh
RUN ln -s /usr/local/etc/php/php.ini-${ENVIRONMENT} /etc/php8/conf.d/99_convenia.ini
RUN mkdir -p /var/log/supervisor /run/nginx
COPY convenia/php/convenia-${ENVIRONMENT}.ini /etc/php8/conf.d/99_convenia.ini
COPY convenia/nginx/security.conf /etc/nginx/conf.d/security.conf
