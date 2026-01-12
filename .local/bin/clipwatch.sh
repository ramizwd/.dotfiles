#!/usr/bin/env bash

wl-paste --type text --watch bash -c '
    if ! wl-paste --list-types | grep -q "x-kde-passwordManagerHint"; then
        cliphist store
    fi
' &

wl-paste --type image --watch cliphist store
