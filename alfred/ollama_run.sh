#!/usr/bin/env bash
# Ollama Runner -- send a prompt to local Ollama for free inference
# Usage: ollama_run.sh "prompt text" [model-name]
# Default model: llama3.2 (small, fast)
# Requires: Ollama running locally (https://ollama.com), jq

set -euo pipefail

PROMPT="${1:?Usage: ollama_run.sh 'prompt' [model]}"
MODEL="${2:-llama3.2}"

RESPONSE=$(curl -s --max-time 120 http://localhost:11434/api/generate \
    -d "{\"model\": \"$MODEL\", \"prompt\": $(echo "$PROMPT" | jq -Rs .), \"stream\": false}")

if [ $? -ne 0 ] || [ -z "$RESPONSE" ]; then
    echo "ERROR: Ollama request failed" >&2
    exit 1
fi

echo "$RESPONSE" | jq -r '.response'
