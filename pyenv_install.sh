#!/usr/bin/env bash
## Link: https://github.com/pyenv/pyenv
# install_pyenv.sh — Installs pyenv via Homebrew

set -euo pipefail

if command -v brew &>/dev/null; then
  echo "Homebrew detected. Installing pyenv via brew..."
  brew update
  brew install pyenv
else
  echo "Homebrew not found. Installing pyenv via curl..."
  curl -fsSL https://pyenv.run | bash
fi

echo "Done. Run 'pyenv --version' to verify."
