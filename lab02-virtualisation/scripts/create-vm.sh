#!/usr/bin/env bash
# Creates the VM for INM429 Lab 2 (Nginx on a VM vs in a container).
# Run from your computer or Cloud Shell, with gcloud logged in.
set -euo pipefail

PROJECT="inm429-lab2"
ZONE="europe-west2-c"
VM_NAME="nginx-vm"

# Allow HTTP (port 80) to VMs tagged http-server, if the rule does not exist yet
if ! gcloud compute firewall-rules describe default-allow-http --project="$PROJECT" >/dev/null 2>&1; then
  gcloud compute firewall-rules create default-allow-http \
    --project="$PROJECT" \
    --network=default \
    --allow=tcp:80 \
    --target-tags=http-server \
    --source-ranges=0.0.0.0/0
fi

gcloud compute instances create "$VM_NAME" \
  --project="$PROJECT" \
  --zone="$ZONE" \
  --machine-type=e2-medium \
  --image-family=debian-13 \
  --image-project=debian-cloud \
  --boot-disk-size=10GB \
  --boot-disk-type=pd-balanced \
  --tags=http-server

echo "External IP:"
gcloud compute instances describe "$VM_NAME" --project="$PROJECT" --zone="$ZONE" \
  --format='get(networkInterfaces[0].accessConfigs[0].natIP)'