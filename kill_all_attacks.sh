#!/bin/sh
# Christopher Gray
#  Version 0.0.7
#  3/2/2020

echo "Killing all attack threads..."

echo "HPing3... "
wait
sleep 2
killall -9 hping3
wait
sleep 2
killall -9 hping

wait
sleep 1
echo "NPing... "
killall -9 nping
wait
sleep 1

echo "Apache Bench (AB)... "
killall -9 ab
wait
sleep 1

echo "Various DNS Attacks..."
killall -9 attack_dns_nxdomain.py
killall -9 attack_phantomdomain.py
killall -9 mz
killall -9 f5-dns-flood.py
killall -9 attack_teardrop.py
killall -9 attack_dns_watertorture_wget.sh
killall -9 gen_udp_floods.sh
wait
sleep 2


echo "DNS Pref.."
killall -9 dnsperf


echo "

Done!


Run the following to confirm:

htop
speedometer -l -r eth0 -t eth0 -m $(( 1024 * 1024 * 3 / 2 ))

"