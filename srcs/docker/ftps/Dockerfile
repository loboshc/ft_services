# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: diego <diego@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/11 14:45:57 by diego             #+#    #+#              #
#    Updated: 2021/03/11 19:11:14 by diego            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

ENV PASS_ADMIN = SuperAdmin123!

RUN apk update && apk upgrade \
	&& apk add vsftpd \
	&& apk add openrc \
	&& apk add openssl
	
RUN rc-status -a \
 	&& touch /run/openrc/softlevel
RUN adduser --disabled-password --gecos "" admin \
	&& mkdir /home/admin/ftp \
	&& chown nobody:nogroup /home/admin/ftp \
	&& chmod a-w /home/admin/ftp \
	&& mkdir /home/admin/ftp/files \
	&& chown admin:admin /home/admin/ftp/files

COPY ./srcs/docker/ftps/srcs_ftps/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./srcs/docker/ftps/srcs_ftps/init.sh /sbin/
RUN chmod +x /sbin/init.sh
EXPOSE 20 21

ENTRYPOINT sleep infinity && wait