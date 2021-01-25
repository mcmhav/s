#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt autoremove -y

installAptKeys() {
  loggit "Installing tools"
  if [ -z "$(which gcloud)" ]; then
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-get update
  fi
  if ! dpkg -s yarn | grep Status >/dev/null; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update
  fi
}

installApts() {
  loggit "Installing apts"

  while read -r l; do
    read -ra APT_PACKAGE <<<"$l"
    if ! dpkg -s "${APT_PACKAGE[0]}" | grep Status >/dev/null; then
      sudo apt-get install -y "$l"
    fi
  done <configs/apts

  loggit "Installing piApts"

  while read -r l; do
    read -ra APT_PACKAGE <<<"$l"
    if ! dpkg -s "${APT_PACKAGE[0]}" | grep Status >/dev/null; then
      sudo apt-get install -y "$l"
    fi
  done <configs/piApts
}

installPython() {
  loggit "Installing python"
  if [ -z "$(which pyenv)" ]; then
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  fi
}

installNode() {
  loggit "Installing node"
}

installDocker() {
  loggit "Installing docker"
  if ! command -v docker &> /dev/null; then
    sudo apt-get install apt-transport-https ca-certificates software-properties-common -y
    mkdir -p "$HOME/tmp"
    cd "$HOME/tmp"
    curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
    cd "$HOME"
    sudo usermod -aG docker pi
    sudo curl https://download.docker.com/linux/raspbian/gpg
    rm -rf tmp
  fi
}

CONFIG_HOME="$CSYS_HOME/sys-setup/os/pi"
RETURN_TO=$(pwd)

cd "$CONFIG_HOME" || exit

installAptKeys
installApts
installPython
installDocker

cd "$RETURN_TO" || exit
