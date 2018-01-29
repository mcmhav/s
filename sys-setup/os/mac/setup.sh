#!/usr/bin/env bash

echo "TODO - more"

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brews
brew install node
brew install watchman
brew install git
brew install bash-completion
brew install shellcheck
brew install pyenv
brew install readline
brew install xz
brew install watch

brew cask install java
brew cask install android-sdk
brew cask install android-ndk
brew cask install enpass

CFLAGS="-I$(brew --prefix openssl)/include" \
LDFLAGS="-L$(brew --prefix openssl)/lib" \
pyenv install -v 3.4.3

# gems
sudo gem install cocoapods

# mac-os setup
mkdir ~/Pictures/screenshots
defaults write com.apple.screencapture location ~/Pictures/screenshots

defaults write com.apple.finder AppleShowAllFiles YES
