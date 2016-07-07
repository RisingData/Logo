#!/bin/bash
rsync -avz --update --delete \
-e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet" \
/home/lbym/Student/ $1:/home/lbym/+Student/
