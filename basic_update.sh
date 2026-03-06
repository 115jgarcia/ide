#!/usr/bin/env bash
# update_packages.sh — Updates and upgrades all apt packages

set -euo pipefail

echo "Updating package lists..."
sudo apt-get update -qq

echo "Upgrading packages..."
sudo apt-get upgrade -y

echo "Removing unused packages..."
sudo apt-get autoremove -y

echo "Done."
