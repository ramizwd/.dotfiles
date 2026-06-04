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
    local action_name=""
    case $chosen in
        $shutdown) action_name="shutdown" ;;
        $reboot)   action_name="reboot" ;;
        $suspend)  action_name="suspend" ;;
        $logout)   action_name="logout" ;;
    esac

    echo -e "Confirm\nCancel" | rofi -dmenu \
        -mesg "Are you sure you want to $action_name?" \
        -theme "$HOME/.config/rofi/confirm.rasi"
}

case $chosen in
    $shutdown)
        if [[ $(confirm_exit) == "Confirm" ]]; then systemctl poweroff; fi ;;
    $reboot)
        if [[ $(confirm_exit) == "Confirm" ]]; then systemctl reboot; fi ;;
    $suspend)
        if [[ $(confirm_exit) == "Confirm" ]]; then systemctl suspend; fi ;;
    $logout)
        if [[ $(confirm_exit) == "Confirm" ]]; then hyprctl dispatch exit; fi ;;
    $hyprland_reload)
         hyprctl reload ;;
esac
