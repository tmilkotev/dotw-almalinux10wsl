#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== dotw-almalinux10wsl: START ==="

"$REPO_ROOT/scripts/pre-install.sh"
"$REPO_ROOT/scripts/install-packages.sh"
"$REPO_ROOT/scripts/post-install.sh"
"$REPO_ROOT/scripts/setup-check.sh"

echo "=== dotw-almalinux10wsl: COMPLETE ==="