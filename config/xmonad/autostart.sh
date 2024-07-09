#!/bin/bash

function run {
	if ! pgrep $1; then
		$@ &
	fi
}
run "dex $HOME/.config/autostart/arcolinux-welcome-app.desktop"
#run "xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal"
#run "xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off"
#run xrandr --output eDP-1 --primary --mode 1368x768 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off
#run xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#run xrandr --output DVI-I-0 --right-of HDMI-0 --auto
#run xrandr --output DVI-1 --right-of DVI-0 --auto
#run xrandr --output DVI-D-1 --right-of DVI-I-1 --auto
#run xrandr --output HDMI2 --right-of HDMI1 --auto
#autorandr horizontal
#xrandr --output DisplayPort-0 --primary --output DVI-1 --right-of DisplayPort-0

#setxkbmap -layout eu
setxkbmap -layout eu,de -option 'grp:alt_shift_toggle'

#run slstatus &
#run /usr/local/bin/dwmblocks &

run "nm-applet"
run "pamac-tray"
#run "variety"
run "xfce4-power-manager"
run "blueberry-tray"
#run "/usr/lib/xfce4/notifyd/xfce4-notifyd"
run dunst &
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
#picom --config $HOME/.config/picom.conf &
run "numlockx on"
run "volumeicon"
run "mpd"
#run "birdtray"
#run "syncthing"

#sxhkd -c ~/.local/share/dwm/sxhkdrc &
#run "nitrogen --restore"
#run "conky -c $HOME/.config/conky/clock.conkyrc"

#you can set wallpapers in themes as well
#feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &

# Select random wallpaper
#run "/home/eddie/.local/bin/wallpaper"

#run applications from startup
run dropbox
#run nextcloud

#run emacs --daemon
#run urxvtd -o -q -f

#run "insync start"
#run "spotify"
#run "ckb-next -b"
#run "discord"
#run "telegram-desktop"
