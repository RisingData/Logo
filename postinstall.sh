# /bin/bash

#set computer number in /etc/hostname
echo "enter sticker number"
read stickerNumber
echo "lbym$stickerNumber" > /etc/hostname

#generate hosts file
echo "localhost 127.0.0.1" > /etc/hosts
echo "lbym lbym.sonoma.edu" >> /etc/hosts

for i in $(seq 1 1 255)
do
		echo "lbym$i 192.168.1.$i" >> /etc/hosts
done

# generate static interfaces filei

#echo auto lo >/tmp/interfaces
#echo iface lo inet loopback >>/tmp/interfaces

#echo auto wlan0 >>/tmp/interfaces
#echo iface wlan0 inet static >>/tmp/interfaces
#echo address 192.168.1.$stickerNumber >>/tmp/interfaces
#echo network 192.168.1.0 >>/tmp/interfaces
#echo netmask 255.255.255.0 >>/tmp/interfaces
#echo broadcast 192.168.1.255 >>/tmp/interfaces
#echo gateway   192.168.1.1 >>/tmp/interfaces
#echo wireless-essid i3 >>/tmp/interfaces
#echo wireless-mode Managed >>/tmp/interfaces
#mv /tmp/interfaces /etc/network/interfaces

