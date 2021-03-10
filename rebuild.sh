#!/bin/sh
if [ $1 != "" ]
then
	kubectl delete -f srcs/yaml/$1.yaml
	eval $(minikube docker-env)
	docker build -t image_$1:lastest -f ./srcs/docker/$1/Dockerfile .
	eval $(minikube docker-env --unset)
	kubectl apply -f srcs/yaml/$1.yaml
fi
