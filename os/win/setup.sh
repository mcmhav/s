#!/usr/bin/env bash

_install() {
  loggit "Installing win stuff"

  csys reqs-install "$SCRIPT_PATH/reqs"
}

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
RETURN_TO=$(pwd)

cd "$SCRIPT_PATH" || exit

_install

cd "$RETURN_TO" || exit
