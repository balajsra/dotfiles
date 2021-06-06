#!/bin/sh
export TERM=xterm-256color           # Sets the terminal type
export SHELL=/usr/bin/fish           # Preferred shell
export EDITOR="emacs"                # Default editor
export GIT_EDITOR="emacs"            # Default git editor
export BROWSER=vivaldi-stable        # Web Browser
export XDG_CONFIG_HOME=$HOME/.config # Set Config directory
export QT_QPA_PLATFORMTHEME=qt5ct    # QGtkStyle

xrdb ~/.Xresources

# Background Processes & Daemons
/home/sravan/.scripts/startup.sh --kill-system &&
    /home/sravan/.scripts/startup.sh --system

# System Tray Applications
# start with a delay so window manager can load first
(sleep 5 &&
    /home/sravan/.scripts/startup.sh --kill-apps &&
    /home/sravan/.scripts/startup.sh --apps) &

exec xmonad
