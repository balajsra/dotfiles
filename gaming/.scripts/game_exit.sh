#!/usr/bin/env bash
if [ $XDG_SESSION_DESKTOP == "dwm" ]; then
    $HOME/.scripts/picom.sh --on &
    /usr/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s false &
fi

$HOME/.scripts/dunst.sh --unpause &
$HOME/.scripts/cpu-gpu.sh --cpu-profile-balanced &
$HOME/.scripts/cpu-gpu.sh --gpu-profile-adaptive &
