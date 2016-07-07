#/bin/bash
#needed parameters
host="$(hostname)"
lbymname="lbym$1"
DATE=`date +%Y-%m-%d:%H:%M:%S`

#move files from stream to headless
rsync -avz --delete \
--exclude-from="/home/lbym/master_i3/headless_tools/backup_excludes" \
--include-from="/home/lbym/master_i3/headless_tools/backup_includes" \
-e "ssh -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" \
lbym@192.168.2.$1:/home/lbym /home/lbym/hpstream_backups/in/$lbymname/

#push files into out folder
rsync -avz /home/lbym/hpstream_backups/in/$lbymname/ \
/home/lbym/hpstream_backups/out/$lbymname/

#make entry to log file
echo $DATE $lbymname >> backup.log

