<h1 align="center">
    <img src="docs/logo.svg" style="width:150px" align="center"/>
    Dotfiles Starter Repository
    <br>
</h1>

A starter repository to get you started with `chezmoi` and your precious config
files on your system (dotfiles).

## How Does It Work?

This repository acts as a repository for [`chezmoi`](https://www.chezmoi.io).
The tool `chezmoi` manages your configuration files between a Git repo to your
`$HOME` directory (or somewhere else).

In this repo only `zsh` and `git` config files are managed for you as a
**starter config**. The ZSH setup is a nice structured setup which provides the
basic.

The tool `chezmoi` default behavior works by first initiating it with
`chezmoi init <repo>` which will clone the `<repo>` by default to
`~/.config/local/chezmoi`. Any `chezmoi apply` will take managed files in your
[`config`](./config) and apply it to your `$HOME` folder (if you made change for
any managed files in your home folder, `chezmoi` will prompt you to overwrite).

## Usage

### Create Your Dotfiles from This Template

Either use this repository on Github as a template (i.e. "Use this template") or
create your own repository with clone `url = ...` (e.g. on Github) to fork this
template repository (you cannot make forks private!) and make it private, that
is:

```shell
cd ~/myrepos
git clone https://github.com/sdsc-ordes/dotfiles.git

# Replace `<url>` with your repository url.
cd dotfiles &&
    git remote set-url origin "<url>" &&
    git push
```

### Configure `.chezmoi.yaml.tmpl`

Edit the file [`.chezmoi.yaml.tmpl`](config/.chezmoi.yaml.tmpl) to fit your
needs. That means change the `git.userName` and `git.userEmail` values for
example. Configure other files to your needs.

### Initialize

Then on the machine where you want to apply this dotfile setup:

```shell
chezmoi init <url>
```

### Apply

Then apply the dotfiles in this repository to your home folder `~/` with

```shell
chezmoi apply --dry-run --verbose
```

> [!CAUTION] This will overwrite files managed in [`config`](config) in your
> home folder `~`. To do it remove `--dry-run`.

## Test in Container

You can **test this dotfiles setup** in this repo safely **in a container** by
doing

```shell
just test-in-container
# or with docker
just container_mgr=docker test-in-container
```

This will log you into ZSH in a container (to not mess with your system) to test
out the ZSH and Git settings and to get a look and feel of Chezmoi.

For the impatient do `just test-in-container --apply`, for the ones wanting a
follow through jump through the next sections.

### Initialize `chezmoi`

```shell
cd ~/workspace
chezmoi init ./
```

### Apply all Configuration Files

```
cd ~/.local/config/chezmoi
chezmoi apply
```

and inspect the changes with

```shell
tree ~/.config
```

### Login again into ZSH

```shell
zsh
```

Which will directly use all config files, install ZSH plugin on startup and
present you with a nice prompt like this:

```text
╭─     ~/.local/share/chezmoi on    master ·······························································································   impure
╰─❯
```
