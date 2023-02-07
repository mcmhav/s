#!/usr/bin/env bash

PACKAGE_COMMAND="tfenv"
INSTALL_TF_VERSION="1.3.7"

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    brew install "$PACKAGE_COMMAND"
  fi

  if ! tfenv list | grep -q "$INSTALL_TF_VERSION"; then
    tfenv install "$INSTALL_TF_VERSION"
    tfenv use "$INSTALL_TF_VERSION"
  fi
}

_setup
