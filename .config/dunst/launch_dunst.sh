#!/bin/bash

# Get values from Xresources
config=~/.config/dunst/dunstrc
geometry_x=$(xgetres dunst.geometry-x)
geometry_y=$(xgetres dunst.geometry-y)
separator_height=$(xgetres dunst.sep-height)
padding=$(xgetres dunst.padding)
horizontal_padding=$(xgetres dunst.horiz-padding)
max_icon_size=$(xgetres dunst.max-icon-size)
frame_width=$(xgetres dunst.frame-width)
lb=$(xgetres dunst.low-background)
lf=$(xgetres dunst.low-foreground)
lfr=$(xgetres dunst.low-frame)
nb=$(xgetres dunst.normal-background)
nf=$(xgetres dunst.normal-foreground)
nfr=$(xgetres dunst.normal-frame)
cb=$(xgetres dunst.critical-background)
cf=$(xgetres dunst.critical-foreground)
cfr=$(xgetres dunst.critical-frame)

# Kill and running dunst instances and start
killall dunst;/usr/bin/dunst -config $config \
    -geometry "0x0-$geometry_x+$geometry_y" \
    -separator_height "$separator_height" \
    -padding "$padding" \
    -horizontal_padding "$horizontal_padding" \
    -max_icon_size "$max_icon_size" \
    -frame_width "$frame_width" \
    -lb "$lb" \
    -lf "$lf" \
    -lfr "$lfr" \
    -nb "$nb" \
    -nf "$nf" \
    -nfr "$nfr" \
    -cb "$cb" \
    -cf "$cf" \
    -cfr "$cfr"
