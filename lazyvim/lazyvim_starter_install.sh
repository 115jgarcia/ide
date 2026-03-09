#!/usr/bin/env bash
# install_lazyvim.sh — Installs LazyVim starter config

set -euo pipefail

# Backup existing configs
echo "Backing up existing Neovim configs..."
mv ~/.config/nvim{,.bak}                        # required
[[ -d ~/.local/share/nvim ]]  && mv ~/.local/share/nvim{,.bak}
[[ -d ~/.local/state/nvim ]]  && mv ~/.local/state/nvim{,.bak}
[[ -d ~/.cache/nvim ]]        && mv ~/.cache/nvim{,.bak}

# Clone LazyVim starter
echo "Cloning LazyVim starter..."
git clone https://https://github.com/115jgarcia/lazyVimStarter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "Done. Start Neovim with: nvim"

