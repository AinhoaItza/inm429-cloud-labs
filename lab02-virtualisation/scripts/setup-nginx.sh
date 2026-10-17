#!/usr/bin/env bash
# Installs Nginx directly on the VM. Run on the VM: sudo bash setup-nginx.sh
set -euo pipefail

apt-get update
apt-get install -y nginx
systemctl enable --now nginx
systemctl is-active nginx