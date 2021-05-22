#!/bin/bash
declare -a start_array=(\
    # System Restore Processes
    "bash /home/sravan/.screenlayout/default.sh" \                 # Restore default screen layout
    "nitrogen --restore" \                                         # Restore wallpaper
    "numlockx on" \                                                # Enable numlock
    # System Tray Applications
    "nyrna" \                                                      # Nyrna Application Suspend
    "blueman-tray" \                                               # Blueman Bluetooth Manager
    "nm-applet" \                                                  # Network Manager Applet
    "kdeconnect-indicator" \                                       # KDE Connect
    "flameshot" \                                                  # Flameshot Screenshot Tool
    "xfce4-power-manager" \                                        # XFCE4 Power Manager
    # Background Processes
    "bash /home/sravan/.scripts/picom.sh --on" \                   # Picom Compositor
    "bash /home/sravan/.scripts/dunst.sh --on" \                   # Dunst Notification Daemon
    "greenclip daemon" \                                           # Greenclip Clipboard Manager
    "redshift -x" \                                                # Reset redshift display gamma
    "redshift-gtk" \                                               # Redshift Blue Light Filter
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" \  # GNOME Polkit Authentication Agent
    "light-locker --lock-on-suspend --lock-on-lid" \               # screen lock for lightdm
)

declare -a kill_array=(\
    # System Tray Applications
    "pkill nyrna" \                                # Nyrna Application Suspend
    "pkill blueman-tray" \                         # Blueman Bluetooth Manager
    "pkill nm-applet" \                            # Network Manager Applet
    "pkill kdeconnect-indicator" \                 # KDE Connect
    "pkill flameshot" \                            # Flameshot Screenshot Tool
    "pkill xfce4-power-manager" \                  # XFCE4 Power Manager
    # Background Processes
    "bash /home/sravan/.scripts/picom.sh --off" \  # Picom Compositor
    "bash /home/sravan/.scripts/dunst.sh --off" \  # Dunst Notification Daemon
    "pkill greenclip" \                            # Greenclip Clipboard Manager
    "pkill redshift" \                             # Redshift Blue Light Filter
    "pkill polkit" \                               # GNOME Polkit Authentication Agent
    "pkill light-locker" \                         # screen lock for lightdm
)

help_menu() {
    echo "Main script to launch and kill autostart processes & applications. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        " Launch Autostart Processes - start"
        "ﮊ Kill Autostart Processes - kill"
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
        --start)
            main "--kill"

            # Run applications (ignore if they don't exist)
            for i in "${start_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --kill)
            # Kill applications (ignore if they don't exist)
            for i in "${kill_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@
