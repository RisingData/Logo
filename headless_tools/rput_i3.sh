#/bin/bash
echo $1
host="$(hostname)"
lbymname="lbym$1"
echo rsync $lbymname
rsync -avz --delete -e "ssh -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" /home/lbym/master_i3/ lbym@$1:/usr/local/i3/

