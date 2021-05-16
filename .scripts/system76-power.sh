#!/bin/bash
help_menu() {
    echo "Script to interact with system76-power. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        " Switchable Graphics - rofi-graphics"
        " Performance Profile - rofi-profile"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" != "quit" ]]; then
        main "--$option" && main "--rofi"
    fi
}

rofi_graphics_menu() {
    declare -a options=(
        "Query Current Graphics - graphics-query"
        "Switch to Compute Mode - graphics-compute"
        "Switch to Hybrid Mode - graphics-hybrid"
        "Switch to Integrated Mode - graphics-integrated"
        "Switch to Nvidia Mode - graphics-nvidia"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" != "quit" ]]; then
        main "--$option" && main "--rofi-graphics"
    fi
}

rofi_profile_menu() {
    declare -a options=(
        "Query Current Profile - profile-query"
        "Switch to Battery Mode - profile-battery"
        "Switch to Balanced Mode - profile-balanced"
        "Switch to Performance Mode - profile-performance"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" != "quit" ]]; then
        main "--$option" && main "--rofi-profile"
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
        --rofi-graphics)
            rofi_graphics_menu
            ;;
        --graphics-query)
            current_graphics=$(pkexec system76-power graphics)
            notify-send "System76-Power Graphics" "$current_graphics"
            ;;
        --graphics-compute)
            notify-send "System76-Power Graphics" "Switching to Compute Graphics..."
            pkexec system76-power graphics compute
            notify-send -u critical -t 0 "System76-Power Graphics" "Please restart computer to switch graphics"
            ;;
        --graphics-hybrid)
            notify-send "System76-Power Graphics" "Switching to Hybrid Graphics..."
            pkexec system76-power graphics hybrid
            notify-send -u critical -t 0 "System76-Power Graphics" "Please restart computer to switch graphics"
            ;;
        --graphics-integrated)
            notify-send "System76-Power Graphics" "Switching to Integrated Graphics..."
            pkexec system76-power graphics integrated
            notify-send -u critical -t 0 "System76-Power Graphics" "Please restart computer to switch graphics"
            ;;
        --graphics-nvidia)
            notify-send "System76-Power Graphics" "Switching to Nvidia Graphics..."
            pkexec system76-power graphics nvidia
            notify-send -u critical -t 0 "System76-Power Graphics" "Please restart computer to switch graphics"
            ;;
        --rofi-profile)
            rofi_profile_menu
            ;;
        --profile-query)
            current_profile=$(pkexec system76-power profile)
            notify-send "System76-Power Profile" "$current_profile"
            ;;
        --profile-battery)
            pkexec system76-power profile battery
            notify-send "System76-Power Profile" "Switched to Battery Profile"
            ;;
        --profile-balanced)
            pkexec system76-power profile balanced
            notify-send "System76-Power Profile" "Switched to Balanced Profile"
            ;;
        --profile-performance)
            pkexec system76-power profile performance
            notify-send "System76-Power Profile" "Switched to Performance Profile"
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@
