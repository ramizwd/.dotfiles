#!/usr/bin/env bash

shutdown="⏻  Shutdown"
reboot="󰜉  Reboot"
suspend="󰤄  Suspend"
logout="󰍃  Logout"
hyprland_reload="󰑓  Reload hyprland"

options="$shutdown\n$reboot\n$suspend\n$logout\n$hyprland_reload"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power Menu")"

case $chosen in
    $shutdown)
        systemctl poweroff ;;
    $reboot)
        systemctl reboot ;;
    $suspend)
        systemctl suspend ;;
    $logout)
        hyprctl dispatch exit ;;
    $hyprland_reload)
        hyprctl reload ;;
esac
