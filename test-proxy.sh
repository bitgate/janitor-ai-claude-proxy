#!/usr/bin/env bash
# Usage: PLAN2API_KEY=p2a_your_key bash test-proxy.sh [model]
set -euo pipefail

: "${PLAN2API_KEY:?Set PLAN2API_KEY to your p2a_ key}"
model="${1:-claude/claude-sonnet-5}"

curl -sS https://api.plan2api.com/v1/chat/completions \
  -H "Authorization: Bearer ${PLAN2API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"${model}\", \"messages\": [{\"role\": \"user\", \"content\": \"Reply with: Janitor proxy works\"}]}"
echo
