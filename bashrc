#!/bin/sh

source /usr/share/git/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=enabled
export GIT_PS1_SHOWUPSTREAM=enabled
PS1='\W$(__git_ps1 " (%s)") > '

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

alias ls='ls --color=auto'

export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

