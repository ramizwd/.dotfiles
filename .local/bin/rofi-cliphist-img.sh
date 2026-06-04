#!/usr/bin/env bash

tmp_dir="/tmp/cliphist"
rm -rf "$tmp_dir"

mkdir -p "$tmp_dir"

prompt="󰅍   Clipboard"

list=$(cliphist list)

# Check if list is empty
if [[ -z "$list" ]]; then
    echo -e "Clipboard is empty..." | rofi -dmenu -p "$prompt"
    exit
fi


read -r -d '' prog <<EOF
/^[0-9]+\s<meta http-equiv=/ { next }
match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
    system("echo " grp[1] "\\\\\t | cliphist decode >$tmp_dir/"grp[1]"."grp[3])
    print \$0"\0icon\x1f$tmp_dir/"grp[1]"."grp[3]
    next
}
1
EOF

selected="$(cliphist list | gawk "$prog" | rofi -dmenu \
    -sync -i \
    -display-columns 2 \
    -p "$prompt")"

if [[ -n "$selected" ]]; then
    cliphist decode <<< "$selected" | wl-copy
    exit
fi
