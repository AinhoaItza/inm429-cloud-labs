# Memory results – Lab 2

Measured on 16 Oct 2026 on an e2-medium VM (Debian 13, europe-west2-c), idle server.

| Component | cgroup (systemctl / docker stats) | RSS (ps) |
| --- | --- | --- |
| Nginx on the VM | 2.8 MB | 15.3 MB |
| Nginx in the container | 3.37 MB | 16.8 MB |
| Docker engine (dockerd) | 234.8 MB (incl. page cache) | 98.0 MB |
| containerd | 20.2 MB | 47.5 MB |