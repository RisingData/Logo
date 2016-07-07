#!/bin/bash
for i in $(seq $1 1 $2)
do
  if ping -c 1 192.168.2.$i &> /dev/null
  then
    echo lbym$i Up
    ssh 192.168.2.$i ls -s /usr/local/i3/hpstream_gnomerc /home/lbym/.gnomerc
  else
    echo lbym$i Down
  fi
  echo
done

