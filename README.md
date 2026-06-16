# ubuntu-ide-setup

Personal scripts for setting up an IDE environment on Ubuntu 24.04.

## Requirements

- Ubuntu 24.04
- A non-root user with `sudo` privileges

## Scripts

| Order | Script | Description |
|-------|--------|-------------|
| 1 | `basic_update.sh` | Updates and upgrades apt packages |
| 2 | `homebrew_install.sh` | Installs Homebrew |
| 3 | `pyenv_install.sh` | Installs pyenv and Python build dependencies |
| 4 | `neovim_install.sh` | Installs Neovim 0.11 |
| 5 | `lazyvim_install.sh` | Install LazyVim | 

## LSPs & Linters

| Language | LSP | Linter/Formatter |
|----------|-----|-----------------|
| Python | `pyright` | `ruff` |
| SQL | `dadbod` (database client) | `sqlfluff` |
| YAML | `yaml-language-server` | — |
| Lua | `lua-language-server` | `stylua` |
| Shell | — | `shfmt` |

## Usage

Run individually:
```bash
chmod +x script.sh
./script.sh
```

Run all in order:
```bash
chmod +x *.sh && ./basic_update.sh && ./homebrew_install.sh && ./pyenv_install.sh && ./neovim_install.sh
```
