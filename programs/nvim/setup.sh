#!/usr/bin/env bash

PACKAGE_NAME="nvim"
NVIM_VERSION="0.10.4"

_install_from_tar() {
    mkdir -p "$HOME/.local/bin"
    NVIM_HOME="$HOME/.local/nvim"
    mkdir -p "$NVIM_HOME"
    if [ "$(uname -m)" == "x86_64" ]; then
        ARCH="x86_64"
    else
        ARCH="arm64"
    fi
    curl -fsSL "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${ARCH}.tar.gz" | tar -xz -C "$NVIM_HOME"
    ln -sf "$NVIM_HOME/nvim-linux-${ARCH}/bin/nvim" "$HOME/.local/bin/nvim"
}

_setup() {
    case $CSYS_OS in
	    "$LIN_OS"*)
            if ! command -v "$PACKAGE_NAME" >/dev/null; then
                _install_from_tar
            else
                CURRENT_VERSION=$(nvim --version | head -n 1 | awk '{print $2}')
                if ! echo -e "v$NVIM_VERSION\n$CURRENT_VERSION" | sort -V -C; then
                    _install_from_tar
                fi
            fi
            ;;
        "$MAC_OS")
            if ! command -v "$PACKAGE_NAME" >/dev/null; then
                brew install "$PACKAGE_NAME"
            fi
            ;;
        *)
            loggit warn "Unsupported OS: $CSYS_OS"
            exit 1
            ;;
    esac

    ln -sf "$SCRIPT_PATH/config/nvim" "$HOME/.config"
}

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup

