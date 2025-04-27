#!/usr/bin/env bash
export TERM=xterm-256color            # Sets the terminal type
export EDITOR="emacs"                 # Default editor
export GIT_EDITOR="emacs"             # Default git editor
export BROWSER=vivaldi-stable         # Web Browser
export XDG_CONFIG_HOME=$HOME/.config  # Set Config directory
export QT_QPA_PLATFORMTHEME=qt6ct     # QGtkStyle
export _JAVA_AWT_WM_NONREPARENTING=1  # Java fix for Window Managers

xrdb ~/.Xresources

# Startup Applications
$HOME/.scripts/x11-startup.sh --kill-startup &&
    $HOME/.scripts/x11-startup.sh --startup

# Delayed Startup Applications
(sleep 5 &&
    $HOME/.scripts/x11-startup.sh --kill-delay &&
    $HOME/.scripts/x11-startup.sh --delay) &

exec dwm
