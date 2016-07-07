#/bin/bash
time=$(date +%Y%m%d%H%M)
mkdir desktops &> /dev/null
chmod 777 ./desktops
cp /home/lbym/Pictures/$(hostname).png ./desktops/$(hostname)_$time.png

