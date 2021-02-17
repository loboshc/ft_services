# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/17 19:17:59 by dlobos-m          #+#    #+#              #
#    Updated: 2021/02/17 20:26:33 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk add wget \
	&& apk add mysql-client \
	&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session php-common \
	php-cli php-mbstring php-bz2 php-phar

RUN mkdir -p /usr/share/webapps/ \
	&& cd /usr/share/webapps \
	&& wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages phpmyadmin \
	&& chmod -R 777 /usr/share/webapps/

COPY srcs/docker/phpmyadmin/srcs_phpmyadmin/config.inc.php /usr/share/webapps/phpmyadmin
COPY srcs/docker/phpmyadmin/srcs_phpmyadmin/init_phpmyadmin.sh /sbin/
RUN chmod 777 /sbin/init_phpmyadmin.sh

EXPOSE 5000

ENTRYPOINT ["/sbin/init_phpmyadmin.sh"]