#!/usr/bin/env bash

PACKAGE_COMMAND="kubectl"
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    # RELEASE_VERSION="$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
    # curl \
    #  -fsSL "https://storage.googleapis.com/kubernetes-release/release/$RELEASE_VERSION/bin/linux/amd64/kubectl" \
    #  -o /usr/local/bin/kubectl
    # chmod +x /usr/local/bin/kubectl
    brew install kubectl
  fi
}

_setup
