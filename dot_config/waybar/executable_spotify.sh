#!/bin/bash

# Dependencies: playerctl, jq

# Get artist and title
artist=$(playerctl -p spotify metadata xesam:artist 2>/dev/null)
title=$(playerctl -p spotify metadata xesam:title 2>/dev/null)
length=$(playerctl -p spotify metadata mpris:length 2>/dev/null) # microseconds
position=$(playerctl -p spotify position 2>/dev/null)            # seconds

if [[ -z "$artist" && -z "$title" ]]; then
  echo '{"text": "  No song", "class": "progress-0"}'
  exit 0
fi

# Convert length to seconds
if [[ -n "$length" && "$length" != "0" ]]; then
  length_sec=$((length / 1000000))
else
  length_sec=0
fi

# Remove decimals from position
position_sec=${position%.*}
if [[ -z "$position_sec" ]]; then
  position_sec=0
fi

if (( length_sec == 0 )); then
  percent=0
else
  percent=$((position_sec * 100 / length_sec))
  # Clamp value
  [[ $percent -lt 0 ]] && percent=0
  [[ $percent -gt 100 ]] && percent=100
fi

# Output JSON for Waybar
echo "{\"text\": \"$artist - $title\", \"class\": \"progress-$percent\"}"