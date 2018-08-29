#!/usr/bin/env bash

echo "TODO - more"

installStuff() {
  # brew
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  xcode-select --install

  brew update
  brew upgrade
  brew cask upgrade

  # brews
  installBrews

  CFLAGS="-I$(brew --prefix openssl)/include" \
  LDFLAGS="-L$(brew --prefix openssl)/lib" \

  pyenv install -v 3.4.3

  # gems
  sudo gem install cocoapods

  # mac-os setup
  if [ ! -d ~/Pictures/screenshots ]; then
    mkdir ~/Pictures/screenshots
  fi

  defaults write com.apple.screencapture location ~/Pictures/screenshots

  defaults write com.apple.finder AppleShowAllFiles YES

  # app configs
  ln -sf ~/r/s/sys-setup/os/mac/configs/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist

  # stop mouse from accelerating
  defaults write .GlobalPreferences com.apple.mouse.scaling -1
}

installBrews() {
  echo "Installing brews"

  while read l; do
    brew install $l
  done < configs/brews

  while read l; do
    brew cask install $l
  done < configs/casks
}

installStuff
