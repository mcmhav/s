#!/usr/bin/env bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/shrc ] && source /etc/shrc

# export CSYS_HOME="$HOME/r/s"
# source "$CSYS_HOME/sys-setup/bash/bashrc/.bashcsysrc"
# source "$CSYS_HOME/sys-setup/bash/bashrc/.bashSourcerc"

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LINK_PATH="$(readlink "$SCRIPT_PATH"/"$(basename "${BASH_SOURCE[0]}")")"
CONFIG_HOME="$(cd "$(dirname "$LINK_PATH")" >/dev/null 2>&1 && pwd)"

export CSYS_HOME="$CONFIG_HOME/../.."
# export CSYS_HOME="$HOME/r/s"
source "$CONFIG_HOME/bashrc/.bashcsysrc"
source "$CONFIG_HOME/bashrc/.bashSourcerc"

# auto set to first of python versions?
if [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
  versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
  if [ "${#versions[@]}" -eq 1 ]; then
    PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${versions[0]}/bin/${PYENV_COMMAND}"
  fi
fi
