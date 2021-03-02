#!/bin/sh

#configuracion telegraf
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
sed -i '112s/.*/  urls = ["http:\/\/influxdb-svc:8086"]/' telegraf.conf
sed -i '116s/.*/  database = "mysql"' telegraf.conf

mysql_install_db --user=root --datadir=/var/lib/mysql/
mysqld --user=root --bootstrap < /tmp/mariadb-create.sql
mysqld --user=root & sleep 10
./telegraf --config telegraf.conf