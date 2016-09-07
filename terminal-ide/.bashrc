###################################
#                                 #
# Terminal IDE ~/.bashrc ver 1.2  #
#                                 #
# Feb 1 2012                      #
#                                 #
###################################

#Your HOSTNAME is set to your ip, but you can change it here
export HOSTNAME=cakeTab

# Set up some environment variables
# These are here more for explanation. No need to change them.
# DO NOT REMOVE
export IDESYSTEM=$HOME/system
export TERMINFO=$IDESYSTEM/etc/terminfo
export TEMP=$HOME/tmp
export TMPDIR=$TEMP
export ODEX_FOLDER=$TEMP
export SHELL=$IDESYSTEM/bin/bash
export MC_DATADIR=$IDESYSTEM/etc/mc
export VIMRUNTIME=$IDESYSTEM/etc/vim
export EDITOR=vim

#Check if we are running over telnet or ssh
#This variable is set in the telnetd script
if [ "$TELNET_ON" = yes ]
then
    #Change a few things
    #you may need to set a different TERM value
    #export TERM=xterm

    #Need to resize the screen
    resize
fi

#Some default values - this used by telnetd
export TELNET_PORT=8080

#HISTORY
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
#HISTFILESIZE=2000
HISTFILE=$HOME/.bash_history
#Reload the history - as bash original starts from wrong home dir..
history -r

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
color_prompt=yes

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]terminal\[\e[1;31m\]++\[\e[1;33m\]@\[\e[1;35m\]$HOSTNAME\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
    #OR Super Simple
    #PS1=#
fi
unset color_prompt

# Some aliases
alias ll='ls -l'
alias la='ls -la'
alias mmkdir='mkdir -m 770 -p'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Jump to the HOME folder
cd $HOME


export GIT_SSH=/data/data/com.spartacusrex.spartacuside/files/sssh

alias ls='ls --color=auto'

# alias git_graph_local="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)\' --abbrev-commit --date=relative"
# alias git_graph_all="git log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)\' --abbrev-commit --date=relative"
# alias git_graph_all_with_timestamp="git log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(bold white)— %an%C(reset)' --abbrev-commit"
# alias gt=git_graph_local
# alias gta=git_graph_all

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gs='git status'
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash --patch'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcl='git clone'
alias gd='git diff'
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

alias gdl='git pull'
alias gcm='git commit -am'
alias gup='git push'
