#!/usr/bin/env bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/shrc ] && source /etc/shrc

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LINK_PATH="$(readlink "$SCRIPT_PATH"/"$(basename "${BASH_SOURCE[0]}")")"
CONFIG_HOME="$(cd "$(dirname "$LINK_PATH")" >/dev/null 2>&1 && pwd)"

export CSYS_HOME="$CONFIG_HOME/../.."
source "$CONFIG_HOME/bashrc/.bashcsysrc"
source "$CONFIG_HOME/bashrc/.bashSourcerc"

# auto set to first of python versions?
if [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
  versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
  if [ "${#versions[@]}" -eq 1 ]; then
    PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${versions[0]}/bin/${PYENV_COMMAND}"
  fi
fi
for i in $(ls -A $HOME/.bashrc.d/); do source $HOME/.bashrc.d/$i; done
