#!/bin/bash

BAT=~/.i3/i3conk-battery
NOBAT=~/.i3/i3conk-nobattery

CFG="$NOBAT"

[[ -e /sys/class/power_supply/BAT0 ]] && CFG="$BAT" 

echo '{"version":1}'
echo '['
echo '[],'
exec conky -c $CFG
