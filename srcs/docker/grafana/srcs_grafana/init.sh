#!/bin/sh


grafana-cli --homepath "/usr/share/grafana" admin reset-admin-password admin123
./create_datasources.sh
cd /usr/share/grafana && /usr/sbin/grafana-server --config=/etc/grafana.ini