#!/usr/bin/env bash
#
# Jesus christ, xorg, quit screwing with xinput attribute numbers.
# Fuck!

# How slow you want it?
DECEL=3

# Get dev ID of Logitech Unifying Device receiver.  
# Yes, it's dirty as sin.
ID=$(xinput list | grep "Logitech Unifying" |awk -Fid= '{print $2}'|awk '{print $1}')
PROP=$(xinput list-props $ID |grep "Device Accel Constant Decel"| awk -F\( '{print $2}' |sed -e 's/).*//' )

xinput set-prop $ID $PROP $DECEL
