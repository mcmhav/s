#!/usr/bin/env bash

PACKAGE_COMMAND="kubectl"
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

_install() {
    case $CSYS_OS in
    "$LIN_OS"*)
        RELEASE_VERSION="$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
        curl \
            -fsSL "https://storage.googleapis.com/kubernetes-release/release/$RELEASE_VERSION/bin/linux/amd64/kubectl" \
            -o /usr/local/bin/kubectl
        chmod +x /usr/local/bin/kubectl
        ;;
    "$MAC_OS")
        brew install "$PACKAGE_COMMAND"
        ;;
    *)
        echo "Unsupported OS: $CSYS_OS, pgk: $PACKAGE_COMMAND"
        exit 1
        ;;
    esac
}
_setup() {
    if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
        _install
    fi
}

_setup
