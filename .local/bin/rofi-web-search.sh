#!/usr/bin/env bash

ICON_DIR="$HOME/.config/rofi/icons"
GITHUB_USERNAME="ramizwd"

# Base URLs
GOOGLE_URL="https://www.google.com"
GMAIL_URL="https://mail.google.com"
YOUTUBE_URL="https://www.youtube.com"
GITHUB_URL="https://github.com"
DDG_URL="https://duckduckgo.com"

# Shortcut options
NAV_HOME="󰋜   Home"
NAV_GMAIL="󰊫   Gmail"
NAV_SUBS="󰚝   Subscriptions"
NAV_REPOS="   My Repositories"

# Engine options
options="Google\0icon\x1f$ICON_DIR/google.svg
YouTube\0icon\x1f$ICON_DIR/youtube.svg
GitHub\0icon\x1f$ICON_DIR/github_dark.svg
DuckDuckGo\0icon\x1f$ICON_DIR/duckduckgo.svg"

engine="$(echo -e "$options" | rofi -dmenu -i -p "Engine")"

case "$engine" in
    DuckDuckGo)
        URL="$DDG_URL/?q="
        glyph="󰇥  "
        shortcuts="" ;;
    Google)
        URL="$GOOGLE_URL/search?q="
        glyph="  "
        shortcuts="$NAV_GMAIL\n$NAV_HOME" ;;
    YouTube)
        URL="$YOUTUBE_URL/results?search_query="
        glyph="󰗃  "
        shortcuts="$NAV_SUBS\n$NAV_HOME" ;;
    GitHub)
        URL="$GITHUB_URL/search?q="
        glyph="  "
        shortcuts="$NAV_REPOS" ;;
    *)
        exit 1 ;;
esac

if [[ -n "$shortcuts" ]]; then
    query="$(echo -e "$shortcuts" | rofi -dmenu -i -p "$glyph $engine" -mesg "Select a shortcut or type to search")"
else
    query="$(rofi -dmenu -i -p "$glyph $engine")"
fi

# Exit if escaped
[[ -z "$query" ]] && exit 1

# Match the selected shortcut or perform a web search if no match
case "$engine:$query" in
    Google:"$NAV_HOME") xdg-open "$GOOGLE_URL" ;;
    Google:"$NAV_GMAIL") xdg-open "$GMAIL_URL" ;;
    YouTube:"$NAV_HOME") xdg-open "$YOUTUBE_URL" ;;
    YouTube:"$NAV_SUBS") xdg-open "$YOUTUBE_URL/feed/subscriptions" ;;
    GitHub:"$NAV_REPOS") xdg-open "$GITHUB_URL/$GITHUB_USERNAME?tab=repositories&type=source" ;;
    *)
        xdg-open "${URL}${query// /+}" ;;
esac
