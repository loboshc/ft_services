#!/bin/sh

echo -e $PASS_ADMIN | passwd admin
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj "/C=ES/ST=Madrid/L=Madrid/O=42_network/CN=localhost"
vsftpd /etc/vsftpd/vsftpd.conf