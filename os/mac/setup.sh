#!/usr/bin/env bash

_unquarantine() {
  xattr -d com.apple.quarantine /Applications/Alacritty.app 2>/dev/null
  xattr -d com.apple.quarantine /Applications/Hyper.app 2>/dev/null
  xattr -d com.apple.quarantine "/Applications/Brave Browser.app" 2>/dev/null
}

_launchctl_setup() {
  for file in "$SCRIPT_PATH/configs/LaunchAgents/"*; do
    ln -sf "$file" "$HOME/Library/LaunchAgents/"
    filename=$(basename -- "$file")
    filename_base="${filename%.*}"
    if launchctl list | grep "$filename_base" >/dev/null; then
      launchctl unload "$HOME/Library/LaunchAgents/$filename"
    fi
    launchctl load "$HOME/Library/LaunchAgents/$filename"
  done
}

_install() {
  loggit "Installing mac stuff"
  while ! xcrun --version 1>/dev/null 2>&1; do
    xcode-select --install 2>/dev/null
    echo "Waiting for xcron/xcode-install"
    sleep 10
  done

  loggit "Installing brew"
  csys install brew
  loggit "Installing csys-reqs"
  csys reqs-install "$SCRIPT_PATH/reqs"

  loggit "Setting mac preferences"
  # mac-os setup
  # Screenshots
  mkdir -p ~/Pictures/screenshots
  defaults write com.apple.screencapture location ~/Pictures/screenshots

  defaults write com.apple.finder AppleShowAllFiles YES

  # app configs
  for file in "$SCRIPT_PATH/configs/plists/"*; do
    ln -sf "$file" "$HOME/Library/Preferences/"
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

  # Change computer name (for bluethooth/localhost/network):
  # scutil --set ComputerName c

  _unquarantine
  _launchctl_setup

  # setup at
  sudo launchctl bootstrap system /System/Library/LaunchDaemons/com.apple.atrun.plist
  sudo launchctl enable system/com.apple.atrun
  sudo launchctl list com.apple.atrun
  # might also need to give terminal (Alacritty) or `/usr/libexec/atrun` `Full Disk Access`

  # mac update packages
  softwareupdate --all --install --force
}

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
RETURN_TO=$(pwd)

cd "$SCRIPT_PATH" || exit

_install

cd "$RETURN_TO" || exit
