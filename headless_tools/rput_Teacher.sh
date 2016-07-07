#!/bin/bash
if (ssh lbym@$1 '[ -d /home/lbym/+Teacher ]')
then
rsync -arvz --delete -e "ssh -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" /home/lbym/Teacher/ lbym@$1:/home/lbym/+Teacher
fi

