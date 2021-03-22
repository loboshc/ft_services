# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/11 14:45:57 by diego             #+#    #+#              #
#    Updated: 2021/03/21 13:17:11 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

ENV PASS_ADMIN SuperFT_service123!

RUN apk update && apk upgrade \
	&& apk add vsftpd \
	&& apk add openrc \
	&& apk add openssl \
	&& apk add --no-cache procps
	
RUN rc-status -a \
 	&& touch /run/openrc/softlevel
#creo el usuario admin para el ftps y configuro la carpeta
RUN adduser --disabled-password --gecos "" admin \
	&& mkdir /home/admin/ftp \
	&& chown nobody:nogroup /home/admin/ftp \
	&& chmod a-w /home/admin/ftp \
	&& mkdir /home/admin/ftp/files \
	&& chown admin:admin /home/admin/ftp/files
#intall grafana 
RUN cd sbin/ \
	&& wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.3_linux_i386.tar.gz \
	&& tar xf telegraf-1.17.3_linux_i386.tar.gz \
	&& rm telegraf-1.17.3_linux_i386.tar.gz \
	&& mv telegraf-1.17.3 telegraf

COPY ./srcs/docker/ftps/srcs_ftps/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./srcs/docker/ftps/srcs_ftps/init.sh /sbin/
COPY ./srcs/docker/ftps/srcs_ftps/ft_services.sh /sbin/
RUN chmod +x /sbin/init.sh
RUN chmod +x /sbin/ft_services.sh
EXPOSE 20 21 10000-10005

ENTRYPOINT ["/sbin/init.sh"]