#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup_vscode_config() {
	loggit "Setting up vs-code-config"
	VS_CODE_SETTINGS_LOCATION="/workspace/.vscode-remote/data/Machine/"
	COUNT=0
	while [ ! -f "$VS_CODE_SETTINGS_LOCATION/settings.json" ]; do
		COUNT=$((COUNT + 1))
		loggit warn "Could not find settings json, waiting"
		if [ "$COUNT" -ge 3 ]; then
			loggit warn "Giving up waiting for settings.json-file"
			break
		fi
		sleep 5
	done
	mkdir -p "$VS_CODE_SETTINGS_LOCATION"
	loggit "Adding vscode config to machine"
	cp "$SCRIPT_PATH/config/settings.json" "$VS_CODE_SETTINGS_LOCATION"
	# code --install-extension "travis.simple-dark"
	code --install-extension "ms-pyright.pyright"
	# code --install-extension "vscodevim.vim"
	# do something with state like so:
	# https://stackoverflow.com/questions/58900482/where-does-vs-code-store-its-memory-of-what-notifications-ive-previously-reques
}

_setup() {
	export CSYS_LOG_LEVEL=5
	export CSYS_SHALLOW_SETUP="true"

	COPILOT_CONFIG="$HOME/.config/github-copilot"
	mkdir -p "$COPILOT_CONFIG"
	echo "$COPILOT_HOSTS" | base64 -d >"$COPILOT_CONFIG/hosts.json"
	# Store an updated key
	# cat ~/.config/github-copilot/hosts.json | base64 -w 0 | xargs -I {} gp env COPILOT_HOST={}

	_setup_vscode_config &

	sudo apt-get update
	loggit "Installing brew"
	csys install brew
	loggit "Installing csys-reqs"
	csys reqs-install "$SCRIPT_PATH/reqs"

	sudo apt-get install -y mariadb-client

	echo 'if [ -f "$HOME/.bashrc" ]; then source "$HOME/.bashrc"; fi' >>"$HOME/.bash_profile"
}

_setup
