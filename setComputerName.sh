#!/bin/sh


#  setComputerName.sh
#
#  Download a CSV of lab computer names from the web
#  
#  Using the Jamf Binary...
#  If the serial number exists, set the name to the name written in the file
#
#  If not, calculate the name based on hardware information


curl -H 'Authorization:Basic SomeObfuscatedUserAndPass' https://yourwebsite.edu/labComputerNames.csv -o "/tmp/labNames.csv"

jset=`jamf setComputerName -fromFile /tmp/labNames.csv | grep error`

if [ "$jset" == "There was an error." ]
then
	echo "Name not found in CSV"
	MODEL=`system_profiler SPHardwareDataType | awk '/Model Name/ {print $3$4}'`
	SERIAL=`system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`
	NAME="RMU"$SERIAL

	if [ "$MODEL" == "MacBookPro" ];
	then
		NAME="MBP"$SERIAL

	elif [ "$MODEL" == "iMac" ];
	then
		NAME="MAC"$SERIAL
        
    elif [ "$MODEL" == "Macmini" ];
	then
		NAME="MAC"$SERIAL

	elif [ "$MODEL" == "MacBook" ];
	then
		NAME="MBK"$SERIAL
        
    elif [ "$MODEL" == "MacBookAir" ];
    then
    	NAME="MBA"$SERIAL
        
	else
		exit 1
	fi

	#SET Computer Name with scutil
	#scutil --set HostName $NAME
	#scutil --set LocalHostName $NAME
	#scutil --set ComputerName $NAME

	#SET Computer Name with Jamf Binary
	jamf setComputerName -name $NAME
    echo $NAME
fi
	exit 0