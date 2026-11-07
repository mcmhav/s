#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup_copilot() {
    mkdir -p "$HOME/.config"
    mkdir -p "/workspace/.copilot"
    ln -sfn /workspace/.copilot "$HOME/.config/github-copilot"
}
_setup_cortex() {
    mkdir -p "/workspace/.cortex/conversations"
    ln -sf "/workspace/.cortex/conversations" "$HOME/.snowflake/cortex"
}
_setup_fish_history() {
    # Keep fish's data dir (fish_history) on /workspace so history survives workspace rebuilds.
    # Link the whole dir, not the file: fish saves history by renaming a temp file over
    # fish_history, which would replace a file symlink with a regular file.
    local persist="/workspace/.local/share/fish"
    local data="$HOME/.local/share/fish"
    mkdir -p "$persist" "$HOME/.local/share"
    chmod 700 "$persist"
    if [ -d "$data" ] && [ ! -L "$data" ]; then
        # Keep history recorded before the link existed (e.g. a shell opened during setup).
        for f in "$data"/*_history; do
            [ -f "$f" ] && cat "$f" >>"$persist/$(basename "$f")"
        done
        rm -rf "$data"
    fi
    ln -sfn "$persist" "$data"
}
_setup_buildx_cache() {
    # Keep the buildx "builders" layer cache on /workspace (see /workspace/bin/buildx-persist).
    # Docker (DinD) may still be starting, so wait for it in the background.
    if [ -x /workspace/bin/buildx-persist ]; then
        mkdir -p /workspace/.buildkit
        nohup /workspace/bin/buildx-persist --wait 300 >/workspace/.buildkit/startup.log 2>&1 &
    fi
}
_setup() {
    export CSYS_LOG_LEVEL=5
    export CSYS_SHALLOW_SETUP="true"

    _setup_copilot
    _setup_buildx_cache
    _setup_fish_history

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
    sudo tee -a "/usr/local/bin/xdg-open" <"$SCRIPT_PATH/config/browser-open" >/dev/null

    sudo apt-get install netcat-openbsd
}

_setup
