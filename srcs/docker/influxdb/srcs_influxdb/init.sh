#!/bin/sh

cd /sbin/influxdb
./influxd & sleep 10
./influx setup -u admin -p 123456789 -o ft_services -b ft_services -r 0 -f
tail -f /dev/null