#!/bin/sh

export MINIKUBE_HOME=/goinfre/$(whoami)
clear
echo "\033[34m"
echo "  █████▒▄▄▄█████▓     ██████ ▓█████  ██▀███   ██▒   █▓ ██▓ ▄████▄ ▓█████   ██████ ";
echo "▓██   ▒ ▓  ██▒ ▓▒   ▒██    ▒ ▓█   ▀ ▓██ ▒ ██▒▓██░   █▒▓██▒▒██▀ ▀█ ▓█   ▀ ▒██    ▒ ";
echo "▒████ ░ ▒ ▓██░ ▒░   ░ ▓██▄   ▒███   ▓██ ░▄█ ▒ ▓██  █▒░▒██▒▒▓█    ▄▒███   ░ ▓██▄   ";
echo "░▓█▒  ░ ░ ▓██▓ ░      ▒   ██▒▒▓█  ▄ ▒██▀▀█▄    ▒██ █░░░██░▒▓▓▄ ▄██▒▓█  ▄   ▒   ██▒";
echo "░▒█░      ▒██▒ ░    ▒██████▒▒░▒████▒░██▓ ▒██▒   ▒▀█░  ░██░▒ ▓███▀ ░▒████▒▒██████▒▒";
echo " ▒ ░      ▒ ░░      ▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ▒▓ ░▒▓░   ░ ▐░  ░▓  ░ ░▒ ▒  ░░ ▒░ ░▒ ▒▓▒ ▒ ░";
echo " ░          ░       ░ ░▒  ░ ░ ░ ░  ░  ░▒ ░ ▒░   ░ ░░   ▒ ░  ░  ▒   ░ ░  ░░ ░▒  ░ ░";
echo " ░ ░      ░         ░  ░  ░     ░     ░░   ░      ░░   ▒ ░░          ░   ░  ░  ░  ";
echo "                          ░     ░  ░   ░           ░   ░  ░ ░        ░  ░      ░  ";
echo "                                                  ░       ░                       ";
echo "                                                                      \033[1;92mby dlobos-m";
echo "\033[0m"

build_metallb()
{
	echo "\nInstall and configure \033[1mmetallb\033[0m"
	while :;do printf ".";sleep 1;done &
	trap "kill $!" EXIT  
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml 1>/dev/null;
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml 1>/dev/null;
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 1>/dev/null;
	kubectl apply -f ./srcs/yaml/metallb-configmap.yaml 1>/dev/null;
	disown $! && kill $! && trap " " EXIT
	echo "\033[32;1m [DONE]\n\033[0m"
}

build_services()
{
	for arg in "$@" 
		do
		echo "Building \033[1m$arg\033[0m"
		while :;do printf ".";sleep 1;done &
		trap "kill $!" EXIT  
		if [ "$arg" = "mysql" ] || [ "$arg" = "influxdb" ] ; then kubectl apply -f ./srcs/yaml/$arg-pvc.yaml 1>/dev/null;fi;
		docker build -t image_$arg:lastest -f ./srcs/docker/$arg/Dockerfile . 1>/dev/null
		kubectl apply -f ./srcs/yaml/$arg.yaml 1>/dev/null
		sleep 10;
		disown $! && kill $! && trap " " EXIT
		echo "\033[32;1m [DONE]\n\033[0m"
	done
}
minikube start --driver='virtualbox' --addons dashboard
build_metallb
eval $(minikube docker-env)
build_services mysql wordpress phpmyadmin influxdb grafana nginx ftps
eval $(minikube docker-env --unset)
