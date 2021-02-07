#!/usr/bin/env bash

# TODO:
# find path to atom
# install atom

ATOM_HOME="$HOME/.atom"
ATOM_SETUP_HOME="$CSYS_HOME/sys-setup/programs/atom"

cd "$ATOM_HOME" &>/dev/null || exit

GOT_ATOM_BETA=""
GOT_ATOM=""

if [ -x "$(command -v apm-beta)" ]; then
  GOT_ATOM_BETA="1"
fi
if [ -x "$(command -v apm)" ]; then
  GOT_ATOM="1"
fi

if [ -z "$GOT_ATOM" ] && [ -z "$GOT_ATOM_BETA" ]; then
  exit
fi

makePackagesList() {
  storeLocation="packagesList"

  if [ -n "$1" ]; then
    storeLocation="$1"
  fi

  tmp="$PWD"
  cd "$ATOM_SETUP_HOME/atoms" || exit

  if [ "$GOT_ATOM" == "1" ]; then
    apm list -ib | awk '{split($1,pkname,"@"); print pkname[1]}' >"$storeLocation"
  fi
  if [ "$GOT_ATOM_BETA" == "1" ]; then
    apm-beta list -ib | awk '{split($1,pkname,"@"); print pkname[1]}' >"$storeLocation"
  fi

  cd "$tmp" || exit
}

makeDiff() {
  tmp="$PWD"
  cd "$ATOM_SETUP_HOME/atoms" || exit
  diff --strip-trailing-cr packagesList "$1" | grep ">" | sed 's/> //g' >"$2"
  cd "$tmp" || exit
}

uninstallAll() {
  tmpList="packagesListDel"
  diffList="diff"
  makePackagesList $tmpList

  makeDiff $tmpList $diffList

  loggit "uninstall list:"
  cat "$ATOM_SETUP_HOME/atoms/$diffList"

  cd "$ATOM_HOME/packages" || mkdir "$ATOM_HOME/packages"
  while IFS= read -r line; do
    if [ -n "$line" ] && [ -d "$PWD/${line//[$'\t\r\n ']/}" ]; then
      if [ "$GOT_ATOM" == "1" ]; then
        apm uninstall "${line//[$'\t\r\n ']/}"
      fi
      if [ "$GOT_ATOM_BETA" == "1" ]; then
        apm-beta uninstall "${line//[$'\t\r\n ']/}"
      fi
    fi
  done <"$ATOM_SETUP_HOME/atoms/$diffList"

  rm "$ATOM_SETUP_HOME/atoms/$tmpList"
  rm "$ATOM_SETUP_HOME/atoms/$diffList"

  cd "$ATOM_HOME" || exit
}

installFromPackagesList() {
  uninstallAll

  cd "$ATOM_HOME/packages" || mkdir "$ATOM_HOME/packages"

  loggit "Installing  atoms"

  while IFS= read -r line; do
    if [ ! -d "$PWD/${line//[$'\t\r\n ']/}" ]; then
      if [ "$GOT_ATOM" == "1" ]; then
        apm install "${line//[$'\t\r\n ']/}"
      fi
      if [ "$GOT_ATOM_BETA" == "1" ]; then
        apm-beta install "${line//[$'\t\r\n ']/}"
      fi
    fi
  done <"$ATOM_SETUP_HOME/atoms/packagesList"

  cd "$ATOM_HOME" || exit
}

linkFiledToAtom() {
  ln -sf "$ATOM_SETUP_HOME"/atoms/* "$ATOM_HOME"
}

usage() {
  loggit "lol"
}

verbose=""

while [ "$1" != "" ]; do
  case $1 in
  -mpl | --makePackagesList)
    makePackagesList
    exit
    ;;
  -v | --verbose)
    verbose="true"
    ;;
  -i | --install)
    linkFiledToAtom
    installFromPackagesList
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
