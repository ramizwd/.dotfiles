#!/usr/bin/env bash

ICON_DIR="$HOME/.config/rofi/icons"
GITHUB_USERNAME="ramizwd"

browser_class="firefox"
private_indic="Private Browsing"

# Base URLs
GOOGLE_URL="https://www.google.com"
GMAIL_URL="https://mail.google.com"
YOUTUBE_URL="https://www.youtube.com"
GITHUB_URL="https://github.com"
DDG_URL="https://duckduckgo.com"

# Shortcut options
NAV_HOME="󰋜   Home"
NAV_GMAIL="󰊫   Gmail"
NAV_SUBS="󰵀   Subscriptions"
NAV_REPOS="   My Repositories"
NAV_OVERVIEW="   Overview"

# Engine options
options="Google\0icon\x1f$ICON_DIR/google.svg
YouTube\0icon\x1f$ICON_DIR/youtube.svg
GitHub\0icon\x1f$ICON_DIR/github_dark.svg
DuckDuckGo\0icon\x1f$ICON_DIR/duckduckgo.svg"

engine="$(echo -e "$options" | rofi -dmenu -i -p "Engine")"

case "$engine" in
    DuckDuckGo)
        search_url="$DDG_URL/?q="
        glyph="󰇥  "
        shortcuts="" ;;
    Google)
        search_url="$GOOGLE_URL/search?q="
        glyph="  "
        shortcuts="$NAV_GMAIL\n$NAV_HOME" ;;
    YouTube)
        search_url="$YOUTUBE_URL/results?search_query="
        glyph="󰗃  "
        shortcuts="$NAV_SUBS\n$NAV_HOME" ;;
    GitHub)
        search_url="$GITHUB_URL/search?q="
        glyph="  "
        shortcuts="$NAV_REPOS\n$NAV_OVERVIEW" ;;
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
    GitHub:"$NAV_OVERVIEW") xdg-open "$GITHUB_URL/$GITHUB_USERNAME" ;;
    *)
        xdg-open "${search_url}${query// /+}" ;;
esac


sleep 0.1

# Get last focused browser window ID ignoring private window
ff_active_addr=$(
    hyprctl clients -j |
    jq -r --arg browser_class "$browser_class" --arg private_indic "$private_indic" '
        map(
            select(
                .class == $browser_class and
                (.title | contains($private_indic) | not)
            )
        )
        | min_by(.focusHistoryID)
        | .address
    '
)

# Focus browser window
if [[ "$ff_active_addr" != "null" && -n "$ff_active_addr" ]]; then
    hyprctl dispatch 'hl.dsp.focus({ window = "address:'$ff_active_addr'" })'
fi
