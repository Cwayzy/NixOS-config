#!/usr/bin/env bash

CONFIG="$HOME/.config/waybar/secondBar.json"

if pgrep -f "waybar -c $CONFIG" >/dev/null; then
  pkill -f "waybar -c $CONFIG"
else
  waybar -c "$CONFIG" &
  disown
fi
