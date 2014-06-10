#!/usr/bin/env bash
#
# Jesus christ, xorg, quit screwing with xinput attribute numbers.
# Fuck!

# How slow you want it?
DECEL=3
PROP='Device Accel Constant Deceleration'

# Get dev ID of Logitech Unifying Device receiver.  
# Yes, it's dirty as sin.
ID=$(xinput list | grep "Logitech Unifying" |awk -Fid= '{print $2}'|awk '{print $1}')

if [[ -z $ID ]]
then
    echo "no logitech receiver found"
    exit 0
fi

xinput set-prop $ID "$PROP" $DECEL
