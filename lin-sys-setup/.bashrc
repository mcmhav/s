#!/usr/bin/env bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/shrc ] && . /etc/shrc

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# alias ls='ls -G'

bashCWD="$HOME/r/s/lin-sys-setup"

# adding extra sources
source "$bashCWD"/bashrc/.bashCommandrc;
source "$bashCWD"/bashrc/.bashAwesomerc;
source "$bashCWD"/bashrc/.bashSetuprc;

source "$bashCWD"/bashrc/.bashGitrc;

source "$bashCWD"/bashrc/.bashWebrc;

connectToPie(){
    piIp='10.0.0.14'
    if [ ! -z "$1" ]; then
        piIp="$1"
    fi
    ssh root@"$piIp"
}

alias pieConnect='connectToPie';

alias cake='sh ~/r/s/lin-sys-setup/.cakeInit.sh'
alias http='python -m http.server'
# alias scron="su -c $(printf "%q " "crontab -u $USER -e")"
alias scron="sudo EDITOR=nano crontab -u $USER -e"
alias xterm="xterm & sleep 0.8s && transset-df -a"

export PATH="/git/tools/bin:${PATH}:$(ruby -rubygems -e "puts Gem.user_dir")/bin:/git/bob"
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules
# export EDITOR=subl3
# export VISUAL=subl3
# export HISTFILESIZE=
# export HISTSIZE=
# export CLASSPATH=.:$CLASSPATH:/home/m/repos/suchBazar/mahout/jars/mahout-mrlegacy-1.0-job.jar

lineCount() {
    find . -name "*.$1" | xargs wc -l
}
calcWork(){
    cwd=$(PWD)
    cd "$bashCWD/../bash/timeLogging" || exit
    ./findStartEnd.sh
    cd "$cwd" || exit
}

updateBashRC(){
    source ~/.bashrc;
}

setScreens() {
    xrandr --output VGA-0 --left-of VGA-1
}

alias http='python -m SimpleHTTPServer 8009'
alias lc=lineCount
alias work=calcWork
alias urcs=updateRCs
alias click='shutter -s'

alias probeNetwork='arp -a'

alias aptUpgrade='sudo apt-get update && sudo apt-get upgrade'
