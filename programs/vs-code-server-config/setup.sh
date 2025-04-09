#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup_vscode_config() {
    loggit "Setting up vs-code-config"
    if [ -z "$VS_CODE_SETTINGS_LOCATION" ]; then
        loggit warn "VS_CODE_SETTINGS_LOCATION is not set, using default location"
        VS_CODE_SETTINGS_LOCATION="/workspace/.vscode-remote/data/Machine/"
    fi
    COUNT=0
    while [ ! -f "$VS_CODE_SETTINGS_LOCATION/settings.json" ]; do
        COUNT=$((COUNT + 1))
        loggit warn "Could not find settings json, waiting"
        if [ "$COUNT" -ge 5 ]; then
            loggit warn "Giving up waiting for settings.json-file"
            break
        fi
        sleep 5
    done
    mkdir -p "$VS_CODE_SETTINGS_LOCATION"
    loggit "Adding vscode config to machine"
    cp "$SCRIPT_PATH/config/settings.json" "$VS_CODE_SETTINGS_LOCATION"
    # code --install-extension "travis.simple-dark"
    if ! command -v code &>/dev/null; then
        loggit warn "VS Code is not installed, skipping extension installation"
        exit
    fi
    code --install-extension "ms-pyright.pyright"
    # code --install-extension "vscodevim.vim"
    # do something with state like so:
    # https://stackoverflow.com/questions/58900482/where-does-vs-code-store-its-memory-of-what-notifications-ive-previously-reques
}

_setup_vscode_config
