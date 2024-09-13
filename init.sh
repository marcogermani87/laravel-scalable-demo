#!/bin/bash -e

if [ -d /tmp/node_modules ]; then
  cp -prf /tmp/node_modules /var/www/html/
  rm -rf /tmp/node_modules
fi

chown -R www-data:www-data /var/www/html/
chmod g+w -R /var/www/html/
chmod 755 -R /var/www/html/storage/
chmod 755 -R /var/www/html/bootstrap/cache

php-fpm
