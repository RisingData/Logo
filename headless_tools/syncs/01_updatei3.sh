#!/bin/bash
#check to make sure the master is not being updated
if [ $1 == 192.168.2.23 ]
then
	echo "This script will not update the master copy, please update manually."
	exit
fi

echo "pushing Master i3 Folder to $1"
rsync -avz --delete \
-e "ssh -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" \
--exclude '/home/lbym/master_i3/updates/oldscripts' --exclude '/home/lbym/master_i3/headless_tools/syncs/oldscripts' \
/home/lbym/master_i3/ $1:/usr/local/i3/ | grep -E '^deleting|[^/]$'

