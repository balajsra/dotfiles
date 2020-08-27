# Color Scripts
/bin/bash /opt/shell-color-scripts/colorscript.sh -r

# ALIASES
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# EXPORTS
export EDITOR="code -w"
export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config

# bobthefish Configuration
set -g theme_nerd_fonts yes
set -g theme_display_user yes
set -g fish_prompt_pwd_dir_length 0
set -g theme_color_scheme dracula
set -g theme_newline_cursor yes