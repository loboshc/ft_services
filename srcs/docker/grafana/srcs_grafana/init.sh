#!/bin/sh

grafana-cli --homepath "/usr/share/grafana" admin reset-admin-password admin123
cd /usr/share/grafana/conf/provisioning/datasources
echo "apiVersion: 1

datasources:
  - name: InfluxDB
    type: influxdb
    access: proxy
    database: influxdb
    editable: true
    url: http://influxdb-svc:8086" > influxdb.yaml

cd /usr/share/grafana && /usr/sbin/grafana-server --config=/etc/grafana.ini