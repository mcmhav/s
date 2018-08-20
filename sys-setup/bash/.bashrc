#!/usr/bin/env bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/shrc ] && . /etc/shrc

if [ -x "$(command -v brew)" ]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

HISTSIZE=2000
HISTFILESIZE=2000
export HISTFILE=~/.bash_eternal_ish_history

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
[ -e ~/.bashAkerrcs ] && source ~/.bashAkerrcs/.bashAkerrc;
source "$bashCWD"/bashrc/.bashExportsrc;
source "$bashCWD"/bashrc/.bashAliasesrc;

G_CLOUD_SDK_PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
# The next line updates PATH for the Google Cloud SDK.
if [ -f $G_CLOUD_SDK_PATH/path.bash.inc ]; then
  source $G_CLOUD_SDK_PATH/path.bash.inc
fi

# The next line enables shell command completion for gcloud.
if [ -f $G_CLOUD_SDK_PATH/completion.bash.inc ]; then
  source $G_CLOUD_SDK_PATH/completion.bash.inc
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
