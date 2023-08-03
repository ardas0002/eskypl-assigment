#!/bin/bash

log_file=./logs/logs.log
user_agent=""

tar -xf logs.tar.bz2

if [ $# -gt 0 ]; then
        if [ $# -eq 2 ] && [[ $1 == --method ]] && [[ $2 == --user-agent* ]]; then
                user_agent=$(echo "$2" | cut -d '=' -f 2)
                ip_method_counts=$(cat $log_file | grep "$user_agent" | awk '{
                        match($0, /client_ip: "([^"]+)/, ip);
                        match($0, /method: "([^"]+)/, method);
                        if (ip[1] && method[1]) ips[ip[1] "\t" method[1]]++;
                     } END {
                        printf "%-20s %-10s %s\n", "ADDRESS", "METHOD", "REQUESTS";
                        for (i in ips) {
                             split(i, a, "\t");
                             printf "%-20s %-10s %d\n", a[1], a[2], ips[i];
                        }
                     }')
            echo "$ip_method_counts"
          elif [ $# -eq 1 ] && [[ $1 == --method ]]; then
                ip_method_counts=$(awk '{
                    match($0, /client_ip: "([^"]+)/, ip);
                    match($0, /method: "([^"]+)/, method);
                    if (ip[1] && method[1]) ips[ip[1] "\t" method[1]]++;
                } END {
                   printf "%-20s %-10s %s\n", "ADDRESS", "METHOD", "REQUESTS";
                   for (i in ips) {
                         split(i, a, "\t");
                         printf "%-20s %-10s %d\n", a[1], a[2], ips[i];
                   }
                }' "$log_file")
           echo "$ip_method_counts"
         elif [ $# -eq 1 ] && [[ $1 == --user-agent* ]]; then
               user_agent=$(echo "$1" | cut -d '=' -f 2)
               ip_method_counts=$(cat $log_file | grep "$user_agent" | awk '{
                   match($0, /client_ip: "([^"]+)/, ip);
                   if (ip[1]) ips[ip[1]]++;
               } END {
                  printf "%-20s %s\n", "ADDRESS", "REQUESTS";
                  for (i in ips) {
                        printf "%-20s %d\n", i, ips[i];
                   }}')
           echo "$ip_method_counts"
        fi
else
        ip_method_counts=$(cat $log_file | awk '{
                   match($0, /client_ip: "([^"]+)/, ip);
                   if (ip[1]) ips[ip[1]]++;
               } END {
                  printf "%-20s %s\n", "ADDRESS", "REQUESTS";
                  for (i in ips) {
                        printf "%-20s %d\n", i, ips[i];
                   }}')
        echo "$ip_method_counts"
fi

sudo rm -rf logs
