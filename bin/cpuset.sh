#!/bin/bash
###########
# Toggle between ondemand / performance


if [[ -z $1 ]]
then
	echo "Specify performance or ondemand."
	exit 1
fi

for i in 0 1 2 3; do cpufreq-set -c $i -g $1 ;done 


