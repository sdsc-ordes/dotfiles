set positional-arguments
set shell := ["bash", "-cue"]
root_dir := justfile_directory()

# Test the configuration in a container.
test-in-container: build-image
    #!/usr/bin/env bash
    podman run --rm -it \
        -v "$(pwd):/workspace-tmp" \
        -w /workspace-tmp dotfiles:latest \
        ./tools/test.sh

build-image:
    podman build -f tools/ci/images/Containerfile . -t "dotfiles"

# Apply all configs, also encrypted ones.
apply-configs:
    just cm apply

# Apply all configs but not encrypted ones.
apply-configs-exclude-encrypted:
    chezmoi apply --exclude encrypted

# Encrypt a file using the encryptiong configured
# in `.chezmoi.yaml`.
# This is using the public key.
[no-cd]
encrypt file:
    chezmoi encrypt "{{file}}"

# Decrypt a file using the encryption configured.
# You need `store-kefile-private-key` executed.
# This does actually the following:
# pkey=$(secret-tool lookup chezmoi keyfile-private-key 2>/dev/null) && \
# echo "$pkey" | age -d -i - "{{root_dir}}/config/dot_config/chezmoi/key.age" | age -d -i - "{{file}}"
[no-cd]
decrypt file:
    just cm decrypt {{file}}

# Decrypt and edit the file.
# You need `store-kefile-private-key` executed.
[no-cd]
decrypt-edit file:
    just cm edit "{{file}}"

# This is a wrapper to `chezmoi`.
# TODO: The initial version provides the necessary encryption
# key temporarily and deletes it afterwards again.
# This is only used for invocations which need the private key.
# This needs `store-kefile-private-key` to be run.
[no-cd]
cm *args:
    chezmoi "$@"
