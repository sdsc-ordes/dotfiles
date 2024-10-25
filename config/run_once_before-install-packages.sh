#!/usr/bin/env bash

set -e
set -u

function install_ubuntu_packages() {
    echo "TODO: Add here some installation for ubuntu packages."
}

if [ "$CHEZMOI_OS_RELEASE_ID" = "ubuntu" ]; then
    install_ubuntu_packages
else
    echo "WARNING: Architecture '$CHEZMOI_OS_RELEASE_ID' not supported for installing packages." >&2
fi
