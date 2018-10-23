#!/usr/bin/env bash

# TODO:
# find path to atom
# install atom

ATOM_HOME=~/.atom
ATOM_SETUP_HOME=~/r/s/sys-setup/programs/atom

cd "$ATOM_HOME" || exit

makePackagesList() {
  storeLocation="packagesList"

  if [ -n "$1" ]; then
    storeLocation="$1"
  fi

  tmp="$PWD"
  cd "$ATOM_SETUP_HOME/atoms" || exit;

  if ! [ -x "$(command -v apm-beta)" ]; then
    if ! [ -x "$(command -v apm)" ]; then
      exit
    else
      apm list -ib | awk '{split($1,pkname,"@"); print pkname[1]}' > "$storeLocation"
    fi
  else
    apm-beta list -ib | awk '{split($1,pkname,"@"); print pkname[1]}' > "$storeLocation"
  fi

  cd "$tmp" || exit
}

makeDiff() {
  tmp="$PWD"
  cd "$ATOM_SETUP_HOME/atoms" || exit;
  diff packagesList $1 | grep ">" | sed 's/> //g' > $2
  cd "$tmp" || exit
}

uninstallAll() {
  tmpList="packagesListDel"
  diffList="diff"
  makePackagesList $tmpList

  makeDiff $tmpList $diffList

  loggit "uninstall list:"
  cat $ATOM_SETUP_HOME/atoms/$diffList

  cd "$ATOM_HOME/packages" || mkdir "$ATOM_HOME/packages"
  while read line; do
    if [ -d "$PWD/$line" ]; then
      if ! [ -x "$(command -v apm-beta)" ]; then
        if ! [ -x "$(command -v apm)" ]; then
          exit
        else
          apm uninstall "$line"
        fi
      else
        apm-beta uninstall "$line"
      fi
    fi
  done < $ATOM_SETUP_HOME/atoms/$diffList

  rm $ATOM_SETUP_HOME/atoms/$tmpList
  rm $ATOM_SETUP_HOME/atoms/$diffList

  cd "$ATOM_HOME" || exit
}

installFromPackagesList() {
  uninstallAll

  cd "$ATOM_HOME/packages" || mkdir "$ATOM_HOME/packages"

  loggit "Installing  atoms"

  while read line; do
    if [ ! -d "$PWD/$line" ]; then
      if ! [ -x "$(command -v apm-beta)" ]; then
        if ! [ -x "$(command -v apm)" ]; then
          exit
        else
          apm install "$line"
        fi
      else
        apm-beta install "$line"
      fi
    fi
  done < $ATOM_SETUP_HOME/atoms/packagesList

  cd "$ATOM_HOME" || exit
}

linkFiledToAtom() {
  ln -sf "$ATOM_SETUP_HOME"/atoms/* "$ATOM_HOME"
}

usage() {
  loggit "lol"
}

if [ "$(uname -s)" == "Linux" ]; then
  loggit "TODO"
elif [ "$(uname -s)" == "Darwin" ]; then
  loggit "TODO"
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
  loggit "TODO"
fi

verbose="";

while [ "$1" != "" ]; do
  case $1 in
    -mpl | --makePackagesList )
    makePackagesList
    exit
    ;;
    -v | --verbose )
    verbose="true"
    ;;
    -i | --install )
    linkFiledToAtom
    installFromPackagesList
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
