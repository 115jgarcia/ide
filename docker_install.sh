#!/usr/bin/env bash
# docker_install.sh — Installs Docker on Ubuntu

set -euo pipefail

# Install Docker
sudo apt-get update -qq
sudo apt-get install -y docker.io

# Enable and start Docker service
sudo systemctl enable --now docker

# Add current user to docker group
sudo usermod -aG docker "$USER"

echo "Done. Log out and back in (or run: newgrp docker) for group changes to take effect."
