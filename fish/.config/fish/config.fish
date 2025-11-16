fish_config theme choose "Dracula_Official"

function fish_greeting
    clear
    krabby random
    echo "¸.·´¯`·.´¯`·.¸¸.·´¯`·.¸><(((º>"
end

set -U fish_user_paths $fish_user_paths $HOME/.local/bin/

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Replace ls and tree with eza
alias ls="eza"
alias tree="eza -T"
alias cat="bat"

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

# Starship Prompt
starship init fish | source

# Dracula theme for Docker BuildKit - https://draculatheme.com/docker
export BUILDKIT_COLORS="run=189,147,249:cancel=241,250,140:error=255,85,85:warning=241,250,140"

# Dracula theme for GNU grep - https://draculatheme.com/grep
export GREP_COLORS="mt=1;38;2;255;85;85:fn=38;2;255;121;198:ln=38;2;80;250;123:bn=38;2;80;250;123:se=38;2;139;233;253"

if status is-interactive
and not set -q TMUX
    tmux new-session
end

direnv hook fish | source
