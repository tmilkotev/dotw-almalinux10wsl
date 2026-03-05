#!/usr/bin/env bash
set -euo pipefail

info() { echo "[INFO] $*"; }
warn() { echo "[WARN] $*"; }

if ! command -v python3 >/dev/null 2>&1; then
  warn "python3 not found; skipping awsume install."
  exit 0
fi

if ! python3 -m pip --version >/dev/null 2>&1; then
  warn "pip not available for python3; ensure python3-pip is installed."
  exit 0
fi

info "Upgrading pip..."
python3 -m pip install --upgrade pip

info "Installing/Upgrading awsume..."
python3 -m pip install --upgrade awsume

info "Post-install complete."