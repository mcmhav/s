#!/usr/bin/env bash

installStuff() {
	# Todo: Find alternative, issues with git-clone
	# - https://github.com/nvm-sh/nvm/issues/1643
	# - https://github.com/coreybutler/nvm-windows
	# - nodenv seems to be a good alternative, have not tested with windows
	echo "TODO"
}

CONFIG_HOME="$CSYS_HOME/sys-setup/os/mac"
RETURN_TO=$(pwd)

cd "$CONFIG_HOME" || exit

installStuff

cd "$RETURN_TO" || exit
