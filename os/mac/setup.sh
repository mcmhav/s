#!/usr/bin/env bash

INSTALL_PY_VERSION="3.8.12"
INSTALL_NODE_VERSION="16.14.0"

unquarantine() {
  xattr -d com.apple.quarantine /Applications/Alacritty.app
}

installStuff() {
  loggit "Installing mac stuff"
  while ! xcrun --version 1>/dev/null 2>&1; do
    xcode-select --install 2>/dev/null
    echo "Waiting for xcron/xcode-install"
    sleep 10
  done

  "$CSYS_PROGRAMS/brew/setup.sh"

  CFLAGS="-I$(brew --prefix openssl)/include"
  LDFLAGS="-L$(brew --prefix openssl)/lib"

  if [ -z "$(pyenv versions | grep INSTALL_PY_VERSION)" ]; then
    pyenv install --skip-existing "$INSTALL_PY_VERSION"
    pyenv global "$INSTALL_PY_VERSION"
  fi
  if [ -z "$(nodenv versions | grep INSTALL_NODE_VERSION)" ]; then
    nodenv install --skip-existing "$INSTALL_NODE_VERSION"
    nodenv global "$INSTALL_NODE_VERSION"
  fi

  "$CSYS_PROGRAMS/rust/setup.sh" --setup
  "$CSYS_PROGRAMS/rust/setup.sh" --installCargos

  # mac-os setup
  if [ ! -d ~/Pictures/screenshots ]; then
    mkdir ~/Pictures/screenshots
  fi

  defaults write com.apple.screencapture location ~/Pictures/screenshots

  defaults write com.apple.finder AppleShowAllFiles YES

  # app configs
  for file in "$CONFIG_HOME/configs/plists/"*; do
    ln -sf "$file" "$HOME/Library/Preferences/$(basename -- $file)"
  done

  # stop mouse from accelerating
  defaults write .GlobalPreferences com.apple.mouse.scaling -1
  defaults write -g com.apple.trackpad.scaling -float 1.5
  defaults write -g ApplePressAndHoldEnabled -bool false

  # keyboard input speeds
  defaults write -g KeyRepeat -int 3 # normal minimum is 2
  defaults write -g InitialKeyRepeat -int 20

  # Dock
  # defaults delete com.apple.dock autohide-delay; killall Dock
  defaults write com.apple.dock static-only -bool false
  killall Dock
  # defaults write com.apple.dock autohide-delay -float 1000; killall Dock

  # Menu bar:
  defaults write com.apple.menuextra.clock.plist DateFormat -string "HH:mm"
  # menubar? not working tho?
  # defaults write com.apple.controlcenter.plist "NSStatusItem Visible Sound" -bool false
  defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Battery -int 18
  defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -int 0
  defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 24
  defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Clock -int 18
  defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Sound -int 24
  defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist UserSwitcher -int 24
  defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist WiFi -int 24

  unquarantine
}

CONFIG_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
RETURN_TO=$(pwd)

cd "$CONFIG_HOME" || exit

installStuff

cd "$RETURN_TO" || exit