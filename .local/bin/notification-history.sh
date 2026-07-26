#!/usr/bin/env bash

readonly theme="notifications.rasi"

get_history() {
    dunstctl history 2>/dev/null
}

show_notifications() {
    local list display_list selected row_number notif_id

    # List of unique notifications sorted by id
    list=$(echo $(get_history) | jq -r '
        .data[0]
        | map({id: .id.data, app: .appname.data, sum: .summary.data, body: .body.data})
        | unique_by(.app, .sum, .body)
        | sort_by(.id)
        | reverse
        | .[]
        | "\(.id)\t\(.app)\n\(.sum)\n\(.body)\u000b"')

    # Display empty message if no notifications found
    if [[ -z "$(echo "$list")" ]]; then
        rofi -e "No notifications" -theme "$theme"
        return
    fi

    display_list=$(echo "$list" | cut -f2-)

    selected=$(echo -ne "$display_list" | rofi -dmenu \
        -theme "$theme" \
        -sep $'\x0b' \
        -eh 4 \
        -format i)

    # Pop clicked notification
    if [[ -n "$selected" ]]; then
        row_number=$((selected * 3 + 1))
        notif_id=$(echo "$list" | sed -n "${row_number}p" | cut -f1)

        dunstctl history-pop "$notif_id"
    fi
}

count_notifications() {
    # Count unique notifications
    local count=$(get_history | jq '
        .data[0]
        | map("\(.appname.data)\(.summary.data)\(.body.data)")
        | unique
        | length')

    if [[ "$count" -gt 0 ]]; then
        echo "󰂚 $count"
    fi
}

clear_notifications() {
    dunstctl history-clear
}

case "$1" in
    --show)
        show_notifications
        ;;
    --count)
        count_notifications
        ;;

    --clear)
        clear_notifications
        ;;
    *)
        echo "Usage: $0 [--show | --count | --clear]" >&2
        exit 1
        ;;
esac
