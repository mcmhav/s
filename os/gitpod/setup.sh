#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup_vscode_config() {
  loggit "Setting up vs-code-config"
  cp "$SCRIPT_PATH/config/settings.json" "/workspace/.vscode-remote/data/Machine/"
}

_setup() {
  export CSYS_LOG_LEVEL=5
  export CSYS_SHALLOW_SETUP="true"

  _setup_vscode_config

  loggit "Installing brew"
  csys install brew
  loggit "Installing csys-reqs"
  csys reqs-install "$SCRIPT_PATH/reqs"
}

_setup
