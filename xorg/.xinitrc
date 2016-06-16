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
#xsetroot -cursor_name left_ptr
#source ~/dotfiles/infinality-settings.sh

#export GDK_SCALE=2
#export GDK_DPI_SCALE=0.5


# machine-specific stuff
if [[ -r ~/.xinitrc."$HOSTNAME" ]]
then
   . ~/.xinitrc."$HOSTNAME"
fi

# Apps to start
xautolock -time 10 -locker "i3lock -c 000000" &
#redshift -l 38.71:-77.14&
#~/bin/wallpaper.sh &
sh ~/.fehbg &
parcellite &

#~/apps/2bwm/2bwm &
#exec ~/bin/startbar.sh
#exec cinnamon-session
#/home/mshade/.screenlayout/4kmain1080secondary.sh 
exec ~/apps/i3/i3
#exec i3
#exec startkde
