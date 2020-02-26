#!/bin/sh
# Christopher Gray
# Version 0.1
#  2/26/2020

if [ -z "$1" ]; then
      echo "No dest defined to attack! please define one before continuing \r\n"
      exit
else
      server_ip=$1
      echo "Server is set to $server_ip \r\n"
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


                    LAYER 7 (Application)

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
#sudo ./gen_legit_dns_traffic.sh $server_ip $queries_ps &>/dev/null &

echo "Running UDP Floods... \r\n "
#sudo ./gen_udp_floods.sh $server_ip  &>/dev/null &
#-----------------------------------------------------------------------------------------------------------------

