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

#check is supplied IP is reachable
if ping -c 1 $1 &> /dev/null
then
	#check to make sure computer isn't isolated
	ssh $1 '[ -f ~/.isolate ] && exit 1 || exit 0'
	if [ $? -ne 0 ]
	then
		printf "${LIGHT_RED}Computer at $1 isolated, aborting synchronization ${NONE}\n"
		exit 1
	fi

	DATE=$(date)
	printf "${LIGHT_CYAN}\nStarting Synchronization on ${BLUE}$1${LIGHT_CYAN} $DATE\n"
	location="/home/lbym/master_i3/headless_tools/syncs"
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

			#verify connectivity betweeen execution of each script
			if ping -c 1 $1 &> /dev/null
			then
				$SCRIPT $1
				#if script fails report and record failure
				if [ "$?" -ne "0" ]
				then
					printf "\n${RED}$SCRIPT failed to execute\n"
					failedScripts+=($SCRIPT)
				fi
			else

				printf "$\n{RED}$SCRIPT on $1 connection failure\n"
				failedScripts+=($SCRIPT)

			fi
			#remove one time scripts
			if [[ $SCRIPT == /usr/local/i3/i3-updates/+* ]]
        			then
        	       		printf "${LIGHT_RED}archiving one-time script $SCRIPT\n"
        	      		mv $SCRIPT /usr/local/i3/i3-updates/oldscripts/
	       		fi
			printf "${GREEN}__________________________\n${NONE}"
		else 
			if [ -f $SCRIPT -a $SCRIPT ]
			then
				printf "\n${YELLOW}skipping $SCRIPT\n"
			fi
		fi

	done
	DATE=`date +%y-%m-%d:%H:%M:%S`

	#check if certain scripts have fininshed and update flags accordingly

	if containsElement "backup" "${failedScripts[@]}"
	then
		printf "${LIGHT_RED}Not updating Backup flag, backup failed"
	else
		printf "${LIGHT_CYAN}Updating Backup flag to $DATE\n"
		ssh $1 "rm -rf /home/lbym/Backup_* && touch /home/lbym/Backup_$DATE"	
	fi

	if containsElement "updatei3" "${failedScripts[@]}"
	then
		printf "${LIGHT_RED}Not running i3-update, i3 synchronization failed\n"
	else
		ssh $1 "/usr/local/i3/i3-update2.sh"
	fi
	DATE=$(date)
	printf "${LIGHT_CYAN}\nSynchronization Complete $DATE\n${NONE}"
else

	printf "${RED}\n$1 is unreachable\n${NONE}"

fi

	
