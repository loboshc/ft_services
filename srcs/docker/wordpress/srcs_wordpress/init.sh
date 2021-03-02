#!/bin/sh
#configuracion telegraf
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = ["http:\/\/influxdb-svc:8086"]/' telegraf.conf
sed -i '116s/.*/  database = "phpmyadmin"/' telegraf.conf

sleep 20
/sbin/setup_wordpress.sh
/usr/sbin/wp server --host=0.0.0.0 --port=5050 --docroot=/usr/share/webapps/wordpress & sleep 40
cd /sbin/telegraf/usr/bin
./telegraf --config telegraf.conf