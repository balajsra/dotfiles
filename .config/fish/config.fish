# Fish Greeting
set fish_greeting "¸.·´¯`·.´¯`·.¸¸.·´¯`·.¸><(((º>"

# PowerLine Shell
function fish_prompt
    powerline-shell --shell bare $status
end

# Run neofetch when opening terminal (w/ empty line above)
# neofetch

# Color Scripts
/bin/bash /opt/shell-color-scripts/colorscript.sh -r

# ALIASES
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# EXPORTS
export EDITOR="code -w"
export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config
