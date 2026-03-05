#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

CONFIG="$REPO_ROOT/packages/packages-dnf.json"

info() { echo "[INFO] $*"; }
fail() { echo "[FAIL] $*"; exit 1; }

command -v jq >/dev/null 2>&1 || fail "jq is required but not installed (pre-install.sh should install it)"

install_group() {
  local group="$1"
  if jq -e --arg g "$group" '.[$g] != null' "$CONFIG" >/dev/null; then
    info "Installing group: $group"
    jq -r --arg g "$group" '.[$g][]' "$CONFIG" | while read -r pkg; do
      info "-> $pkg"
      sudo dnf -y install "$pkg"
    done
  else
    info "Group not found in config (skipping): $group"
  fi
}

install_group "base"
install_group "devops"

info "Package installation complete."