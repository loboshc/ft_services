#!/bin/sh

cd /usr/share/webapps/wordpress

/usr/sbin/wp config create --dbname=wordpress --dbuser=wp_admin --dbpass=123456 --dbhost=mysql-svc

/usr/sbin/wp core install --url=http://localhost:5050 --title=hola --admin_user=wp_admin --admin_password=123456 --admin_email=dlobos-m@student.42madrid.com --skip-email

php --server 0.0.0.0:5050 --docroot /usr/share/webapps/wordpress