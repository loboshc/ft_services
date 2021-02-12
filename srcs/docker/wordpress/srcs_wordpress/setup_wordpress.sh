#!/bin/sh

mkdir -p /usr/share/webapps/ \
cd /usr/share/webapps/ \
chmod 777 /usr/share/webapps/wordpress/wp-content/uploads \
chown -R nginx:www-data /usr/share/webapps/ \
ln -s /usr/share/webapps/wordpress /var/www/wordpress
