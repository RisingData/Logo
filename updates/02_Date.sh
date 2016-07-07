#!/bin/bash
if ping -c 1 192.168.2.1 &> /dev/null
then
	echo "Synchronizing Date and Time With Server"
	date=$(ssh 192.168.2.1 -p 25000 date)
	sudo date -s "$date"
else
	echo "Failed To Reach Server"
	exit 1
fi
exit 0
