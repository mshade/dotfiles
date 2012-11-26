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

# Fonts
xset +dpms +fp /usr/share/fonts/local

# input
setxkbmap -option terminate:ctrl_alt_bksp,compose:ralt,ctrl:nocaps

# Xresources
xrdb -merge ~/.Xresources

# machine-specific stuff
if [[ -r ~/.xinitrc."$HOSTNAME" ]]
then
   . ~/.xinitrc."$HOSTNAME"
fi

exec ck-launch-session i3 >> ~/.i3/i3log.txt 2>&1
