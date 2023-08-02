#!/bin/bash


tar -xf logs.tar.bz2
if [ $? -ne 0 ]; then
	echo "BZIP2 not installed, installing it"
	sudo apt-get install bzip2
	tar -xf logs.tar.bz2
fi

log_file="file.txt"

if [[ -n "$1" ]]; then
	if [[ "$1" == "--method" ]]; then
	  awk '{ match($0, /client_ip: "([^"]+)/, ip); match($0, /method: "([^"]+)/, method);
	       if (ip[1] && method[1]) ips[ip[1], method[1]]++ }
    		 END { printf "%-20s %-10s %s\n", "ADDRESS", "METHOD", "REQUESTS";
       		    for (i in ips) { split(i, a, SUBSEP);
              	printf "%-20s %-10s %d\n", a[1], a[2], ips[i] } }' "$log_file"
		sudo rm -rf logs
		exit 0
	else
	  echo "Provided parameter is incorrect"
	fi
	exit 255
fi

awk '{ match($0, /client_ip: "([^"]+)/, ip); if (ip[1]) ips[ip[1]]++ }
     END { for (i in ips) printf "%-20s %d\n", i, ips[i] }' "$log_file" |
sort -k2,2nr -k1,1 |
awk 'BEGIN { printf "%-20s %s\n", "ADDRESS", "REQUESTS" } { print }'
sudo rm -rf logs
exit 0
