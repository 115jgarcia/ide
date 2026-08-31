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
| 3 | `pyenv/pyenv_install.sh` | Installs pyenv and Python build dependencies |
| 4 | `lazyvim/install.sh` | Full Neovim + LazyVim orchestrator (recommended) |
| 5 | `tmux/install_tmux.sh` | Installs tmux and TPM (Tmux Plugin Manager) |

### Neovim + LazyVim — individual scripts (run in order)

| Order | Script | Description |
|-------|--------|-------------|
| 1 | `lazyvim/neovim_install.sh` | Installs Neovim 0.12.4 to `/opt/nvim-linux-x86_64` and adds it to `~/.bashrc` |
| 2 | `lazyvim/lazyvim_dep.sh` | Installs NVM, Node 24, and Go (required for LSPs) |
| 3 | `lazyvim/lazyvim_starter_install.sh` | Clones [custom LazyVim starter](https://github.com/115jgarcia/lazyVimStarter) config |
| 4 | `lazyvim/lazyvim_config.sh` | Copies plugin and LSP config files into `~/.config/nvim` |

### Uninstall

| Script | Description |
|--------|-------------|
| `lazyvim/neovim_uninstall.sh` | Removes Neovim binary and all config/data/cache dirs. Requires sudo and date confirmation. |

> **Note:** The uninstall script does not modify `~/.bashrc`. After running it, manually remove the following line from your shell config:
> ```
> export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
> ```
> Then run `source ~/.bashrc` (or restart your shell).

### Tmux

| Script | Description |
|--------|-------------|
| `tmux/install_tmux.sh` | Installs tmux and TPM (Tmux Plugin Manager) |
| `tmux/dev-v1.sh` | Creates/attaches to a `dev1` tmux session with an `editor` window running `nvim` |

> **Note:** `dev-v1.sh` hardcodes `EDITOR_DIR="~"`. Edit the script to point at your project directory before running.

## Usage

**Full Neovim + LazyVim install (recommended):**
```bash
bash lazyvim/install.sh
```
This backs up any existing config, then runs all four steps in order.

**Individual scripts:**
```bash
bash lazyvim/neovim_install.sh
bash lazyvim/lazyvim_dep.sh
bash lazyvim/lazyvim_starter_install.sh
bash lazyvim/lazyvim_config.sh
```

**Uninstall:**
```bash
bash lazyvim/neovim_uninstall.sh
```
Requires sudo. You will be prompted to enter today's date (MM/DD) to confirm.

**Tmux:**
```bash
bash tmux/install_tmux.sh
bash tmux/dev-v1.sh
```
