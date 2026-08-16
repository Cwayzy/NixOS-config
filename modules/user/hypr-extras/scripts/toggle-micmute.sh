#!/bin/bash
set -euo pipefail
SOURCE_IDS=$(wpctl status | awk '
  /^Audio/ { in_audio=1 }
  /^Video/ { in_audio=0 }
  in_audio && /Sources:/ { in_sources=1; next }
  in_audio && /Sink endpoints:|Source endpoints:|Filters:|Streams:|Sinks:/ { in_sources=0 }
  in_audio && in_sources && /^\s*[│├└]/ {
    match($0, /[0-9]+\./, arr)
    if (arr[0] != "") print substr(arr[0], 1, length(arr[0])-1)
  }
')
if [[ -z "$SOURCE_IDS" ]]; then
  echo "No sources found."
  exit 1
fi
while read -r id; do
  wpctl set-mute "$id" toggle
done <<<"$SOURCE_IDS"
