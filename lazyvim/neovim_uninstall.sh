#!/usr/bin/env bash
# neovim_uninstall.sh — Completely removes Neovim and all associated config/data dirs.
# Requires sudo. Prompts for today's date (MM/DD) as confirmation.
set -euo pipefail

# ── confirmation ────────────────────────────────────────────────────────────
EXPECTED=$(date +%m/%d)

echo "This will permanently delete:"
echo "  /opt/nvim-linux-x86_64   (Neovim binary)"
echo "  ~/.config/nvim           (config)"
echo "  ~/.local/share/nvim      (data / plugins)"
echo "  ~/.local/state/nvim      (state)"
echo "  ~/.cache/nvim            (cache)"
echo ""
read -rp "Enter today's date (MM/DD) to confirm: " INPUT

if [[ "${INPUT}" != "${EXPECTED}" ]]; then
  echo "Incorrect date. Aborting."
  exit 1
fi

# ── sudo check ──────────────────────────────────────────────────────────────
if ! sudo -v 2>/dev/null; then
  echo "sudo privileges required. Aborting."
  exit 1
fi

# ── remove binary ───────────────────────────────────────────────────────────
if [[ -d /opt/nvim-linux-x86_64 ]]; then
  echo "Removing /opt/nvim-linux-x86_64 ..."
  sudo rm -rf /opt/nvim-linux-x86_64
else
  echo "/opt/nvim-linux-x86_64 not found, skipping."
fi

# ── remove user dirs ────────────────────────────────────────────────────────
for DIR in \
  "${HOME}/.config/nvim" \
  "${HOME}/.local/share/nvim" \
  "${HOME}/.local/state/nvim" \
  "${HOME}/.cache/nvim"
do
  if [[ -e "${DIR}" ]]; then
    echo "Removing ${DIR} ..."
    rm -rf "${DIR}"
  else
    echo "${DIR} not found, skipping."
  fi
done

echo ""
echo "Neovim has been fully removed."
echo ""
echo "Manual step — remove the PATH entry from your shell config:"
echo "  1. Open ~/.bashrc (or ~/.zshrc / ~/.profile, whichever you use)"
echo "  2. Find and delete the line:"
echo '       export PATH="/opt/nvim-linux-x86_64/bin:$PATH"'
echo "  3. Save the file and run:  source ~/.bashrc"
