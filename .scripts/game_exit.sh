#!/usr/bin/env bash
/home/sravan/.scripts/picom.sh --on &
/home/sravan/.scripts/deadd.sh --unpause &
/home/sravan/.scripts/cpu-gpu.sh --cpu-profile-balanced &
/home/sravan/.scripts/cpu-gpu.sh --gpu-profile-adaptive &
/usr/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s false &
