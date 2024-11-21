#!/usr/bin/env bash

set -e
set -u

function install_ubuntu_packages() {
    echo "TODO: Add here some installation for ubuntu packages."
}

function install_macos_packages() {
    echo "TODO: Add here some installation for macOS packages."

    if command -v brew &>/dev/null; then
        brew install \
            binutils \
            coreutils \
            findutils \
            git \
            git-lfs \
            gnu-sed \
            gnu-tar \
            gnu-time \
            bash \
            grep
    fi
}

if [ "$CHEZMOI_OS" = "darwin" ]; then
    install_macos_packages
elif [ "$CHEZMOI_OS_RELEASE_ID" = "ubuntu" ]; then
    install_ubuntu_packages
else
    echo "WARNING: Architecture '$CHEZMOI_OS' not supported for installing packages." >&2
fi
