#!/usr/bin/env bash

rgb="RGB"
hsl="HSL"
hsv="HSV"
hex="HEX"
cmyk="CMYK"

options="$rgb\n$hsl\n$hsv\n$hex\n$cmyk"
prompt_txt="󰏘   Color Picker"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "$prompt_txt" -theme-str 'mode-switcher { margin: 0; }')"

# Wait for rofi to close
sleep 0.2

if [[ -n "$chosen" ]]; then
    color=$(hyprpicker -a --format="${chosen,,}")

    if [[ -n "$color" ]]; then
        notify-user.sh color-picker -a "Color Picker" "$chosen color copied to clipboard"
    fi
fi
