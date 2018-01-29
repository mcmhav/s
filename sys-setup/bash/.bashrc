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

bashCWD="$HOME/r/s/sys-setup/bash"

# adding extra sources
source "$bashCWD"/bashrc/.bashCommandrc;
source "$bashCWD"/bashrc/.bashAwesomerc;
source "$bashCWD"/bashrc/.bashSetuprc;
source "$bashCWD"/bashrc/.bashGitrc;
source "$bashCWD"/bashrc/.bashWebrc;
source "$bashCWD"/bashrc/.bashHelperFuncsrc;
if [ "$(uname -s)" == "Linux" ]; then
  source "$bashCWD"/bashrc/.bashLinrc;
elif [ "$(uname -s)" == "Darwin" ]; then
  source "$bashCWD"/bashrc/.bashMacrc;
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
  source "$bashCWD"/bashrc/.bashWinrc;
fi
[ -e ~/.bashZepprcs ] && source ~/.bashZepprcs/.bashZepprc;

alias cake='sh ~/r/s/sys-setup/.dotfiles/.cakeInit.sh'
# alias scron="su -c $(printf "%q " "crontab -u $USER -e")"
alias scron="sudo EDITOR=nano crontab -u $USER -e"
alias xterm="xterm & sleep 0.8s && transset-df -a"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
# path shit
export PATH="/git/tools/bin:${PATH}"
export PATH="$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin"
export PATH="$PATH:/git/bob"
export PATH="$PATH:`yarn global bin`"
export PATH="$PATH:/Users/mcmhav/work/bin/protoc-gen-go"
export PATH="$PATH:/usr/local/opt/python/libexec/bin"
export PATH="$PYENV_ROOT/bin:$PATH"

# go sgit
export GOPATH="$GOPATH:/Users/mcmhav/r/motione/go"

export NODE_PATH="/usr/local/lib/node_modules"
# export EDITOR=subl3
# export VISUAL=subl3
# export HISTFILESIZE=
# export HISTSIZE=

alias http='python -m http.server'
alias http='python -m SimpleHTTPServer 8009'
alias click='shutter -s'

alias probeNetwork='arp -a'

alias aptUpgrade='sudo apt-get update && sudo apt-get upgrade'

alias space='du -h -d 2 | sort -n'

export GOPATH=$HOME/.go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# android:
export ANDROID_HOME=/usr/local/share/android-sdk

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/mcmhav/Downloads/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/mcmhav/Downloads/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/mcmhav/Downloads/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/mcmhav/Downloads/google-cloud-sdk/completion.bash.inc'
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
  versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
  if [ "${#versions[@]}" -eq 1 ]; then
    PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${versions[0]}/bin/${PYENV_COMMAND}"
  fi
fi
