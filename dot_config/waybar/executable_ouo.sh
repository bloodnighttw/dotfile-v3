#!/bin/bash

# Paths
cache_dir="$HOME/.cache/waybar"
album_png="$cache_dir/album.png"
url_cache="$cache_dir/spotify_album_url.txt"

mkdir -p "$cache_dir"

# Get current art URL
arturl=$(playerctl --player=spotify metadata mpris:artUrl 2>/dev/null)

# Read last URL
lasturl=""
if [[ -f "$url_cache" ]]; then
    lasturl=$(cat "$url_cache")
fi

# Only download or copy if the URL changed
if [[ "$arturl" != "$lasturl" ]]; then
    if [[ "$arturl" =~ ^file:// ]]; then
        cp "${arturl#file://}" "$album_png"
    elif [[ "$arturl" =~ ^http ]]; then
        wget -qO "$album_png" "$arturl"
    fi
    echo "$arturl" > "$url_cache"
fi

# echo the album art path
echo "$album_png"