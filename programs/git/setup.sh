#!/usr/bin/env bash

PACKAGE_NAME="git"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  if ! brew ls --version "$PACKAGE_NAME" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi

  ln -sf "$SCRIPT_PATH/config/git" "$HOME/.config"
  ln -sf "$SCRIPT_PATH/config/.gitignore" "$HOME/.config"
  ln -sf "$SCRIPT_PATH/config/.gitconfig" "$HOME/.config"
}

_setup
