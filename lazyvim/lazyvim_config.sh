#!/usr/bin/env bash
# lazyvim_config.sh

set -euo pipefail

CONFIG_DIR="${HOME}/.config/nvim"

# ── Copy config files ──────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "${CONFIG_DIR}/lua/plugins"
cp -r "${SCRIPT_DIR}/nvim/." "${CONFIG_DIR}"

echo "Done. Open Neovim and run :checkhealth lazy to verify."
