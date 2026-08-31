#!/usr/bin/env bash
set -euo pipefail

sudo apt update

# check if tmux is already installed
if ! command -v tmux >/dev/null 2>&1; then
  sudo apt install -y tmux
fi

# install plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# append plugin config to ~/.tmux.conf if not already present
if ! grep -q "tpm/tpm" ~/.tmux.conf 2>/dev/null; then
  cat >> ~/.tmux.conf <<'EOF'

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
#set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF
fi

