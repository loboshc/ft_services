FROM alpine:3.12

RUN apk update \
	&& apk add nginx && mkdir -p /run/nginx \
	&& apk add openrc --no-cache \
	&& apk add --no-cache git make musl-dev go

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

COPY srcs/docker/nginx/srcs_nginx/default.conf /etc/nginx/conf.d/default.conf
COPY srcs/docker/nginx/srcs_nginx/init.sh /sbin/
RUN chmod 777 /sbin/init.sh
EXPOSE 80 443

ENTRYPOINT sleep infinity && wait