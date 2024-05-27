#!/usr/bin/env bash
export TERM=xterm-256color            # Sets the terminal type
export SHELL=/bin/fish                # Preferred shell
export EDITOR="emacs"                 # Default editor
export GIT_EDITOR="emacs"             # Default git editor
export BROWSER=vivaldi-stable         # Web Browser
export XDG_CONFIG_HOME=$HOME/.config  # Set Config directory
export QT_QPA_PLATFORMTHEME=qt5ct     # QGtkStyle
export _JAVA_AWT_WM_NONREPARENTING=1  # Java fix for Window Managers

xrdb ~/.Xresources

# Startup Applications
/home/sravan/.scripts/startup.sh --kill-startup &&
    /home/sravan/.scripts/startup.sh --startup

# Delayed Startup Applications
(sleep 5 &&
    /home/sravan/.scripts/startup.sh --kill-delay &&
    /home/sravan/.scripts/startup.sh --delay) &

exec dwm
