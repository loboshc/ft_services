#!/bin/sh

minikube start --driver='virtualbox'

#install and configure metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/yaml/metallb-configmap.yaml

#conect to docker on minikube
eval $(minikube docker-env)

kubectl apply -f ./srcs/yaml/mysql-pvc.yaml
docker build -t image_mysql:lastest -f ./srcs/docker/mysql/Dockerfile .
kubectl apply -f ./srcs/yaml/mysql.yaml
docker build -t image_wordpress:lastest -f ./srcs/docker/wordpress/Dockerfile .
kubectl apply -f ./srcs/yaml/wordpress.yaml
docker build -t image_phpmyadmin:lastest -f ./srcs/docker/phpmyadmin/Dockerfile .
kubectl apply -f ./srcs/yaml/phpmyadmin.yaml
kubectl apply -f ./srcs/yaml/influxdb-pvc.yaml
docker build -t image_influxdb:lastest -f ./srcs/docker/influxdb/Dockerfile .
kubectl apply -f ./srcs/yaml/influxdb.yaml
docker build -t image_telegraf:lastest -f ./srcs/docker/telegraf/Dockerfile .
kubectl apply -f ./srcs/yaml/telegraf.yaml


eval $(minikube docker-env --unset)
