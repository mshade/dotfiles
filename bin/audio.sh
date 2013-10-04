#!/usr/bin/env bash
# reload pulse and alsa modules because ice1712 sucks on suspend/resume
# run as user that has passwordless sudo enabled

# kill pulse so modules will unload

pulseaudio -k

# get modules loaded and unload 'em
MODULES=$(lsmod |grep ^snd| awk '{print $1}')

# unload 'em
while $(lsmod |grep -q ^snd)
do
    echo "while active"
    for i in $MODULES
    do
        echo "removing $i"
        sudo rmmod $i
    done
done

# load 'em

sudo modprobe snd_ice1712
pulseaudio --start

