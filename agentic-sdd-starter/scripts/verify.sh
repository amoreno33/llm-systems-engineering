#!/usr/bin/env bash
set -euo pipefail

echo "== Agentic SDD verify =="

if [ -f package.json ]; then
  if npm run | grep -q " lint"; then
    echo "Running lint..."
    npm run lint
  else
    echo "Skipping lint: script not found"
  fi

  if npm run | grep -q " typecheck"; then
    echo "Running typecheck..."
    npm run typecheck
  else
    echo "Skipping typecheck: script not found"
  fi

  if npm run | grep -q " test"; then
    echo "Running tests..."
    npm test
  else
    echo "Skipping tests: script not found"
  fi

  if npm run | grep -q " build"; then
    echo "Running build..."
    npm run build
  else
    echo "Skipping build: script not found"
  fi
else
  echo "No package.json found. Customize scripts/verify.sh for your stack."
fi

echo "Verification complete."
