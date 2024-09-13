FROM node:20-alpine AS node_stage

WORKDIR /app

COPY src/package*.json src/*.mix.js /app/

RUN npm install

FROM php:8.2-fpm

RUN apt-get update && apt-get install -y build-essential libpq-dev libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    locales zip jpegoptim optipng pngquant gifsicle vim unzip curl libzip-dev libcurl4-gnutls-dev libicu-dev libmcrypt-dev \
    libxml2-dev libxslt1-dev libssh2-1-dev libssh2-1 libssl-dev ssh wget libffi-dev iputils-ping telnet \
    nano default-mysql-client

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

RUN apt-get install -y nodejs

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions

RUN install-php-extensions bcmath curl fileinfo intl json mbstring mcrypt mysqli pdo_mysql simplexml soap sockets \
    xml xmlreader xmlrpc xmlwriter xsl zip ssh2 gd redis pcntl exif memcached opcache calendar gettext ldap posix

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html

COPY --from=node_stage /app/node_modules /tmp/node_modules

WORKDIR /var/www/html/public

ADD init.sh /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]

