#!/bin/bash
recurse=0;
currentSize=$(du -s $1 | awk '{print $1}')
if [ "$currentSize" -gt $2 ]
then
	fileCount=$(ls $1| wc -l)
	rand=$(shuf -i 2-$(( fileCount -- )) -n 1)
	randFile=$(ls $1 | head -n $rand| tail -n 1)
	rm -rf $1/$randFile
	recurse=1
fi

if [ $recurse = 1 ]
then
	
	command="$0 $1 $2"
	command=$(echo $command | sed 's/.\///')
	./$command
fi



