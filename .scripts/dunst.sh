#!/bin/bash
help_menu() {
    echo "Script to interact with dunst. Use only one argument at a time."
    echo "  - Toggle On/Off:         dunst.sh OR dunst.sh --toggle OR dunst.sh -t"
    echo "  - Turn On:               dunst.sh --on"
    echo "  - Turn Off:              dunst.sh --off"
    echo "  - Context Menu:          dunst.sh --context"
    echo "  - Close Notification:    dunst.sh --close"
    echo "  - History Pop:           dunst.sh --history"
    echo "  - Toggle Do Not Disturb: dunst.sh --dnd"
    echo "  - Rofi Menu:             dunst.sh --rofi"
    echo "  - Help:                  dunst.sh --help OR dunst.sh -h"
}

is_running() {
    if pgrep -x dunst >/dev/null; then
        echo 1
    else
        echo 0
    fi
}

rofi_menu() {
    declare -a options=(
        "⏼ Toggle - toggle"
        " Turn On - on"
        " Turn Off - off"
        " Open Actions - context"
        " Close Notification - close"
        " View History - history"
        " Toggle Do Not Disturb - dnd"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" != "quit" ]]; then
        main "--$option" && main "--rofi"
    fi
}

main() {
    if [ $# -eq 0 ]; then
        # No arguments
        help_menu
    else
        case $1 in
        --help | -h)
            help_menu
            ;;
        --toggle)
            if [ $(is_running) -eq '1' ]; then
                main --off
            else
                main --on
            fi
            ;;
        --on)
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

            if [ $(is_running) -eq '1' ]; then
                killall dunst
            fi

            # Start Dunst
            /usr/bin/dunst -config $config \
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
                           -cfr "$cfr" &

            notify-send "Turning Dunst ON"
            ;;
        --off)
            notify-send "Turning Dunst OFF"

            if [ $(is_running) -eq '1' ]; then
                killall dunst
            fi
            ;;
        --context)
            dunstctl context
            ;;
        --close)
            dunstctl close
            ;;
        --history)
            dunstctl history-pop
            ;;
        --dnd)
            dunstctl set-paused toggle
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@
