#!/usr/bin/env sh

# WM Integation:
# - i3wm: add 'no_focus [instance="no-focus"]' to your i3 config
# - dwm: set noswallow=0 or nofocus=1 for class='no-focus'
# - xmonad: add 'className =? "no-focus" --> doF W.focusDown' to your windowRules in xmonad.hs config

# Link Handler Script FileType:
# - video, music) view in mpv
# - otherwise) open link in browser


[ -z "$1" ] && { "$BROWSER" --class "no-focus"; exit; }

case "$1" in
	*youtube.com/watch*|*youtube.com/playlist*|*youtu.be*|*hooktube.com*|*bitchute.com*|*webm)
		setsid mpv --x11-name="no-focus" --title="no-focus" --pause --profile=youtube --ytdl-format="bestvideo[height<=?720]+bestaudio[ext=m4a]" --speed=1.8 "$1" >/dev/null 2>&1 & ;;
	*)
        setsid $BROWSER --class "no-focus" "$1" >/dev/null 2>&1 &
esac

sleep 0.5

if [ "$(basename $XDG_CURRENT_DESKTOP)" = "Hyprland" ]; then
    hyprctl dispatch focuswindow "title:^.*(newsboat).*$"
else
    wmctrl -a newsboat
fi

exit 0
