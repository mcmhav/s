#!/usr/bin/env bash

echo "todo - more"

sudo apt-get update
sudo apt-get upgrade

# apt list --installed

if [ ! -d "$NVM_DIR" ]; then
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
fi
if [ -z "$(which pyenv)" ]; then
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi
if [ -z "$(which pipenv)" ]; then
  curl https://raw.githubusercontent.com/kennethreitz/pipenv/master/get-pipenv.py | python
fi

if [ dpkg -l yarn &> /dev/null ]; then
  echo "oaijdf"
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
fi

if [ -z "$(which gcloud)" ]; then
  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
fi

# install packages from piApts and apts (perhaps move apts to lin)
# apt list --installed

