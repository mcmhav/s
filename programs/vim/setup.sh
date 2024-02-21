#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
COC_HOME="$HOME/.config/coc/extensions"
VIM_HOME="$HOME/.vim"
LOCAL_CONFIG_PATH="$SCRIPT_PATH/config"

link_config() {
	if [ ! -d "$VIM_HOME" ]; then
		mkdir "$VIM_HOME"
	fi

	ln -sf "$LOCAL_CONFIG_PATH"/*.vim "$VIM_HOME"

	if [ ! -d "$VIM_HOME/colors" ]; then
		mkdir "$VIM_HOME/colors"
	fi
	if [ ! -d "$VIM_HOME/after/syntax" ]; then
		mkdir -p "$VIM_HOME/after/syntax"
	fi
	if [ ! -d "$VIM_HOME/sessions" ]; then
		mkdir "$VIM_HOME/sessions"
	fi
	if [ ! -d "$VIM_HOME/autoload" ]; then
		mkdir "$VIM_HOME/autoload"
	fi
	ln -sf "$LOCAL_CONFIG_PATH/colors/"* "$VIM_HOME/colors/"
	ln -sf "$LOCAL_CONFIG_PATH/c-pluggs" "$HOME/.vim"
	ln -sf "$LOCAL_CONFIG_PATH/.vimrc" "$HOME/.vimrc"

	mkdir -p "$COC_HOME"
	ln -sf "$LOCAL_CONFIG_PATH/coc-package.json" "$COC_HOME/package.json"
}

setup_plugins() {
	if [ ! -f "$VIM_HOME/autoload/plug.vim" ]; then
		curl -fLo "$VIM_HOME/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi

	{
		vim +'PlugInstall --sync' +qall &>/dev/null </dev/tty
		vim +PlugUpgrade +qall &>/dev/null </dev/tty
		vim +PlugUpdate +qall &>/dev/null </dev/tty
		(
			cd "$COC_HOME" &&
				npm install --ignore-scripts --no-lockfile --omit=dev --legacy-peer-deps --no-global
		)
	}
}

link_config
setup_plugins
