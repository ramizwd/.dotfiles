#!/usr/bin/env bash

ICON_DIR="$HOME/.config/rofi/icons"

options="Google\0icon\x1f$ICON_DIR/google.svg
YouTube\0icon\x1f$ICON_DIR/youtube.svg
GitHub\0icon\x1f$ICON_DIR/github_dark.svg
DuckDuckGo\0icon\x1f$ICON_DIR/duckduckgo.svg"

engine="$(echo -e "$options" | rofi -dmenu -i -p "Engine")"

case "$engine" in
    DuckDuckGo)
        URL="https://duckduckgo.com/?q="
        glyph="󰇥  " ;;
    Google)
        URL="https://www.google.com/search?q="
        glyph="  " ;;
    YouTube)
        URL="https://www.youtube.com/results?search_query="
        glyph="󰗃  " ;;
    GitHub)
        URL="https://github.com/search?q="
        glyph="  " ;;
    *)
        exit 1 ;;
esac

query=$(rofi -dmenu -p "$glyph $engine")

if [ -n "$query" ]; then
    xdg-open "${URL}${query// /+}"
fi
