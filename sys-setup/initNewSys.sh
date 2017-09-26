#!/usr/bin/env bash

ln -sf ~/r/s/lin-sys-setup/.bashrc ~/.bashrc;
ln -sf ~/r/s/lin-sys-setup/.vimrc ~/.vimrc;
ln -sf ~/r/s/lin-sys-setup/.gitconfig ~/.gitconfig;

if [ "$(uname -s)" == "Linux" ]; then
	echo "TODO - more"
	sudo apt-get update
	sudo apt-get install nodejs npm ruby
elif [ "$(uname -s)" == "Darwin" ]; then
	echo "TODO - more"

  # brew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# brews
	brew install node
	brew install watchman
	brew install git
	brew install bash-completion
	brew install shellcheck

  brew cask install java
  brew cask install android-sdk
  brew cask install android-ndk

	# gems
	sudo gem install cocoapods

  # mac-os setup
  mkdir ~/Pictures/screenshots
  defaults write com.apple.screencapture location ~/Pictures/screenshots

  defaults write com.apple.finder AppleShowAllFiles YES
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
	echo "TODO - more"
fi

atom/setup.sh --install
subl/setup.sh
vim/setup.sh

# Apps:
#   python

# function:
# npm installs:
#   bower
#
#   gulp
#   jshint
#   yo
#   eslint
#   babel-eslint
#   n
#	node-notifier
