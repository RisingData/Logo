#!/bin/bash

# NetworkInfo=$(nmcli nm)
# if [[ $NetworkInfo =~ "disconnected" ]]
# then	
#	nmcli dev wifi connect i3-v220
# fi 

#!/bin/bash
count=$( ping -c 1 192.168.2.$1 | grep -i unreachable |wc -l )
echo $count
if [ $count -eq 0 ]
then
 echo $1 up
else
 echo $1 down
fi


