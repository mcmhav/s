#!/usr/bin/env bash

PACKAGE_NAME="zsh"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
	if ! command -v "$PACKAGE_NAME" >/dev/null; then
		brew install "$PACKAGE_NAME"
	fi

	if ! test -L "$HOME/.zshrc"; then
		rm -rf "$HOME/.zshrc"
	fi
	ln -sf "$SCRIPT_PATH/config/.zshrc" "$HOME/.zshrc"
}

_setup
