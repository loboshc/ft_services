# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/01 16:23:04 by dlobos-m          #+#    #+#              #
#    Updated: 2021/04/01 16:23:05 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk add wget \
	&& apk add nginx && mkdir -p /run/nginx \
	&& apk add openrc --no-cache \
	&& apk add mysql-client \
	&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session php-common \
	php-cli php-mbstring php-bz2 php-phar php-cgi \
	&& apk --update add php7-ctype \
	&& wget -P /tmp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /tmp/wp-cli.phar && mv /tmp/wp-cli.phar /usr/sbin/wp
#intall telegraf
RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf \
	&& apk add --no-cache procps

COPY srcs/docker/wordpress/srcs_wordpress/init.sh /sbin/
COPY srcs/docker/wordpress/srcs_wordpress/setup_wordpress.sh /sbin/
COPY srcs/docker/wordpress/default.conf /etc/nginx/conf.d/default.conf
COPY srcs/docker/wordpress/srcs_wordpress/ft_services.sh /sbin/
RUN chmod +x /sbin/init.sh
RUN chmod +x /sbin/setup_wordpress.sh
RUN chmod +x /sbin/ft_services.sh

EXPOSE 5050 

ENTRYPOINT ["/sbin/init.sh"]