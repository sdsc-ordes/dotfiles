{
  description = "dotfiles";

  nixConfig = {
    substituters = [
      # Add here some other mirror if needed.
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      # Nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgsStable.url = "github:nixos/nixpkgs/nixos-23.11";
    # Also see the 'stable-packages' overlay at 'overlays/default.nix'.

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgsStable,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem
    # Creates an attribute map `{ devShells.<system>.default = ...}`
    # by calling this function:
    (
      system: let
        # Import nixpkgs and load it into pkgs.
        pkgs = import nixpkgs {
          inherit system;
        };

        # Things needed only at compile-time.
        nativeBuildInputs = with pkgs; [
          just
          chezmoi
          podman
        ];

        nbi-ci = with pkgs;
          nativeBuildInputs
          ++ [
            coreutils
            findutils
            binutils
            tree
            zsh
          ];

        # Things needed at runtime.
        buildInputs = [];
      in {
        devShells.default = pkgs.mkShell {
          inherit buildInputs nativeBuildInputs;
        };

        devShells.ci = pkgs.mkShell {
          inherit buildInputs;
          nativeBuildInputs = nbi-ci;
        };
      }
    );
}
