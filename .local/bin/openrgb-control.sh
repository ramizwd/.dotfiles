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

CURRENT_INDEX=$(cat "$INDEX_FILE")

case "$1" in
    --toggle)
    if [ -f "$STATE_DIR/is_off" ]; then
        # Turn on to the last used profile
        LAST_INDEX=$(cat "$LAST_USED_FILE")
        openrgb --profile "${PROFILES[$LAST_INDEX]}"
        echo "$LAST_INDEX" > "$INDEX_FILE"
        rm "$STATE_DIR/is_off"
    else
        # Turn off
        openrgb --color 000000
        echo "$CURRENT_INDEX" > "$LAST_USED_FILE"
        touch "$STATE_DIR/is_off"
    fi
    ;;

    --cycle)
        NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#PROFILES[@]} ))
        openrgb --profile "${PROFILES[$NEXT_INDEX]}"

        # Save state
        echo "$NEXT_INDEX" > "$INDEX_FILE"
        echo "$NEXT_INDEX" > "$LAST_USED_FILE"

        rm -f "$STATE_DIR/is_off"
        ;;
esac
