#!/bin/bash
if(ssh $1 '[ -d /home/lbym/+Teacher ]')
then

rsync -avz --update --delete \
-e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" \
/home/lbym/Teacher/ $1:/home/lbym/+Teacher/

fi
