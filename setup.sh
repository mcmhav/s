#!/usr/bin/env bash
# https://raw.githubusercontent.com/mcmhav/s/HEAD/setup.sh

CONFIG_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
export CSYS_HOME="$CONFIG_HOME"

CSYS_BASH_HOME="$CSYS_HOME/programs/bash"

inject_bashrc() {
  BASHRC_LOCATION="$HOME/.csys.bashrc.d"
  mkdir -p "$BASHRC_LOCATION"
  ln -sf "$CSYS_BASH_HOME/main.bashrc" "$BASHRC_LOCATION"
  # Hacky as shit?
  BASH_RC_SOURCER="[ -f \"$BASHRC_LOCATION/main.bashrc\" ] && source \"$BASHRC_LOCATION/main.bashrc\" || echo \"csys not set up\""
  if ! grep -q "$BASH_RC_SOURCER" <"$HOME/.bashrc"; then
    echo "$BASH_RC_SOURCER" >>"$HOME/.bashrc"
  fi
}

non_gui_config() {
  DOTFILES="$CSYS_HOME/programs/home_dotfiles"
  mkdir -p "$HOME/.config"
  GLOBIGNORE="$DOTFILES/.:$DOTFILES/.."
  for f in "$DOTFILES"/.*; do
    ln -sf "$f" "$HOME/"
  done
}

_setup() {
  source "$CSYS_BASH_HOME/bashrc.d/csys.bashrc"
  source "$CSYS_BASH_HOME/bashrc.d/sourcer.bashrc"

  while [ "$1" != "" ]; do
    case $1 in
    -v | --verbose)
      export CSYS_LOG_LEVEL=5
      ;;
    esac
    shift
  done

  inject_bashrc
  non_gui_config

  loggit "Setup using:"
  loggit "  CSYS_HOME: $CSYS_HOME"
  loggit "  CSYS_OS: $CSYS_OS"
  "$CSYS_HOME/os/$CSYS_OS/setup.sh"
}

_setup "$@"
