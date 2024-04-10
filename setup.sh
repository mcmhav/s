#!/usr/bin/env bash
# https://raw.githubusercontent.com/mcmhav/s/HEAD/setup.sh

CONFIG_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
export CSYS_HOME="$CONFIG_HOME"

CSYS_BASH_HOME="$CSYS_HOME/programs/bash"

inject_bashrc() {
	BASHRC_LOCATION="$HOME/.csys.bashrc.d"
	mkdir -p "$BASHRC_LOCATION"
	ln -sf "$CSYS_BASH_HOME/main.bashrc" "$BASHRC_LOCATION"
	{
		echo "export CSYS_HOME=$CSYS_HOME"
		echo "export CSYS_BASH_HOME=$CSYS_BASH_HOME"
	} >"$BASHRC_LOCATION/csys_env"

	if [ ! -f "$HOME/.bashrc" ]; then
		touch "$HOME/.bashrc"
	fi
	# Hacky as shit?
	BASH_RC_SOURCER="[ -f \"$BASHRC_LOCATION/main.bashrc\" ] && source \"$BASHRC_LOCATION/main.bashrc\" || echo \"csys not set up\""
	if ! grep -q "$BASH_RC_SOURCER" <"$HOME/.bashrc" >/dev/null; then
		echo "$BASH_RC_SOURCER" >>"$HOME/.bashrc"
	fi
	PROFILE_SOURCER="[ -f \"$HOME/.bashrc\" ] && source \"$HOME/.bashrc\" || echo \"csys not set up\""
	if ! grep -q "$PROFILE_SOURCER" <"$HOME/.profile" >/dev/null; then
		echo "$PROFILE_SOURCER" >>"$HOME/.profile"
	fi
}

non_gui_config() {
	DOTFILES="$CSYS_HOME/programs/home_dotfiles"
	mkdir -p "$HOME/.config"
	GLOBIGNORE="$DOTFILES/.:$DOTFILES/.."
	for f in "$DOTFILES"/.*; do
		ln -sf "$f" "$HOME/"
	done
}

_setup() {
	START_TIME="$(date +%s)"
	source "$CSYS_BASH_HOME/bashrc.d/csys.bashrc"
	source "$CSYS_BASH_HOME/bashrc.d/sourcer.bashrc"

	while [ "$1" != "" ]; do
		case $1 in
		-v | --verbose)
			export CSYS_LOG_LEVEL=5
			;;
		esac
		shift
	done

	inject_bashrc
	non_gui_config

	loggit "Setup using:"
	env | grep 'CSYS_'
	# TODO:  add flagg  for running setup as subprocess
	# we need to not run in subprocess if we do not have brew
	# Could probably be improved by having programs we want to install tell
	# if they can be installed without input, and decide based on that
	if [ -n "$CSYS_NO_SUBPROCESS_INSTALL" ] || ! command -v brew >/dev/null; then
		"$CSYS_HOME/os/$CSYS_OS/setup.sh"
		touch "$CSYS_BASHRC_D/.setup_done"
		loggit "Setup done"
		DONE_TIME="$(date +%s)"
		loggit "Setup took $((DONE_TIME - START_TIME)) seconds"
	else
		(
			"$CSYS_HOME/os/$CSYS_OS/setup.sh"
			touch "$CSYS_BASHRC_D/.setup_done"
			loggit "Setup done"
			DONE_TIME="$(date +%s)"
			loggit "Setup took $((DONE_TIME - START_TIME)) seconds"
		) &
	fi
}

_setup "$@"
