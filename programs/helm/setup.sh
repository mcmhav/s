#!/usr/bin/env bash

PACKAGE_COMMAND="helm"

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    brew install helm
  fi
}

_setup
