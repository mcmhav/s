#!/usr/bin/env bash

PACKAGE_NAME="coreutils"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  brew unlink md5sha1sum >/dev/null 2>&1
  if ! csys is-package-installed "$PACKAGE_NAME"; then
    brew install "$PACKAGE_NAME"
  fi
}

_setup
