# Alfred -- The Household Orchestrator

> Alfred does not do the deep work. He runs the staff and decides what reaches you.
> All communication flows through your chosen channel (Telegram, Slack, Discord, etc.).

## How Alfred Works

Alfred is a scheduling layer on your always-on server. Each sub-agent is a headless `claude -p` invocation triggered by cron. Alfred delegates to sniper sub-agents and controls what surfaces to your communication channel.

Each sub-agent lives in `alfred/[name]/` with:
- `spec.md` -- the agent's prompt (fed to `claude -p`)
- `run.sh` -- the cron-callable wrapper script
- `output/` -- timestamped output logs
- Any agent-specific config or state files

## Channel Message Rules

Every Alfred output should follow these rules:
- Concise, scannable, ADHD-friendly
- Short paragraphs, clear signal
- **Bold the single most important line per message**

## Quick Start

1. Copy `alfred/` to your server
2. Create your first agent: `mkdir alfred/my_agent && echo "Your prompt here" > alfred/my_agent/spec.md`
3. Configure your messaging channel tokens in environment variables
4. Add to crontab: `0 8 * * * bash /path/to/alfred/run_agent.sh my_agent`

## Model Routing

Alfred uses a tiered model system to route each agent to the cheapest model that can handle it:

| Tier | Name | Model | Best At |
|------|------|-------|---------|
| Admiral | Opus | claude-opus | Strategy, voice, complex reasoning, judgment |
| Captain | Sonnet | claude-sonnet | Code gen, structured tasks, following instructions |
| Bosun | Haiku | claude-haiku | Classification, summarization, simple extraction |
| Deckhand | Ollama | Local LLM (FREE) | Bulk processing, health checks, simple transforms |

Configure per-agent routing in `model_map.conf`. When in doubt, send the stronger model. These aren't humans -- they don't grow from challenge.

## The Dispatch Protocol

The Dispatch Protocol turns numbered replies into real work:

```
Morning Briefing ─────────→ Numbered items to your channel
                                    │
You reply (anywhere) ─────→ "1 yes 2 A 3 skip"
                                    │
Channel parses reply ─────→ Creates task manifests in dispatch_queue/pending/
                                    │
Dispatch Runner (cron) ───→ Picks up tasks, spawns Claude agents
                                    │
Agents do real work ──────→ Drafts, searches, builds, saves to project folders
                                    │
Status Report ────────────→ Progress update to your channel
```

Key files:
- `dispatch_queue/spec.md` -- how numbered replies become task manifests
- `dispatch_queue/dispatch_runner.sh` -- the agent spawner
- `dispatch_queue/pending/` -- task manifests waiting for agents
- `dispatch_queue/active/` -- tasks currently being executed
- `dispatch_queue/completed/` -- agent receipts (done or failed)

## Agent Ideas

You build what you need. Some categories to consider:

- **Sync/Health** -- monitor your infrastructure, check backups
- **Intake/Sorting** -- process incoming files, sort ideas, triage
- **Revenue/Commerce** -- scout opportunities, track metrics
- **Content** -- mine stories, draft posts, schedule publishing
- **Research** -- competitive analysis, tool scouting, market signals
- **Memory** -- consolidate learnings, surface forgotten notes
- **Briefing** -- morning dispatch, evening recap, weekly review

Each agent is just a `spec.md` with a clear prompt and a `run.sh` that calls `run_agent.sh`.

## Creating an Agent

```bash
# Create the directory
mkdir -p alfred/my_agent/output

# Write the spec (this is the prompt fed to claude -p)
cat > alfred/my_agent/spec.md << 'EOF'
# My Agent

You are a [role]. Your job is to [task].

## Read First
- [relevant file paths]

## Output
[what to produce and where to save it]

## Rules
- [constraints]
EOF

# Add to model-map
echo "my_agent=sonnet" >> alfred/model_map.conf

# Add to crontab
echo "0 9 * * * bash /path/to/alfred/run_agent.sh my_agent" >> alfred/crontab.txt
```

## Crontab Template

See `crontab.txt` for a starter schedule. Adjust times to your timezone and workflow.

## Files

| File | Purpose |
|------|---------|
| `ALFRED.md` | This document |
| `run_agent.sh` | Universal agent runner -- reads spec, routes model, sends to channel |
| `model_map.conf` | Per-agent model tier assignments |
| `ollama_run.sh` | Local Ollama helper for free-tier processing |
| `crontab.txt` | Template cron schedule |
| `dispatch_queue/` | The dispatch protocol (task manifests, runner, receipts) |
