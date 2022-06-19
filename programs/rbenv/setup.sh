#!/bin/bash

PACKAGE_NAME="rbenv"

_setup() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi
}

_setup
