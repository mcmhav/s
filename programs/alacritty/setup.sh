#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  if ! command -v alacritty >/dev/null; then
    cargo install alacritty
    # brew install --cask alacritty
  fi

  case "$CSYS_OS" in
  "$LIN_OS"*) _with_nvm ;;
  "$MAC_OS") _with_nvm ;;
  *)
    loggit warn "$PACKAGE_NAME install not implemented for OS: $CSYS_OS"
    ;;
  esac
}

_setup
