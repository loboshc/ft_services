#!/bin/sh

SERVICIO=""
SERVICIO="${SERVICIO} msql"
SERVICIO="${SERVICIO} wordpress"
SERVICIO="${SERVICIO} phpmyadmin"
SERVICIO="${SERVICIO} influxdb"

cd /usr/share/grafana/conf/provisioning/datasources

for NAME in ${SERVICIO}; do
	echo "apiVersion: 1

datasources:
  - name: ${NAME}
    type: influxdb
    access: proxy
    database: ${NAME}
    editable: true
    url: http://influxdb-svc:8086" > ${NAME}.yaml
done