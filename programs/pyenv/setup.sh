#!/usr/bin/env bash

PACKAGE_NAME="pyenv"
INSTALL_PY_VERSION="3.8.12"

_setup() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi

  if ! pyenv versions | grep -q "$INSTALL_PY_VERSION"; then
    pyenv install --skip-existing "$INSTALL_PY_VERSION"
    pyenv global "$INSTALL_PY_VERSION"
  fi
}

_setup
