#!/usr/bin/env bash

ln -sf ~/r/s/lin-sys-setup/.bashrc ~/.bashrc;
ln -sf ~/r/s/lin-sys-setup/.vimrc ~/.vimrc;
ln -sf ~/r/s/lin-sys-setup/.gitconfig ~/.gitconfig;

if [ "$(uname -s)" == "Linux" ]; then
	echo "TODO"
	sudo apt-get update
	sudo apt-get install nodejs npm ruby
elif [ "$(uname -s)" == "Darwin" ]; then
	echo "TODO"

  # brew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# brews
	brew install node
	brew install watchman
	brew install git
	brew install bash-completion
	brew install shellcheck

	# gems
	sudo gem install cocoapods

  # mac setup
  mkdir ~/.screenshots
  defaults write com.apple.finder AppleShowAllFiles YES ~/.screenshots
  defaults write com.apple.screencapture location
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
	echo "TODO"
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
