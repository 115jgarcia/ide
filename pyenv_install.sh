#!/usr/bin/env bash
## Link: https://github.com/pyenv/pyenv
# install_pyenv.sh — Installs pyenv via Homebrew

set -euo pipefail

if command -v brew &>/dev/null; then
  echo "Homebrew detected. Installing pyenv via brew..."
  brew update
  brew install pyenv
  # Python build dependencies
  brew install openssl readline sqlite3 xz tcl-tk@8 libb2 zstd zlib pkgconfig
else
  echo "Homebrew not found. Installing pyenv via curl..."
  curl -fsSL https://pyenv.run | bash
  # Python build dependencies
  sudo apt-get update -qq
  sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl git \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
fi

echo "Done. Run 'pyenv --version' to verify."
