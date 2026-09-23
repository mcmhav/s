#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
COC_HOME="$HOME/.config/coc"
COC_EXTENSIONS_HOME="$COC_HOME/extensions"
VIM_HOME="$HOME/.vim"
LOCAL_CONFIG_PATH="$SCRIPT_PATH/config"

link_config() {
     mkdir -p \
        "$VIM_HOME/autoload" \
        "$VIM_HOME/colors" \
        "$VIM_HOME/after/syntax" \
        "$VIM_HOME/sessions" \
        "$COC_EXTENSIONS_HOME"

    ln -sf "$LOCAL_CONFIG_PATH"/*.vim "$VIM_HOME"
    ln -sf "$LOCAL_CONFIG_PATH/colors/"* "$VIM_HOME/colors/"
    ln -sf "$LOCAL_CONFIG_PATH/c-pluggs" "$HOME/.vim"
    ln -sf "$LOCAL_CONFIG_PATH/.vimrc" "$HOME/.vimrc"

    ln -sf "$LOCAL_CONFIG_PATH/coc-package.json" "$COC_EXTENSIONS_HOME/package.json"
    ln -sf "$LOCAL_CONFIG_PATH/coc-settings.json" "$COC_HOME/coc-settings.json"
}

setup_plugins() {
    if [ ! -f "$VIM_HOME/autoload/plug.vim" ]; then
        curl -fsSLo "$VIM_HOME/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    {
        vim +PlugInstall +qall &>/dev/null
        vim +PlugUpgrade +qall &>/dev/null
        vim +PlugUpdate +qall &>/dev/null

        # coc_extensions=$(tr '\n' ' ' <"$LOCAL_CONFIG_PATH/coc-extensions")
        # vim -c "CocInstall -sync $coc_extensions|q"
    } &
}

setup_coc_extensions() {
    command -v npm >/dev/null 2>&1 || {
        printf '%s\n' "npm is required to install CoC extensions" >&2
        return 1
    }

    npm --prefix "$COC_EXTENSIONS_HOME" install \
        --omit=dev \
        --no-audit \
        --no-fund &
}

link_config
setup_plugins
setup_coc_extensions
