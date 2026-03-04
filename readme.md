# Dotfiles

Cross-platform dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package | Contents |
|---------|----------|
| `zsh`   | `.zshrc` |
| `tmux`  | `.tmux.conf`, `.tmux/scripts/` |
| `pi`    | `.pi/agent/settings.json`, skills |

## Install

```bash
git clone git@github.com:jonsherrard/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Usage

```bash
# Stow a single package
stow -d ~/dotfiles -t ~ zsh

# Remove a package's symlinks
stow -d ~/dotfiles -t ~ -D tmux

# Re-stow after changes
stow -d ~/dotfiles -t ~ -R pi
```
