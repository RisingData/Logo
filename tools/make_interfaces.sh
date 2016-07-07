#!/bin/bash
echo auto lo >/tmp/interfaces
echo iface lo inet loopback >>/tmp/interfaces

echo auto wlan0 >>/tmp/interfaces
echo iface wlan0 inet static >>/tmp/interfaces
echo address 192.168.1.23 >>/tmp/interfaces
echo network 192.168.1.0 >>/tmp/interfaces
echo netmask 255.255.255.0 >>/tmp/interfaces
echo broadcast 192.168.1.255 >>/tmp/interfaces
echo gateway   192.168.1.1 >>/tmp/interfaces
echo wireless-essid i3 >>/tmp/interfaces
echo wireless-mode Managed >>/tmp/interfaces

