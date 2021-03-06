#!/usr/bin/env bash

export TERMINAL="/usr/local/bin/st"
export BROWSER="firefox"
export FILE_MANAGER="thunar"
export SXHKD_SCRIPT_DIR="$HOME/bin"
export SXHKD_CONFIG_DIR="$HOME/.config"

APP_NAME=sxhkd

# Terminate already running bar instances
killall -q $APP_NAME

# Wait until the processes have been shut down
while pgrep -u $UID -x $APP_NAME >/dev/null
do
    sleep 1
done

# Launch polybar
$APP_NAME -c "$HOME/.config/$APP_NAME/config_bspwm" "$HOME/.config/$APP_NAME/config_common" & disown

