#!/bin/bash

port=""
health=""

if [ $# -gt 0 ]; then
	if [ $# -eq 2 ]; then
		port=$(echo "$1" | cut -d '=' -f 2)
		health=$2
	elif [ $# -eq 1 ] && [[ $1 == --port* ]]; then
		port=$(echo "$1" | cut -d '=' -f 2)
	else
		health=$1
	fi
fi

sudo docker build -t app .

if [[ -n "$port" ]]; then
	if [[ -n "$health" ]]; then
		sudo docker run --name app -d -p $port:$port -e BIND_ADDRESS=$port app
                sleep 7
                response_headers=$(curl -s -I http://localhost:$port/health)
                if echo "$response_headers" | grep -q "HTTP/1.1 200"; then
                        echo "Container is running"
                else
                        echo "Container is not running"
                fi
	else 
		sudo docker run  --name app -d -p $port:$port -e BIND_ADDRESS=$port app
		sleep 7
	fi
elif [[ -n "$health" ]]; then 
	sudo docker run --name app -d -p 8080:8080 app
	sleep 7
        response_headers=$(curl -s -I http://localhost:$port/health)
        if echo "$response_headers" | grep -q "HTTP/1.1 200"; then
                echo "Container is running"
        else
                echo "Container is not running"
        fi
else
	sudo docker run --name app -d -p 8080:8080 app
	sleep 7
fi
sudo docker stop app
