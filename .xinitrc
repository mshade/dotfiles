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

# Xresources
xrdb ~/.Xresources

# Fonts
xset +fp /usr/share/fonts/local
xsetroot -cursor_name left_ptr
source ~/dotfiles/infinality-settings.sh


# machine-specific stuff
if [[ -r ~/.xinitrc."$HOSTNAME" ]]
then
   . ~/.xinitrc."$HOSTNAME"
fi

# Apps to start
xautolock -time 10 -locker "i3lock -c 000000" &
redshift -l 38.71:-77.14&
~/bin/wallpaper.sh &
parcellite &

#export XDG_CONFIG_HOME="$HOME/.config"
#export BSPWM_SOCKET="/tmp/bspwm-socket"

#compton &
#sxhkd &
#tint2 &
#exec bspwm
exec i3
