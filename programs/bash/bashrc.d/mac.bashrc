#!/usr/bin/env bash

installDmg() {
  hdiutil attach "$1"
}

cb() {
  clear && printf '\e[3J' && "$@"
}

alias brewUpdate='brew update && brew upgrade && brew cask upgrade'

# java versions-helpers (resolved once, when the alias is defined)
# shellcheck disable=SC2139,SC2046
if [[ $(/usr/libexec/java_home -V 2>/dev/null) ]]; then
  alias j8="export JAVA_HOME=$(/usr/libexec/java_home -v 1.8); java -version"
  alias j10="export JAVA_HOME=$(/usr/libexec/java_home -v 10); java -version"
  alias j11="export JAVA_HOME=$(/usr/libexec/java_home -v 11); java -version"
  if [[ $(/usr/libexec/java_home -X) ]]; then
    # TODO: is this used?
    alias openjdk="export JAVA_HOME=$(/usr/libexec/java_home -v $(/usr/libexec/java_home -X | xmllint --xpath 'string(//array/dict/key[.="JVMVersion"]/following-sibling::*[1])' --format -)); java -version"
  fi

  # Set java 8 as default
  JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  export JAVA_HOME
fi

if ! xcrun --version &>/dev/null; then
  loggit "Should probably install stuff, want that? Might take a couple of minutes"
  select yn in "Yes" "No"; do
    case $yn in
    Yes)
      "$CSYS_HOME/os/mac/setup.sh"
      break
      ;;
    No) exit ;;
    esac
  done
fi
CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export CFLAGS

# Added for python c-building issues, due to big sur? https://github.com/pyenv/pyenv/issues/1643#issuecomment-695350501
export SYSTEM_VERSION_COMPAT=1

# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="$PATH:$CSYS_OS_PATH/mac/bin"
