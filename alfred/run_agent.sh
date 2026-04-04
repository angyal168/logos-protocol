#!/usr/bin/env bash
# Alfred Agent Runner
# Usage: run_agent.sh <agent-name> [extra-context-file...]
#
# Reads alfred/<agent-name>/spec.md as the prompt.
# Sends output to your configured messaging channel.
# Extra context files are appended to the prompt.

set -euo pipefail

AGENT_NAME="${1:?Usage: run_agent.sh <agent-name>}"
shift

# CONFIGURE THESE for your setup
FORGE_ROOT="${FORGE_ROOT:-$HOME/FORGE}"
ALFRED_DIR="$FORGE_ROOT/alfred"

# Model routing -- read from model_map.conf, default to sonnet
MODEL_MAP="$ALFRED_DIR/model_map.conf"
AGENT_MODEL=""
if [ -f "$MODEL_MAP" ]; then
    AGENT_MODEL=$(grep "^${AGENT_NAME}=" "$MODEL_MAP" | cut -d'=' -f2 | tr -d ' ')
fi
AGENT_MODEL="${AGENT_MODEL:-sonnet}"

AGENT_DIR="$ALFRED_DIR/$AGENT_NAME"
SPEC="$AGENT_DIR/spec.md"
OUTPUT_DIR="$AGENT_DIR/output"
TIMESTAMP=$(date +%Y-%m-%d_%H%M)
LOG_FILE="$OUTPUT_DIR/${TIMESTAMP}.md"

# --- MESSAGING CONFIG ---
# Set these environment variables for your channel:
#   CHANNEL_BOT_TOKEN -- your bot token (Telegram, Slack, Discord, etc.)
#   CHANNEL_CHAT_ID -- your chat/channel ID
#
# Telegram example:
#   export CHANNEL_BOT_TOKEN="your-telegram-bot-token"
#   export CHANNEL_CHAT_ID="your-chat-id"
CHANNEL_BOT_TOKEN="${CHANNEL_BOT_TOKEN:-}"
CHANNEL_CHAT_ID="${CHANNEL_CHAT_ID:-}"

# --- TTS CONFIG (optional) ---
# Set PIPER_MODEL to enable voice output via Piper TTS
# Example: PIPER_MODEL="$HOME/.local/share/piper-voices/en_GB-alba-medium.onnx"
PIPER_MODEL="${PIPER_MODEL:-}"

# Validate
if [ ! -f "$SPEC" ]; then
    echo "ERROR: No spec found at $SPEC" >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Build prompt from spec + any extra context files
PROMPT=$(cat "$SPEC")
for ctx_file in "$@"; do
    if [ -f "$ctx_file" ]; then
        PROMPT="$PROMPT

---
$(cat "$ctx_file")"
    fi
done

# Run the agent
echo "[$TIMESTAMP] Running $AGENT_NAME (model: $AGENT_MODEL)..." >&2

if [ "$AGENT_MODEL" = "ollama" ]; then
    # Ollama execution -- local, free. 120s timeout to prevent hung cron agents.
    RESULT=$(curl -s --max-time 120 http://localhost:11434/api/generate \
        -d "{\"model\": \"llama3.2\", \"prompt\": $(echo "$PROMPT" | jq -Rs .), \"stream\": false}" \
        | jq -r '.response' 2>/dev/null) || {
        echo "WARN: Ollama failed for $AGENT_NAME, falling back to haiku" >&2
        RESULT=$(cd "$FORGE_ROOT" && claude -p "$PROMPT" --model haiku 2>/dev/null) || {
            echo "ERROR: $AGENT_NAME failed on fallback too" >&2
            exit 1
        }
    }
else
    RESULT=$(cd "$FORGE_ROOT" && claude -p "$PROMPT" --model "$AGENT_MODEL" 2>/dev/null) || {
        echo "ERROR: $AGENT_NAME failed" >&2
        exit 1
    }
fi

# Save output log
echo "$RESULT" > "$LOG_FILE"

# Send to channel if there's output and agent isn't marked silent
if [ -n "$RESULT" ] && ! echo "$RESULT" | grep -q "^SILENT$"; then
    MSG=$(echo "$RESULT" | head -c 4000)

    # --- TELEGRAM EXAMPLE ---
    # Uncomment and configure for your messaging platform
    if [ -n "$CHANNEL_BOT_TOKEN" ] && [ -n "$CHANNEL_CHAT_ID" ]; then
        # Text message
        curl -s -X POST "https://api.telegram.org/bot${CHANNEL_BOT_TOKEN}/sendMessage" \
            -d chat_id="$CHANNEL_CHAT_ID" \
            -d text="$MSG" \
            -d parse_mode="Markdown" \
            > /dev/null 2>&1 || {
                # Retry without markdown if parsing fails
                curl -s -X POST "https://api.telegram.org/bot${CHANNEL_BOT_TOKEN}/sendMessage" \
                    -d chat_id="$CHANNEL_CHAT_ID" \
                    -d text="$MSG" \
                    > /dev/null 2>&1
            }

        # Voice message (optional -- requires Piper TTS + ffmpeg)
        if [ -n "$PIPER_MODEL" ] && [ -f "$PIPER_MODEL" ] && command -v piper &>/dev/null && command -v ffmpeg &>/dev/null; then
            VOICE_FILE="/tmp/alfred_${AGENT_NAME}_${TIMESTAMP}.ogg"
            VOICE_TEXT=$(echo "$RESULT" | sed 's/\*\*//g; s/\*//g; s/^#\+\s*//; s/^-\s*//' | head -c 4000)

            echo "$VOICE_TEXT" | python3 -m piper \
                --model "$PIPER_MODEL" \
                --length_scale 0.88 \
                --output_raw 2>/dev/null | \
            ffmpeg -f s16le -ar 22050 -ac 1 -i - \
                -c:a libopus -b:a 48k -y "$VOICE_FILE" 2>/dev/null

            if [ -f "$VOICE_FILE" ] && [ -s "$VOICE_FILE" ]; then
                curl -s -X POST "https://api.telegram.org/bot${CHANNEL_BOT_TOKEN}/sendVoice" \
                    -F chat_id="$CHANNEL_CHAT_ID" \
                    -F voice=@"$VOICE_FILE" \
                    -F caption="$AGENT_NAME" \
                    > /dev/null 2>&1
                rm -f "$VOICE_FILE"
            fi
        fi
    fi
fi

# Commit output to git (optional -- ensures remote sessions can pull agent output)
cd "$FORGE_ROOT" && git add "$LOG_FILE" 2>/dev/null && \
    git commit -m "alfred: $AGENT_NAME output $TIMESTAMP" --no-gpg-sign 2>/dev/null && \
    git push origin master 2>/dev/null || true

echo "[$TIMESTAMP] $AGENT_NAME complete. Log: $LOG_FILE" >&2
