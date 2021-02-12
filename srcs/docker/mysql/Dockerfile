# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dlobos-m <dlobos-m@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/02 15:02:51 by dlobos-m          #+#    #+#              #
#    Updated: 2021/02/10 19:36:04 by dlobos-m         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


FROM alpine:3.12

RUN apk add mariadb mariadb-client mariadb-common
RUN mkdir -p /run/mysqld

COPY srcs/docker/mysql/srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
COPY srcs/docker/mysql/srcs/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY srcs/docker/mysql/srcs/mariadb-create.sql /tmp/

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]