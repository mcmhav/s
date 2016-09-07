# -*- coding: utf-8 -*-
import urllib
import json

print "test"
jurl = "http://freegeoip.net/json/"
print jurl

location = json.load(urllib.urlopen(jurl))

region = urllib.quote(location['region_name'])
country = urllib.quote(location['country_name'])
city = urllib.quote(location['city'])

if location['region_name'] == "Sor-Trondelag":
    region = urllib.quote("Sør-Trøndelag")


urllib.urlretrieve('http://www.yr.no/place/' + country + '/' + region + '/' + city + '/' + city + '/avansert_meteogram.png', '~/.scripts/images/v.png')
