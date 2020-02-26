#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# Update: 0.0.5
#------------------------------------------------
import re
import mechanize
browser = mechanize.Browser()
#browser = mechanize.Browser(factory=mechanize.RobustFactory())
browser.set_handle_robots(False)
browser.set_handle_equiv(True)
browser.set_handle_gzip(False)
browser.set_handle_redirect(True)
browser.set_handle_referer(True)
browser.select_form(nr=0)
ua = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36'
browser.addheaders = [('User-Agent', ua), ('Accept', '*/*')]
#---------------------------------------------------------------

url = input("Enter the full url")
#------------------------------------------------------------------------------------------------------------------------------------
attackNumber = 1
with open('xss_vectors.txt') as f:
    for line in f:
        browser.open(url)
        browser["fname"] = line
        res = browser.submit()
        content = res.read()
        #  check the attack vector is printed in the response.
        if content.find(line) > 0:
            print ("Possible XXS")

        #output = open('response/'+str(attackNumber)+'.txt', 'w')
        #output.write(content)
        #output.close()
        print ("Attack #", attackNumber, ", Response: ", content)
        attackNumber += 1