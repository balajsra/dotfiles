#!/usr/bin/env bash
help_menu() {
    echo "Script to interact with gammastep. Use only one argument at a time."
}

is_running() {
    if pgrep -x gammastep >/dev/null; then
        echo 1
    else
        echo 0
    fi
}

rofi_menu() {
    declare -a options=(
        "⏼ Toggle - toggle"
        "󱩌 Turn On - on"
        "󱩍 Turn Off - off"
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
                pkill gammastep
            fi

            # Start Gammastep
            /usr/bin/gammastep-indicator &

            notify-send "Turning Gammastep ON" &
            ;;
        --off)
            notify-send "Turning Gammastep OFF" &

            if [ $(is_running) -eq '1' ]; then
                pkill gammastep
            fi
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@
