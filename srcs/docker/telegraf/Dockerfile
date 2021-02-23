# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/23 16:20:59 by dlobos-m          #+#    #+#              #
#    Updated: 2021/02/23 17:02:16 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	cd /sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_amd64.tar.gz \
	&& tar xvfz telegraf-1.17.3_linux_amd64.tar.gz \
	&& rm telegraf-1.17.3_linux_amd64.tar.gz \
	&& mv telegraf-1.17.3 telegraf

ENTRYPOINT sleep infinity && wait
