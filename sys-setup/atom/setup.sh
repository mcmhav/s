#!/usr/bin/env bash

# TODO:
# find path to atom
# install atom

ATOM_HOME=~/.atom
ATOM_SETUP_HOME=~/r/s/sys-setup/atom

echo "handle atom setup"

cd "$ATOM_HOME" || exit

makePackagesList(){
    tmp="$PWD"
    cd "$ATOM_SETUP_HOME/atoms" || exit;

    apm list -ib | awk '{split($1,pkname,"@"); print pkname[1]}' > packagesList

    cd "$tmp" || exit
}

installFromPackagesList() {
    cd "$ATOM_HOME/packages" || mkdir "$ATOM_HOME/packages"
    while read line; do
        echo "$line"
        if [ ! -d "$PWD/$line" ]; then
            apm install "$line"
        fi
    done < $ATOM_SETUP_HOME/atoms/packagesList

    cd "$ATOM_HOME" || exit
}

linkFiledToAtom() {
    ln -sf "$ATOM_SETUP_HOME"/atoms/* "$ATOM_HOME"
}

if [ "$(uname -s)" == "Linux" ]; then
    echo "TODO"
elif [ "$(uname -s)" == "Darwin" ]; then
    echo "TODO"
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
    echo "TODO"
fi

linkFiledToAtom
installFromPackagesList
