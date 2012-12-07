#!/usr/bin/env bash
################################################
# Monitor X idle time.  Lock screen when idle. 
					       
IDLETIME="5" # in minutes    
					       
################################################

function getidle () {
	# Get idle in seconds instead of ms
	echo $(( $(xprintidle) / 1000))
}

function lockscreen () {
	# check for running instance of slimlock
	if [[ $(pgrep slimlock) ]]
	then
		echo "Existing instance detected."
	else
		slimlock
	fi
}


# minutes to seconds
IDLE=$(($IDLETIME * 60))

while true
do
	IDLESEC=$(getidle)
	if (( "$IDLESEC" >= "$IDLE" ))
	then
		sudo /home/mshade/bin/cpuset.sh ondemand
		lockscreen
		# Reset IDLESEC to force full sleep period
		IDLESEC=0
	fi
	#echo $IDLESEC
	#echo "Sleeping for $(( $IDLE - $IDLESEC ))"
	sleep $(( $IDLE - $IDLESEC ))
done

