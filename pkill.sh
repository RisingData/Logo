#!/bin/sh
/bin/kill $(ps ax | awk '$5 ~ /'"$1"'/ { print $1 }')
#ps ax | awk '$5 ~ /'"$1"'/ { print $1 }

