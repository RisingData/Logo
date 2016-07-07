#!/bin/bash
rsync -arvz --delete -e "ssh -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" /home/lbym/Student/ lbym@$1:/home/lbym/+Student/

