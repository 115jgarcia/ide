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
