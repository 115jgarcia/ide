#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT/infrastructure/ansible"
INVENTORY="inventory.ini"
PLAYBOOK="playbooks/workstation.yml"

echo "==> Syntax check"
ansible-playbook -i "$INVENTORY" "$PLAYBOOK" --syntax-check

if command -v ansible-lint >/dev/null 2>&1; then
  echo "==> Lint"
  ansible-lint "$PLAYBOOK"
else
  echo "==> Skipping lint (ansible-lint not installed)"
fi

echo "==> Dry run (--check, best-effort)"
echo "    Note: the docker role's 'dpkg --print-architecture' is a command"
echo "    task, which Ansible skips under --check by default, so the"
echo "    downstream deb822_repository task will likely fail here. Expected —"
echo "    this dry run is best-effort. Full validation happens via dev/"
echo "    (a real VM)."
ansible-playbook -i "$INVENTORY" "$PLAYBOOK" --check ||
  echo "==> Dry run reported failures (see note above) — non-fatal for check.sh"
