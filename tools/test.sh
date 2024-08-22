#!/usr/bin/env bash

set -u
set -e

function main() {
    if [ -z "${IN_NIX_SHELL:-}" ]; then
        cp -r /workspace-tmp ~/workspace &&
            cd ~/workspace &&
            git clean -dfX &&
            rm -rf .git &&
            git init && git add . &&
            git config --global --list &&
            git commit -a -m "ci: init"

        echo "Entering Nix shell."
        exec sudo nix develop --accept-flake-config ./tools/nix#ci \
            --command "./tools/test.sh" "$@"
    fi

    if [ "$(id -un)" != "ci" ]; then
        echo "Switching to user 'ci'."
        chown -R ci:ci "$TMPDIR"
        exec sudo -E -u ci -H "./tools/test.sh" "$@"
    fi

    test
}

function test() {
    echo "Test Chezmoi apply and enter ZSH"
    cd ~/workspace
    echo "cwd: $(pwd)"
    echo "id: $(id)"
    echo "tmp: $TMPDIR, $(ls -ald "$TMPDIR")"
    # env | sort -u

    local workspace="private"
    chezmoi init --promptChoice "Workspace?=$workspace" ./
    cd ~/.local/share/chezmoi
    chezmoi apply

    tree -L 2 ~/.config

    zsh
}

main "$@"
