#!/bin/bash

for ARG in $*
do
	HexID=$(echo "obase=16; $ARG" | bc)
	ID=66acd000-77fe-1000-9115-d802$HexID
	wget http://marketplace.xbox.com/en-US/X8/Game/$ID
	valid=$(json_verify < $ID)
	if [[ $valid == "JSON is valid" ]]; then
		json_reformat -u < $ID > $ARG.json
		rm $ID
		sed -i 's/    /\t/g' $ARG.json
	else
		echo "ERROR: $ARG"
	fi
done
