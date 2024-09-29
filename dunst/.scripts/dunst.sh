#!/usr/bin/env bash
help_menu() {
    echo "Script to interact with dunst. Use only one argument at a time."
    echo "  - Toggle On/Off:           dunst.sh OR dunst.sh --toggle OR dunst.sh -t"
    echo "  - Turn On:                 dunst.sh --on"
    echo "  - Turn Off:                dunst.sh --off"
    echo "  - Context Menu:            dunst.sh --context"
    echo "  - Close Notification:      dunst.sh --close"
    echo "  - Close All Notifications: dunst.sh --close-all"
    echo "  - History Pop:             dunst.sh --history"
    echo "  - History Clear:           dunst.sh --history-clear"
    echo "  - Toggle Do Not Disturb:   dunst.sh --dnd"
    echo "  - Pause Notifications:     dunst.sh --pause"
    echo "  - Unpause Notifications:   dunst.sh --unpause"
    echo "  - Rofi Menu:               dunst.sh --rofi"
    echo "  - Help:                    dunst.sh --help OR dunst.sh -h"
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
        "󰂞 Turn On - on"
        "󰂛 Turn Off - off"
        "󱨩 Open Actions - context"
        " Close Notification - close"
        " Close All Notifications - close-all"
        " View History - history"
        "󰎟 Clear History - history-clear"
        "󰂠 Toggle Do Not Disturb - dnd"
        " Pause Popup Notifications - pause"
        " Unpause Popup Notifications - unpause"
        "󰌍 Back - back"
        "󰗼 Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        pkill rofi
    elif [[ "$option" != "back" ]]; then
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
            if [ $(is_running) -eq '1' ]; then
                pkill dunst
            fi

            # Start Dunst
            /usr/bin/dunst -config ~/.config/dunst/dunstrc &

            notify-send "Turning Dunst ON" &
            ;;
        --off)
            notify-send "Turning Dunst OFF" &

            if [ $(is_running) -eq '1' ]; then
                pkill dunst
            fi
            ;;
        --context)
            dunstctl context
            ;;
        --close)
            dunstctl close
            ;;
        --close-all)
            dunstctl close-all
            ;;
        --history)
            dunstctl history-pop
            ;;
        --history-clear)
            dunstctl history-clear
            ;;
        --dnd)
            dunstctl set-paused toggle
            ;;
        --pause)
            dunstctl set-paused true
            ;;
        --unpause)
            dunstctl set-paused false
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@
