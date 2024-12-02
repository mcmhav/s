#!/usr/bin/env bash

ZED_SERVER_VERSION="0.163.2"

_install() {
	tmp="$(mktemp -d "/tmp/zed-XXXXXX")"

	# https://zed.dev/docs/remote-development?highlight=ssh#initializing-the-remote-server
	curl -L "https://github.com/zed-industries/zed/releases/download/v$ZED_SERVER_VERSION/zed-remote-server-linux-x86_64.gz" \
		-o "$tmp/zed-remote-server-stable-linux-x86_64.gz"

	gzip -d "$tmp/zed-remote-server-stable-linux-x86_64.gz"
	chmod +x "$tmp/zed-remote-server-stable-linux-x86_64"
	mkdir -p "$HOME/.zed_server"
	cp "$tmp/zed-remote-server-stable-linux-x86_64" "$HOME/.zed_server"
}

_setup() {
	# https://zed.dev/docs/remote-development?highlight=ssh#initializing-the-remote-server
	if [ ! -f "$HOME/.zed_server/zed-remote-server-stable-linux-x86_64" ]; then
		_install
	fi
}

_setup
