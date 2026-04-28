#!/usr/bin/env bash
set -euo pipefail

# Post-edit scope signal. This hook does not block by default.
# It reports the current changed files so the agent/user can see scope creep.

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  CHANGED="$(git diff --name-only || true)"
  COUNT="$(echo "$CHANGED" | sed '/^$/d' | wc -l | tr -d ' ')"

  if [ "$COUNT" -gt 8 ]; then
    echo "Warning: ${COUNT} files changed. Check for scope creep." >&2
    echo "$CHANGED" >&2
  fi
fi

exit 0
