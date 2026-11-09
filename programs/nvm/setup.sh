#!/usr/bin/env bash

PACKAGE_NAME="nvm"
# Minimum node version. If nvm already has this or newer (e.g. the Coder base image), that is used as is;
# only when nothing new enough is installed does this exact version get installed.
MIN_NODE_VERSION="v22.20.0"
# renovate: datasource=github-releases depName=nvm-sh/nvm extractVersion=^v(?<version>.+)$
NVM_VERSION="0.41.0"

_version_gte() {
  # _version_gte <a> <b>: true when a >= b. Versions look like vX.Y.Z; anything else (e.g. N/A) is false.
  [[ "$1" == v[0-9]* ]] || return 1
  [ "$(printf '%s\n%s\n' "${2#v}" "${1#v}" | sort -V | head -n 1)" = "${2#v}" ]
}

_with_nvm() {
  export NVM_DIR="$HOME/.nvm"
  if [ ! -f "$NVM_DIR/nvm.sh" ]; then
    mkdir -p "$NVM_DIR"
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" | PROFILE=/dev/null bash
  fi
  source "$NVM_DIR/nvm.sh"

  local default newest
  default="$(nvm version default)"
  if _version_gte "$default" "$MIN_NODE_VERSION"; then
    loggit dbug "$PACKAGE_NAME: using default node $default (>= $MIN_NODE_VERSION)"
    return
  fi

  newest="$(nvm version node)"
  if _version_gte "$newest" "$MIN_NODE_VERSION"; then
    loggit dbug "$PACKAGE_NAME: default node $default < $MIN_NODE_VERSION, switching default to installed $newest"
    nvm alias default "$newest" >/dev/null
    return
  fi

  if [[ "$(uname -m)" == armv6* ]]; then
    # nodejs.org has no armv6l (Pi Zero) builds
    export NVM_NODEJS_ORG_MIRROR="https://unofficial-builds.nodejs.org/download/release"
  fi
  # -b: binaries only; without it nvm falls back to compiling node from source (hours on a Pi)
  nvm install -b "$MIN_NODE_VERSION"
  nvm alias default "$MIN_NODE_VERSION"
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
