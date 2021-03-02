#!/bin/sh
#configuracion telegraf
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = ["http:\/\/influxdb-svc:8086"]/' telegraf.conf
sed -i '116s/.*/  database = "wordpress"/' telegraf.conf

php --server 0.0.0.0:5000 --docroot /usr/share/webapps/phpmyadmin & sleep 20
./telegraf --config telegraf.conf