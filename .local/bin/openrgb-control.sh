#!/bin/bash

PROFILES=("Lime" "Sunset" "Nightshade" "Afterglow")

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/openrgb_state"
INDEX_FILE="$STATE_DIR/profile_index"
LAST_USED_FILE="$STATE_DIR/last_used_index"

mkdir -p "$STATE_DIR"
chmod 700 "$STATE_DIR"

# Initialize files if they don't exist
[ ! -f "$INDEX_FILE" ] && echo 0 > "$INDEX_FILE"
[ ! -f "$LAST_USED_FILE" ] && echo 0 > "$LAST_USED_FILE"

current_index=$(cat "$INDEX_FILE")

case "$1" in
    --toggle)
    if [ -f "$STATE_DIR/is_off" ]; then
        # Turn on to the last used profile
        last_index=$(cat "$LAST_USED_FILE")
        openrgb --profile "${PROFILES[$last_index]}"
        echo "$last_index" > "$INDEX_FILE"
        rm "$STATE_DIR/is_off"
    else
        # Turn off
        openrgb --color 000000
        echo "$current_index" > "$LAST_USED_FILE"
        touch "$STATE_DIR/is_off"
    fi
    ;;

    --cycle)
        next_index=$(( (current_index + 1) % ${#PROFILES[@]} ))
        openrgb --profile "${PROFILES[$next_index]}"

        # Save state
        echo "$next_index" > "$INDEX_FILE"
        echo "$next_index" > "$LAST_USED_FILE"

        rm -f "$STATE_DIR/is_off"
        ;;
esac
