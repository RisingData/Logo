#/bin/bash
host="$(hostname)"
for ((;;))
do
  /usr/bin/scrot ~/Pictures/$host.png
  rsync -avz -e "ssh -p 25000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet"  ~/Pictures/$host.png lbym@192.168.2.1:/var/www/html/Desktops/ 
  sleep 20
done

