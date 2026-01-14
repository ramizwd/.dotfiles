#!/usr/bin/env bash

wl-paste --type text --watch bash -c '
    if ! wl-paste --list-types | grep -q "x-kde-passwordManagerHint"; then
        cliphist -max-items 20 store
    fi
' &

wl-paste --type image --watch cliphist -max-items 20 store
