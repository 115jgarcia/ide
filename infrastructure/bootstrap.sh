#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "==> Installing Ansible"

  sudo apt-get update
  sudo apt-get install -y ansible
fi

echo "==> Running workstation provisioning"

ansible-playbook \
  -i "$ROOT/ansible/inventory.ini" \
  "$ROOT/ansible/playbooks/workstation.yml"
