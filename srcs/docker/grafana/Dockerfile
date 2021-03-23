# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/28 18:36:18 by diego             #+#    #+#              #
#    Updated: 2021/03/23 13:59:23 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk upgrade \
	&& wget https://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/grafana-7.4.5-r1.apk \
	&& apk add grafana-7.4.5-r1.apk \
	&& rm grafana-7.4.5-r1.apk \
	&& apk add --no-cache procps

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY ./srcs/docker/grafana/srcs_grafana/init.sh /sbin/
COPY ./srcs/docker/grafana/srcs_grafana/create_datasources.sh /sbin/
COPY ./srcs/docker/grafana/srcs_grafana/create_dashboard.sh /sbin/
COPY ./srcs/docker/grafana/srcs_grafana/ft_services.sh /sbin/
COPY ./srcs/docker/grafana/srcs_grafana/dashboard.json /usr/share/grafana/conf/provisioning/dashboards
COPY ./srcs/docker/grafana/srcs_grafana/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards
RUN chmod +x /sbin/init.sh
RUN chmod +x /sbin/create_datasources.sh
RUN chmod +x /sbin/create_dashboard.sh
RUN chmod +x /sbin/ft_services.sh

EXPOSE 3000

ENTRYPOINT ["/sbin/init.sh"]