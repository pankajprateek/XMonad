#!/bin/bash

# nitrogen --restore &

xsetroot -cursor_name left_ptr

xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'clear Lock'
xmodmap -e 'add Control = Control_L'

# because the right button broke
#synclient TapButton2=3

# turn off the annoying beep beep
xset b off

# feh  --bg-scale '/home/pankaj/scripts/wallpaper/wallpaper.jpg' & 
#feh --bg-scale '/home/pankaj/.wallpaper' &

# gnome-terminal -e "python fire.py" &

#./.wallpaper/wallpaper.sh

# trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand true --width 10% --tint 0x000000 --transparent true --alpha 0 --height 14 &

# dropboxd &
urxvtd &
#arbtt-capture &
#sudo modprobe vboxdrv

#export PATH=$HOME/bin:$HOME/.gem/ruby/2.1.0/bin:/usr/local/bin:$PATH
#export PATH=$HOME/.cabal/bin/:$PATH
#export MANPATH="/usr/local/man:$MANPATH"

#if [ -x /usr/bin/nm-applet ] ; then
 #  nm-applet --sm-disable &
#fi
 
#if [ -x /usr/bin/gnome-power-manager ] ; then
 #  sleep 3
  # gnome-power-manager &
#fi

# mapped to spawn in xmonad.hs
# xpad --show &
# firefox &
# skype &
# pidgin &
# spotify &

# xmobar second instance; HACK!!!!! :(, think of a better way using xmonad.hs
# Doesn't Work
# xmobar ~/.xmobarrc.up &

#udiskie &
./dotfiles/randr.sh
exec xmonad
#exec i3
