#!/usr/bin/env bash
# install_lazyvim.sh — Installs LazyVim starter config

set -euo pipefail

if [[ "${SKIP_BACKUP:-false}" != "true" ]]; then
  TMP_BACKUP="/tmp/nvim_backup"
  mkdir -p "${TMP_BACKUP}"

  # Move to temp
  echo "Backing up to temp..."
  [[ -d ~/.config/nvim ]] && mv ~/.config/nvim "${TMP_BACKUP}/"
  [[ -d ~/.local/share/nvim ]] && mv ~/.local/share/nvim "${TMP_BACKUP}/share_nvim"
  [[ -d ~/.local/state/nvim ]] && mv ~/.local/state/nvim "${TMP_BACKUP}/state_nvim"
  [[ -d ~/.cache/nvim ]] && mv ~/.cache/nvim "${TMP_BACKUP}/cache_nvim"

  # Revert from temp on failure
  revert_backups() {
    echo "Something went wrong. Reverting..."
    [[ -d "${TMP_BACKUP}/nvim" ]] && mv "${TMP_BACKUP}/nvim" ~/.config/nvim
    [[ -d "${TMP_BACKUP}/share_nvim" ]] && mv "${TMP_BACKUP}/share_nvim" ~/.local/share/nvim
    [[ -d "${TMP_BACKUP}/state_nvim" ]] && mv "${TMP_BACKUP}/state_nvim" ~/.local/state/nvim
    [[ -d "${TMP_BACKUP}/cache_nvim" ]] && mv "${TMP_BACKUP}/cache_nvim" ~/.cache/nvim
  }

  trap revert_backups ERR
fi

# Install dependencies
sudo apt-get install unzip xclip

# Clone LazyVim starter
echo "Cloning LazyVim starter..."
git clone --branch v1.1.0 --depth 1 https://github.com/115jgarcia/lazyVimStarter.git ~/.config/nvim > /dev/null 2>&1
rm -rf ~/.config/nvim/.git

# Cleanup temp on success
echo "Install successful. Cleaning up temp backups..."
rm -rf "${TMP_BACKUP}"

echo "Done. Start Neovim with: nvim"
