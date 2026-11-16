#!/usr/bin/env bash

PACKAGE_NAME="pyenv"
# renovate: datasource=python-version depName=python
INSTALL_PY_VERSION="3.11.18"

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
