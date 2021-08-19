#!/bin/bash
declare -a startup_array=(\
    # Background Processes
    "bash /home/sravan/.scripts/deadd.sh --on" \                   # Deadd Notification Center
    "bash /home/sravan/.scripts/picom.sh --on" \                   # Picom Compositor
    "/usr/bin/greenclip daemon" \                                  # Greenclip Clipboard Manager
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" \  # GNOME Polkit Authentication Agent
    "/usr/bin/xss-lock -l -- betterlockscreen --lock" \            # Session Lock Utility
    "/usr/lib/kdeconnectd --replace" \                             # KDE Connect Daemon
    "/usr/bin/redshift -x" \                                       # Redshift Blue Light Filter
)

declare -a kill_startup_array=(\
    # Background Processes
    "killall deadd-notificat" \  # Deadd Notification Center
    "killall picom" \            # Picom Compositor
    "killall greenclip" \        # Greenclip Clipboard Manager
    "killall polkit" \           # GNOME Polkit Authentication Agent
    "killall xss-lock" \         # Session Lock Utility
    "killall kdeconnectd" \      # KDE Connect Daemon
    "killall redshift" \         # Redshift Blue Light Filter
)

declare -a delay_array=(\
    # System Tray Applications
    "/usr/bin/redshift-gtk" \                # Redshift Blue Light Filter
    "/usr/bin/blueman-applet" \              # Blueman Bluetooth Manager
    "/usr/bin/nm-applet" \                   # Network Manager Applet
    "/usr/bin/kdeconnect-indicator" \        # KDE Connect Indicator
    "/usr/bin/flameshot" \                   # Flameshot Screenshot Tool
    "/usr/bin/xfce4-power-manager" \         # XFCE4 Power Manager
    "/usr/bin/volctl" \                      # PulseAudio Volume Control
    "/usr/bin/nyrna" \                       # Nyrna
    # System Restore Processes
    "/usr/bin/autorandr --change --force" \  # Auto restore screen layout
    "/usr/bin/numlockx on" \                 # Enable numlock
)

declare -a kill_delay_array=(\
    # System Tray Applications
    "killall redshift" \              # Redshift Blue Light Filter
    "killall blueman-applet" \        # Blueman Bluetooth Manager
    "killall nm-applet" \             # Network Manager Applet
    "killall kdeconnect-indicator" \  # KDE Connect Indicator
    "killall flameshot" \             # Flameshot Screenshot Tool
    "killall xfce4-power-manager" \   # XFCE4 Power Manager
    "killall volctl" \                # PulseAudio Volume Control
    "killall nyrna" \                 # Nyrna
)


help_menu() {
    echo "Main script to launch and kill startup processes. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        " Launch Startup Processes - startup"
        "羽 Launch Delayed Processes - delay"
        " Kill Startup Processes - kill-startup"
        " Kill Delayed Processes - kill-delay"
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
        --startup)
            for i in "${startup_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --delay)
            for i in "${delay_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --kill-startup)
            for i in "${kill_startup_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --kill-delay)
            for i in "${kill_delay_array[@]}"
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
