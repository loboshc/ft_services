# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/17 19:17:59 by dlobos-m          #+#    #+#              #
#    Updated: 2021/03/23 16:12:06 by dlobos-m         ###   ########.fr        #
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
	php-cli php-mbstring php-bz2 php-phar \
	&& apk add --no-cache git make musl-dev go \
	&& apk add --no-cache procps

RUN mkdir -p /var/lib/nginx/www/ \
	&& cd /var/lib/nginx/www/ \
	&& wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages phpmyadmin \
	&& adduser -D -g 'www' www \
	&& chown -R www:www /var/lib/nginx

RUN cd /tmp && wget https://github.com/FiloSottile/mkcert/archive/v1.0.0.tar.gz && tar xzvf /tmp/v1.0.0.tar.gz \
	&& cd /tmp/mkcert-1.0.0 && make \
	&& cd /tmp/mkcert-1.0.0/bin && chmod +x mkcert \
	&& cd /tmp/mkcert-1.0.0/bin && cp mkcert /usr/bin/ \
	&& cd /tmp/ && mkcert -install && mkcert localhost

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY srcs/docker/phpmyadmin/srcs_phpmyadmin/default.conf /etc/nginx/conf.d/default.conf
COPY srcs/docker/phpmyadmin/srcs_phpmyadmin/config.inc.php /var/lib/nginx/www//phpmyadmin
COPY srcs/docker/phpmyadmin/srcs_phpmyadmin/init_phpmyadmin.sh /sbin/
COPY srcs/docker/phpmyadmin/srcs_phpmyadmin/ft_services.sh /sbin/
RUN chmod +x /sbin/init_phpmyadmin.sh
RUN chmod +x /sbin/ft_services.sh 

EXPOSE 5000

ENTRYPOINT ["/sbin/init_phpmyadmin.sh"]