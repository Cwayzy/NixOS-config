#!/bin/bash
et -euo pipefail

SINK_IDS=$(wpctl status | awk '
  /Sinks:/ { in_sinks=1; next }
  /Sources:|Sink endpoints:|Source endpoints:|Filters:|Streams:/ { in_sinks=0 }
  in_sinks && /^\s*[│├└]/ {
    match($0, /[0-9]+\./, arr)
    if (arr[0] != "") print substr(arr[0], 1, length(arr[0])-1)
  }
')

if [[ -z "$SINK_IDS" ]]; then
  echo "No sinks found."
  exit 1
fi

while read -r id; do
  wpctl set-mute "$id" toggle
done <<<"$SINK_IDS"
