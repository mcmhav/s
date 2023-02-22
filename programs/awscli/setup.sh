#!/usr/bin/env bash

PACKAGE_COMMAND="aws"

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    case "$CSYS_OS" in
    "$LIN_OS")
      curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -so "/tmp/awscliv2.zip"
      unzip -qo /tmp/awscliv2.zip -d /tmp
      sudo /tmp/aws/install
      ;;
    "$MAC_OS")
      brew install awscli
      ;;
    "*") ;;
    esac
  fi
}

_setup
