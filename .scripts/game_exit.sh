#!/bin/bash
/home/sravan/.scripts/deadd.sh --unpause
/home/sravan/.scripts/cpu-gpu.sh --gpu-profile-adaptive
/usr/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s false
