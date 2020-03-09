#!/bin/sh
#
echo "This will throttle your network interface. Use this in an AWS environment.. \r\n "

echo "URL: https://netbeez.net/blog/how-to-use-the-linux-traffic-control/"

echo "Bandwidth Limit to 1mbps... \r\n "
tc qdisc add dev eth0 root tbf rate 10mbit burst 32kbit latency 400ms

echo "DONE!"

#echo "Network Delay: tc qdisc add dev eth0 root netem delay 200ms"
#tc qdisc add dev eth0 root netem delay 200ms

echo "Testing... \r\n "
iperf -c 172.31.0.142