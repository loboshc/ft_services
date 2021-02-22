# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/20 16:55:57 by diego             #+#    #+#              #
#    Updated: 2021/02/22 21:02:19 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& cd /sbin/ \
	&& wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.0.4-linux-amd64.tar.gz \
	&& tar xvfz influxdb2-2.0.4-linux-amd64.tar.gz \
	&& rm influxdb2-2.0.4-linux-amd64.tar.gz \
	&& mv influxdb2-2.0.4-linux-amd64 influxdb

COPY srcs/docker/influxdb/init.sh /sbin/
RUN chmod 777 /sbin/init.sh

EXPOSE 8086

ENTRYPOINT ["/sbin/init.sh"]
