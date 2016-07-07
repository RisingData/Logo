#/bin/bash
time=$(date +%Y%m%d%H%M)
mkdir saves &> /dev/null
chmod 777 saves
mkdir saves/$time &> /dev/null
chmod 777 saves/$time
cp ./*.txt saves/$time/ &> /dev/null
cp ./*.logo saves/$time/ &> /dev/null
cp ./*.prj  saves/$time/ &> /dev/null
rm -f saves/$time/common.txt
chmod 777 saves/*


