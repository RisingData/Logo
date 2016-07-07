#!/bin/bash
pushd ~/

if [ $# -ne 2 ]
then
        echo "Usage: $0 <source> <destination>"
fi

SOURCE=$1
DEST=$2

if [ -z "$DEST" ]
then
        echo "ERROR: i3-copy requires two inputs"
        echo ' '
        exit 1
fi 
 
if [ ! -d "$SOURCE" ]
then
        echo "ERROR: $SOURCE does not exist"
        exit 1
fi

if [ -d "$DEST" ]
then
        echo "ERROR: $DEST already exists."
        exit 1 
fi

echo copy $SOURCE to $DEST
mkdir $DEST
chmod 777 $DEST
chmod 777 $SOURCE
cd $SOURCE
tar cpf /tmp/temp.tar .
cd ~/
chmod 444 $SOURCE
cd $DEST
touch .jlOK
tar xpf /tmp/temp.tar .
cd ~/
ls -ld $DEST
popd

