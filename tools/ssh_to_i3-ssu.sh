#!/bin/bash
host="$(hostname)"
/usr/local/i3/dtach -a meet$host | ssh -A -t lbym@192.168.2.1 \"/bin/bash\"
