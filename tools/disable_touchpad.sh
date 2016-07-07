#!/bin/bash
strindex() {
x="${1%%$2*}"
[[ $x = $1 ]] && echo -1 || echo ${#x}
}
listdata=$(xinput list)
OIFS="${IFS}"
NIFS=$'\n'
IFS="${NIFS}"
ARRAY=()
for LINE in ${listdata} ; do
IFS="${OIFS}"
line=${LINE// /}
if [[ $line == *"slave"*"pointer"* ]] && [[ $line != *"USB"* ]];
then
firstindex=$(strindex "$line" "id=")
line=${line:firstindex+3}
secondindex=$(strindex "$line" "[")
line=${line:0:secondindex-1}
ARRAY[${#ARRAY[@]}]=$line
fi
IFS="${NIFS}"
done
IFS="${OIFS}"
for i in "${ARRAY[@]}"
do :
xinput set-prop $i "Device Enabled" 0
done
