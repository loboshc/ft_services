# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/02 15:02:51 by dlobos-m          #+#    #+#              #
#    Updated: 2021/03/21 12:55:36 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


FROM alpine:3.12

RUN apk add mariadb mariadb-client mariadb-common
RUN mkdir -p /run/mysqld

COPY srcs/docker/mysql/srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
COPY srcs/docker/mysql/srcs/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY srcs/docker/mysql/srcs/mariadb-create.sql /tmp/

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf \
	&& apk add --no-cache procps

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]