FROM alpine:3.12

RUN apk update \
	&& apk add wget \
	&& apk add mysql-client \
	&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session php-common \
	php-cli php-mbstring php-bz2 php-phar \
	&& wget -P /tmp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /tmp/wp-cli.phar && mv /tmp/wp-cli.phar /usr/sbin/wp 
  
RUN mkdir -p /usr/share/webapps/ \
	&& cd /usr/share/webapps/ \
	&& wget http://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& rm latest.tar.gz

COPY srcs/docker/wordpress/srcs_wordpress/setup_wordpress.sh /tmp/
RUN chmod 777 /tmp/setup_wordpress.sh

EXPOSE 5050	

ENTRYPOINT ["/tmp/setup_wordpress.sh"]