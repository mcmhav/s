#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

setup() {
  loggit "Setting up rust"
  if [ ! -d "$HOME/.cargo" ]; then
    mkdir "$HOME/.cargo"
  fi
  ln -sf "config.toml" "$HOME/.cargo"
}

installCargos() {
  loggit "Installing cargos"
  while read -r l; do
    loggit "Installing: $l"
    cargo install "$l" --quiet
  done <"$SCRIPT_DIR/cargos"
  while read -r l; do
    loggit "Installing: $l"
    cargo-binstall $l --no-confirm >/dev/null
  done <"$SCRIPT_DIR/cargos-bin"
}

ACTION="$1"
shift
case "$ACTION" in
--setup)
  setup
  ;;
--installCargos)
  installCargos
  ;;
*)
  echo "Action not recognised, $ACTION"
  ;;
esac