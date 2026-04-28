#!/usr/bin/env bash
set -euo pipefail

# Soft guard: warns when code is edited without any specs directory or explicit spec.
# Customize to make this blocking (exit 2) for protected branches or sensitive paths.

INPUT="$(cat || true)"

if [ ! -d "specs" ]; then
  echo "Warning: specs/ directory not found. Consider creating one for non-trivial changes." >&2
  exit 0
fi

# Blocking example for sensitive paths:
if echo "$INPUT" | grep -Eiq '"file_path":\s*"(src/auth|server/auth|infra|migrations|db/migrations)'; then
  if ! find specs -type f -name "*.md" | grep -q .; then
    echo "Blocked: sensitive path change requires a spec in specs/." >&2
    exit 2
  fi
fi

exit 0
