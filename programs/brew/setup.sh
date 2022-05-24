#!/usr/bin/env bash

_installBrews() {
  loggit "Installing brews"

  for l in $(cat $SCRIPT_DIR/configs/brews); do
    read -ra BREW_PACKAGE <<<"$l"
    if ! brew ls --versions "${BREW_PACKAGE[0]}" >/dev/null; then
      brew install "$l"
    fi
  done

  loggit "Installing brews casks"

  while read -r l; do
    read -ra BREW_PACKAGE <<<"$l"
    if ! brew ls --cask --versions "${BREW_PACKAGE[0]}" >/dev/null; then
      brew install --cask "$l"
    fi
  done <"$SCRIPT_DIR/configs/casks"
}

_setup() {
  # brew
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if ! brew tap | grep -q 'homebrew/cask-fonts'; then
    brew tap homebrew/cask-fonts
  fi

  brew update
  brew upgrade
  brew upgrade --cask
  brew tap homebrew/services

  # brews
  _installBrews

}

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

_setup
