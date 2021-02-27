#!/bin/bash

/usr/bin/dunst -config ~/.config/dunst/dunstrc \
    -geometry "0x0-$(xgetres dunst.geometry-x)+$(xgetres dunst.geometry-y)" \
    -separator_height "$(xgetres dunst.sep-height)" \
    -padding "$(xgetres dunst.padding)" \
    -horizontal_padding "$(xgetres dunst.horiz-padding)" \
    -max_icon_size "$(xgetres dunst.max-icon-size)" \
    -frame_width "$(xgetres dunst.frame-width)" \
    -lb "$(xgetres dunst.low-background)" \
    -lf "$(xgetres dunst.low-foreground)" \
    -lfr "$(xgetres dunst.low-frame)" \
    -nb "$(xgetres dunst.normal-background)" \
    -nf "$(xgetres dunst.normal-foreground)" \
    -nfr "$(xgetres dunst.normal-frame)" \
    -cb "$(xgetres dunst.critical-background)" \
    -cf "$(xgetres dunst.critical-foreground)" \
    -cfr "$(xgetres dunst.critical-frame)"
