#/bin/bash
i3-save.sh
cp $1/*.txt .  &> /dev/null
cp $1/*.logo .  &> /dev/null
cp $1/*.prj .  &> /dev/null
echo "~~"
echo "loaded project from $1"
echo "~"
