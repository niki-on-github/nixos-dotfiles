#!/usr/bin/env bash
# Description: Show notification on song change.
# Setup: add `execute_on_song_change = /path/to/notify.sh` to your ncmpcpp config


[ -z "$(mpc status | grep '\[paused\] ')" ] || exit
[ "$(mpc current | wc -c)" -gt "128" ] && exit  # avoid usless notify messages

# workaround for not playing
mpc pause
mpc play

exec notify-send -i "$HOME/.config/ncmpcpp/music-icon.png" "Now Playing" "$(mpc current)"
