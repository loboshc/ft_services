#!/bin/sh
#configuracion telegraf
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = ["http:\/\/influxdb-svc:8086"]/' telegraf.conf
sed -i '116s/.*/  database = "nginx"/' telegraf.conf

sleep 20
#configuracion nginx
adduser -D -g 'www' www
chown -R www:www /var/lib/nginx
sed -i '3s/.*/user www;/' /etc/nginx/nginx.conf
#configuracion openrc
rc-status -a
touch /run/openrc/softlevel
rc-service nginx start
cd /sbin/telegraf/usr/bin
./telegraf --config telegraf.conf