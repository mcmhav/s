#!/bin/bash -x

#TEMP=`sensors | grep -m 1 C | awk -F + ‘{print $2}’ | awk -F \( ‘{print $1}’`
#CAPACITY=`cat /proc/acpi/battery/BAT1/info | grep “last full capacity” | cut -d” ” -f9`
#CURRENT=`cat /proc/acpi/battery/BAT1/state | grep “remaining” | cut -d” ” -f8`
#PERCENT=`gawk -v CONVFMT=”%12.2f” -v OFMT=”%.5g”  “BEGIN { print $CURRENT / $CAPACITY * 100; }”`
#STATUS=`cat /proc/acpi/battery/BAT1/state | grep “charging state” | cut -d” ” -f12`
#WIFI=`iwconfig wlan0 | grep SSID | cut -d”\”" -f2`
#GetWEATHER=`wget ‘http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=AFR|ZA|SF004|PRETORIA’ -O ~/weather.txt`
#GetIMAGE=`grep -A2 Currently ~/weather.txt | grep gif | cut -d”\”" -f2`
#IMAGE=`wget $GetIMAGE -O ~/a.gif`
#WEATHER=`grep Currently: ~/weather.txt | cut -d”<” -f2 | cut -d”>” -f2`
#OUTPUT=`echo -e  ‘~~~~~~~~~~~~’ ‘\n’ LOCAL WEATHER ‘\n’ $WEATHER ‘\n’ ‘~~~~~~~~~~~~’ ‘\n’ LOCAL SYSTEM ‘\n’ BATTERY $STATUS $PERCENT% ‘\n’ CPU TEMPERATURE $TEMP ‘\n’ Wireless Access Point: $WIFI ‘~~~~~~~~~~~~’`
notify-send –urgency=critical -i ~/Pictures/yr/v.png ‘INFORMATION’ “a”