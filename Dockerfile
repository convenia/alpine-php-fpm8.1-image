# Alpine como a imagem mais limpa
FROM php:8.1.4-fpm-alpine3.15
# Informações
LABEL maintainer="devs@convenia.com.br"
LABEL company="Convenia"
# Chave para construir uma imagem de desenvolvimento ou produção
ARG ENVIRONMENT=development
# Instalação de pacotes
RUN apk --update add git
# Instalação do php ext installer (https://github.com/mlocati/docker-php-extension-installer)
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
# Instalação de pacotes
RUN IPE_GD_WITHOUTAVIF=1 install-php-extensions bcmath bz2 calendar exif gd gettext gmp opcache pcntl \
    pdo_mysql sockets xsl zip \
    igbinary-stable \
    redis-stable \
    mongodb-stable \
    xdebug-stable \
    imagick-stable
# Instalação do composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
# Configuração específica da Convenia
COPY convenia/php/convenia-${ENVIRONMENT}.ini /usr/local/etc/php/conf.d/99_convenia.ini
COPY convenia/fpm/docker-${ENVIRONMENT}.conf /usr/local/etc/php-fpm.d/docker.conf
COPY convenia/fpm/www-${ENVIRONMENT}.conf /usr/local/etc/php-fpm.d/www.conf
# Cria usuário e grupo app
RUN addgroup -S -g 1000 app && adduser -u 1000 -G app -D app
# Portas padrão do FPM e XDebug
EXPOSE 9000 9003
WORKDIR /var/www
CMD ["php-fpm","-F"]