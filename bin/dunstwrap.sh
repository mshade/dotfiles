#!/usr/bin/env bash
#
# Restart dunst if it dies.  Which it does, frequently.

x=0
while x=0
do
	PIDX=$(pgrep xinit)
	if [[ -z $PIDX ]]
	then
		echo "X must be running.  Bailing"
		exit 1
	else
		dunst
		unset PIDX
	fi
done
