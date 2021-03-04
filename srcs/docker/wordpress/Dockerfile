FROM alpine:3.12

RUN apk update \
	&& apk add wget \
	&& apk add nginx && mkdir -p /run/nginx \
	&& apk add openrc --no-cache \
	&& apk add mysql-client \
	&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session php-common \
	php-cli php-mbstring php-bz2 php-phar php-cgi\
	&& wget -P /tmp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /tmp/wp-cli.phar && mv /tmp/wp-cli.phar /usr/sbin/wp
#intall telegraf
RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY srcs/docker/wordpress/srcs_wordpress/init.sh /sbin/
COPY srcs/docker/wordpress/srcs_wordpress/setup_wordpress.sh /sbin/
COPY srcs/docker/wordpress/default.conf /etc/nginx/conf.d/default.conf
RUN chmod 777 /sbin/init.sh
RUN chmod 777 /sbin/setup_wordpress.sh

EXPOSE 5050 

ENTRYPOINT ["/sbin/init.sh"]