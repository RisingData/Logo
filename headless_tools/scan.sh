#!/bin/bash
for i in $(seq $1 1 $2)
do
  if ping -c 1 192.168.2.$i &> /dev/null
  then
    ssh 192.168.2.$1 '[ -f ~/.isolate ] && exit 1 || exit 0' 
    if [ $? == 1 ] 
    then
	echo "lbym$1 isolated"
	exit 1
    fi
    echo lbym$i Up
    if [ $i == 23 ]
    then
      echo Not pushing master_i3 to lbym23 the real master
    else
      echo Pushing Master I3 Folder to lbym$i
      /home/lbym/master_i3/headless_tools/put_i3.sh $i
    fi
    echo Backing up /home/lbym on lbym$i
    /home/lbym/master_i3/headless_tools/get_lbym.sh $i
    echo Pushing Student Folder to lbym$i
    /home/lbym/master_i3/headless_tools/put_Student.sh $i
    echo Pushing Teacher Folder to lbym$i
    /home/lbym/master_i3/headless_tools/put_Teacher.sh $i
    ssh 192.168.2.$i "/usr/local/i3/i3-update.sh"

    ssh 192.168.2.$i rm -f Backup_*
    DATE=`date +%Y-%m-%d:%H:%M:%S`
    ssh 192.168.2.$i touch /home/lbym/Backup_$DATE
  else
    echo lbym$i Down
  fi
  echo
done

