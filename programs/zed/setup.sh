#!/usr/bin/env bash

ZED_VERSION="0.159.10"

_install() {
	# ref. https://zed.dev/install.sh
	tmp="$(mktemp -d "/tmp/zed-XXXXXX")"
	curl -sL "https://github.com/zed-industries/zed/releases/download/v$ZED_VERSION/Zed.dmg" -o "$tmp/Zed.dmg"
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
}

_setup
