#!/usr/bin/env bash
help_menu() {
    echo "Script to run common gentoo specific actions."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        "󰚰 Sync and Update Packages - sync-update"
        " Remove Obsolete Packages - depclean"
        " Update Package Configuration Files - conf-update"
        " Update Kernel Config - update-kernel"
        " Remove Old Kernels - clean-kernel"
        "󱋆 Update Grub Configuration - grub-update"
        " Spice Up Spotify - spicetify"
        "󰌍 Back - back"
        "󰗼 Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        pkill rofi
    elif [[ "$option" != "back" ]]; then
        main "--$option" && pkill rofi
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
        --sync-update)
            notify-send "Gentoo" "Syncing and Updating Packages" &
            uwsm app -- foot -H sudo ${HOME}/.scripts/.gentoo_sync_and_update_packages.sh
            ;;
        --depclean)
            notify-send "Gentoo" "Removing Obsolete Packages" &
            uwsm app -- foot -H sudo emerge --depclean
            ;;
        --conf-update)
            notify-send "Gentoo" "Updating Configuration Files" &
            uwsm app -- foot -H sudo dispatch-conf
            ;;
        --update-kernel)
            notify-send "Gentoo" "Updating Kernel Configuration" &
            uwsm app -- foot -H sudo ${HOME}/.scripts/.gentoo_update_kernel_config.sh
            ;;
        --clean-kernel)
            notify-send "Gentoo" "Removing Old Kernels" &
            uwsm app -- foot -H sudo eclean-kernel -b grub2 -n 2
            ;;
        --grub-update)
            notify-send "Gentoo" "Updating Grub Configuration" &
            uwsm app -- foot -H sudo grub-mkconfig -o /boot/grub/grub.cfg
            ;;
        --spicetify)
            notify-send "Gentoo" "Spicing Up Spotify" &
            uwsm app -- foot -H sudo ${HOME}/.scripts/.gentoo_spice_up_spotify.sh
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@
