#/bin/bash
# get i3 master from master HPStream lbym23
host="$(hostname)"
rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" lbym@192.168.2.23:/usr/local/i3 /home/lbym/hpstream_backups/in/lbym23
rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" lbym@192.168.2.23:/usr/local/i3 /home/lbym/lbym23

