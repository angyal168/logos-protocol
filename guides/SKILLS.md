# Creating Custom Skills (Slash Commands)

> Turn repetitive workflows into one-word commands your AI executes instantly.

Skills are the most powerful upgrade you can add to your protocol. They let you type `/init` to warm up a session, `/bank` to cool down, `/council` to spin up a team of agents -- anything you find yourself doing repeatedly. (These command names are customizable -- use whatever feels right.)

---

## What is a Skill?

A skill is a markdown file that Claude Code loads when you type a slash command. It contains instructions your AI follows step by step. That is it. No code. No plugins. Just a text file with clear directions.

When you type `/mystuff`, Claude Code finds the skill file, reads it, and executes the instructions.

## Where Skills Live

```
your-workspace/
  .claude/
    skills/
      my-skill-name/
        SKILL.md       <-- The skill file (required)
        helpers.md     <-- Optional supporting docs
```

Each skill gets its own folder inside `.claude/skills/`. The main file must be called `SKILL.md`.

## Anatomy of a Skill

Every SKILL.md has two parts: **frontmatter** (metadata) and **body** (instructions).

```markdown
---
name: my-skill-name
description: "Use when the user wants to [specific trigger]. Activates on /my-skill-name or when [condition]."
---

# My Skill Name

## What This Does
[One paragraph explaining the skill's purpose]

## Steps

1. [First thing the AI should do]
2. [Second thing]
3. [Third thing]

## Rules
- [Constraint or guardrail]
- [Another constraint]
```

### Frontmatter Fields

Only two fields matter:

- **name**: Letters, numbers, hyphens only. Max 64 characters. This becomes the `/command` name.
- **description**: Starts with "Use when..." and describes specific triggers. Max 1024 characters. This is how Claude Code decides whether to load the skill -- make it specific.

### Good vs Bad Descriptions

**Good:** `"Use when the user starts a new session and wants to warm up. Activates on /init or 'let's get started'."`

**Bad:** `"A warmup skill that does various things to prepare the session."`

The description is a search query, not a summary. Be specific about when it triggers.

## Example: A Session Warmup Skill

```markdown
---
name: warmup
description: "Use when the user starts a session and wants a briefing. Activates on /warmup, /init, or 'what's going on'."
---

# Session Warmup

## Steps

1. Check `/intake/` for any new files dropped since last session
2. Sort recognized files into project folders. Flag unrecognized files.
3. Read `PROJECT_TRACKER.md`
4. Present a briefing:
   - What was last worked on
   - Any new intake items
   - Recommended next task
5. If the user seems stuck, pick ONE task and say: "Let's just do this."

## Rules
- Never modify PROJECT_TRACKER.md during warmup. Read only.
- Keep the briefing under 10 lines. Dense, not wordy.
- If intake has more than 5 files, summarize by category rather than listing each one.
```

## Example: A Session Cooldown Skill

```markdown
---
name: cooldown
description: "Use when the user is ending a session. Activates on /cooldown, /bank, or 'let's wrap up'."
---

# Session Cooldown

## Steps

1. Summarize what was accomplished this session (3-5 bullets)
2. Update `PROJECT_TRACKER.md`:
   - Update the "Last session" line
   - Update any project states that changed
   - Add new ideas to the Idea Inbox
   - Add a row to the Session Log
3. Save any insights worth keeping to your staging folder
4. Set the cold-start sentence: "Next session, pick up from [exact step]."
5. If using git: stage changes and commit with a summary message

## Rules
- This is the ONLY time PROJECT_TRACKER.md gets written to during a session.
- Capture ALL ideas mentioned during the session, even casual ones.
- The cold-start sentence must be specific enough to resume without re-reading the whole session.
```

## Example: A Research Skill

```markdown
---
name: deep-dive
description: "Use when the user wants thorough research on a topic. Activates on /deep-dive or 'research this'."
---

# Deep Dive Research

## Steps

1. Clarify the research question (one clarifying question max, then execute)
2. Spawn 3 sub-agents in parallel:
   - Agent 1: Search for recent articles and primary sources
   - Agent 2: Search the user's existing files for related context
   - Agent 3: Generate a structured outline of the topic
3. Compile results into a single research brief
4. Present findings with: Key takeaways (3-5 bullets), Sources, Open questions, Recommended next step

## Rules
- Sub-agents use mid-tier model (Sonnet), not Opus
- Research brief must fit in one screen (no scrolling)
- Always cite sources with links when available
- Flag any conflicting information between sources
```

## Writing Effective Skills

### Keep Them Short

Your skill file consumes context window every time it loads. A 2000-word skill eats into the space your AI has for actual work. Aim for:
- Getting-started skills: under 150 words
- Frequently-used skills: under 200 words
- Complex skills: under 500 words

If a skill needs more than 500 words, it is probably two skills.

### Be Specific, Not Clever

Write instructions like you are writing a checklist for a new employee. Explicit steps, clear success criteria, obvious guardrails.

**Good:** "Read PROJECT_TRACKER.md. Find the project with status ACTIVE and the oldest 'last activity' date. Present it as the recommended task."

**Bad:** "Intelligently determine the most important thing to work on."

### Test With Pressure

The best skills survive when the AI is under pressure -- long context, ambiguous input, the user contradicting the skill's instructions. Test by:

1. Running the skill with a fresh session (does it cold-start cleanly?)
2. Running it 80% into a conversation (does context rot break it?)
3. Giving it conflicting input ("skip the briefing" when the skill says to always brief)

### One Job Per Skill

A skill that does warmup AND research AND code review is three skills pretending to be one. Split them. You can chain skills manually: `/warmup` then `/research` then `/review`.

## Advanced: Skills That Reference Files

If your skill needs detailed reference material (a style guide, a list of rules, a template), put it in a separate file in the skill folder:

```
.claude/skills/
  my-skill/
    SKILL.md           <-- Main instructions (short)
    style-guide.md     <-- Detailed reference (loaded only when needed)
    template.md        <-- Template file
```

In your SKILL.md, reference it explicitly:

```markdown
## Steps
1. Read `.claude/skills/my-skill/style-guide.md` for the current style rules
2. Apply those rules to the user's content
```

This keeps the main skill file small while giving access to detailed references only when they are needed.

## Installing Third-Party Skills

Skills are just files. To install someone else's skill:

1. Copy their skill folder into your `.claude/skills/` directory
2. That is it. Type the slash command and it works.

To update: pull the latest version and replace the folder.

## Your First Skill

Start with whatever you do most often. If you find yourself saying the same thing to your AI at the start of every session, that is a skill. If you always end sessions the same way, that is a skill. If you have a research process you repeat, that is a skill.

Write the steps. Put them in a SKILL.md. Test it. Iterate.

The best skills are the ones you actually use.
