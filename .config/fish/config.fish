########################
# AUTOSTART X AT LOGIN #
########################
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

############
# GREETING #
############
function fish_greeting
    # Indices of colorscripts that don't block prompt
    set colorscript_indices 2 3 5 6 7 13 14 15 16 17 18 19 20 21 22 23 25 26 27 28 29 30 31 36 37 38 39 40 41 43 44 46 47 48 49 50 51
    # Get length of array
    set length (count $colorscript_indices)
    # Randomly select array index
    set i (math (random) % $length + 1)
    # Output randomly selected colorscript from approved list
    colorscript -e $colorscript_indices[$i]
    # Output swimming fish string
    echo "¸.·´¯`·.´¯`·.¸¸.·´¯`·.¸><(((º>"
end

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

##########
# PROMPT #
##########
# Starship Prompt
starship init fish | source
