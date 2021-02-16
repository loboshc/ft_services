#!/bin/sh

/sbin/setup_wordpress.sh
/usr/sbin/wp server --host=0.0.0.0 --port=5050 --docroot=/usr/share/webapps/wordpress