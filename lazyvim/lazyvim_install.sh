#!/usr/bin/env bash
# install_lazyvim.sh — Installs lazy.nvim using the Structured Setup

set -euo pipefail

CONFIG_DIR="${HOME}/.config/nvim"

# ── Backup existing config ─────────────────────────────────────────────────────
if [[ "${SKIP_BACKUP:-false}" != "true" ]]; then
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
fi

# ── Copy config files ──────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "${CONFIG_DIR}/lua/plugins"
cp -r "${SCRIPT_DIR}/nvim/." "${CONFIG_DIR}"

echo "Done. Open Neovim and run :checkhealth lazy to verify."
