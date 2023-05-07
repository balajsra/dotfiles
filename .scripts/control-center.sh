#!/bin/bash
help_menu() {
    echo "Main script to launch sub-menu scripts. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        "󱕅 Compositor - picom"
        "󰍹 Display - brightness"
        "󰂚 Notifications - deadd"
        " Media - playerctl"
        "󰕾 Volume - pactl"
        "󰁯 Backup - backup"
        " Startup Processes - startup"
        " Hardware - cpu-gpu"
        " Gaming - gaming"
        " Power Menu - session"
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
        --picom)
            /home/sravan/.scripts/picom.sh --rofi
            ;;
        --brightness)
            /home/sravan/.scripts/brightness.sh --rofi
            ;;
        --deadd)
            /home/sravan/.scripts/deadd.sh --rofi
            ;;
        --playerctl)
            /home/sravan/.scripts/playerctl.sh --rofi
            ;;
        --pactl)
            /home/sravan/.scripts/pactl.sh --rofi
            ;;
        --backup)
            /home/sravan/.scripts/backup.sh --rofi
            ;;
        --startup)
            /home/sravan/.scripts/startup.sh --rofi
            ;;
        --cpu-gpu)
            /home/sravan/.scripts/cpu-gpu.sh --rofi
            ;;
        --gaming)
            /home/sravan/.scripts/gaming.sh --rofi
            ;;
        --session)
            /home/sravan/.scripts/session.sh --rofi
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@
