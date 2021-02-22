# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: diego <diego@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/20 16:55:57 by diego             #+#    #+#              #
#    Updated: 2021/02/20 17:20:43 by diego            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.0.4-linux-amd64.tar.gz \
	&& tar xvfz influxdb2-2.0.4-linux-amd64.tar.gz

EXPOSE 8086
ENTRYPOINT sleep infinity && wait
