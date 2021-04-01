# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/20 16:55:57 by dlobos-m          #+#    #+#              #
#    Updated: 2021/04/01 16:21:46 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk add influxdb \
	&& cd /sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf \
	&& apk add --no-cache procps

COPY srcs/docker/influxdb/srcs_influxdb/init.sh /sbin/
COPY srcs/docker/influxdb/srcs_influxdb/ft_services.sh /sbin/
RUN chmod +x /sbin/init.sh
RUN chmod +x /sbin/ft_services.sh

EXPOSE 8086

ENTRYPOINT ["/sbin/init.sh"]
