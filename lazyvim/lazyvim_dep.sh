#!/usr/bin/env bash
set -e

# -----------------------------
# Versions
# -----------------------------
NVM_VERSION="v0.40.4"
NODE_VERSION="24.14.0"
GO_VERSION="1.26.1"

# -----------------------------
# Install NVM
# -----------------------------
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing NVM..."
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

# -----------------------------
# Install Node
# -----------------------------
if ! nvm ls "$NODE_VERSION" >/dev/null 2>&1; then
  echo "Installing Node $NODE_VERSION..."
  nvm install "$NODE_VERSION"
fi

nvm use "$NODE_VERSION"

# -----------------------------
# Install Go (for sqls LSP)
# -----------------------------
GO_TAR="go${GO_VERSION}.linux-amd64.tar.gz"

if ! command -v go >/dev/null 2>&1; then
  echo "Installing Go $GO_VERSION..."

  curl -fsLO https://go.dev/dl/${GO_TAR}

  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf ${GO_TAR}

  rm -f ${GO_TAR}
fi

# -----------------------------
# Ensure Go PATH
# -----------------------------
if ! grep -q "/usr/local/go/bin" "$HOME/.bashrc"; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.bashrc"
fi

export PATH=$PATH:/usr/local/go/bin

# -----------------------------
# Done
# -----------------------------
echo "Setup complete!"
echo "Node: $(node -v)"
echo "NPM:  $(npm -v)"
echo "Go:   $(go version)"
