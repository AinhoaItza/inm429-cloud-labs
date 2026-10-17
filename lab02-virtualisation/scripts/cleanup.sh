#!/usr/bin/env bash
# Deletes the lab VM. Run from your computer or Cloud Shell.
set -euo pipefail

gcloud compute instances delete nginx-vm \
  --project=inm429-lab2 \
  --zone=europe-west2-c \
  --quiet