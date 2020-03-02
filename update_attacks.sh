#!/bin/sh
clear
echo "
    Updated Attack scripts


Version:  0.0.17
Last Updated:  3/2/2020

This is meant for Ubuntu 16.04+

"
#---------------------------------------------------
echo "
Downloading files...

"
#--- Files ---
rm README.md && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/README.md
rm update_attacks.sh && curl -H 'Cache-Control: no-cache' -o "update_attacks.sh" https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/update_attacks.sh
rm gen_ab.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_ab.sh
rm kill_all_attacks.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/kill_all_attacks.sh
rm xss_vectors.txt && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/xss_vectors.txt
rm Tester_gen_data.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/Tester_gen_data.sh

#--- Layer 3/4 ----
rm gen_data.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_data.sh
rm gen_udp_floods.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_udp_floods.sh
rm gen_legit_dns_traffic.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_legit_dns_traffic.sh
rm attack_dns_nxdomain.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_dns_nxdomain.py
rm attack_dns_watertorture_wget.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_dns_watertorture_wget.sh
rm attack_phantomdomain.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_phantomdomain.py
rm attack_teardrop.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/attack_teardrop.py
rm f5-dns-flood.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/f5-dns-flood.py


#--- Layer 7 ---
rm port_scanner.py && curl  -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/port_scanner.py

rm gen_data_layer7.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_data_layer7.sh
rm gen_l7_attacks.sh && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_l7_attacks.sh
rm mechanize_attack1.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/mechanize_attack1.py
rm mechanize_attack2.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/mechanize_attack2.py
rm mechanize_attack3.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/mechanize_attack3.py

rm ssh-brute-force-threded.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/ssh-brute-force-threded.py
rm sqli_attack-vector.txt && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/sqli_attack-vector.txt

rm recursive_dns.txt && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/recursive_dns.txt
rm sqlmitm.py && curl -H 'Cache-Control: no-cache' -O -C - https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/sqlmitm.py

#-------------------------------------------------------------------------------------------
sudo chmod u+x *.sh
sudo chmod u+x *.py

#---- add auto update to crontab ----
Cron_output=$(crontab -l | grep "update_attacks.sh")
if [ -z "$Cron_output" ]
then
    echo "Script not in crontab. Adding."
    line="10 3 * * * /home/ubuntu/attacks/update_attacks.sh >> /var/log/update_attacks.log 2>&1"
    (crontab -u root -l; echo "$line" ) | crontab -u root -

#   line="@reboot /root/update_attacks.sh >> /var/log/update_attacks.log 2>&1"
#   (crontab -u root -l; echo "$line" ) | crontab -u root -
else
      echo "Script was found in crontab. skipping addition"
fi

echo "

DONE!

"