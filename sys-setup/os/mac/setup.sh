#!/usr/bin/env bash

installStuff() {
  while ! xcrun --version 1>/dev/null 2>&1; do
    xcode-select --install 2>/dev/null
    echo "Waiting for xcron/xcode-install"
    sleep 10
  done

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
	installBrews

	CFLAGS="-I$(brew --prefix openssl)/include"
	LDFLAGS="-L$(brew --prefix openssl)/lib"

	if [ -z "$(pyenv versions | grep 3.7.7)" ]; then
		pyenv install --skip-existing 3.7.7
	fi

	$CSYS_HOME/sys-setup/programs/pip/setup.sh
	$CSYS_HOME/sys-setup/programs/rust/setup.sh --setup
	$CSYS_HOME/sys-setup/programs/rust/setup.sh --installCargos

	# mac-os setup
	if [ ! -d ~/Pictures/screenshots ]; then
		mkdir ~/Pictures/screenshots
	fi

	defaults write com.apple.screencapture location ~/Pictures/screenshots

	defaults write com.apple.finder AppleShowAllFiles YES

	# app configs
  for file in "$CSYS_HOME/sys-setup/os/mac/configs/plists/"*; do
    ln -sf $file ~/Library/Preferences/$(basename -- $file)
  done

	# stop mouse from accelerating
	defaults write .GlobalPreferences com.apple.mouse.scaling -1

  # keyboard input speeds
  defaults write -g KeyRepeat -int 3 # normal minimum is 2
  defaults write -g InitialKeyRepeat -int 20

  # Dock hiding
  defaults delete com.apple.dock autohide-delay; killall Dock
  # defaults write com.apple.dock autohide-delay -float 1000; killall Dock

  # menubar? not working tho?
  # defaults write com.apple.controlcenter.plist "NSStatusItem Visible Sound" -bool false

  # Menu bar:
  defaults write com.apple.menuextra.clock.plist DateFormat -string "HH:mm"
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
