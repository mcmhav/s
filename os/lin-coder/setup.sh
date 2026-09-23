#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup_copilot() {
    mkdir -p "$HOME/.config"
    mkdir -p "/workspace/.copilot"
    ln -sfn /workspace/.copilot "$HOME/.config/github-copilot"
}
_setup() {
    export CSYS_LOG_LEVEL=5
    export CSYS_SHALLOW_SETUP="true"

    _setup_copilot

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
    sudo tee -a "/usr/local/bin/xdg-open" < "$SCRIPT_PATH/config/browser-open" > /dev/null

    sudo apt-get install netcat-openbsd
}

_setup
