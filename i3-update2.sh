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

#array checking logic
containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == *"$1"* ]] && return 0; done
  return 1
}

DATE=$(date)
printf "${LIGHT_CYAN}\nRunning i3-update on $hostname $DATE\n"
location="/usr/local/i3/updates"
failedScripts=()

#run the full stack of scripts on this machine
for SCRIPT in $location/*
do
	SLASH="/"
	_SCRIPT=${SCRIPT#$location}
	_SCRIPT=${_SCRIPT#$SLASH}

	#execute all runnable scripts. To prevent a script from running, change it's permission (-x)
	if [ -f $SCRIPT -a -x $SCRIPT ] && !([ -f $location/oldscripts/$_SCRIPT ]);
	then
		printf "\n${GREEN}Running $SCRIPT\n"
		printf "__________________________\n${LIGHT_GREEN}"

		$SCRIPT $1
		#if script fails report and record failure
		if [ "$?" -ne "0" ]
		then
			printf "\n${RED}$SCRIPT failed to execute\n"
			failedScripts+=($SCRIPT)
		fi

		printf "${GREEN}__________________________\n${NONE}"

	else
		if [ -f $SCRIPT -a $SCRIPT ]
		then
			printf "\n${YELLOW}skipping $SCRIPT\n"
		fi
	fi
	
	#remove one time scripts
	if [[ $SCRIPT == /usr/local/i3/updates/+* ]]
	then
  		printf "${YELLOW}archiving one-time script $SCRIPT\n"
       		mv $SCRIPT /usr/local/i3/updates/oldscripts/
	fi


done

#DATE=`date +%y-%m-%d:%H:%M:%S`
#if containsElement "XXX" "${failedScripts[@]}"
#then
#	printf "${LIGHT_RED}ERROR MESSGE\n"
#else
#	printf "${LIGHT_CYAN}SUCCESS MESSAGE"
	#success code
#fi


DATE=$(date)
printf "${LIGHT_CYAN}\nUpdate Complete $DATE\n${NONE}"


	
