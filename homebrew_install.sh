#!/usr/bin/env bash
# install_homebrew_ubuntu2404.sh — Installs Homebrew on Ubuntu 24.04

set -euo pipefail

# Install dependencies
sudo apt-get update -qq
sudo apt-get install -y build-essential procps curl file git

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to PATH
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

echo "Done. Open a new terminal or run: eval \"\$(brew shellenv)\""
