#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ZED_APP_PATH="$HOME/.local/zed/Applications"
ZED_VERSION="0.201.5"

_install() {
    # ref. https://zed.dev/install.sh
    tmp="$(mktemp -d "/tmp/zed-XXXXXX")"
    curl -sL "https://github.com/zed-industries/zed/releases/download/v$ZED_VERSION/Zed-x86_64.dmg" -o "$tmp/Zed.dmg"
    hdiutil attach -quiet "$tmp/Zed.dmg" -mountpoint "$tmp/mount"

    mkdir -p "$ZED_APP_PATH"
    ditto "$tmp/mount/Zed.app" "$HOME/.local/zed/Applications/Zed.app"
    hdiutil detach -quiet "$tmp/mount"

    mkdir -p "$HOME/.local/bin"
    ln -sf "$HOME/.local/zed/Applications/Zed.app/Contents/MacOS/cli" "$HOME/.local/bin/zed"
}

_setup() {
    if ! command -v zed &>/dev/null; then
        _install
    else
        CURRENT_ZED_VERSION="$(zed --version | awk '{print $2}')"
        if ! echo -e "$ZED_VERSION\n$CURRENT_ZED_VERSION" | sort -V -C; then
            rm -rf "$ZED_APP_PATH"
            _install
        fi
    fi

    mkdir -p "$HOME/.config/zed"
    ln -sf "$SCRIPT_PATH/config/keymap.json" "$HOME/.config/zed/"
    ln -sf "$SCRIPT_PATH/config/settings.json" "$HOME/.config/zed/"
}

_setup
