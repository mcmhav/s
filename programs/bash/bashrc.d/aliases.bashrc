#!/usr/bin/env bash

if [ -x /usr/bin/dircolors ] || [ "$(uname -s)" == "Darwin" ]; then
  if [ "$(uname -s)" == "Linux" ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
  elif [ "$(uname -s)" == "Darwin" ]; then
    alias ls='ls -G'
  else
    alias ls='ls --color=auto'
  fi
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias less='less -r'
fi

if command -v bat 1>/dev/null 2>&1; then
  alias cat='bat'
  alias less='bat'
fi

if command -v btm 1>/dev/null 2>&1; then
  alias top='btm'
fi

if command -v watch 1>/dev/null 2>&1; then
  alias watch='watch --color'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# loggs
alias logginfo='loggit info'
alias loggwarn='loggit warn'
alias loggerrr='loggit errr'

alias click='shutter -s'

alias probeNetwork='arp -a'

alias space='du -h -d 2 | sort -n'

alias updateBashRC='source ~/.bashrc'

alias :q='exit'

if command -v nvim 1>/dev/null 2>&1; then
  alias vim='nvim'
fi

alias ..='cd ..'
alias ...='cd ../..'
