#!/usr/bin/env bash
# install.sh — Full LazyVim setup orchestrator

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Backup once upfront ────────────────────────────────────────────────────────
echo "==> Backing up existing Neovim config..."
source "${SCRIPT_DIR}/lazyvim_backup.sh"

export SKIP_BACKUP=true

# ── Steps ─────────────────────────────────────────────────────────────────────
echo "==> Installing LazyVim starter..."
bash "${SCRIPT_DIR}/lazyvim_starter_install.sh"

echo "==> Done. Open Neovim and run :checkhealth lazy to verify."
