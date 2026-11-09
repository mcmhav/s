#!/usr/bin/env bash

PACKAGE_COMMAND="kubectl"
# renovate: datasource=github-releases depName=kubernetes/kubernetes
VERSION="v1.37.2"

_install_release() {
    case "$(csys release --arch)" in
    armv6)
        # linux/arm is built with GOARM=7
        loggit warn "$PACKAGE_COMMAND: no prebuilt release for $(uname -m), skipping"
        return
        ;;
    esac
    csys release kubectl "$VERSION" \
        "https://dl.k8s.io/release/{version}/bin/linux/{goarch}/kubectl"
}

_install() {
    case $CSYS_OS in
    "$LIN_OS"*)
        _install_release
        ;;
    "$MAC_OS")
        brew install "$PACKAGE_COMMAND"
        ;;
    *)
        loggit warn "Unsupported OS: $CSYS_OS, pgk: $PACKAGE_COMMAND"
        exit 1
        ;;
    esac
}
_setup() {
    if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
        _install
    fi
}

_setup
