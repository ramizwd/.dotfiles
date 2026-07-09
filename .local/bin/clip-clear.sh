#!/usr/bin/env bash

# clear the cliphist db
cliphist wipe

# clear the active selection
wl-copy --clear

# clear the primary selection
wl-copy --primary --clear

notify-user.sh clipboard -a "Clipboard" "History and buffers cleared"
