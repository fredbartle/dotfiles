#!/bin/bash

R=$'\e[0;31m'   # red
G=$'\e[0;32m'   # green
Y=$'\e[0;33m'   # yellow
B=$'\e[0;34m'   # blue
M=$'\e[0;35m'   # magenta
C=$'\e[0;36m'   # cyan
W=$'\e[0;37m'   # white
D=$'\e[0m'      # clear

# source .bash_git_dirty
git_dirty() {
    git_status="$(git status 2> /dev/null)"
    branch_pattern="On branch ([^${IFS}]*)"
    remote_pattern="Your branch is (.*) of"
    diverge_pattern="Your branch and (.*) have diverged"
    if [[ ! ${git_status} =~ "working directory clean" ]]; then
        state="${R}⚡"
    else
        state="${G}✓"
    fi
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
            remote="${Y}↑"
        else
            remote="${Y}↓"
        fi
    fi
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="${Y}↕"
    fi
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
        echo "${remote}${state}${D}"
    fi
}

stty -ixon -ixoff

alias ls='ls -F'
alias fetch='curl -O'
alias vi='vim -v'
alias vim='vim -v'
alias tmux='TERM=screen-256color-bce tmux'

source /usr/local/etc/bash_completion/git-completion.bash
source /usr/local/etc/bash_completion/git-prompt.sh

export CLICOLOR=1
export EDITOR=vim

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export PS1='${M}\u${D}@${Y}\h ${R}\t${D} ${G}\w${D} $(__git_ps1 "Git(${B}%s${D})$(git_dirty)")\n$ '
