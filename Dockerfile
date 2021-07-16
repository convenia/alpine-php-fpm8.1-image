# Alpine como a imagem mais limpa
FROM alpine:3.14
# Informações
LABEL maintainer="devs@convenia.com.br"
LABEL company="Convenia"
# Chave para construir uma imagem de desenvolvimento ou produção
ARG ENVIRONMENT=development
# Instalação de pacotes
RUN apk --update add php8 php8-common php8-fpm php8-bcmath php8-bz2 php8-calendar php8-ctype php8-exif php8-gd php8-gettext php8-gmp php8-mysqlnd \
    php8-opcache php8-pcntl php8-pdo_mysql php8-pdo_sqlite php8-phar php8-sockets php8-xsl php8-zip \
    php8-pecl-igbinary php8-pecl-xdebug php8-pecl-redis php8-pecl-mongodb \
    sqlite git openssh curl zip unzip
# Executável como somente 'php'
RUN ln -s /usr/bin/php8 /usr/bin/php
# Instalação do composer
COPY convenia/php/getcomposer.sh /tmp/
RUN sh /tmp/getcomposer.sh && rm /tmp/getcomposer.sh
# Configuração específica da Convenia
COPY convenia/php/convenia-${ENVIRONMENT}.ini /etc/php8/conf.d/99_convenia.ini
# Portas padrão do FPM e XDebug
EXPOSE 9000 9003
CMD ["php-fpm8","-F"]