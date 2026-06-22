#!/usr/bin/env bash

CITY=$(cat "$HOME/.weather_city" 2>/dev/null || echo "")

weather=$(curl -sf "wttr.in/$CITY?format=1")

if [ $? -ne 0 ]; then
    echo "wttr unavailable"
else
    echo "$weather"
fi
