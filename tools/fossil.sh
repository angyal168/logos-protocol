#!/usr/bin/env bash
# fossil.sh -- FOSL (Fear of State Loss) durability audit.
#
# Detects claude CLI processes that are vulnerable to shell drop --
# anything running outside tmux dies if the parent shell exits
# (laptop sleep, terminal close, network blip, ssh disconnect).
# The conversation is unrecoverable when the shell dies.
#
# Reports:
#   - Vulnerable claude processes (no tmux ancestor)
#   - Durable claude processes (inside tmux)
#   - Tmux session count
#
# Exit code is always 0 -- this is a diagnostic, not a gate.
#
# Usage:
#   fossil.sh              human-readable report
#   fossil.sh --json       machine-readable single-line JSON
#   fossil.sh --notify     report + Telegram bedtime ping
#
# --notify requires two environment variables:
#   TELEGRAM_BOT_TOKEN     bot API token (or path in TELEGRAM_BOT_TOKEN_FILE)
#   TELEGRAM_CHAT_ID       destination chat ID
#
# Wire it as a nightly cron right before you'd otherwise close the laptop:
#   30 23 * * *  /path/to/fossil.sh --notify

set -euo pipefail

JSON=0
NOTIFY=0
for arg in "$@"; do
  case "$arg" in
    --json) JSON=1 ;;
    --notify) NOTIFY=1 ;;
  esac
done

# Walk a process's parent chain, return 0 if any ancestor's comm matches ^tmux.
in_tmux() {
  local pid="$1"
  local guard=0
  while [ -n "$pid" ] && [ "$pid" != "1" ] && [ "$pid" != "0" ] && [ "$guard" -lt 50 ]; do
    local comm
    comm=$(ps -o comm= -p "$pid" 2>/dev/null || echo "")
    if echo "$comm" | grep -qE "^tmux"; then
      return 0
    fi
    pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ' || echo "")
    guard=$((guard + 1))
  done
  return 1
}

# Find claude processes (the actual CLI, not stray scripts mentioning claude).
mapfile -t CLAUDE_PIDS < <(pgrep -x claude 2>/dev/null || true)

VULNERABLE=()
DURABLE=()
for pid in "${CLAUDE_PIDS[@]}"; do
  [ -z "$pid" ] && continue
  if in_tmux "$pid"; then
    DURABLE+=("$pid")
  else
    VULNERABLE+=("$pid")
  fi
done

TMUX_COUNT=$(tmux ls 2>/dev/null | wc -l || echo 0)

if [ "$JSON" = "1" ]; then
  printf '{"timestamp":"%s","host":"%s","vulnerable":%d,"durable":%d,"tmux_sessions":%d,"vulnerable_pids":"%s"}\n' \
    "$(date -Iseconds)" "$(hostname)" "${#VULNERABLE[@]}" "${#DURABLE[@]}" "$TMUX_COUNT" "${VULNERABLE[*]:-}"
else
  echo "=== FOSSIL -- FOSL Durability Audit ==="
  echo "Time: $(date -Iseconds)"
  echo "Host: $(hostname)"
  echo
  echo "Claude processes:"
  echo "  Durable (inside tmux): ${#DURABLE[@]}"
  echo "  Vulnerable (no tmux):  ${#VULNERABLE[@]}"
  if [ "${#VULNERABLE[@]}" -gt 0 ]; then
    echo
    echo "  Vulnerable PIDs and parent shells:"
    for vpid in "${VULNERABLE[@]}"; do
      ps -o pid,ppid,user,start,args -p "$vpid" 2>/dev/null | tail -1 | sed 's/^/    /'
    done
    echo
    echo "  These die if the parent shell drops (desktop sleep, terminal close, network blip)."
    echo "  No retroactive fix -- conversation is lost when the shell dies."
    echo "  Prevention only: launch new sessions inside tmux."
  fi
  echo
  echo "Tmux sessions: $TMUX_COUNT"
  tmux ls 2>/dev/null | sed 's/^/  /'
  echo
  if [ "${#VULNERABLE[@]}" -eq 0 ]; then
    echo "VERDICT: CLEAN. All sessions durable. Safe to close laptop / go to bed."
  else
    echo "VERDICT: ${#VULNERABLE[@]} VULNERABLE session(s). Finish or save what's there before walking away."
  fi
fi

if [ "$NOTIFY" = "1" ]; then
  if [ "${#VULNERABLE[@]}" -gt 0 ]; then
    MSG="FOSSIL alert ($(date +%H:%M)) -- ${#VULNERABLE[@]} vulnerable claude session(s) outside tmux. Will die on shell drop. PIDs: ${VULNERABLE[*]}"
  else
    MSG="FOSSIL clean ($(date +%H:%M)) -- ${#DURABLE[@]} durable session(s), $TMUX_COUNT tmux session(s). Safe to sleep."
  fi

  # Resolve bot token from env or token-file path.
  BOT_TOKEN="${TELEGRAM_BOT_TOKEN:-}"
  if [ -z "$BOT_TOKEN" ] && [ -n "${TELEGRAM_BOT_TOKEN_FILE:-}" ] && [ -r "${TELEGRAM_BOT_TOKEN_FILE}" ]; then
    BOT_TOKEN=$(cat "${TELEGRAM_BOT_TOKEN_FILE}")
  fi
  CHAT_ID="${TELEGRAM_CHAT_ID:-}"

  if [ -z "$BOT_TOKEN" ] || [ -z "$CHAT_ID" ]; then
    echo "fossil: --notify requires TELEGRAM_BOT_TOKEN (or TELEGRAM_BOT_TOKEN_FILE) and TELEGRAM_CHAT_ID" >&2
    echo "fossil: would have sent: $MSG" >&2
  else
    DISABLE_NOTIF=$([ "${#VULNERABLE[@]}" -gt 0 ] && echo false || echo true)
    curl -sS -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
      --data-urlencode "chat_id=${CHAT_ID}" \
      --data-urlencode "text=${MSG}" \
      --data-urlencode "disable_notification=${DISABLE_NOTIF}" \
      >/dev/null 2>&1 || echo "fossil: Telegram send failed" >&2
  fi
fi
