#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Activate git tab completion
source /usr/share/bash-completion/completions/git

# Scrot will per default use select mode and save in specified directory
alias scrot=$'scrot -s \'%Y-%m-%d_$w$h.png\' -e \'mv $f ~/imgs/screenshots/\''

# Enable Less syntax highlighting using source-highlight package
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
