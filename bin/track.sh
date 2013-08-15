#!/usr/bin/env bash
#
# toggle touchpad on/off on thinkpad

DEVICE="SynPS/2 Synaptics TouchPad"
PROP="Device Enabled"

if [[ -z $@ ]]
then
    exit 0
fi

if [[ $@ == "off" ]]
then
    xinput set-prop "$DEVICE" "$PROP" 0
elif [[ $@ == "on" ]]
then
    xinput set-prop "$DEVICE" "$PROP" 1
fi

