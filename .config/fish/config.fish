############
# GREETING #
############
/opt/shell-color-scripts/colorscript.sh random # Color Scripts
set fish_greeting "¸.·´¯`·.´¯`·.¸¸.·´¯`·.¸><(((º>" # Fish Greeting

#############
# VARIABLES #
#############
set -U fish_user_paths $fish_user_paths $HOME/.local/bin/

###########
# ALIASES #
###########
# pacman and yay
alias pacsyu='sudo pacman -Syyu' # update only standard pkgs
alias yaysua='yay -Sua --noconfirm' # update only AUR pkgs
alias yaysyu='yay -Syu --noconfirm' # update standard pkgs and AUR pkgs
alias unlock='sudo rm /var/lib/pacman/db.lck' # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)' # remove orphaned packages

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# bare git repo alias for dotfiles
alias config="GIT_WORK_TREE=~ GIT_DIR=~/.cfg"

###############
# FISH PROMPT #
###############
# Starship Prompt
starship init fish | source
