#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

installCargos() {
  while read -r l; do
    cargo install "$l"
  done <"$SCRIPT_DIR/cargos"
}

installCargos
