#!/usr/bin/env bash
if [ $XDG_SESSION_DESKTOP == "dwm" ]; then
    /home/sravan/.scripts/picom.sh --on &
    /usr/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s false &
fi

/home/sravan/.scripts/dunst.sh --unpause &
/home/sravan/.scripts/cpu-gpu.sh --cpu-profile-balanced &
/home/sravan/.scripts/cpu-gpu.sh --gpu-profile-adaptive &
