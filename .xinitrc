#########################
# ENVIRONMENT VARIABLES #
#########################
export TERM=xterm-256color           # Sets the terminal type
export SHELL=/usr/bin/fish           # Preferred shell
export EDITOR="code -w"              # Default editor
export BROWSER=brave                 # Web Browser
export XDG_CONFIG_HOME=$HOME/.config # Set Config directory
export QT_QPA_PLATFORMTHEME=gtk2     # QGtkStyle

###########
# STARTUP #
###########
xrdb ~/.Xresources

##################
# WINDOW MANAGER #
##################
exec dwm
