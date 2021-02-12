#!/bin/sh

minikube start --driver='virtualbox'

#install and configure metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"


#conect to docker on minikube
eval $(minikube docker-env)

docker build -t image_mysql:lastest -f ./srcs/docker/mysql/Dockerfile .
docker build -t image_wordpress:lastest -f ./srcs/docker/wordpress/Dockerfile .



eval $(minikube docker-env --unset)
kubectl apply -f ./srcs/yaml/