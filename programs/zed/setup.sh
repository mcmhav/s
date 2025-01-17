#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ZED_VERSION="0.169.2"

_install() {
	# ref. https://zed.dev/install.sh
	tmp="$(mktemp -d "/tmp/zed-XXXXXX")"
	curl -sL "https://github.com/zed-industries/zed/releases/download/v$ZED_VERSION/Zed-x86_64.dmg" -o "$tmp/Zed.dmg"
	hdiutil attach -quiet "$tmp/Zed.dmg" -mountpoint "$tmp/mount"

	mkdir -p "$HOME/.local/zed/Applications"
	ditto "$tmp/mount/Zed.app" "$HOME/.local/zed/Applications/Zed.app"
	hdiutil detach -quiet "$tmp/mount"

	ln -sf "$HOME/.local/zed/Applications/Zed.app/Contents/MacOS/cli" "$HOME/.local/bin/zed"
}

_setup() {
	if ! command -v zed &>/dev/null; then
		_install
	fi

	ln -sf "$SCRIPT_PATH/config/keymap.json" "$HOME/.config/zed/"
	ln -sf "$SCRIPT_PATH/config/settings.json" "$HOME/.config/zed/"
}

_setup
