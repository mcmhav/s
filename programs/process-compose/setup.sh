#!/usr/bin/env bash

PACKAGE_NAME="process-compose"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VERSION="v1.78.0"

_install() {
    case $CSYS_OS in
    "$LIN_OS"*)
        curl -fsSL https://github.com/F1bonacc1/process-compose/releases/download/$VERSION/process-compose_linux_amd64.tar.gz | tar -xz -C /tmp
        sudo mv /tmp/process-compose /usr/local/bin
        ;;
    "$MAC_OS")
        curl -fsSL https://github.com/F1bonacc1/process-compose/releases/download/$VERSION/process-compose_darwin_amd64.tar.gz | tar -xz -C /tmp
        mv /tmp/process-compose "$HOME/.local/bin"
        ;;
    *)
        echo "Unsupported OS: $CSYS_OS, pgk: $PACKAGE_NAME"
        exit 1
        ;;
    esac
}
_setup() {
    if ! command -v "$PACKAGE_NAME" >/dev/null; then
        _install
    fi
}

_setup
