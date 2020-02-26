#!/usr/bin/env python
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

def formFuzzer(url, size=50):
    buffer=["\x00"]
    counter = 100

    while len(buffer ) <= size:
        buffer.append("\x00"*counter)
        counter=counter+200

    for evil in buffer:
        print "Attempting attack with: " + evil
        try:
            browser.open(url)
            browser.select_form(nr=0)
            browser.form['search'] = evil
            browser.submit()
            for line in browser.response():
                print line
        except:
            pass


#formFuzzer("https://127.0.0.1/someform",10)
formFuzzer(url,10)
