#!/bin/bash

PACKAGE_NAME="rust"
PACKAGE_COMMAND="rustc"
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

_installCargos() {
  loggit dbug "Installing cargos"
  while read -r l; do
    loggit dbug "Installing: $l"
    cargo install $l --quiet
  done <"$SCRIPT_DIR/cargos"
}

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi
  mkdir -p "$HOME/.cargo"
  ln -sf "config.toml" "$HOME/.cargo"
  _installCargos
}

_setup
