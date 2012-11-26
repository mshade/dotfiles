#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Custom stuff
# Set synaptics up correctly
~/bin/synclient.sh &

# Make caps lock control
~/bin/remap-keys.sh

exec ck-launch-session i3 >> ~/.i3/i3log.txt 2>&1
