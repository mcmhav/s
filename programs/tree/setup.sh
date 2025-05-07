#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="tree"

_install() {
    case $CSYS_OS in
    "$LIN_OS"*)
        if command -v yum >/dev/null; then
            sudo yum install -y "$PACKAGE_NAME"
        elif command -v apt-get >/dev/null; then
            sudo apt-get install -y "$PACKAGE_NAME" 2>/dev/null || {
                sudo apt-get update
                sudo apt-get install -y "$PACKAGE_NAME"
            }
        else
            echo "Package manager not found"
            exit 1
        fi
        ;;
    "$MAC_OS")
        brew install "$PACKAGE_NAME"
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
