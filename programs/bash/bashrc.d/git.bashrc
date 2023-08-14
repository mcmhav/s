#!/usr/bin/env bash

export PATH=$PATH:"$CSYS_BASH_HOME/bashrc.d/gitbin"

# bins start
alias gt=git_graph_local
alias gta=git_graph_all
alias gtat=git_graph_all_with_timestamp
alias gl7c=get_get_my_7days_last_commits
alias gplb=git_purge_local_branches
alias gtloc=git_line_count
alias gnb='makeNewRemoteAAndLocalBranch'
alias gnt='makeNewRemoteAAndLocalTag'
alias gdb='deleteRemoteAndLocalBranch'
alias gdt='deleteRemoteAndLocalTag'
# bins end

alias g='git'
alias gco='git checkout'
alias ga='git add'
alias gaa='git add --all'
alias gs='git status --short --branch'
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash --patch'
alias gc='git commit'
alias gca='git commit --amend'
alias gacf='gaa && gca --no-edit && gup -f'
alias gcl='git clone'
alias gd=git_diff
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gd0='git diff HEAD~1 HEAD'
alias gd1='git diff HEAD~2 HEAD~1'
alias gd2='git diff HEAD~3 HEAD~2'
alias gd3='git diff HEAD~4 HEAD~3'
alias gd4='git diff HEAD~5 HEAD~4'
alias gd5='git diff HEAD~6 HEAD~5'
alias gf='git fetch'
alias gm='git merge'
alias grm='git rm'
alias guc='git reset --soft HEAD^'
alias grh='git reset HEAD'
alias gb='git branch'
alias gg='git grep'
alias gmv='git mv'
alias gdl='git pull --no-edit'
alias gup='git push'
alias gupf='git push -f'
alias gcm='gaa && git commit -am'
alias gl='git log --oneline'

alias guia='git update-index --assume-unchanged'
alias guina='git update-index --no-assume-unchanged'
