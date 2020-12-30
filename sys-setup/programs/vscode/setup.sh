#!/usr/bin/env bash

VS_CODE_SETUP_HOME=""
VS_CODE_HOME_USER=""

VS_CODE_SETUP_HOME="$CSYS_HOME/sys-setup/programs/vscode"

if [[ "$(uname -s)" =~ MINGW64_NT* ]]; then
  VS_CODE_HOME_USER="$HOME/AppData/Roaming/Code/User"
  extra_link_flag="--hard"
elif [ "$(uname -s)" == "Linux" ]; then
  loggit "TODO vscode setup"
  exit 1
elif [ "$(uname -s)" == "Darwin" ]; then
  VS_CODE_HOME_USER="$HOME/Library/Application Support/Code/User"
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
  loggit "TODO"
  exit 1
fi

handleVSUser() {
  ln -sf "$extra_link_flag" "$VS_CODE_SETUP_HOME/User/settings.json" "$VS_CODE_HOME_USER/settings.json"
  ln -sf "$extra_link_flag" "$VS_CODE_SETUP_HOME/User/keybindings.json" "$VS_CODE_HOME_USER/keybindins.json"
  ln -sf "$VS_CODE_SETUP_HOME/User/snippets" "$VS_CODE_HOME_USER/snippets"
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
  diff extentions $1 | grep ">" | sed 's/> //g' >$2
  cd "$tmp" || exit
}

uninstallDiff() {
  tmpList="packagesListDel"
  diffList="diff"

  storeExtentions $tmpList

  makeDiff $tmpList $diffList

  loggit "uninstall list:"
  cat $VS_CODE_SETUP_HOME/$diffList

  while read -r l; do
    code --uninstall-extension $l
  done <"$VS_CODE_SETUP_HOME"/$diffList

  rm $VS_CODE_SETUP_HOME/$tmpList
  rm $VS_CODE_SETUP_HOME/$diffList
}

installExtentions() {
  loggit "Installing vs-code extentions"

  uninstallDiff

  while read l; do
    if ! code --list-extensions | grep $l >/dev/null; then
      code --install-extension $l
    fi
  done <"$VS_CODE_SETUP_HOME"/extentions
}

usage() {
  loggit "lol"
}

verbose=""

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
    installExtentions
    handleVSUser
    ;;
  -h | --help)
    usage
    exit
    ;;
  *)
    usage
    exit 1
    ;;
  esac
  shift
done

