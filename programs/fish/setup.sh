#!/usr/bin/env bash

PACKAGE_NAME="fish"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_install() {
  case $CSYS_OS in
  "$GITPOD_OS"* | "$MAC_OS")
    brew install "$PACKAGE_NAME"
    ;;
  "$LIN_OS"*)
    if command -v apt-get >/dev/null; then
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "$PACKAGE_NAME" >/dev/null
    else
      loggit warn "$PACKAGE_NAME: no apt-get on $CSYS_OS, skipping install"
    fi
    ;;
  *)
    loggit warn "Unsupported OS: $CSYS_OS"
    ;;
  esac
}

_setup() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    _install
  fi

  if ! test -L "$HOME/.config/fish"; then
    rm -rf "$HOME/.config/fish"
  fi
  ln -sf "$SCRIPT_PATH/config/fish" "$HOME/.config"
}

_setup
