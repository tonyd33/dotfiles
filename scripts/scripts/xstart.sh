#!/bin/sh

# faster typing speed
xset r rate 150 30 &
# wallpaper
nitrogen --restore &

# pipewire
pipewire &
pipewire-pulse &
pipewire-media-session
