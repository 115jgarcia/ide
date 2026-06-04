#!/usr/bin/env bash
# install_lazyvim.sh — Installs lazy.nvim using the Structured Setup

set -euo pipefail

CONFIG_DIR="${HOME}/.config/nvim"

# ── Backup existing config ─────────────────────────────────────────────────────
BACKUP_ROOT="./neovimBak"
BACKUP_DATE="$(date +%Y%m%d)"
BACKUP_DIR="${BACKUP_ROOT}/${BACKUP_DATE}"

mkdir -p "$BACKUP_DIR"

backup_dir () {
  if [[ -d "$1" ]]; then
    echo "Backing up $1 → $BACKUP_DIR"
    mv "$1" "$BACKUP_DIR/"
  fi
}

backup_dir "$HOME/.config/nvim"
backup_dir "$HOME/.local/share/nvim"
backup_dir "$HOME/.local/state/nvim"
backup_dir "$HOME/.cache/nvim"

# ── Create directory structure ─────────────────────────────────────────────────
mkdir -p "${CONFIG_DIR}/lua/config"
mkdir -p "${CONFIG_DIR}/lua/plugins"

# ── Create init.lua ────────────────────────────────────────────────────────────
cat > "${CONFIG_DIR}/init.lua" << 'EOF'
require("config.lazy")

-- Sync native editor registers with your system clipboard
vim.opt.clipboard = "unnamedplus"

-- Disable all legacy external language providers to boost startup speed
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider  = 0 -- Disables legacy Python 2 check
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_ruby_provider    = 0
EOF

# ── Create lua/config/lazy.lua ─────────────────────────────────────────────────
cat > "${CONFIG_DIR}/lua/config/lazy.lua" << 'EOF'
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leaders before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
EOF

echo "Done. Open Neovim and run :checkhealth lazy to verify."
