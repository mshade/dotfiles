#!/usr/bin/env bash
#
# Jesus christ, xorg, quit screwing with xinput attribute numbers.
# Fuck!

# How slow you want it?
#DECEL=3
#PROP='Device Accel Constant Deceleration'
DECEL='-1.000'
PROP='libinput Accel Speed'

# Get dev ID of Logitech Unifying Device receiver.  
# Yes, it's dirty as sin.
ID=$(xinput list | grep "Logitech" |awk -Fid= '{print $2}'|awk '{print $1}')

if [[ -z $ID ]]
then
    echo "no logitech receiver found"
    exit 0
fi

xinput set-prop $ID "$PROP" $DECEL

# libinput Accel Speed (273): -1.000000
# libinput Accel Speed Default (274): 0.000000
# libinput Accel Profiles Available (275):  1, 1
# libinput Accel Profile Enabled (276): 1, 0
# libinput Accel Profile Enabled Default (277): 1, 0

