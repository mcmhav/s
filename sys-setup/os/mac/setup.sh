#!/usr/bin/env bash

installStuff() {
	# brew
	if ! [ -x "$(command -v brew)" ]; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	if ! brew tap | grep -q 'homebrew/cask-fonts'; then
		brew tap homebrew/cask-fonts
	fi

	xcode-select --install 2>/dev/null

	brew update
	brew upgrade
	brew upgrade --cask
	brew tap homebrew/services

	# brews
	installBrews

	CFLAGS="-I$(brew --prefix openssl)/include"
	LDFLAGS="-L$(brew --prefix openssl)/lib"

	if [ -z "$(pyenv versions | grep 3.7.7)" ]; then
		pyenv install --skip-existing 3.7.7
	fi

	$CSYS_HOME/sys-setup/programs/pip/setup.sh

	# mac-os setup
	if [ ! -d ~/Pictures/screenshots ]; then
		mkdir ~/Pictures/screenshots
	fi

	defaults write com.apple.screencapture location ~/Pictures/screenshots

	defaults write com.apple.finder AppleShowAllFiles YES

	# app configs
	ln -sf $CSYS_HOME/sys-setup/os/mac/configs/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist
	ln -sf $CSYS_HOME/sys-setup/os/mac/configs/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
	# ln -sf $CSYS_HOME/sys-setup/os/mac/configs/com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist
	# ln -sf $CSYS_HOME/sys-setup/os/mac/configs/.hyper.js ~/.hyper.js

	# stop mouse from accelerating
	defaults write .GlobalPreferences com.apple.mouse.scaling -1

	# remove white line
	defaults write -app Visual\ Studio\ Code NSRequiresAquaSystemAppearance -bool No
	defaults write -app Hyper NSRequiresAquaSystemAppearance -bool No
	defaults write -app Google\ Chrome NSRequiresAquaSystemAppearance -bool No
	defaults write -app Atom\ Beta NSRequiresAquaSystemAppearance -bool No
	defaults write -app Station NSRequiresAquaSystemAppearance -bool No
}

installBrews() {
	loggit "Installing brews"

	while read -r l; do
		read -ra BREW_PACKAGE <<<"$l"
		if ! brew ls --versions "${BREW_PACKAGE[0]}" >/dev/null; then
			brew install "$l"
		fi
	done <configs/brews

	loggit "Installing brews casks"

	while read -r l; do
		read -ra BREW_PACKAGE <<<"$l"
		if ! brew ls --cask --versions "${BREW_PACKAGE[0]}" >/dev/null; then
			brew install --cask "$l"
		fi
	done <configs/casks
}

CONFIG_HOME="$CSYS_HOME/sys-setup/os/mac"
RETURN_TO=$(pwd)

cd "$CONFIG_HOME" || exit

installStuff

cd "$RETURN_TO" || exit
