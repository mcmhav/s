#!/usr/bin/env bash

PACKAGE_NAME="lf"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  if ! csys is-package-installed "$PACKAGE_NAME"; then
    brew install "$PACKAGE_NAME"
  fi

  if ! test -L "$HOME/.config/lf"; then
    rm -rf "$HOME/.config/lf"
  fi
  ln -sf "$SCRIPT_PATH/config/lf" "$HOME/.config"
}

_setup
