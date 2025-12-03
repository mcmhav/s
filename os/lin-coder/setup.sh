#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
    export CSYS_LOG_LEVEL=5
    export CSYS_SHALLOW_SETUP="true"

    COPILOT_CONFIG="$HOME/.config/github-copilot"
    mkdir -p "$COPILOT_CONFIG"
    echo "$COPILOT_HOSTS" | base64 -d >"$COPILOT_CONFIG/hosts.json"
    # Store an updated key
    # cat ~/.config/github-copilot/hosts.json | base64 -w 0 | xargs -I {} gp env COPILOT_HOST={}

    export VS_CODE_SETTINGS_LOCATION="$HOME/.vscode-server/data/Machine/"
    csys install vs-code-server-config &

    export VS_CODE_SETTINGS_LOCATION="$HOME/.local/share/code-server/Machine/"
    csys install vs-code-server-config &
    # sudo apt-get update
    # loggit "Installing brew"
    # csys install brew
    loggit "Installing csys-reqs"
    csys reqs-install "$SCRIPT_PATH/reqs"

    # sudo apt-get install -y mariadb-client
    # pip install "uv<1.0.0"
    # uv tool install ruff@latest

    echo 'if [ -f "$HOME/.bashrc" ]; then source "$HOME/.bashrc"; fi' >>"$HOME/.bash_profile"

    cat "$SCRIPT_PATH/config/browser-open" >"/usr/local/bin/browser-override"
    cat "$SCRIPT_PATH/config/browser-open" >"/usr/local/bin/xdg-open"

    sudo apt-get install netcat-openbsd
}

_setup
