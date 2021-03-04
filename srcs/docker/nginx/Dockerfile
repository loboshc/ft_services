FROM alpine:latest

RUN apk update && \
	&& apk add nginx && mkdir -p /run/nginx \
	&& apk add openrc --no-cache

RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY srcs/docker/nginx/srcs_nginx/init.sh /sbin/
RUN chmod 777 /sbin/init.sh
EXPOSE 80 443

ENTRYPOINT sleep infinity && wait