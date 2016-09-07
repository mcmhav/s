#!/usr/bin/env bash

# TODO: install sublime

SUBL_SETUP_HOME=~/r/s/sys-setup/subl/subls
SUBL_SNIPPETS_HOME=~/r/s/sys-setup/subl/snippets

if [ "$(uname -s)" == "Linux" ]; then
    SUBL_HOME=~/.config/sublime-text-3/Packages/User
    OS_NAME="Linux"
elif [ "$(uname -s)" == "Darwin" ]; then
    SUBL_HOME=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    OS_NAME="Mac"
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
    SUBL_HOME=~/AppData/Roaming/Sublime\ Text\ 3/Packages/User
    OS_NAME="Windows"
fi

ln -sf "$SUBL_SETUP_HOME"/Default\ \(Linux\).sublime-keymap "$SUBL_HOME"/Default\ \($OS_NAME\).sublime-keymap;
ln -sf "$SUBL_SETUP_HOME"/Package\ Control.sublime-settings "$SUBL_HOME"/Package\ Control.sublime-settings;
ln -sf "$SUBL_SETUP_HOME"/Preferences.sublime-settings "$SUBL_HOME"/Preferences.sublime-settings;
ln -sf "$SUBL_SETUP_HOME"/Main.sublime-menu "$SUBL_HOME"/Main.sublime-menu;

SNIPPES="$SUBL_SNIPPETS_HOME/*"
for SNIPPET in $SNIPPES; do
    snippetFileName=$(basename "$SNIPPET")
    ln -sf "$SNIPPET" "$SUBL_HOME"/"$snippetFileName";
done
