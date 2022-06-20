#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  loggit "Installing brew"
  csys install brew
  loggit "Installing csys-reqs"
  csys reqs-install "$SCRIPT_PATH/reqs"
}

_setup
