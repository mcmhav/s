#!/usr/bin/env bash

PACKAGE_NAME="nvm"
DESIRED_NODE_VERSION="v22.20.0"
NVM_VERSION="0.39.7"

_match_major_version() {
    local version="$1"
    local expected_major="$2"

    local clean_version="${version#v}"
    local clean_expected_major_version="${expected_major#v}"
    local actual_major="${clean_version%%.*}"

    if [[ "$actual_major" == "$clean_expected_major_version" ]]; then
        return 0
    else
        return 1
    fi
}

_with_nvm() {
    export NVM_DIR="$HOME/.nvm"
    if [ ! -d "$NVM_DIR" ] || [ ! -f "$NVM_DIR/nvm.sh" ]; then
        # brew install "$PACKAGE_NAME"
        mkdir -p "$NVM_DIR"
        cd "$NVM_DIR" || exit
        curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" | PROFILE=/dev/null bash
    fi
    source "$NVM_DIR/nvm.sh"
    _node_version=$(nvm version)
    if ! _match_major_version "$_node_version" "${DESIRED_NODE_VERSION%%.*}" && ! _match_major_version "$_node_version" "${DESIRED_NODE_VERSION%%.*}"; then
        nvm install --lts "$DESIRED_NODE_VERSION"
        nvm alias default "$DESIRED_NODE_VERSION"
    fi
}

_setup() {
    case "$CSYS_OS" in
    "$LIN_OS"*) _with_nvm ;;
    "$MAC_OS") _with_nvm ;;
    *)
        loggit warn "$PACKAGE_NAME install not implemented for OS: $CSYS_OS"
        ;;
    esac
}

_setup
