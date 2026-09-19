# ubuntu-ide-setup

Personal scripts for setting up an IDE environment on Ubuntu 24.04.

## Requirements

- Ubuntu 24.04
- A non-root user with `sudo` privileges

## Infrastructure

Machine setup now lives in [`infrastructure/`](infrastructure/) and is split across three tools (see [`infrastructure/CONTEXT.md`](infrastructure/CONTEXT.md)):

| Tool | Responsibility |
|------|----------------|
| **Ansible** | System-level provisioning: OS packages, repos, services, Docker, permissions |
| **Homebrew** | User-level CLI utilities that don't need strict version pinning ([`Brewfile`](infrastructure/homebrew/Brewfile)) |
| **mise** | Version-pinned dev tools/runtimes: Node, Go, Neovim, lazygit ([`mise.toml`](infrastructure/ansible/mise/mise.toml)) |

**Install:**
```bash
bash infrastructure/bootstrap.sh
```
This installs Ansible if missing, then runs the `workstation.yml` playbook, which provisions the system (core, pyenv-build, docker roles) and the user environment (homebrew, mise roles).

## Neovim + LazyVim

| Script | Description |
|--------|-------------|
| `lazyvim/install.sh` | Orchestrator: backs up any existing config, then runs `lazyvim_starter_install.sh` |
| `lazyvim/lazyvim_starter_install.sh` | Clones the LazyVim starter config (called by `install.sh`, or run directly) |
| `lazyvim/neovim_uninstall.sh` | Removes Neovim binary and all config/data/cache dirs. Requires sudo and date confirmation |

```bash
bash lazyvim/install.sh
```

> **Note:** The uninstall script does not modify `~/.bashrc`. After running it, manually remove:
> ```
> export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
> ```
> Then run `source ~/.bashrc` (or restart your shell).

## Tmux

| Script | Description |
|--------|-------------|
| `tmux/dev-v1.sh` | Creates/attaches to a `dev1` tmux session with an `editor` window running `nvim` |

```bash
bash tmux/dev-v1.sh
```

> **Note:** `dev-v1.sh` hardcodes `EDITOR_DIR="~"`. Edit the script to point at your project directory before running.
