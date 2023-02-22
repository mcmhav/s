#!/usr/bin/env bash

PACKAGE_COMMAND="yapf"

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    brew install yapf
  fi
}

_setup
