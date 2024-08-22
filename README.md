<h1 align="center">
    <img src="docs/logo.svg" style="width:150px" align="center"/>
    Dotfiles Starter Repository
    <br>
</h1>

# Dotfiles Repo

A starter repository to get you started with `chezmoi` and your precious config
files on your system (dotfiles).

## How Does It Work?

This repository acts as a repository for [`chezmoi`](https://www.chezmoi.io).
The tool `chezmoi` manages your configuration files between a Git repo to your
`$HOME` directory (or somewhere else).

In this repo only `zsh` and `git` config files are managed for you as a starter
config. The ZSH setup is a nice structured setup which provides the basic.

The tool `chezmoi` default behavior works by first initiating it with
`chezmoi init <repo>` which will clone the `<repo>` by default to
`~/.config/local/chezmoi`. Any `chezmoi apply` will take managed files in your
[`config`](./config) and apply it to your `$HOME` folder (if you made change for
any managed files in your home folder, `chezmoi` will prompt you to overwrite).

## Test Setup in Container

```shell
just test-in-container
# or with docker
just container_mgr=docker test-in-container
```

This will log you into ZSH in a container (to not mess with your system) to test
out the ZSH and Git settings and to get a look and feel of Chezmoi.
