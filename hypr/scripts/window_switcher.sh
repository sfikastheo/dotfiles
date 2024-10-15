#!/usr/bin/env bash

format='"\(.address) | \(.title) >> \(.class)"'
windows=$(hyprctl clients -j | jq -r ".[] | $format")
window=$(echo "$windows" | rofi -dmenu -p '' -theme $ROFI/launch/dmenu.rasi --matching normal -i)

if [[ -z "$window" ]]; then
    echo "$NOTHING_DO_MESSAGE"
    exit 0
fi

address=$(echo "$window" | cut -d '|' -f 1 | xargs)
echo "$address"

if [[ -z "$address" ]]; then
    echo "$NOTHING_DO_MESSAGE"
    exit 0
else
    hyprctl dispatch focuswindow address:$address
fi

