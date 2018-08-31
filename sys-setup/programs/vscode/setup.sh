#!/usr/bin/env bash

VS_CODE_SETUP_HOME=""
VS_CODE_HOME_USER=""
# VS_CODE_HOME=""

if [ "$(uname -s)" == "Linux" ]; then
  echo "TODO"
  exit 1
elif [ "$(uname -s)" == "Darwin" ]; then
  VS_CODE_SETUP_HOME="$HOME/r/s/sys-setup/programs/vscode"
  VS_CODE_HOME_USER="$HOME/Library/Application Support/Code/User"
  # VS_CODE_HOME=~/.vscode
  echo "TODO"
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
  echo "TODO"
  exit 1
fi

handleVSUser() {
  ln -sf "$VS_CODE_SETUP_HOME"/User/settings.json "$VS_CODE_HOME_USER"
  # ln -sf "$VS_CODE_SETUP_HOME"/User/snippets "$VS_CODE_HOME_USER"
}

storeExtentions() {
  code --list-extensions > "$VS_CODE_SETUP_HOME"/extentions
}

installExtentions() {
  while read l; do
    echo "installing $l"
    code --install-extension $l
  done < "$VS_CODE_SETUP_HOME"/extentions
}

usage() {
  echo "lol"
}

verbose="";

while [ "$1" != "" ]; do
  case $1 in
    -mpl | --makePackagesList )
    storeExtentions
    exit
    ;;
    -v | --verbose )
    verbose="true"
    ;;
    -i | --install )
    installExtentions
    handleVSUser
    ;;
    -h | --help )
    usage
    exit
    ;;
    * )
    usage
    exit 1
  esac
  shift
done
