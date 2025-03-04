#!/usr/bin/env bash

PACKAGE_NAME="fish"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
    case $CSYS_OS in
        "$GITPOD_OS"* | "$MAC_OS")
            if ! command -v "$PACKAGE_NAME" >/dev/null; then
                brew install "$PACKAGE_NAME"
            fi
            ;;
        *)
            loggit warn "Unsupported OS: $CSYS_OS"
            ;;
    esac

	if ! test -L "$HOME/.config/fish"; then
		rm -rf "$HOME/.config/fish"
	fi
	ln -sf "$SCRIPT_PATH/config/fish" "$HOME/.config"
}

_setup
