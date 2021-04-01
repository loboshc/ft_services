#!/bin/sh

export MINIKUBE_HOME=/goinfre/$(whoami)
clear
minikube status 1>/dev/null
MINIKUBE_STATUS=$?
if [ "$1" = "rebuild" ]; then
	if [ "$2" != "mysql" ] && [ "$2" != "wordpress" ] && [ "$2" != "phpmyadmin" ] && [ "$2" != "influxdb" ] && [ "$2" != "grafana" ] && [ "$2" != "nginx" ] && [ "$2" != "ftps" ]; then 
		echo "\033[1;91mService not found\033[0m"
		exit 1
	elif [ $MINIKUBE_STATUS == 85 ] ; then
		echo "\033[1;91mMinikube is not running\033[0m"
		exit 1
	else
		kubectl delete -f srcs/yaml/$2.yaml
		eval $(minikube docker-env)
		docker build -t image_$2:lastest -f ./srcs/docker/$2/Dockerfile .
		kubectl apply -f srcs/yaml/$2.yaml
		eval $(minikube docker-env --unset)
		exit 1
	fi
fi
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
		while :;do printf ".";sleep 2;done &
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
printf "\n\033[1;32m[ALL SERVICES DEPLOYED]\033[0m\n"
printf "\nOpen \033[1mNginx\033[0m: \033[96mhttps://192.168.99.240:443\033[0m"
printf "\nOpen \033[1mGrafana\033[0m: \033[96mhttps://192.168.99.240:3000\033[0m"
printf "\nOpen \033[1mPhpmyadmin\033[0m: \033[96mhttps://192.168.99.240:5000\033[0m"
printf "\nOpen \033[1mWordpress\033[0m: \033[96mhttps://192.168.99.240:5050\n\033[0m"

minikube dashboard 1>/dev/null
DASHBOARD_STATUS=$?
while [ $DASHBOARD_STATUS == 119 ]
do 
	minikube dashboard 1>/dev/null
	DASHBOARD_STATUS=$?
done