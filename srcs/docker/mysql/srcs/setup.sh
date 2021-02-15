#!/bin/sh

mysql_install_db --user=root --datadir=/var/lib/mysql/
mysqld --user=root --bootstrap < /tmp/mariadb-create.sql
mysqld --user=root
