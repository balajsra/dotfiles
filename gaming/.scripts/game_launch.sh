#!/usr/bin/env bash
if [ $XDG_SESSION_DESKTOP == "dwm" ]; then
    $HOME/.scripts/picom.sh --off &
    /usr/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s true &
fi

if [ $XDG_SESSION_DESKTOP == "Hyprland" ]; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0" &
fi

$HOME/.scripts/cpu-gpu.sh --cpu-profile-performance &
$HOME/.scripts/cpu-gpu.sh --gpu-profile-performance &
$HOME/.scripts/dunst.sh --pause &
