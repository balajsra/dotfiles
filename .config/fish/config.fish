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
# pacman and paru
alias pacsyu='sudo pacman -Syyu' # update only standard pkgs
alias parusua='paru -Sua --noconfirm' # update only AUR pkgs
alias parusyu='paru -Syu --noconfirm' # update standard pkgs and AUR pkgs
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

# ssh fix for kitty terminal
alias ssh="kitty +kitten ssh"

#######
# TTY #
#######
if [ "$TERM" = "linux" ]
    then
    printf %b '\e[40m' '\e[8]' # set default background to color 0 'dracula-bg'
    printf %b '\e[37m' '\e[8]' # set default foreground to color 7 'dracula-fg'
    printf %b '\e]P0282a36' # redefine 'black'          as 'dracula-bg'
    printf %b '\e]P86272a4' # redefine 'bright-black'   as 'dracula-comment'
    printf %b '\e]P1ff5555' # redefine 'red'            as 'dracula-red'
    printf %b '\e]P9ff7777' # redefine 'bright-red'     as '#ff7777'
    printf %b '\e]P250fa7b' # redefine 'green'          as 'dracula-green'
    printf %b '\e]PA70fa9b' # redefine 'bright-green'   as '#70fa9b'
    printf %b '\e]P3f1fa8c' # redefine 'brown'          as 'dracula-yellow'
    printf %b '\e]PBffb86c' # redefine 'bright-brown'   as 'dracula-orange'
    printf %b '\e]P4bd93f9' # redefine 'blue'           as 'dracula-purple'
    printf %b '\e]PCcfa9ff' # redefine 'bright-blue'    as '#cfa9ff'
    printf %b '\e]P5ff79c6' # redefine 'magenta'        as 'dracula-pink'
    printf %b '\e]PDff88e8' # redefine 'bright-magenta' as '#ff88e8'
    printf %b '\e]P68be9fd' # redefine 'cyan'           as 'dracula-cyan'
    printf %b '\e]PE97e2ff' # redefine 'bright-cyan'    as '#97e2ff'
    printf %b '\e]P7f8f8f2' # redefine 'white'          as 'dracula-fg'
    printf %b '\e]PFffffff' # redefine 'bright-white'   as '#ffffff'
    clear
end

##########
# PROMPT #
##########
# Starship Prompt
starship init fish | source
