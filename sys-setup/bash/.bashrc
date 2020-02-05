#!/usr/bin/env bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/shrc ] && source /etc/shrc

# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

export CSYS_HOME="$HOME/r/s"
source "$CSYS_HOME/sys-setup/bash/bashrc/.bashcsysrc"
source "$CSYS_HOME/sys-setup/bash/bashrc/.bashSourcerc"

# shims and autocompletion, pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# auto set to first of python versions?
if [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
  versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
  if [ "${#versions[@]}" -eq 1 ]; then
    PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${versions[0]}/bin/${PYENV_COMMAND}"
  fi
fi

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/mch/.sdkman"
[[ -s "/Users/mch/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/mch/.sdkman/bin/sdkman-init.sh"
