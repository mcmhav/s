#!/usr/bin/env bash

PACKAGE_NAME="surreal"
PACKAGE_COMMAND="$PACKAGE_NAME"

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi

  mkdir -p "$CSYS_BASHRC_D/surreal/logs"
}

_setup "$@"
