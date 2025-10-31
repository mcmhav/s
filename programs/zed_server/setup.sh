#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ZED_SERVER_VERSION="0.208.4"

_ZED_REMOTE_BIN="$HOME/.zed_server/zed-remote-server-stable-$ZED_SERVER_VERSION"
_install() {
    tmp="$(mktemp -d "/tmp/zed-XXXXXX")"

    # https://zed.dev/docs/remote-development?highlight=ssh#initializing-the-remote-server
    curl -fsSL "https://github.com/zed-industries/zed/releases/download/v$ZED_SERVER_VERSION/zed-remote-server-linux-x86_64.gz" \
        -o "$tmp/zed-remote-server-stable-linux-x86_64.gz"

    gzip -d "$tmp/zed-remote-server-stable-linux-x86_64.gz"
    chmod +x "$tmp/zed-remote-server-stable-linux-x86_64"
    mkdir -p "$HOME/.zed_server"
    cp "$tmp/zed-remote-server-stable-linux-x86_64" "$_ZED_REMOTE_BIN"

    mkdir -p "$HOME/.config/zed"

    ln -sf "$SCRIPT_PATH/config/settings.json" "$HOME/.config/zed/settings.json"
}

_setup() {
    # https://zed.dev/docs/remote-development?highlight=ssh#initializing-the-remote-server
    if [ ! -f "$_ZED_REMOTE_BIN" ]; then
        _install
    fi
}

_setup
