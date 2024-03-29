# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/01 16:22:31 by dlobos-m          #+#    #+#              #
#    Updated: 2021/04/01 16:22:40 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update \
	&& apk add nginx && mkdir -p /run/nginx \
	&& apk add openrc --no-cache \
	&& apk add --no-cache git make musl-dev go \
	&& apk add --no-cache procps

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

RUN cd /tmp && wget https://github.com/FiloSottile/mkcert/archive/v1.0.0.tar.gz && tar xzvf /tmp/v1.0.0.tar.gz \
	&& cd /tmp/mkcert-1.0.0 && make \
	&& cd /tmp/mkcert-1.0.0/bin && chmod +x mkcert \
	&& cd /tmp/mkcert-1.0.0/bin && cp mkcert /usr/bin/ \
	&& cd /tmp/ && mkcert -install && mkcert localhost

RUN mkdir -p /var/lib/nginx/www/hmtl
COPY srcs/docker/nginx/srcs_nginx/html /var/lib/nginx/www/html
COPY srcs/docker/nginx/srcs_nginx/default.conf /etc/nginx/conf.d/default.conf
COPY srcs/docker/nginx/srcs_nginx/init.sh /sbin/
COPY srcs/docker/nginx/srcs_nginx/ft_services.sh /sbin/
RUN chmod +x /sbin/init.sh
RUN chmod +x /sbin/ft_services.sh

EXPOSE 80 443

ENTRYPOINT ["/sbin/init.sh"]