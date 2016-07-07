#/bin/bash

echo "Type a name for your project followed by [ENTER]:"

read projectName

#generate LOGO file
LOGO_STRING=";jlogo file for $projectName\n
\n
to $projectName\n
	\tprint \"|starting $projectName|\n
	\tinit-$projectName\n
	\tloop\n
	\t[\n
		\t\t;this is the forever loop of your jlogo progoram\n
	\t]\n
end\n
\n
to init-$projectName\n
	\t;this is where you should initialize any variables you may need\n
	\tinit-hardware\n
	\n
end\n
\n
to init-hardware\n
	\t;this is where you should start your app boards running\n
\n
end\n"

TEXT_STRING=';ulogo file for $projectName\n
to onpowerup\n
;ready \n
\n
end\n
\n
to ongo \n
;set \n
\n
end\n
\n
to onstart \n
;go \n
\n
end'


PRJ_STRING="$projectName.txt"

echo $LOGO_STRING > $projectName.logo
echo $TEXT_STRING > $projectName.txt
echo $PRJ_STRING > $projectName.prj

./jl