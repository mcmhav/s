#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

installGos() {
  while read -r l; do
    go get -u "$l"
  done <"$SCRIPT_DIR/gos"
}

installGos
