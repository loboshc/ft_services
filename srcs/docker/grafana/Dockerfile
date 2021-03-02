# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/28 18:36:18 by diego             #+#    #+#              #
#    Updated: 2021/03/02 19:35:05 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk upgrade \
	&& wget http://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/grafana-7.4.3-r0.apk \
	&& apk add grafana-7.4.3-r0.apk \
	&& rm grafana-7.4.3-r0.apk

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY ./srcs/docker/grafana/srcs_grafana/init.sh /sbin/
COPY ./srcs/docker/grafana/srcs_grafana/create_datasources.sh /sbin/
RUN chmod 777 /sbin/init.sh
RUN chmod 777 /sbin/create_datasources.sh

EXPOSE 3000

ENTRYPOINT ["/sbin/init.sh"]