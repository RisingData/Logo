#!/bin/bash

for (( ;; ))
do

i=0
while read line
do
    number=$(echo $line | tr -dc '0-9')        
    array[ $i ]="$number"
    (( i++ ))
done < <(ls /home/lbym/hpstream_backups/in/)

for lbym in  "${array[@]}"
do
if ping -c 1 192.168.2.$lbym &> /dev/null
then
	echo $lbym up
	scp /home/lbym/master_i3/hpstream_gnomerc 192.168.2.$lbym:/usr/local/i3/hpstream_gnomerc
	ssh 192.168.2.$lbym "ln -sf /usr/local/i3/hpstream_gnomerc /home/lbym/.gnomerc"
	ssh 192.168.2.$lbym "source /home/lbym/.gnomerc" 2> /dev/null 
	sleep 30
else 
	echo $lbym down
fi
done

sleep 30
done

 
