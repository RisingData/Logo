#!/bin/bash
if [ -f /etc/modprobe.d/wifi.conf ]
then
   echo "wifi driver installed"
else
   echo "install wifi driver - reboot required"
   sudo cp /usr/local/i3/tools/wifi.conf /etc/modprobe.d/wifi.conf
   exit 1
fi



if ping -c 1 192.168.1.1 &> /dev/null
then
  echo "connection verified"
else

  echo "restarting wireless"
  sudo ifdown wlan0 && ifup --force -v  wlan0
fi

