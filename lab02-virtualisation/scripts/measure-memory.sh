#!/usr/bin/env bash
# Prints memory measurements. Run on the VM: sudo bash measure-memory.sh
set -uo pipefail

sum_rss() {  # total RSS of all processes with this name, in MB
  ps -C "$1" -o rss= | awk '{s+=$1} END {printf "%.1f MB\n", s/1024}'
}

echo "== Nginx processes (RSS, whichever Nginx is running) =="
sum_rss nginx

echo "== Host Nginx service (cgroup) =="
systemctl status nginx --no-pager 2>/dev/null | grep 'Memory:' || echo "not running"

echo "== Nginx container (cgroup) =="
docker stats --no-stream --format '{{.Name}}: {{.MemUsage}}' 2>/dev/null || echo "Docker not installed"

echo "== Docker engine =="
for svc in docker containerd; do
  echo "$svc (cgroup): $(systemctl status "$svc" --no-pager 2>/dev/null | grep 'Memory:' | xargs)"
done
echo "dockerd (RSS):    $(sum_rss dockerd)"
echo "containerd (RSS): $(sum_rss containerd)"