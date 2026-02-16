#!/usr/bin/env bash

rgb="RGB"
hsl="HSL"
hsv="HSV"
hex="HEX"
cmyk="CMYK"

options="$rgb\n$hsl\n$hsv\n$hex\n$cmyk"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Color Picker")"

# Wait for rofi to close
sleep 0.2

case $chosen in
    $rgb)
        hyprpicker -a --format=rgb ;;
    $hsl)
        hyprpicker -a --format=hsl ;;
    $hsv)
        hyprpicker -a --format=hsv ;;
    $hex)
        hyprpicker -a --format=hex ;;
    $cmyk)
        hyprpicker -a --format=cmyk ;;
esac
