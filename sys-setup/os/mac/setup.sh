#!/usr/bin/env bash

echo "TODO - more"

installStuff() {
  # brew
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if ! brew tap | grep -q 'homebrew/cask-fonts'; then
    brew tap caskroom/fonts
  fi

  xcode-select --install

  brew update
  brew upgrade
  brew cask upgrade

  # brews
  installBrews

  CFLAGS="-I$(brew --prefix openssl)/include" \
  LDFLAGS="-L$(brew --prefix openssl)/lib" \

  pyenv install -s -v 3.4.3

  # gems
  sudo gem install cocoapods

  # gos
  installGos

  # mac-os setup
  if [ ! -d ~/Pictures/screenshots ]; then
    mkdir ~/Pictures/screenshots
  fi
  if [ ! -d ~/.nvm ]; then
    mkdir ~/.nvm
  fi

  defaults write com.apple.screencapture location ~/Pictures/screenshots

  defaults write com.apple.finder AppleShowAllFiles YES

  # app configs
  ln -sf ~/r/s/sys-setup/os/mac/configs/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist
  ln -sf ~/r/s/sys-setup/os/mac/configs/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

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

installGos() {
  while read l; do
    go get -u $l
  done < configs/gos
}

installPys() {
  while read l; do
    pip install $l
  done < configs/pys
}

installGems() {
  while read l; do
    gem install $l
  done < configs/gems
}

installStuff
