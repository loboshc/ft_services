#!/bin/sh

service_verifi()
{
	if ps -e | grep -q $1 ; then
		#service  is working"
		return 1
	else
		#service is not working"
		return 0
	fi
}


while true; do
i=1
sleep 3
	for arg in "$@" 
		do 
		if service_verifi $arg -eq 0 ;then
			printf "$arg is not working\nExiting...\n"
			exit 1
		fi
		i=`expr $i + 1` 
	done
done

