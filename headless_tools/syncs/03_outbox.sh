#/bin/bash
lbymname=lbym$(echo $1 | cut -d . -f 4)

echo "moving copy to outbox"
#push files into out folder
rsync -avz --update /home/lbym/hpstream_backups/in/$lbymname/ \
/home/lbym/hpstream_backups/out/$lbymname/ |  grep -E '^deleting|[^/]$'


