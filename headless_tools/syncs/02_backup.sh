#/bin/bash
lbymname=lbym$(echo $1 | cut -d . -f 4)
#DATE=`date +%Y-%m-%d:%H:%M:%S`

echo "backing up files"
#move files from stream to headless
rsync -avz --update --delete \
--exclude-from="/home/lbym/master_i3/headless_tools/backup_excludes" \
--include-from="/home/lbym/master_i3/headless_tools/backup_includes" \
-e "ssh -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" \
$1:/home/lbym /home/lbym/hpstream_backups/in/$lbymname/ |  grep -E '^deleting|[^/]$'

