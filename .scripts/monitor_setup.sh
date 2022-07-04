#!/bin/bash
xrandr \
    --output DP-0 --primary --mode 2560x1440 --pos 0x0 --rate 164.96 \
    --output HDMI-0 --mode 2560x1440 --pos 2560x0 --rate 143.93 \
    --output eDP-1-1 --mode 1920x1080 --pos 5120x1440 --rate 144.00
