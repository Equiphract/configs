#!/bin/sh
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ ! "$TERM" = "linux" ]]; then
    source /usr/share/git/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=enabled
    export GIT_PS1_SHOWUPSTREAM=enabled
    PS1='\W$(__git_ps1 " (%s)") › '
fi

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

alias ls='ls --color=auto'

alias poweroff='doas /sbin/poweroff'
alias reboot='doas /sbin/reboot'

complete -F _root_command doas

