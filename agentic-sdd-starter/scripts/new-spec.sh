#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: ./scripts/new-spec.sh feature-name"
  exit 1
fi

NAME="$1"
SLUG="$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-|-$//g')"
DEST="specs/${SLUG}.md"

if [ -f "$DEST" ]; then
  echo "Spec already exists: $DEST"
  exit 1
fi

cp specs/_template.md "$DEST"
sed -i.bak "s/<nombre>/${SLUG}/g" "$DEST" && rm -f "${DEST}.bak"

echo "Created $DEST"
