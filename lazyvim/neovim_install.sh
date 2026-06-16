#!/usr/bin/env bash
# Git page: https://github.com/neovim/neovim/releases
# install_neovim_ubuntu2404.sh — Installs Neovim 0.11.6 on Ubuntu 24.04
#
set -euo pipefail

REQUIRED_VERSION="0.11.6"

if command -v nvim &>/dev/null; then
  INSTALLED=$(nvim --version | head -1 | grep -oP '\d+\.\d+')
  if [[ "${INSTALLED}" == "${REQUIRED_VERSION}" ]]; then
    echo "Neovim ${INSTALLED} is already installed."
    exit 0
  else
    echo "Neovim ${INSTALLED} is installed but ${REQUIRED_VERSION} is required. Reinstalling..."
  fi
fi

TMP_DIR="/tmp/install/nvim"
mkdir -p "${TMP_DIR}"

curl -LO --output-dir "${TMP_DIR}" https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf "${TMP_DIR}/nvim-linux-x86_64.tar.gz"

echo 'export PATH="/opt/nvim-linux-x86_64/bin:$PATH"' >> ~/.bashrc
echo "Done. Run 'nvim --version' to verify."
