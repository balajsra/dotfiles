#!/usr/bin/env bash
if [ $XDG_SESSION_DESKTOP == "dwm" ]; then
    $HOME/.scripts/picom.sh --off &
    /usr/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s true &
fi

$HOME/.scripts/cpu-gpu.sh --cpu-profile-performance &
$HOME/.scripts/cpu-gpu.sh --gpu-profile-performance &
$HOME/.scripts/dunst.sh --pause &
