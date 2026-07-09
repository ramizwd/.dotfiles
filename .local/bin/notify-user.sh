#!/usr/bin/env bash

declare -A ICONS=(
    ["open-rgb"]="org.openrgb.OpenRGB"
    ["clipboard"]="gpaste"
    ["color-picker"]="gcolor3"
    ["reload"]="view-refresh"
)

if [[ -n "${ICONS[$1]}" ]]; then
    ICON="${ICONS[$1]}"
fi

shift
notify-send -i "$ICON" "$@"
