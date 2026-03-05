#!/usr/bin/env bash
set -euo pipefail

info() { echo "[INFO] $*"; }

info "Refreshing dnf metadata..."
sudo dnf -y makecache

info "Bootstrapping jq (required to read packages-dnf.json)..."
sudo dnf -y install jq