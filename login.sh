#!/bin/bash 
touch /home/lbym/.$(hostname)_login.log
DATE=`date +%Y-%m-%d:%H:%M:%S`
echo $(hostname) $DATE >/home/lbym/.$(hostname)_login.log
scp -P 25000  .$(hostname)_login.log 192.168.2.1:/home/lbym/logs/$(hostname)_logs >/dev/null 2>&1
