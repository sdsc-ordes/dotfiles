#!/usr/bin/env bash

set -e
set -u

function install_ubuntu_packages() {
    echo "TODO: Add here some installation for ubuntu packages."
}

function install_macos_packages() {
    echo "TODO: Add here some installation for macOS packages."

    brew install git git-lfs coreutils findutils binutils gnu-sed gnu-tar gnu-time grep
}

if [ "$CHEZMOI_OS" = "darwin" ] ; then
    install_macos_packages
elif [ "$CHEZMOI_OS_RELEASE_ID" = "ubuntu" ]; then
    install_ubuntu_packages
else
    echo "WARNING: Architecture '$CHEZMOI_OS' not supported for installing packages." >&2
fi
