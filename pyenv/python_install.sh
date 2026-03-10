#!/usr/bin/env bash
# configure_pyenv.sh — Ensures pyenv is properly configured in ~/.bashrc

set -euo pipefail

# Dependencies
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl git \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

pyenv install 3.12.3

if grep -q "pyenv" ~/.bashrc; then
  echo "pyenv is already configured in ~/.bashrc"
else
  echo "Add the following to your ~/.bashrc manually:"
  echo ""
  echo '  export PYENV_ROOT="$HOME/.pyenv"'
  echo '  export PATH="$PYENV_ROOT/bin:$PATH"'
  echo '  eval "$(pyenv init -)"'
  echo ""
  echo "Then run: source ~/.bashrc"
fi

