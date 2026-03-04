#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Dotfiles directory: $DOTFILES_DIR"

# Install stow if missing
if ! command -v stow &>/dev/null; then
  echo "Installing stow..."
  if [[ "$(uname)" == "Darwin" ]]; then
    brew install stow
  else
    sudo apt-get install -y stow
  fi
fi

# Stow all packages
PACKAGES=(zsh tmux pi)

for pkg in "${PACKAGES[@]}"; do
  echo "Stowing $pkg..."
  stow -d "$DOTFILES_DIR" -t "$HOME" --adopt "$pkg" 2>/dev/null || \
  stow -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo ""
echo "✓ All packages stowed."
echo "  Run 'stow -d ~/dotfiles -t ~ <package>' to add individual packages."
echo "  Run 'stow -d ~/dotfiles -t ~ -D <package>' to remove a package."
