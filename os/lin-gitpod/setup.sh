#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup_vscode_config() {
  loggit "Setting up vs-code-config"
  VS_CODE_SETTINGS_LOCATION="/workspace/.vscode-remote/data/Machine/"
  COUNT=0
  while [ ! -f "$VS_CODE_SETTINGS_LOCATION/settings.json" ]; do
    loggit warn "Could not find settings json, waiting"
    if [ "$COUNT" -gt 10 ]; then
      loggit warn "Giving up waiting for settings.json-file"
      break
    fi
    sleep 10
    COUNT=$((COUNT + 1))
  done
  mkdir -p "$VS_CODE_SETTINGS_LOCATION"
  loggit "Adding vscode config to machine"
  cp "$SCRIPT_PATH/config/settings.json" "$VS_CODE_SETTINGS_LOCATION"
  # code --install-extension "travis.simple-dark"
  code --install-extension "ms-pyright.pyright"
  # code --install-extension "vscodevim.vim"
}

_setup() {
  export CSYS_LOG_LEVEL=5
  export CSYS_SHALLOW_SETUP="true"

  _setup_vscode_config &

  loggit "Installing brew"
  csys install brew
  loggit "Installing csys-reqs"
  csys reqs-install "$SCRIPT_PATH/reqs"

  sudo apt-get install -y mariadb-client
}

_setup