#!/usr/bin/env bash

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

notify_status() {
    local icon="org.openrgb.OpenRGB"
    local title="$1"
    local msg="$2"
    local id="$3"

    if [ -n "$id" ]; then
        # Replace existing notification
        notify-send -p -r "$id" -a "$title" "$msg" -i "$icon"
    else
        # Create new notification and return ID
        notify-send -p -a "$title" "$msg" -i "$icon"
    fi
}

case "$1" in
    --toggle)
    if [ -f "$STATE_DIR/is_off" ]; then
        # Turn on to the last used profile
        last_index=$(cat "$LAST_USED_FILE")
        profile="${PROFILES[$last_index]}"

        nid=$(notify_status "OpenRGB" "Turning on: $profile...")

        openrgb --profile "$profile" > /dev/null 2>&1

        echo "$last_index" > "$INDEX_FILE"
        rm "$STATE_DIR/is_off"

        notify_status "OpenRGB" "Profile Loaded: $profile" "$nid"
    else
        nid=$(notify_status "OpenRGB" "Turning off lights...")

        # Turn off
        openrgb --color 000000
        echo "$current_index" > "$LAST_USED_FILE"
        touch "$STATE_DIR/is_off"

        notify_status "OpenRGB" "Lights Off" "$nid"
    fi
    ;;

    --cycle)
        next_index=$(( (current_index + 1) % ${#PROFILES[@]} ))
        profile="${PROFILES[$next_index]}"

        nid=$(notify_status "OpenRGB" "Switching to $profile...")

        openrgb --profile "$profile" > /dev/null 2>&1

        # Save state
        echo "$next_index" > "$INDEX_FILE"
        echo "$next_index" > "$LAST_USED_FILE"

        rm -f "$STATE_DIR/is_off"

        notify_status "OpenRGB" "Active Profile: $profile" "$nid"
        ;;
esac
