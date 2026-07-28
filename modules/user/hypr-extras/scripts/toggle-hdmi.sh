#!/usr/bin/env bash
# toggle-hdmi.sh
LAPTOP="eDP-1"
EXTERNAL="HDMI-A-1"
STATE_FILE="/tmp/hdmi_mode"

MODE=$(cat "$STATE_FILE" 2>/dev/null || echo "extend")

if [ "$MODE" = "extend" ]; then
  hyprctl eval "hl.monitor({ output = \"$EXTERNAL\", mode = \"preferred\", position = \"auto\", scale = 1, mirror = \"$LAPTOP\" })"
  echo "mirror" >"$STATE_FILE"
  notify-send "Display" "Mirroring to HDMI"
else
  hyprctl eval "hl.monitor({ output = \"$LAPTOP\", mode = \"1920x1080@60\", position = \"0x0\", scale = 1, disabled = false, mirror = \"none\" })"
  hyprctl eval "hl.monitor({ output = \"$EXTERNAL\", mode = \"preferred\", position = \"auto\", scale = 1, disabled = false, mirror = \"none\" })"
  echo "extend" >"$STATE_FILE"
  notify-send "Display" "Extending to HDMI"
fi
