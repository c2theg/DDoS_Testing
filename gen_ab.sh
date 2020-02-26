
#!/bin/sh
# Christopher Gray
# Version 0.2.3
#  2-26-2020

if [ -z "$1" ]; then
      echo "No dest defined to attack! please define one before continuing \r\n"
      exit
else
      server_ip=$1
      echo "Server is set to $server_ip \r\n"
fi

#---- apache bench attack ----
echo "Starting a Apache bench strest test... \r\n"

#ab -t 60 -n 10000000 http://$server_ip
#cat load_urls.txt | parallel "ab -n 10000 -c 10 {}"

#while true
#do
    #ab -r -c 1000 -n 1000000 $server_ip  &>/dev/null &
#    ab -n 1000 -c 10 -k -H "Accept-Encoding: gzip, deflate" $server_ip
#done


# https://www.petefreitag.com/item/689.cfm

# ab -n 100 -c 10 http://$server_ip
# ab -n 1 -v 2 http://$server_ip
ab -l -r -n 80 -c 100 -k -H "Accept-Encoding: gzip, deflate"  http://$server_ip

"""
Usage: ab [options] [http[s]://]hostname[:port]/path
Options are:
    -n requests     Number of requests to perform
    -c concurrency  Number of multiple requests to make
    -t timelimit    Seconds to max. wait for responses
    -b windowsize   Size of TCP send/receive buffer, in bytes
    -p postfile     File containing data to POST. Remember also to set -T
    -T content-type Content-type header for POSTing, eg.
        'application/x-www-form-urlencoded'
        Default is 'text/plain'
    -v verbosity    How much troubleshooting info to print
    -w              Print out results in HTML tables
    -i              Use HEAD instead of GET
    -x attributes   String to insert as table attributes
    -y attributes   String to insert as tr attributes
    -z attributes   String to insert as td or th attributes
    -C attribute    Add cookie, eg. 'Apache=1234. (repeatable)
    -H attribute    Add Arbitrary header line, eg. 'Accept-Encoding: gzip'
        Inserted after all normal header lines. (repeatable)
    -A attribute    Add Basic WWW Authentication, the attributes
        are a colon separated username and password.
    -P attribute    Add Basic Proxy Authentication, the attributes
        are a colon separated username and password.
    -X proxy:port   Proxyserver and port number to use
    -V              Print version number and exit
    -k              Use HTTP KeepAlive feature
    -d              Do not show percentiles served table.
    -S              Do not show confidence estimators and warnings.
    -g filename     Output collected data to gnuplot format file.
    -e filename     Output CSV file with percentages served
    -r              Don't exit on socket receive errors.
    -h              Display usage information (this message)
    -Z ciphersuite  Specify SSL/TLS cipher suite (See openssl ciphers)
    -f protocol     Specify SSL/TLS protocol (SSL2, SSL3, TLS1, or ALL)
"""