#!/bin/bash

sudo /usr/local/i3/Wifi.sh > /dev/null
echo "waiting 5 seconds for Wifi..."
sleep 5

#set date and time
count=$( ping -c 1 192.168.1.1 | grep icmp |wc -l )
echo $count
if [ $count -eq 1 ]
then
     	file="/tmp/tdate"
	datei3=$(cat "$file")
	echo $datei3
	date --set="$datei3"

# drop option to ask for date and time from keyboard
#else
#        echo "current date with format mmddHHMMyy" 
#        read currentDate
#        date $currentDate
fi


