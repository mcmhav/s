#!/usr/bin/env bash

installStuff() {
  if [ ! -d "$HOME/.wakatime" ]; then
    mkdir "$HOME/.wakatime"
  fi
	if [ ! -d ~/.nvm ]; then
		mkdir ~/.nvm
	fi

	# Todo: Find alternative, issues with git-clone
	# - https://github.com/nvm-sh/nvm/issues/1643
	# - https://github.com/coreybutler/nvm-windows
	if [ -x "$(command -v nvm)" ]; then
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
	fi
}


CONFIG_HOME="$CSYS_HOME/sys-setup/os/mac"
RETURN_TO=$(pwd)

cd "$CONFIG_HOME" || exit

installStuff

cd "$RETURN_TO" || exit
