#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

installGems() {
  while read -r l; do
    gem install "$l"
  done <"$SCRIPT_DIR/gems"
}

installGems
