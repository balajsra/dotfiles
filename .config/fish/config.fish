# Fish Greeting
set fish_greeting "¸.·´¯`·.´¯`·.¸¸.·´¯`·.¸><(((º>"

# PowerLine Shell
function fish_prompt
    powerline-shell --shell bare $status
end

# Run neofetch when opening terminal (w/ empty line above)
neofetch

# ALIASES
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# EXPORTS
export EDITOR="code -w"
export TERM=xterm-256color
