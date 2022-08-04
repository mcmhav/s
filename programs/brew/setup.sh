#!/usr/bin/env bash

_setup() {
  if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  BREW_TAPS=$(brew tap)
  if ! echo "$BREW_TAPS" | grep -q 'homebrew/cask-fonts'; then
    brew tap homebrew/cask-fonts
  fi
  if ! echo "$BREW_TAPS" | grep -q 'homebrew/services'; then
    brew tap homebrew/services
  fi

  if [ "$CSYS_SHALLOW_SETUP" != "true" ]; then
    brew update
    brew upgrade
  fi
}

_setup
