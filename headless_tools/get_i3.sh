#/bin/bash
# get i3 master
host="$(hostname)"
rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" lbym@192.168.2.$1:/usr/local/i3 /home/lbym/lbym$1

