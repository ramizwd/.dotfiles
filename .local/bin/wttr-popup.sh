#!/usr/bin/env bash

CITY=$(cat "$HOME/.weather_city" 2>/dev/null || echo "")

if [ "$1" == "v2" ]; then
    hyprctl dispatch exec "[float; size 700 900] kitty --hold curl v2.wttr.in/$CITY"
else
    hyprctl dispatch exec "[float; size 1150 700] kitty --hold curl wttr.in/$CITY"
fi
