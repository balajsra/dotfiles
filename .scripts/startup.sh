#!/bin/bash
declare -a system_array=(\
    # Background Processes
    "bash /home/sravan/.scripts/deadd.sh --on" \                   # Deadd Notification Center
    "bash /home/sravan/.scripts/picom.sh --on" \                   # Picom Compositor
    "greenclip daemon" \                                           # Greenclip Clipboard Manager
    "redshift -x" \                                                # Reset redshift display gamma
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" \  # GNOME Polkit Authentication Agent
    "light-locker --lock-on-suspend --lock-on-lid" \               # Screen lock for lightdm
    "/usr/lib/kdeconnectd --replace" \                             # KDE Connect Daemon
    # System Restore Processes
    "bash /home/sravan/.screenlayout/default.sh" \                 # Restore default screen layout
    "nitrogen --restore" \                                         # Restore wallpaper
    "numlockx on" \                                                # Enable numlock
)

declare -a kill_system_array=(\
    # Background Processes
    "killall deadd-notificat" \  # Deadd Notification Center
    "killall picom" \            # Picom Compositor
    "killall greenclip" \        # Greenclip Clipboard Manager
    "killall redshift" \         # Redshift Blue Light Filter
    "killall polkit" \           # GNOME Polkit Authentication Agent
    "killall light-locker" \     # Screen lock for lightdm
    "killall kdeconnectd" \      # KDE Connect Daemon
)

declare -a apps_array=(\
    # System Tray Applications
    "redshift-gtk" \          # Redshift Blue Light Filter
    "bauh-tray" \             # Bauh Package Management GUI
    "blueman-tray" \          # Blueman Bluetooth Manager
    "nm-applet" \             # Network Manager Applet
    "kdeconnect-indicator" \  # KDE Connect Indicator
    "flameshot" \             # Flameshot Screenshot Tool
    "xfce4-power-manager" \   # XFCE4 Power Manager
    "volctl" \                # PulseAudio Volume Control
)

declare -a kill_apps_array=(\
    # System Tray Applications
    "killall redshift" \              # Redshift Blue Light Filter
    "killall bauh-tray" \             # Bauh Package Management GUI
    "killall blueman-tray" \          # Blueman Bluetooth Manager
    "killall nm-applet" \             # Network Manager Applet
    "killall kdeconnect-indicator" \  # KDE Connect Indicator
    "killall flameshot" \             # Flameshot Screenshot Tool
    "killall xfce4-power-manager" \   # XFCE4 Power Manager
    "killall volctl" \                # PulseAudio Volume Control
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
        " Launch System Processes - system"
        " Launch Tray Applications - apps"
        "ﮊ Kill System Processes - kill-system"
        "ﮊ Kill Tray Applications - kill-apps"
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
        --system)
            for i in "${system_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --apps)
            for i in "${apps_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --kill-system)
            for i in "${kill_system_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --kill-apps)
            for i in "${kill_apps_array[@]}"
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
