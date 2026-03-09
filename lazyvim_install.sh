#!/usr/bin/env bash
# install_lazyvim.sh — Installs lazy.nvim using the Structured Setup

set -euo pipefail

CONFIG_DIR="${HOME}/.config/nvim"

# ── Backup existing config ─────────────────────────────────────────────────────
if [[ -d "${CONFIG_DIR}" ]]; then
  echo "Existing Neovim config found. Backing up to ~/.config/nvim.bak..."
  mv "${CONFIG_DIR}" "${HOME}/.config/nvim.bak"
fi

# ── Create directory structure ─────────────────────────────────────────────────
mkdir -p "${CONFIG_DIR}/lua/config"
mkdir -p "${CONFIG_DIR}/lua/plugins"

# ── Create init.lua ────────────────────────────────────────────────────────────
cat > "${CONFIG_DIR}/init.lua" << 'EOF'
require("config.lazy")
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
