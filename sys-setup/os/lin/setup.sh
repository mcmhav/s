#!/usr/bin/env bash

echo "TODO - more"

sudo apt-get update
sudo apt-get upgrade

# could be shared with pi
# TODO: should make shared linux-setup with pi, pi and linux have intercecting sys
if [ -z $(command -v nvm) ]; then
  mkdir "$HOME/.nvm"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
fi
