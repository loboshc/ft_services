#!/bin/sh
cd /sbin/telegraf/usr/bin
./telegraf -sample-config -input-filter kube_inventory -output-filter influxdb > telegraf.conf
./telegraf --config telegraf.conf