#!/bin/bash
#colors
RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
BLUE="\033[1;34m"
LIGHT_RED="\033[1;31m"
LIGHT_GREEN="\033[1;32m"
CYAN="\033[0;36m"
LIGHT_CYAN="\033[1;36m"
WHITE="\033[1;37m"
LIGHT_GRAY="\033[0;37m"
NONE="\e[0m"

#check if overload server IP address was included
if [ -z "$1" ]
then
	serverIP=192.168.2.1
else
	serverIP="$1"
fi

if [ -z "$2" ]
then
	lbymnum=$(hostname | cut -c5-8)
	clientIP="192.168.2.$lbymnum"
else
	clientIP="$2"
fi

printf "${LIGHT_CYAN}Connecting To server...\n"
if ping -c 1 $serverIP &> /dev/null
then
	ssh -p 25000 $serverIP 'bash /home/lbym/master_i3/headless_tools/sync.sh 192.168.2.8'
fi

printf "${LIGHT_CYAN}Computer is up to date ${NONE}\n"

