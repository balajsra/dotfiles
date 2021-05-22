#!/bin/sh
export TERM=xterm-256color           # Sets the terminal type
export SHELL=/usr/bin/fish           # Preferred shell
export EDITOR="emacs -nw"            # Default editor
export BROWSER=vivaldi-stable        # Web Browser
export XDG_CONFIG_HOME=$HOME/.config # Set Config directory
export QT_QPA_PLATFORMTHEME=qt5ct    # QGtkStyle

xrdb ~/.Xresources

/home/sravan/.scripts/startup.sh --start

exec xmonad
