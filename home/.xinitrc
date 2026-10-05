#!/bin/sh
export $(dbus-launch)
feh --bg-fill /home/void/Downloads/e8ca70cc4cc7132799c9d69936705507.jpg &
setxkbmap -layout us,ru -option grp:alt_shift_toggle
pulseaudio --start
export LIBVA_DRIVER_NAME=i965
export XCURSOR_THEME="manhattan-cafe"
export XCURSOR_SIZE=24
exec i3
