#!/usr/bin/env bash
# install_neovim_ubuntu2404.sh — Installs Neovim 0.11 on Ubuntu 24.04

set -euo pipefail

REQUIRED_VERSION="0.11"

if command -v nvim &>/dev/null; then
  INSTALLED=$(nvim --version | head -1 | grep -oP '\d+\.\d+')
  if [[ "${INSTALLED}" == "${REQUIRED_VERSION}" ]]; then
    echo "Neovim ${INSTALLED} is already installed."
    exit 0
  else
    echo "Neovim ${INSTALLED} is installed but ${REQUIRED_VERSION} is required. Reinstalling..."
  fi
fi

sudo apt-get update -qq
sudo apt-get install -y neovim=0.11*

echo "Done. Run 'nvim --version' to verify."
