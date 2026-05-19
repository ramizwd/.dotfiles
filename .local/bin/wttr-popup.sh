#!/usr/bin/env bash

CITY=$(cat "$HOME/.weather_city" 2>/dev/null || echo "")

if [ "$1" == "v2" ]; then
    hyprctl dispatch 'hl.dsp.exec_cmd("kitty --hold curl v2.wttr.in/'$CITY'", { float = true, size = {700, 900} })'
else
    hyprctl dispatch 'hl.dsp.exec_cmd("kitty --hold curl wttr.in/'$CITY'", { float = true, size = {1150, 700} })'
fi
