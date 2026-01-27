#!/usr/bin/env bash

shutdown="⏻ Shutdown"
reboot="󰜉 Reboot"
suspend="󰤄 Suspend"
logout="󰍃 Logout"

options="$shutdown\n$reboot\n$suspend\n$logout"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power Menu:" -config $HOME/.config/rofi/config.rasi)"

case $chosen in
    $shutdown)
        systemctl poweroff ;;
    $reboot)
        systemctl reboot ;;
    $suspend)
        systemctl suspend ;;
    $logout)
        hyprctl dispatch exit ;;
esac
