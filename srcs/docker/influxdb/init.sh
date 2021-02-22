#!/bin/sh

cd /sbin/influxdb
./influxd
./influx setup -u admin -p 123456789 -o ft_services -b ft_services -r 0 -f
