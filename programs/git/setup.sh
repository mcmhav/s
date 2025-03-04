#!/usr/bin/env bash

PACKAGE_NAME="git"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_install_package() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi
}

_setup() {
  case "$CSYS_OS" in
  "$LIN_OS"*) _install_package ;;
  "$MAC_OS") _install_package ;;
  *)
    loggit warn "$PACKAGE_NAME install not implemented for OS: $CSYS_OS"
    ;;
  esac

  ln -sf "$SCRIPT_PATH/config/git" "$HOME/.config"
  ln -sf "$SCRIPT_PATH/config/.gitignore" "$HOME/.config"
  ln -sf "$SCRIPT_PATH/config/.gitconfig" "$HOME/.config"
}

_setup
