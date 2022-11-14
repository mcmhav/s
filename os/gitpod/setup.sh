#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup_vscode_config() {
  loggit "Setting up vs-code-config"
  VS_CODE_SETTINGS_LOCATION="/workspace/.vscode-remote/data/Machine/"
  mkdir -p "$VS_CODE_SETTINGS_LOCATION"
  cp "$SCRIPT_PATH/config/settings.json" "$VS_CODE_SETTINGS_LOCATION"
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
