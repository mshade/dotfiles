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
xset +fp /usr/share/fonts/local
xsetroot -cursor_name left_ptr

# Xresources
xrdb ~/.Xresources

# machine-specific stuff
if [[ -r ~/.xinitrc."$HOSTNAME" ]]
then
   . ~/.xinitrc."$HOSTNAME"
fi

# Apps to start
#~/bin/dunstwrap.sh &
xautolock -time 10 -locker "i3lock -c 000000" &
redshift -l 38.71:-77.14&
~/bin/wallpaper.sh &
#
#sxhkd &
#exec bspwm
parcellite &

export XDG_CONFIG_HOME="$HOME/.config"
export BSPWM_SOCKET="/tmp/bspwm-socket"

compton &
#exec i3
#exec startxfce4
sxhkd &
exec bspwm
#herbstluftwm --locked
