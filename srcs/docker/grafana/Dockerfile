# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/28 18:36:18 by diego             #+#    #+#              #
#    Updated: 2021/03/01 20:39:26 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk upgrade \
	&& wget http://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/grafana-7.4.3-r0.apk \
	&& apk add grafana-7.4.3-r0.apk \
	&& rm grafana-7.4.3-r0.apk
COPY ./srcs/docker/grafana/srcs_grafana/init.sh /sbin/
RUN chmod 777 /sbin/init.sh

EXPOSE 3000

ENTRYPOINT ["/sbin/init.sh"]