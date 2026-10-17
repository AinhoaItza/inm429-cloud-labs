#!/usr/bin/env bash
# Runs Nginx in a Docker container. Run on the VM: sudo bash setup-docker.sh
set -euo pipefail

# Free port 80: stop the host Nginx and keep it off after reboots
systemctl disable --now nginx || true

apt-get install -y docker.io
docker --version

# Remove an old container with the same name, then start a new one
docker rm -f nginx-container 2>/dev/null || true
docker run -d --name nginx-container -p 80:80 nginx
docker ps