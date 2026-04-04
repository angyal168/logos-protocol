#!/usr/bin/env bash
# Dispatch Runner -- picks up task manifests and spawns Claude agents
# Runs on a cron interval (recommended: every 30 minutes).
# Max concurrent agents is configurable (default: 2, conservative for VPS resources).
# Each task = one Claude Code session doing real work.

set -euo pipefail

FORGE_ROOT="${FORGE_ROOT:-$HOME/FORGE}"
QUEUE="$FORGE_ROOT/alfred/dispatch_queue"
PENDING="$QUEUE/pending"
ACTIVE="$QUEUE/active"
COMPLETED="$QUEUE/completed"
DECISIONS_LOG="$QUEUE/decisions.log"
MAX_CONCURRENT=2
TIMESTAMP=$(date +%Y-%m-%d_%H%M)

# Messaging config (optional -- set env vars for notifications)
CHANNEL_BOT_TOKEN="${CHANNEL_BOT_TOKEN:-}"
CHANNEL_CHAT_ID="${CHANNEL_CHAT_ID:-}"

mkdir -p "$PENDING" "$ACTIVE" "$COMPLETED"

# Check for stale active tasks (older than 2 hours = likely failed)
for active_task in "$ACTIVE"/*.md; do
    [ -f "$active_task" ] || continue
    if [ "$(find "$active_task" -mmin +120 2>/dev/null)" ]; then
        task_name=$(basename "$active_task" .md)
        echo "[$TIMESTAMP] STALE: $task_name (active > 2h, marking failed)" >> "$DECISIONS_LOG"
        cat > "$COMPLETED/${task_name}_receipt.md" <<EOF
---
task: $task_name
completed: $TIMESTAMP
status: failed
reason: Timed out (active > 2 hours)
---

Task was active for more than 2 hours without completing. Likely hit context limit or API error.
Original manifest preserved at: $COMPLETED/${task_name}_manifest.md
EOF
        mv "$active_task" "$COMPLETED/${task_name}_manifest.md" 2>/dev/null || true
    fi
done

# Count active tasks
active_count=0
for f in "$ACTIVE"/*.md; do [ -f "$f" ] && active_count=$((active_count + 1)); done
available_slots=$((MAX_CONCURRENT - active_count))

if [ "$available_slots" -le 0 ]; then
    echo "[$TIMESTAMP] All slots full ($active_count active). Waiting." >> "$DECISIONS_LOG"
    exit 0
fi

# Collect pending tasks (oldest first)
pending_tasks=""
for f in "$PENDING"/*.md; do [ -f "$f" ] && pending_tasks="$pending_tasks $f"; done
pending_tasks=$(echo "$pending_tasks" | xargs -r ls -tr 2>/dev/null) || true
if [ -z "$pending_tasks" ]; then
    exit 0  # Nothing to do, silent exit
fi

echo "[$TIMESTAMP] Dispatch runner: $available_slots slots available, picking up tasks..." >> "$DECISIONS_LOG"

# Pick up pending tasks (oldest first, limited to available slots)
picked=0
for task in $pending_tasks; do
    [ -f "$task" ] || continue
    [ "$picked" -ge "$available_slots" ] && break

    task_name=$(basename "$task" .md)

    # Move to active
    cp "$task" "$ACTIVE/${task_name}.md"
    rm "$task"

    echo "[$TIMESTAMP] DISPATCHING: $task_name" >> "$DECISIONS_LOG"

    # Run agent in background subshell
    (
        RUN_TIMESTAMP=$(date +%Y-%m-%d_%H%M)

        # The task manifest IS the prompt. It contains everything the agent needs.
        TASK_PROMPT="You are a dispatch agent. Execute the following task precisely.
Do the work described. Save output to the specified locations.
When done, output a brief receipt: what you did, what files you created/modified, and any issues.

$(cat "$ACTIVE/${task_name}.md")"

        # Read model from task manifest if specified, otherwise from model_map, otherwise sonnet
        TASK_MODEL=$(grep -i "^model:" "$ACTIVE/${task_name}.md" 2>/dev/null | head -1 | cut -d: -f2 | tr -d ' ')
        if [ -z "$TASK_MODEL" ]; then
            MODEL_MAP="$FORGE_ROOT/alfred/model_map.conf"
            TASK_MODEL=$(grep "^${task_name}=" "$MODEL_MAP" 2>/dev/null | cut -d'=' -f2 | tr -d ' ')
        fi
        TASK_MODEL="${TASK_MODEL:-sonnet}"
        RESULT=$(cd "$FORGE_ROOT" && claude -p "$TASK_PROMPT" --model "$TASK_MODEL" 2>/dev/null) || RESULT="FAILED: Agent execution error for $task_name"

        # Determine status
        if echo "$RESULT" | grep -qi "^FAILED\|error\|could not\|unable to"; then
            STATUS="failed"
        else
            STATUS="done"
        fi

        # Write receipt
        cat > "$COMPLETED/${task_name}_receipt.md" <<RECEIPT
---
task: $task_name
dispatched: $TIMESTAMP
completed: $RUN_TIMESTAMP
status: $STATUS
---

$RESULT
RECEIPT

        # Preserve original manifest alongside receipt
        mv "$ACTIVE/${task_name}.md" "$COMPLETED/${task_name}_manifest.md" 2>/dev/null || true

        echo "[$RUN_TIMESTAMP] COMPLETED ($STATUS): $task_name" >> "$DECISIONS_LOG"

        # Send notification (Telegram example -- adapt for your platform)
        if [ -n "$CHANNEL_BOT_TOKEN" ] && [ -n "$CHANNEL_CHAT_ID" ]; then
            NOTIFY_MSG="DISPATCH COMPLETE: $task_name [$STATUS]
$(echo "$RESULT" | head -c 500)"
            curl -s -X POST "https://api.telegram.org/bot${CHANNEL_BOT_TOKEN}/sendMessage" \
                -d chat_id="$CHANNEL_CHAT_ID" \
                -d text="$NOTIFY_MSG" \
                > /dev/null 2>&1
        fi

        # Git commit the receipt
        cd "$FORGE_ROOT" && \
            git add "$COMPLETED/" "$DECISIONS_LOG" 2>/dev/null && \
            git commit -m "dispatch: $task_name $STATUS $RUN_TIMESTAMP" --no-gpg-sign 2>/dev/null && \
            git push origin master 2>/dev/null || true
    ) &

    picked=$((picked + 1))
done

# Don't wait -- let background agents run. Next cron invocation checks for stale actives.
echo "[$TIMESTAMP] Dispatched $picked tasks. Running in background." >> "$DECISIONS_LOG"
