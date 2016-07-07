#/bin/bash
host="$(hostname)"
rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p22021 -o LogLevel=quiet"   /home/user lbym@192.168.2.1:/home/lbym 

