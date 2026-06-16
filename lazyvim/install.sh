#!/usr/bin/env bash
# install.sh — Full LazyVim setup orchestrator

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Backup once upfront ────────────────────────────────────────────────────────
echo "==> Backing up existing Neovim config..."
source "${SCRIPT_DIR}/lazyvim_backup.sh"

export SKIP_BACKUP=true

# ── Steps ─────────────────────────────────────────────────────────────────────
echo "==> Installing Neovim..."
bash "${SCRIPT_DIR}/neovim_install.sh"

echo "==> Installing dependencies..."
bash "${SCRIPT_DIR}/lazyvim_dep.sh"

echo "==> Installing LazyVim starter..."
bash "${SCRIPT_DIR}/lazyvim_starter_install.sh"

echo "==> Applying custom config..."
bash "${SCRIPT_DIR}/lazyvim_config.sh"

echo "==> Done. Open Neovim and run :checkhealth lazy to verify."
