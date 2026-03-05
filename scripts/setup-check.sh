#!/usr/bin/env bash
set -euo pipefail

failures=0

pass() { echo "[PASS] $*"; }
fail() { echo "[FAIL] $*"; failures=$((failures+1)); }

check() {
  if command -v "$1" >/dev/null 2>&1; then
    pass "$1 found ($(command -v "$1"))"
  else
    fail "$1 missing"
  fi
}

echo ""
echo "=== CORE ==="
check git

echo ""
echo "=== LANGUAGES ==="
check python3
check pip3

echo ""
echo "=== INFRASTRUCTURE ==="
check ansible
check ansible-playbook
check awsume

echo ""
echo "=== DEVOPS TOOLS ==="
check jq

echo ""
if [[ $failures -eq 0 ]]; then
  echo "=== GREEN LIGHT: all checks passed ==="
  exit 0
else
  echo "=== RED LIGHT: failures = $failures ==="
  exit 1
fi