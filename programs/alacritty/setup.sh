#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_with_cargo() {
  if ! command -v alacritty >/dev/null; then
    cargo install alacritty
    # brew install --cask alacritty
  fi
}

_setup() {

  case "$CSYS_OS" in
  "$MAC_OS") _with_cargo ;;
  *)
    loggit warn "$PACKAGE_NAME install not implemented for OS: $CSYS_OS"
    ;;
  esac

  ln -sf "$SCRIPT_PATH/config/alacritty" "$HOME/.config"
}

_setup
