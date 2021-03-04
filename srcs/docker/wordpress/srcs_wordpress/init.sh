#!/bin/sh
#configuracion telegraf
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = ["http:\/\/influxdb-svc:8086"]/' telegraf.conf
sed -i '116s/.*/  database = "phpmyadmin"/' telegraf.conf

sleep 20
#configuracion nginx
mkdir -p /var/lib/nginx/www/wordpress
adduser -D -g 'www' www
chown -R www:www /var/lib/nginx
sed -i '3s/.*/user www;/' /etc/nginx/nginx.conf
#configuracion openrc
rc-status -a
touch /run/openrc/softlevel
#configuro usuario y grupo en PHP-FPM
sed -i '23s/.*/user = www/' /etc/php7/php-fpm.d/www.conf
sed -i '24s/.*/group = www/' /etc/php7/php-fpm.d/www.conf

/sbin/setup_wordpress.sh
rc-service php-fpm7 start; rc-service nginx start
cd /sbin/telegraf/usr/bin
./telegraf --config telegraf.conf