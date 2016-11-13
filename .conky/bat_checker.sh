#!/bin/bash

# display the warning window if the found battery-load is 16 percent or lower. With a stepsize of 5, the last warning will come in at 1 percent.
displayAt=16

# display the warning window after 5 percent are dropped. Continue till die.
displayStepsize=5

# read the piped-in data:
while read data; do
	if [[ $data == *need-to-warn* ]] # need-to-warn is a dedicated keyword that my conky prints in his textoutput. 
	then
		percent=`echo $data | tr -cd \[:digit:\]` #extract numbers from data string.
		if [[ $percent -ge 1 && $percent -le $displayAt ]] #leq my desired percent val?
		then 
			# handle low battery event!!
			python $HOME/workspace/python/SysDisplays/batdisplay.py&
			displayAt=$displayAt-$displayStepsize # decrement
		fi
	elif [[ $data == *need-to-restore* ]] # need-to-restore is a dedicated keyword that my conky prints in his textoutput.
	then	
		# reset the local variables here. The user plugged the power cable!
		percent=`echo $data | tr -cd \[:digit:\]` #extract numbers from data string.
		displayAt=$displayStepsize+$percent  
		if [[ displayAt -ge 16 ]]
		then
			displayAt=16
		fi
	else
		# echo valid json only. Do not echo the non-json keywords to the i3bar.
		echo $data
	fi
done
