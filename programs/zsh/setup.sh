#!/usr/bin/env bash

PACKAGE_NAME="zsh"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ZSH_CONFIG_HOME="$HOME/.config/zsh"

_setup() {
	if ! command -v "$PACKAGE_NAME" >/dev/null; then
        if command -v yum >/dev/null; then
            sudo yum install -y "$PACKAGE_NAME"
        elif command -v apt-get >/dev/null; then
            sudo apt-get install -y "$PACKAGE_NAME"
        elif command -v brew >/dev/null; then
            brew install "$PACKAGE_NAME"
        else
            echo "Package manager not found"
            exit 1
        fi
	fi

	if ! test -L "$HOME/.zshrc"; then
		rm -rf "$HOME/.zshrc"
	fi
	ln -sf "$SCRIPT_PATH/config/.zshrc" "$HOME/.zshrc"
	ln -sf "$SCRIPT_PATH/config/zsh" "$ZSH_CONFIG_HOME"

	if ! test -d "$ZSH_CONFIG_HOME/zsh-autosuggestions"; then
		git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CONFIG_HOME/zsh-autosuggestions"
	fi
}

_setup
