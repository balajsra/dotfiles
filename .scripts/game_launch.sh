#!/bin/bash
/home/sravan/.scripts/picom.sh --off
/home/sravan/.scripts/cpu-gpu.sh --cpu-profile-performance
/home/sravan/.scripts/cpu-gpu.sh --gpu-profile-performance
/home/sravan/.scripts/deadd.sh --pause
/usr/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s true
