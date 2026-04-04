# dispatch_queue -- The Dispatch Protocol

> This is the command chain that turns numbered replies into real agent work.
> Briefings generate numbered items. You reply by number. Task manifests get created.
> The dispatch runner spawns Claude agents. Status reports aggregate results.

## Folder Structure

```
dispatch_queue/
├── README.md               # You are here
├── spec.md                 # How numbered replies become task manifests
├── dispatch_runner.sh      # Cron script: picks up pending tasks, spawns agents
├── decisions.log           # Append-only log of every dispatch decision
├── parked.md               # Deferred items (resurfaced by a review agent)
├── briefing_context/       # Full context files backing each numbered briefing item
│   ├── YYYY-MM-DD_morning.md
│   └── YYYY-MM-DD_evening.md
├── pending/                # Task manifests waiting to be picked up
├── active/                 # Tasks currently being executed
└── completed/              # Agent receipts + original manifests (done or failed)
    ├── [task]_manifest.md  # The original task that was dispatched
    └── [task]_receipt.md   # What the agent did, success/failure, files created
```

## Flow

1. Your briefing agent generates numbered items + context file
2. You reply via your channel: "1 yes 2 A 3 skip"
3. Your channel agent parses the reply, reads context, creates task manifests in `pending/`
4. `dispatch_runner.sh` (cron) moves manifests to `active/`, spawns Claude agents
5. Agent does work, writes receipt to `completed/`
6. Status report agent aggregates receipts, sends update to your channel

## Rules

- Task manifests must be self-contained. The agent has never seen the briefing or conversation.
- Max 2 concurrent agents (configurable in dispatch_runner.sh).
- Active tasks older than 2 hours are marked failed and moved to completed.
- Never delete anything from completed. It's the audit trail.
- decisions.log is append-only.
