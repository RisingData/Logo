#!/bin/bash

start=$1
stop=$2

ssh_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet -o ConnectTimeout=10 -o BatchMode=yes"

#master_dir=/home/lbym/ASU/asu_i3/
master_dir=/home/lbym/master_i3/

#
# check to see whether the first argument is an address or a number
#   if address, we're remote, otherwise local
#
nodots=${start//./}
if [ ${#nodots} -eq ${#start} ]
then
    # prior standard script usage, argument 1 is a number
    ip=192.168.2
    local=1
else
    ip=$start
    port=$stop
    [ "$port" ] || port=25000
    start=
    stop=
    local=0
fi
[ "$port" ] || port=22

#
# now do the usual work
#

for i in $(seq $start 1 $stop)
do

  # make sure the remote machine is up
  cping=1
  if [ $local -eq 1 ]
  then
     ip1=${ip}.${i}
     ping -w 1 -c 1 $ip1 &> /dev/null
     cping=$?
     rhost=lbym$i
  else
     ip1=$ip
     rhost=$(ssh -p $port $ssh_args lbym@${ip1} hostname 2>/dev/null)
     if [ "$rhost" ]
     then
         i=${rhost//lbym/}
         cping=0
     else
         port=22
         rhost=$(ssh -p $port $ssh_args lbym@${ip1} hostname 2>/dev/null)
         if [ "$rhost" ]
         then
             i=${rhost//lbym/}
             cping=0
         fi
     fi
  fi

  if [ $cping ]
  then
    echo $rhost Up
    if [ $i == 23 ]
    then
      echo Not pushing master_i3 to lbym23 the real master
    else
      echo Pushing Master I3 Folder to $rhost
      /home/lbym/master_i3/headless_tools/rput_i3.sh $i
      rsync -avz --delete -e "ssh -p $port $ssh_args" $master_dir \
          lbym@${ip1}:/usr/local/i3/

    fi

    echo Backing up /home/lbym on $rhost
    # /home/lbym/master_i3/headless_tools/rget_lbym.sh $i
    #move files from stream to headless
    rsync -avz --delete \
        --exclude-from="/home/lbym/master_i3/headless_tools/backup_excludes" \
        --include-from="/home/lbym/master_i3/headless_tools/backup_includes" \
        -e "ssh -p $port $ssh_args" \
        lbym@${ip1}:/home/lbym /home/lbym/hpstream_backups/in/$rhost/
    #push files into out folder
    rsync -avz /home/lbym/hpstream_backups/in/$rhost/ \
        /home/lbym/hpstream_backups/out/$rhost/

    echo Pushing Student Folder to $rhost
    /home/lbym/master_i3/headless_tools/rput_Student.sh $i
    rsync -arvz --delete -e "ssh -p $port $ssh_args" \
        /home/lbym/Student/ lbym@$1:/home/lbym/+Student/


    echo Pushing Teacher Folder to $rhost
    /home/lbym/master_i3/headless_tools/rput_Teacher.sh $i
    if (ssh -p $port $ssh_args lbym@$ip1 '[ -d /home/lbym/+Teacher ]')
    then
        rsync -arvz --delete -e "ssh -p $port $ssh_args" /home/lbym/Teacher/ \
            lbym@${ip1}:/home/lbym/+Teacher
    fi

    # finish up and book-keeping
    ssh -p $port $ssh_args lbym@${ip1} "/usr/local/i3/i3-update.sh"
    ssh -p $port $ssh_args lbym@${ip1} rm -f Backup_*
    DATE=`date +%Y-%m-%d:%H:%M:%S`
    ssh -p $port $ssh_args lbym@${ip1} touch /home/lbym/Backup_$DATE

    #make entry to log file
    echo $DATE $rhost >> backup.log

  else
    echo $rhost Down
  fi
  echo
done
