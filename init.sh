#!/bin/bash -e

if [ -d /tmp/node_modules ]; then
  cp -prf /tmp/node_modules /var/www/html/
  rm -rf /tmp/node_modules
fi

chown -R 1000:www-data /var/www/html/
chmod g+w -R /var/www/html/
chmod 755 -R /var/www/html/storage/
chmod 755 -R /var/www/html/bootstrap/cache

composer install

exec php artisan octane:frankenphp --host=127.0.0.1 --port=80
