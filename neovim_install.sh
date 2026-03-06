#!/usr/bin/env bash
# install_neovim_ubuntu2404.sh — Installs Neovim 0.11 on Ubuntu 24.04

set -euo pipefail

sudo apt-get update -qq
sudo apt-get install -y neovim=0.11*

echo "Done. Run 'nvim --version' to verify."
