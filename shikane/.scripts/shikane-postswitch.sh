#!/usr/bin/env bash
if [ $XDG_SESSION_DESKTOP == "Hyprland" ]; then
    hyprctl reload
fi

systemctl --user restart waybar.service
$HOME/.scripts/gammastep.sh --on
waypaper --restore
