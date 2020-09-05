###############
# FISH PROMPT #
###############
# Color Scripts
/bin/bash /opt/shell-color-scripts/colorscript.sh -r

###########
# ALIASES #
###########
# dotfiles repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

###########
# EXPORTS #
###########
export EDITOR="code -w"
export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config

############################
# BOBTHEFISH CONFIGURATION #
############################
# Git
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes

# Fonts
set -g theme_nerd_fonts yes

# Prompt
set -g theme_display_user yes
set -g fish_prompt_pwd_dir_length 0
set -g theme_newline_cursor yes
set -g theme_title_display_process yes
set -g theme_title_display_user yes
set -g theme_display_hostname yes

# Theme
set -g theme_color_scheme dracula

# Python
set -g theme_display_virtualenv yes
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
