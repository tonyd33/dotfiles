mouse_sens.sh 0.75 &
xrandr --output DP-0 --primary --mode 1920x1080 --pos 0x0 --rate 144.0 --output HDMI-0 --mode 1920x1080 --pos 1920x0 &
flameshot &
dunst &
nm-applet &
picom -bf --experimental &
nitrogen --restore &
exec openbox-session
#exec i3
