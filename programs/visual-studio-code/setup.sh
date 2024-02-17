#!/usr/bin/env bash

VS_CODE_SETUP_HOME=""
VS_CODE_HOME_USER=""

PACKAGE_NAME="visual-studio-code"
PACKAGE_COMMAND="code"

VS_CODE_SETUP_HOME="$CSYS_PROGRAMS/$PACKAGE_NAME"

case "$CSYS_OS" in
"$MAC_OS") VS_CODE_HOME_USER="$HOME/Library/Application Support/Code/User" ;;
"$WIN_OS") VS_CODE_HOME_USER="$HOME/AppData/Roaming/Code/User" ;;
*)
  loggit warn "TODO: Not set up for os $CSYS_OS"
  exit 1
  ;;
esac

handleVSUser() {
  ln -sf "$VS_CODE_SETUP_HOME/User/settings.json" "$VS_CODE_HOME_USER/settings.json"
  ln -sf "$VS_CODE_SETUP_HOME/User/keybindings.json" "$VS_CODE_HOME_USER/keybindins.json"
  #ln -sf "$VS_CODE_SETUP_HOME/User/snippets" "$VS_CODE_HOME_USER/snippets"
}

storeExtentions() {
  storeLocation="extentions"
  if [ -n "$1" ]; then
    storeLocation="$1"
  fi

  code --list-extensions >"$VS_CODE_SETUP_HOME/$storeLocation"
}

makeDiff() {
  tmp="$PWD"
  cd "$VS_CODE_SETUP_HOME" || exit
  diff --strip-trailing-cr extentions "$1" | grep ">" | sed 's/> //g' >"$2"
  cd "$tmp" || exit
}

uninstallDiff() {
  tmpList="packagesListDel"
  diffList="diff"

  storeExtentions $tmpList

  makeDiff $tmpList $diffList

  loggit dbug "Uninstall list:"
  cat "$VS_CODE_SETUP_HOME/$diffList"

  while IFS= read -r l; do
    code --uninstall-extension "$l"
  done <"$VS_CODE_SETUP_HOME/$diffList"

  rm "$VS_CODE_SETUP_HOME/$tmpList"
  rm "$VS_CODE_SETUP_HOME/$diffList"
}

installExtentions() {
  loggit dbug "Installing vs-code extentions"

  uninstallDiff

  loggit dbug "Installing extentions"
  while IFS= read -r l; do
    # Checking and strippig
    # Stripping to handled swithing between os's
    if ! code --list-extensions | grep "${l//[$'\t\r\n ']/}" >/dev/null; then
      code --install-extension "${l//[$'\t\r\n ']/}"
    fi
  done <"$VS_CODE_SETUP_HOME/extentions"

  ln -sf "$VS_CODE_SETUP_HOME/themes/csys.theme" "$HOME/.vscode/extensions/"
}

usage() {
  loggit "lol"
}

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    brew install --cask "$PACKAGE_NAME"
  fi
  installExtentions
  handleVSUser
}

verbose=""

if [ "$1" == "" ]; then
  _setup
fi

while [ "$1" != "" ]; do
  case $1 in
  -mpl | --makePackagesList)
    storeExtentions
    exit
    ;;
  -v | --verbose)
    verbose="true"
    ;;
  -i | --install)
    _setup
    ;;
  -h | --help)
    usage
    exit
    ;;
  *)
    usage
    exit
    ;;
  esac
  shift
done
