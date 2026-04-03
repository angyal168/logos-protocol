# Commands & Procedures -- The Rituals You Can Map

> Every repeatable procedure in the protocol can become a slash command or a cron job.

This is the catalog of built-in procedures. Each one can be:
- A **slash command** (type `/warmup` and your AI executes the steps)
- A **cron job** (runs automatically on a schedule)
- A **manual checklist** (you run through the steps yourself)

Pick the ones that match your workflow. You don't need all of them.

---

## Session Procedures

These are the opening and closing rituals. Every session should have them.

### /warmup (Session Open)

**When:** Every time you start a session.
**What it does:** Gets your AI up to speed in under 30 seconds.

```
Steps:
1. Scan /intake/ for new files dropped since last session
2. Sort recognized files into project folders
3. Flag unrecognized files for your review
4. Read PROJECT_TRACKER.md for current project state
5. Present the Daily Briefing:
   - What was last worked on
   - New intake items
   - Recommended task (based on your energy level)
6. If you're frozen: pick ONE task and say "Let's just do this."
```

**To make it a skill:** See the warmup example in [SKILLS.md](SKILLS.md).

---

### /cooldown (Session Close)

**When:** Every time you end a session.
**What it does:** Saves everything so the next session can cold-start perfectly.

```
Steps:
1. Summarize what was accomplished (3-5 bullets)
2. Update PROJECT_TRACKER.md:
   - "Last session" line
   - Project states that changed
   - New ideas -> Idea Inbox
   - New row in Session Log
3. Capture insights to your staging folder (if using a knowledge vault)
4. Set the cold-start sentence: "Next session, pick up from [exact step]."
5. If using git: stage and commit with summary message
6. If syncing to other devices: push/sync
```

---

### /handoff (Context Getting Full)

**When:** Context window approaching 50%, or after a long debugging session.
**What it does:** Writes a structured summary so a fresh session can continue seamlessly.

```
Steps:
1. Write a handoff file (handoff_YYYY-MM-DD.md) containing:
   - What we were working on
   - Current state of the task
   - What's been tried and what worked/failed
   - Exact next step
   - Any files that were modified
2. Save to workspace root
3. Tell the user: "Context is getting full. Start a new session and say 'read the handoff file.'"
```

---

## Work Procedures

### /focus [project-name]

**When:** Switching to a specific project.
**What it does:** Loads project context without loading everything else.

```
Steps:
1. Read the project's STATUS.md (or its section in PROJECT_TRACKER.md)
2. Present: current state, last activity, next step, blockers
3. Ask: "Ready to pick up from [next step]?"
```

---

### /idea [text]

**When:** A random idea hits mid-session.
**What it does:** Captures it without derailing current work.

```
Steps:
1. Append the idea to Idea Inbox in PROJECT_TRACKER.md
   (or save to a scratch file if mid-session tracker writes are disabled)
2. Acknowledge: "Captured. Back to [current task]."
```

---

### /review

**When:** Before claiming any work is done.
**What it does:** Forces verification before declaring victory.

```
Steps:
1. Run the relevant test/verification command
2. Check output for errors
3. If tests pass: confirm completion
4. If tests fail: diagnose, don't just retry
5. Never say "it works" without proof
```

---

### /research [topic]

**When:** Need thorough research on something.
**What it does:** Parallel research with compiled results.

```
Steps:
1. Clarify the question (1 question max, then execute)
2. Spawn sub-agents for parallel research:
   - Search external sources
   - Search your existing files for related context
   - Generate structured outline
3. Compile into a research brief:
   - Key takeaways (3-5 bullets)
   - Sources
   - Open questions
   - Recommended next step
```

---

## Cron Jobs (Automated Schedules)

These run on a timer without you doing anything. They require a server or always-on computer (Level 4+).

### Morning Briefing

**Schedule:** Daily at 6 AM (or whenever you wake up)
**Delivery:** Telegram message, voice note, or both

```
What it does:
1. Read PROJECT_TRACKER.md
2. Check for new intake files
3. Summarize: what's hot, what's stalled, what's next
4. Send briefing to Telegram (text + optional voice via Piper TTS)
```

**Cron example:**
```bash
0 6 * * * /home/user/scripts/morning-briefing.sh
```

---

### Evening Wrap-Up

**Schedule:** Daily at 9 PM (or before your work window)
**Delivery:** Telegram message

```
What it does:
1. Check what changed in the workspace since morning
2. List any new intake files
3. Suggest tonight's task based on energy heuristics
4. Pre-load relevant context so /warmup is instant
```

---

### Weekly Review

**Schedule:** Sunday evening

```
What it does:
1. Scan all projects for staleness (no activity in 7+ days)
2. Count completed vs. planned items
3. Flag projects that need attention or archiving
4. Generate a 1-paragraph "state of the forge" summary
5. Send via Telegram
```

---

### Health Check

**Schedule:** Every 6 hours

```
What it does:
1. Verify all services are running (bots, cron jobs, sync)
2. Check disk space
3. Verify git repo is clean (no uncommitted changes lingering)
4. Alert via Telegram if anything is wrong
```

---

## Custom Commands

The commands above are starting points. The protocol is designed for you to create your own. Common patterns people build:

| Command | What It Does |
|---------|-------------|
| `/ship` | Package current project for release (build, test, deploy) |
| `/clean` | Archive completed projects, sort loose files |
| `/sync` | Push to git, sync to other devices, verify consistency |
| `/submit` | Package work for review by another person |

See [SKILLS.md](SKILLS.md) for how to turn any of these into a working slash command.

---

## Mapping Your Own Procedures

Think about your daily workflow:

1. **What do you do at the start of every session?** That's your `/warmup`.
2. **What do you do at the end?** That's your `/cooldown`.
3. **What do you do repeatedly during work?** Each one is a potential command.
4. **What should happen while you sleep?** Each one is a potential cron job.

Start with warmup and cooldown. Add more as friction reveals itself. If you find yourself explaining the same process to your AI twice, it should be a skill.
