#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

_setup() {
  if ! command -v "go" >/dev/null; then
    brew install go
  fi

  while read -r l; do
    if ! command -v "$(echo "$l" | jq -r '.name')" >/dev/null; then
      go install "$(echo "$l" | jq -r '.pkg')"
    fi
  done <"$SCRIPT_DIR/gos"
}

_setup
