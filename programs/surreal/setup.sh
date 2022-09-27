#!/usr/bin/env bash

PACKAGE_NAME="surreal"
PACKAGE_COMMAND="$PACKAGE_NAME"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi
}

_setup "$@"
