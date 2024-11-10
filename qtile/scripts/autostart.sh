#!/bin/bash

# Set Background. For multiple monitors pass multiple paths
# Possible options:
# --bg-scale FILE
# --bg-tile FILE
# --bg-center FILE
# --bg-max FILE
# --bg-fill FILE
feh --bg-fill --no-fehbg ~/Pictures/Wallpapers/tram.png ~/Pictures/Wallpapers/netrunner.png &

# Set up the compositor. Picom configuration can either be specified by:
# pciom --config /path/to/config else ~/.config/picom/picom.conf is used.
picom &

# System Tray (X11)

# bluetooth
#blueman-applet &
# Network Manager
nm-applet &
# Pulseaudio
#pasystray &

# Notifications
dunst &

# Turn on Numlock on startup
numlockx on &

# Change default cursor
xsetroot -cursor_name left_ptr &

# Load Xresources
xrdb -merge ~/.Xresources &

# Add polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Change keyboard layouts
# setxkbmap -layout us,gr -option 'grp:lalt_lshift_toggle' & 
# Can also easily be configured through qtile with the
# KeyboardLayout widget, that also uses setxkbmap.
