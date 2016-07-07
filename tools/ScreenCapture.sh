#/bin/bash
#MAC_ADDRESS=$(sed -e '$!d' /sys/class/net/*/address)
#MAC_ADDRESS=`echo $MAC_ADDRESS | tr -d -c ".[:alnum:]"`
#import -window root ~/Pictures/$MAC_ADDRESS.png
#rsync ~/Pictures/$MAC_ADDRESS.png lbym@192.168.2.1:/var/www/html/Desktops/

#/bin/bash
host="$(hostname)"
#import -window root ~/Pictures/$host.png
#rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/#dev/null -p22021 -o LogLevel=quiet"  ~/Pictures/$host.png lbym@192.168.2.1:/var/www/html/Desktops/ 

#/bin/bash
host="$(hostname)"
export DISPLAY=:0.0
/usr/bin/scrot ~/Pictures/$host.png


if ping -c 1 192.168.1.1 &> /dev/null
then
rsync -avz -e "ssh -p 25000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet"  ~/Pictures/$host.png lbym@192.168.2.1:/var/www/html/Desktops/
fi

if ping -c 1 i3-ssu.sonoma.edu &> /dev/null
then
rsync -avz -e "ssh -p 25000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet"  ~/Pictures/$host.png lbym@i3-ssu.sonoma.edu:/var/www/html/Desktops
fi
