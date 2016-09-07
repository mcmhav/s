#!/usr/bin/env bash

ln -sf ~/r/s/lin-sys-setup/.bashrc ~/.bashrc;
ln -sf ~/r/s/lin-sys-setup/.vimrc ~/.vimrc;
ln -sf ~/r/s/lin-sys-setup/.gitconfig ~/.gitconfig;

atom/setup.sh
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

if [ "$(uname -s)" == "Linux" ]; then
	echo "TODO"
	sudo apt-get update
	sudo apt-get install nodejs npm ruby
elif [ "$(uname -s)" == "Darwin" ]; then
	echo "TODO"
	# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	# brew install node shellcheck
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
	echo "TODO"
fi
