#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "==> Installing Ansible"

  sudo apt-get update
  sudo apt-get install -y ansible
fi

echo "==> Running workstation provisioning"

cd "$ROOT/ansible"
ansible-playbook \
  -i inventory.ini \
  playbooks/workstation.yml
