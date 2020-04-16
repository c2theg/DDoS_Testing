#!/bin/sh

# Source: 
#     https://hackertarget.com/7-nmap-nse-scripts-recon/
#
#
# Path: /usr/share/nmap/scripts/
#
#
#----------------------------------------------------------------------

#  DNS Brute Force
nmap -p 80 --script dns-brute.nse vulnweb.com

# Find Hosts on IP
sudo nmap -p 80 --script hostmap-bfk.nse nmap.org

# Traceroute Geolocation
sudo nmap --traceroute --script traceroute-geolocation.nse -p 80 10.144.188.139

# http-enum.nse
nmap --script http-enum 192.168.10.55

# HTTP Title
nmap --script http-title -sV -p 80 192.168.1.0/24


