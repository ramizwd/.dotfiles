#!/usr/bin/env bash

shutdown="󰐥"
reboot="󰜉"
suspend="󰤄"
logout="󰍃"
hyprland_reload="󰑓"

options="$shutdown\n$reboot\n$suspend\n$logout\n$hyprland_reload"

chosen="$(echo -e "$options" | rofi -dmenu -theme "$HOME/.config/rofi/powermenu.rasi")"

[[ -z "$chosen" ]] && exit

confirm_exit() {
    echo -e "Confirm\nCancel" | rofi -dmenu -theme "$HOME/.config/rofi/confirm.rasi"
}

case $chosen in
    $shutdown)
        if [[ $(confirm_exit) == "Confirm" ]]; then systemctl poweroff; fi ;;
    $reboot)
        if [[ $(confirm_exit) == "Confirm" ]]; then systemctl reboot; fi ;;
    $suspend)
        systemctl suspend ;;
    $logout)
         if [[ $(confirm_exit) == "Confirm" ]]; then hyprctl dispatch exit; fi ;;
    $hyprland_reload)
         hyprctl reload ;;
esac
