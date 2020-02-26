#!/bin/sh
#    If you update this from Windows, using Notepad ++, do the following:
#       sudo apt-get -y install dos2unix
#       dos2unix <FILE>
#       chmod u+x <FILE>
#
clear
echo "
    Updated Attack scripts


Version:  0.0.12     
Last Updated:  2/26/2020

This is meant for Ubuntu 16.04+

"
#---------------------------------------------------
if [ -f update_attacks.sh ]; then
    rm update_attacks.sh gen_data.sh gen_udp_floods.sh gen_legit_dns_traffic.sh attack_dns_nxdomain.py attack_dns_watertorture_wget.sh attack_phantomdomain.py attack_teardrop.py f5-dns-flood.py gen_ab.sh kill_all_attacks.sh gen_l7_attacks.sh README.md
fi

echo "
Downloading scripts... 

"
#--- files ----
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/README.md
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/update_attacks.sh
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_data.sh
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_udp_floods.sh
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_legit_dns_traffic.sh
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_dns_nxdomain.py
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_dns_watertorture_wget.sh
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_phantomdomain.py
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_teardrop.py
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/f5-dns-flood.py
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_ab.sh
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/kill_all_attacks.sh
wget https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_l7_attacks.sh


curl -o "attack_dns_watertorture_wget.sh" https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_dns_watertorture_wget.sh && chmod u+x attack_dns_watertorture_wget.sh && ./attack_dns_watertorture_wget.sh

#---------------------------------
sudo chmod u+x *.sh
sudo chmod u+x *.py

#---- add auto update to crontab ----
Cron_output=$(crontab -l | grep "update_attacks.sh")
if [ -z "$Cron_output" ]
then
    echo "Script not in crontab. Adding."
    line="10 3 * * * /home/ubuntu/update_attacks.sh >> /var/log/update_attacks.log 2>&1"
    (crontab -u root -l; echo "$line" ) | crontab -u root -

#   line="@reboot /root/update_attacks.sh >> /var/log/update_attacks.log 2>&1"
#   (crontab -u root -l; echo "$line" ) | crontab -u root -
else
      echo "Script was found in crontab. skipping addition"
fi

echo "

DONE!

"