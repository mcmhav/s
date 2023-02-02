#!/usr/bin/env bash

PACKAGE_COMMAND="coder"

_setup() {
  loggit dbug "Setting up coder"
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    curl -fsSL "https://coder.com/install.sh" | sh
  fi
}

_setup
