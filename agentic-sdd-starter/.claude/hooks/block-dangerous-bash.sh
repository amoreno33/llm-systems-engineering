#!/usr/bin/env bash
set -euo pipefail

# Claude Code hooks usually receive JSON on stdin. This simple guard reads all input
# and blocks obvious dangerous shell patterns. Adapt to your environment.

INPUT="$(cat || true)"

BLOCKLIST=(
  "rm -rf /"
  "rm -rf ."
  "git push --force"
  "curl .*\\| sh"
  "wget .*\\| sh"
  "chmod -R 777"
  "DROP DATABASE"
)

for pattern in "${BLOCKLIST[@]}"; do
  if echo "$INPUT" | grep -Eiq "$pattern"; then
    echo "Blocked dangerous command pattern: $pattern" >&2
    exit 2
  fi
done

exit 0
