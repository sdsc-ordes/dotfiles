set positional-arguments
set shell := ["bash", "-cue"]
root_dir := justfile_directory()

container_mgr := "podman"

# This is a wrapper to `chezmoi`.
[no-cd]
cm *args:
    chezmoi "$@"

# Test the configuration in a container.
test-in-container *args: build-image
    #!/usr/bin/env bash
    "{{container_mgr}}" run --rm -it \
        -v "$(pwd):/workspace-tmp" \
        -w /workspace-tmp dotfiles:latest \
        ./tools/test.sh "$@"

build-image:
    "{{container_mgr}}" build -f tools/ci/images/Containerfile . -t "dotfiles"

# Apply all configs, also encrypted ones.
apply-configs:
    just cm apply
