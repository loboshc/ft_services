#!/bin/sh

mysql_install_db --user=root --datadir=/var/lib/mysql/
mysqld --user=root < /tmp/mariadb-create.sql
