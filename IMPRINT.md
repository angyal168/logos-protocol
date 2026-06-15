# The Imprint -- An AI Companion Protocol

> *"The best tool disappears into the work."*

This is a protocol for building an AI assistant that actually knows you. Not a chatbot you re-explain yourself to every time. Not a novelty that impresses for five minutes and then collects dust. A persistent, evolving, working partner that gets sharper every session.

It was forged (literally) through dozens of late-night sessions by a pharmacist working 60-hour weeks who builds projects in limited evening windows -- roughly 10pm to 1am. He needed an AI system that could cold-start in seconds, remember everything, protect its own reasoning quality, and never waste a minute of his time. He called it Logos. He called his workspace The Forge.

You do not need to use those names. You do not need to be a programmer. You do not need to work late nights. You just need a computer, a Claude account, and something you want to build or organize.

This document will walk you through everything.

---

## Table of Contents

1. [What This Is (and What It Does)](#1-what-this-is-and-what-it-does)
2. [Prerequisites -- What You Need Before Starting](#2-prerequisites----what-you-need-before-starting)
3. [The First Ignition -- Zero to Working Assistant](#3-the-first-ignition----zero-to-working-assistant)
4. [The Imprinting Ritual -- Making It Yours](#4-the-imprinting-ritual----making-it-yours)
5. [The Protocol Explained -- Every Piece and Why It Matters](#5-the-protocol-explained----every-piece-and-why-it-matters)
6. [The Roadmap -- From Basic Assistant to Autonomous Companion](#6-the-roadmap----from-basic-assistant-to-autonomous-companion)
7. [Template: CLAUDE.md](#7-template-claudemd)
8. [Template: PROJECT_TRACKER.md](#8-template-project_trackermd)
9. [Template: DECISION_LOG.md](#9-template-decision_logmd)
10. [Troubleshooting and FAQ](#10-troubleshooting-and-faq)

---

## 1. What This Is (and What It Does)

Every time you open a new conversation with an AI, it starts from zero. It does not know your name, your projects, your preferences, or what you were working on yesterday. You spend the first five minutes re-explaining yourself. Then the conversation gets long, the AI starts forgetting things from earlier, and quality drops. You close the chat and start over tomorrow. Repeat forever.

This protocol fixes that.

**What you get:**

- An AI assistant that reads a file at the start of every session and immediately knows who you are, what you are working on, and where you left off
- Session rituals (start and end) that prevent information loss between conversations
- A memory system that persists across sessions -- your AI actually learns and improves
- Context rot protection -- rules that keep the AI sharp instead of letting it degrade as conversations get long
- A self-improvement loop where the AI logs its own mistakes and corrections
- A project tracker that serves as the single source of truth for everything you are working on
- A clear upgrade path from "basic assistant" to "autonomous agent that runs while you sleep"

**What you do NOT need:**

- Programming experience
- A computer science degree
- Any particular operating system
- Money (the basic setup is free beyond the Claude subscription)

**How it works, simply:**

Claude Code (the tool you will use) reads a special file called `CLAUDE.md` every time it starts. That file contains your protocol -- the rules, the rituals, the personality, the context. It is like giving your assistant a briefing document before every shift. The assistant reads it, understands its role, and picks up right where things left off.

The protocol then uses a handful of plain text files to maintain memory, track projects, and protect quality. No databases. No servers. No complex software. Just files and folders that you and your AI both understand.

---

## 2. Prerequisites -- What You Need Before Starting

Think of this like setting up a kitchen before you cook. You need a few things on the counter before you start.

### Must Have

**A Claude account with Claude Code access**

Claude Code is Anthropic's command-line tool for Claude. It is what lets Claude read and write files on your computer, which is what makes this whole system work. As of early 2026, it requires a Claude Pro or Team subscription.

- Sign up at claude.ai if you have not already
- Claude Code documentation: docs.anthropic.com/claude-code

**A terminal / command line**

This is the text-based interface on your computer. Do not be intimidated by it -- you will type short commands and the AI will do the rest.

- **Mac**: Open the app called "Terminal" (search for it in Spotlight)
- **Windows**: Use "Windows Terminal" or "PowerShell" (search in Start menu). For the best experience, install WSL (Windows Subsystem for Linux) -- it gives you a Linux terminal inside Windows. Your AI can help you set this up.
- **Linux**: You already know where your terminal is

**A folder for your workspace**

Pick a spot on your computer where your projects and files will live. This is your workspace -- your "forge," your "workshop," your "lab," whatever you want to call it. Examples:

- Mac: `~/Workshop/`
- Windows: `C:\Users\yourname\Workshop\`
- Linux: `~/workshop/`

Create this folder now. Everything will live inside it.

### Nice to Have (Not Required to Start)

- **A text editor**: VS Code, Cursor, or even Notepad. You will occasionally want to read or edit files yourself. Any text editor works.
- **Git**: Version control for your files. Not required at Level 1, but becomes valuable at Level 2+. Your AI can help you set this up later.
- **A cloud sync solution**: iCloud, Dropbox, Google Drive, OneDrive -- anything that syncs a folder between devices. Useful if you want to access your workspace from multiple computers or your phone.
- **Obsidian**: A free note-taking app that works with plain text files. Great for building a personal knowledge base ("vault") alongside your AI system. Optional but powerful.

---

## 3. The First Ignition -- Zero to Working Assistant

This section takes you from nothing to a working AI assistant in one session. Follow each step in order.

### Step 1: Install Claude Code

Open your terminal and run the native installer (Anthropic's current default):

```
curl -fsSL https://claude.ai/install.sh | bash
```

If you prefer npm and already have Node.js, this also works:

```
npm install -g @anthropic-ai/claude-code
```

If neither works, install Node.js first (nodejs.org, LTS version), then retry the npm command.

Verify it worked:

```
claude --version
```

If you see a version number, you are good.

### Step 2: Create Your Workspace

```
mkdir ~/Workshop
cd ~/Workshop
```

(Replace `Workshop` with whatever you want to call your space.)

### Step 3: Create Your Protocol File

This is the most important file in the system. Claude Code reads it automatically every time it starts in this folder.

```
touch CLAUDE.md
```

Now open `CLAUDE.md` in any text editor and paste in the template from Section 7 of this document. Do not worry about filling in the placeholders yet -- that comes in the Imprinting Ritual (next section).

### Step 4: Create Your Project Tracker and Decision Log

```
touch PROJECT_TRACKER.md
touch DECISION_LOG.md
```

Open `PROJECT_TRACKER.md` and paste in the template from Section 8. Open `DECISION_LOG.md` and paste in the template from Section 9. Both start nearly empty -- they fill up over time as you work.

### Step 5: Create Your Folder Structure

```
mkdir intake
mkdir projects
mkdir archive
mkdir vault-staging
```

Here is what each does:

- **intake/** -- A drop zone. Throw files here throughout the day. Your AI will sort them at the start of each session.
- **projects/** -- Where your active projects live, each in its own subfolder.
- **archive/** -- Where finished or paused projects go. Out of sight, never deleted.
- **vault-staging/** -- A holding area for ideas and insights that you want to save long-term (to a notes app, journal, etc.).

### Step 6: Launch Your First Session

```
cd ~/Workshop
claude
```

That is it. Claude Code starts, reads your `CLAUDE.md`, and your assistant is live. It will greet you according to whatever protocol you have set up.

If you pasted the template without filling it in yet, that is fine. Your assistant will see the placeholders and you can fill them in together. In fact, that is a great way to do the Imprinting Ritual -- with your AI helping you.

### Step 7: Test It

Try saying:

> "Read my CLAUDE.md and tell me what you understand about your role."

Your assistant should read the file and describe the protocol back to you. If it does, the system is working. Everything from here is personalization and expansion.

---

## 4. The Imprinting Ritual -- Making It Yours

This is where the protocol becomes *yours*. The template is a skeleton. The Imprinting Ritual puts flesh on it.

You can do this by yourself with a text editor, or you can do it live with your AI assistant. The second way is more fun -- just start a session and say "Let's do the Imprinting Ritual" and work through these questions together. Your AI can edit the CLAUDE.md file with your answers.

### The Questions

**About You**

1. What is your name? (What should your AI call you?)
2. What do you do? (Job, profession, or primary role -- one sentence)
3. What are your working hours for AI sessions? (When do you typically sit down to work with your assistant?)
4. How do you communicate? (Short and direct? Conversational? Do you use voice-to-text? Do you ramble or are you precise?)
5. What do you value? (Examples: clarity over cleverness, speed over perfection, shipped over theorized, thorough over quick)
6. What should your AI never do? (Examples: never sugarcoat, never use corporate jargon, never make decisions without asking, never use emojis)

**About Your Work**

7. What are your current projects? (List 1-5 things you are actively working on)
8. For each project: what is its current status and what is the next step?
9. Do you have any recurring commitments that limit your time? (Job, family, etc.)
10. What does "done" look like for you right now? (What is the one thing that, if finished, would make the biggest difference?)

**About Your System**

11. What do you want to call your AI assistant? (Examples: Logos, Jarvis, Friday, Atlas, or just "assistant" -- anything works)
12. What do you want to call your workspace? (Examples: The Forge, The Workshop, The Lab, The Studio, or just "workspace")
13. Do you sync files between devices? If so, how? (iCloud, Dropbox, Google Drive, etc.)
14. Do you use a note-taking app? (Obsidian, Notion, Apple Notes, etc.)

**About Your Personality (Optional but Powerful)**

15. What kind of voice should your AI have? (Direct and blunt? Warm and encouraging? Professional? Casual?)
16. When you are stuck or overwhelmed, what helps? (Someone picking a task for you? A pep talk? Silence and space?)
17. Is there anything your AI should always remember about you? (Health considerations, family context, long-term goals, anything that shapes decisions)

### What to Do With the Answers

Take your answers and fill in the `[PLACEHOLDERS]` in your CLAUDE.md template (Section 7). The template has comments explaining where each answer goes.

If you are doing this live with your AI, just say: "Here are my answers to the Imprinting Ritual. Update CLAUDE.md with them." Your AI will edit the file for you.

---

## 5. The Protocol Explained -- Every Piece and Why It Matters

This section explains every component of the protocol in plain language. Think of it as the "why" behind the "what."

### The Prime Directives -- Ground Rules for Your AI

These are the non-negotiable rules your AI follows every session. Here is each one and why it exists:

**"Read PROJECT_TRACKER.md before every session."**

Why: This is how your AI "remembers" between sessions. Claude Code starts fresh every time -- it has no built-in memory of previous conversations. The tracker file IS its memory. If it does not read it, it is starting blind.

**"Update the tracker ONLY at the end of session. Never mid-session."**

Why: If you use cloud sync (iCloud, Dropbox, etc.) and you work from multiple devices, editing the same file from two places creates conflict copies -- duplicates with names like "PROJECT_TRACKER 2.md". By only writing to the tracker at the end, you eliminate this risk. During a session, use per-project status files instead.

**"One task at a time. Finished before the next."**

Why: Context switching kills quality. AI assistants produce dramatically better work when focused on a single task. Queue things up; do not juggle.

**"Test everything you build."**

Why: If your AI writes code, a script, or an automation, it should verify it works before handing it to you. You should never have to debug something your AI built. If you have to troubleshoot, the AI failed at its job.

**"When a raw idea comes in: capture it, acknowledge it, redirect to current task."**

Why: Ideas are precious but distracting. This rule means nothing gets lost (it goes in the Idea Inbox) but nothing derails the session either. Your AI respects your ideas AND your focus.

**"Never sugarcoat. Be direct."**

Why: A sycophantic AI wastes your time. If something is not feasible, you need to know now, not after you have invested three hours.

**"Ask before executing on destructive operations."**

Why: Deleting files, overwriting data, resetting configurations -- these should always require your explicit approval. Safety net.

**"If context window approaches 50%, trigger a handoff."**

Why: This is the most important technical rule in the protocol. See "Context Rot Protection" below.

**"Don't ask questions. Look it up first."**

Why: Your AI has access to your files. If the answer is in the tracker, a status file, or its memory, it should look there instead of asking you. Your time is more valuable than its compute time.

### Context Rot Protection -- Why Your AI Gets Dumber (and How to Stop It)

This is the secret sauce. Most people do not know this happens, and it is the single biggest reason AI assistants feel unreliable.

**The problem:** Every AI model has a "context window" -- a maximum amount of text it can hold in its head at once. As your conversation gets longer, the AI is holding more and more text. Research (and hard experience) shows that AI quality degrades significantly once the context window is past 50% full. The AI starts forgetting things from earlier in the conversation. It contradicts itself. It makes mistakes it would not have made at the start.

This is not a bug. It is a fundamental property of how these models work. And almost nobody accounts for it.

**The solution:** The protocol includes rules that actively manage context health:

- **Never exceed 50% of the context window.** This is the hard ceiling. Past this point, degradation is measurable.
- **Never use auto-compact.** Some tools offer to "summarize" the conversation to free up space. This destroys nuance and reasoning chains. It is like summarizing a math proof -- you lose the logic, not just the words.
- **Trigger a handoff instead.** When context is getting full, the AI writes a handoff file -- a structured summary of everything important -- and you start a new session. The new session reads the handoff and continues cleanly. Full quality, no degradation.
- **Give sub-agents bite-sized specs.** If you use sub-agents (Level 5), do not pass them the entire project context. Give them exactly what they need for their specific task.
- **Read only the files needed for the current task.** Every file your AI reads consumes context. Do not let it read the whole project when it only needs one file.
- **After 3+ turns debugging, suggest trimming.** Long debugging sessions accumulate a lot of failed approaches in context. Archiving them and continuing fresh is often faster.
- **Failed approaches get archived, not carried forward.** Dead ends are useful to remember ("we tried X, it did not work") but the full details should not take up active context.

### Model Orchestration -- Using the Right Brain for the Right Job

Not every task needs your most powerful (and most expensive) AI model. The protocol includes a tiered approach:

**The rule:** Your main AI assistant (the orchestrator) always runs on the strongest reasoning model available. It is the brain making decisions, planning work, and talking to you. But when it delegates work to sub-agents, it picks the lightest model that can handle the job.

**The tiers:**

1. **Strongest model** (e.g., Opus) -- The orchestrator. Your main assistant. All complex reasoning, planning, and decision-making.
2. **Mid-tier model** (e.g., Sonnet) -- Sub-agents handling moderate tasks: research, summarization, code generation, content writing.
3. **Light model** (e.g., Haiku) -- Sub-agents handling simple tasks: file sorting, formatting, basic searches, data extraction.
4. **Local model** (e.g., Ollama) -- Free, runs on your hardware. Lightest tasks that do not need cloud AI at all: simple text processing, templating, quick lookups.

**The bias rule:** When in doubt between two tiers, always use the heavier model. If the orchestrator is deciding between Haiku and Sonnet for a task, it picks Sonnet. Quality over cost savings. You can always optimize later once you see usage patterns.

**Why this matters:** Without this rule, either everything runs on the expensive model (wasteful) or you manually decide which model to use for each task (exhausting). The protocol automates this decision so you never think about it.

### Session Rituals -- The Warmup and The Cooldown

**The Warmup (Session Start)**

When you open a new session, your AI automatically:

1. Checks for file conflicts or duplicates (if you use cloud sync)
2. Scans the intake folder for new files you dropped in since last time
3. Sorts known files into project folders, flags anything it is unsure about
4. Reads the project tracker to load current state
5. Presents a briefing: what was last worked on, what is pending, what it recommends
6. If you are stuck: picks one thing and says "Let's just do this"

Why this matters: You sit down, and the hearth is already hot. No fumbling, no re-explaining, no "where was I?" Just a briefing and a recommendation. This alone saves 5-15 minutes per session.

**The Cooldown (Session End)**

When you are done for the night, your AI:

1. Summarizes what was accomplished
2. Updates the project tracker with current state
3. Captures any new ideas that came up (in the tracker AND in vault-staging)
4. Queues any insights worth archiving
5. Sets a "cold-start sentence": the exact place to pick up next time

Why this matters: This is how continuity works. The cooldown writes the information that the next session's warmup will read. It is a relay race -- each session passes the baton to the next. Without this, every session starts from scratch.

### The Memory System -- How Your AI Actually Learns

Claude Code has a built-in memory system. When you tell it something important ("I prefer short variable names" or "always use TypeScript"), it can save that to a memory file that persists across sessions.

The protocol structures this into categories:

- **Feedback memories**: Your preferences, corrections, communication style
- **Project memories**: Key context about specific projects
- **System memories**: Technical details about your setup

Your AI also has a self-improvement loop: when it discovers a correction or a pattern during a session, it logs it as a dated lesson. If three or more related lessons accumulate, it creates a dedicated context file. This means your AI gets measurably better over time -- not just in a vague "machine learning" way, but in a concrete, auditable, file-you-can-read way.

### The Decision Log -- Why Decisions Need Their Own Memory

The project tracker remembers what is happening. The memory system remembers what is true. Neither is a good home for *what was decided, why, and what would change it*.

That gap is small but expensive. Without a decision log, you will:

- Re-decide the same thing six months later because you forgot why you ruled it out
- Lose the rationale when the situation changes and you should actually revisit
- Re-litigate locked decisions because the lock is not visible to your AI or to future-you

The fix is one extra file: `DECISION_LOG.md`. It lives next to your tracker. Your AI reads it at session start (after the tracker) and writes to it at session end (during the cooldown), but only when a decision was actually made -- not when one was merely discussed.

Each entry captures six things:

- **Date** -- when the call was made
- **Project** -- which lane it belongs to
- **Decision** -- the actual call, in one sentence
- **Why** -- the reasoning that drove it (this is the part you will need later)
- **Reversible?** -- yes or no, so future-you knows the cost of re-opening
- **Revisit trigger** -- what would make this decision worth re-opening (e.g., "if vendor X drops support" or "after the next funding round")

This is the smallest possible cure for the largest founder-time leak. It does not replace the tracker. It does not replace memory. It captures the decisions both of those would otherwise lose.

A template lives at `templates/DECISION_LOG.md` and as Section 9 of this document.

> **What does NOT go here.** Tasks belong in the tracker. Patterns and feedback belong in memory. Discussions that did not end in a call belong in the session log. A decision changes what you are willing to do tomorrow -- a note does not.

### The Project Tracker -- Your Single Source of Truth

The project tracker is a single markdown file that contains:

- A briefing section (what is hot, what is stalled, what to prioritize)
- The state of every project (status, last activity, where you left off, next step, blockers)
- An Idea Inbox (raw ideas captured during sessions, waiting to be sorted)
- A session log (date, project, what got done, next step -- your work history)

This is what your AI reads first every session. It is what gets updated last every session. It is the canonical record of your work.

---

## 6. The Roadmap -- From Basic Assistant to Autonomous Companion

You do not need to build everything at once. Start at Level 1 and move up when you are ready. Each level builds on the one before it.

### Level 1: Basic Assistant

**What you get:** An AI that knows who you are, what you are working on, and picks up where you left off.

**What you set up:**
- CLAUDE.md (your protocol file)
- PROJECT_TRACKER.md (your project tracker)
- Basic folder structure (intake, projects, archive, vault-staging)

**What it feels like:** You sit down, your AI reads the tracker, gives you a briefing, and you get to work. At the end, it updates the tracker. Next session, it picks up where you left off.

**Time to set up:** 30-60 minutes (including the Imprinting Ritual)

---

### Level 2: Memory and Persistence

**What you add:** The Claude Code memory system, per-project STATUS.md files, session handoff protocol, git version control.

**What you set up:**
- Claude Code memory files (happens naturally as you give feedback)
- A STATUS.md file inside each project folder
- Git repository for your workspace (your AI can set this up for you)
- Self-improvement logging (corrections and lessons)

**What it feels like:** Your AI remembers your preferences across sessions. It does not repeat mistakes. It gets noticeably better after 5-10 sessions. If you lose a file, git has your back.

**Time to set up:** One session to initialize git and create status files. Memory accumulates naturally.

**Key concept -- handoffs:** When a session gets long and context quality starts to drop, your AI writes a handoff file and you start fresh. The new session reads the handoff and continues seamlessly. This is the #1 quality-of-life improvement over "just chatting with an AI."

---

### Level 3: Intake and Automation

**What you add:** A drop zone that works from your phone, basic automation for repetitive tasks.

**What you set up:**
- Cloud sync (iCloud, Dropbox, Google Drive) so your intake folder is accessible from your phone
- Simple automations using n8n (self-hosted, free) or Zapier/Make (hosted, free tiers available)
- File sorting rules in your protocol

**What it feels like:** You have an idea at work, drop a voice memo or a photo into the intake folder from your phone, and when you sit down that night, your AI has already sorted it and is ready to discuss it.

**Time to set up:** 1-2 sessions for cloud sync. Automation setup varies.

---

### Level 4: Voice and Channels

**What you add:** Voice transcription, a Telegram bot for remote communication with your system, text-to-speech replies.

**What you set up:**
- A Telegram bot (free, created through @BotFather on Telegram)
- Whisper (free, open-source speech-to-text by OpenAI) for voice transcription
- n8n workflow connecting Telegram to your workspace
- Optional: TTS for voice replies (Piper TTS -- free, runs locally)

**What it feels like:** You send a voice message to your Telegram bot from anywhere. It transcribes it, saves it to your intake folder, and optionally sends a reply. You are building a relationship with your system throughout the day, not just during sessions.

**Time to set up:** 2-3 sessions. Requires a server or always-on computer.

---

### Level 5: Multi-Agent

**What you add:** Sub-agents for parallel work, a local LLM for free processing, specialized agents for different tasks.

**What you set up:**
- Ollama (free, runs AI models locally on your hardware)
- Sub-agent delegation rules in your protocol
- Specialized agent prompts for different tasks (research, writing, coding, etc.)

**What it feels like:** You tell your main AI to research three topics. It spawns three sub-agents that work in parallel, each with a focused context. Results come back compiled. Your main agent stays clean and sharp while the sub-agents do the heavy lifting.

**Time to set up:** 1-2 sessions for Ollama. Sub-agent patterns develop naturally.

**Key concept -- cost management:** Local LLMs are free but less capable. Use them for light tasks (summarization, simple questions, drafting) and save your Claude tokens for complex reasoning. Let the cheap models do the grunt work.

---

### Level 6: Autonomous Operations

**What you add:** Scheduled tasks, proactive monitoring, the AI working while you sleep.

**What you set up:**
- Scheduled n8n workflows (check RSS feeds, monitor prices, run reports)
- Proactive alerts via Telegram ("Your project X has been stalled for 5 days")
- Automated backups and maintenance tasks
- Channel sessions (always-on Claude Code listening to Telegram/Discord)

**What it feels like:** You wake up and there is a summary of what happened overnight. Your AI monitored your systems, flagged anything that needs attention, and prepared a briefing. You are not just using an assistant -- you have a digital operations partner.

**Time to set up:** Ongoing. This is a journey, not a destination.

**Important note:** Autonomous operations require trust, which requires experience. Do NOT jump to Level 6. The earlier levels build the judgment and guardrails that make autonomy safe.

---

## 7. Template: CLAUDE.md

Copy this entire block into your `CLAUDE.md` file. Fill in the `[BRACKETED PLACEHOLDERS]` with your information. Lines starting with `<!--` are comments explaining what to put there -- delete them after you fill things in, or leave them. Your AI can read them either way.

```markdown
# [YOUR SYSTEM NAME] Protocol

<!-- Example: "The Atlas Protocol" or "Workshop Protocol" or just "My AI Assistant Protocol" -->
<!-- This is the name for your overall system. Pick anything that feels right. -->

> [YOUR AI NAME] is the [ROLE DESCRIPTION] of [YOUR WORKSPACE NAME].
> [YOUR NAME] is the principal -- [YOUR ONE-LINE DESCRIPTION].
> [OPTIONAL: YOUR SCHEDULE/TIME CONSTRAINT]
> [YOUR AI NAME] reduces friction to zero. When [YOUR NAME] sits down, everything is ready.

<!-- Example: -->
<!-- > Atlas is the organizing intelligence of the Workshop. -->
<!-- > Sam is the principal -- teacher, writer, parent. -->
<!-- > She works full-time and builds at night after the kids are in bed. -->
<!-- > Atlas reduces friction to zero. When Sam sits down, everything is ready. -->

## Prime Directives

- Read `PROJECT_TRACKER.md` before every session. It is the source of truth.
- Update `PROJECT_TRACKER.md` ONLY during the end-of-session cooldown. Never mid-session.
<!-- WHY: Prevents file conflicts if you use cloud sync between devices. -->
- One task at a time. Finished before the next.
- Test everything you build. [YOUR NAME] is not a software engineer. If they have to debug it, you failed.
<!-- ADJUST: If you ARE a software engineer, change this to match your expectations. -->
- When [YOUR NAME] dumps a raw idea: capture it in the Idea Inbox, acknowledge it, redirect to current task.
- Never sugarcoat. Be direct. If it is not feasible, say so.
<!-- ADJUST: Change the communication style to match YOUR preferences. Some people want warmth. Some want blunt. -->
- Ask-before-executing on any destructive operation.
- Spawn sub-agents freely for parallel work, exploration, or competing solutions. Do not ask permission to delegate.
<!-- NOTE: Sub-agents are a Level 5 feature. Leave this in -- it won't hurt at Level 1 and it's ready when you need it. -->
- If context window approaches 50%, trigger a handoff. Do not let quality degrade silently.
<!-- THIS IS CRITICAL. Do not remove this rule. It is the #1 quality protection in the protocol. -->
- Don't ask questions you can answer by reading the tracker, status files, or memory. Look it up first.

## Session Start Protocol

1. Scan `/intake/` for new files dropped since last session
2. For known files: sort into project folders. For unknown files: flag them and ask [YOUR NAME].
3. Check for orphaned files in the workspace root. Flag them, don't touch them.
4. Read `PROJECT_TRACKER.md` for project state
5. Present the Daily Briefing:
   - What was last worked on and where it left off
   - New intake items sorted (or pending sort)
   - Recommended task based on stated energy level
<!-- CUSTOMIZE: Add or remove steps based on your workflow. -->
<!-- If you use cloud sync, add a step 0: "Check for file conflict copies and clean them up." -->
6. If [YOUR NAME] is frozen: pick ONE thing and say "Let's just do this."

## Session End Protocol

1. Summarize what was accomplished
2. Update `PROJECT_TRACKER.md` -- what changed, what is next, any blockers
3. Capture any new ideas in BOTH:
   - The Idea Inbox in `PROJECT_TRACKER.md`
   - `/vault-staging/` for archiving to [YOUR NOTES APP / JOURNAL / VAULT]
<!-- ADJUST: If you don't use a notes app, just use the Idea Inbox. Remove vault-staging references. -->
4. Queue any session insights worth archiving
5. Confirm all ideas and insights are accounted for
6. Set the cold-start sentence: "Next session, pick up from [exact step]."
<!-- The cold-start sentence is what the next session reads to know EXACTLY where to resume. -->

## How [YOUR NAME] Works

<!-- Fill in YOUR communication style and preferences. Be specific -- your AI will follow this closely. -->

- [HOW YOU COMMUNICATE -- e.g., "Uses voice-to-text, messages are raw and rambling. Hold the thread." or "Types carefully, messages are concise and specific."]
- [HOW YOU HANDLE INPUT -- e.g., "Drops files into /intake/ throughout the day from phone" or "Pastes links and screenshots into chat"]
- [VOICE/STYLE PREFERENCES -- e.g., "No corporate speak. No jargon. Plain English." or "Technical language is fine. Be precise."]
- [DECISION STYLE -- e.g., "Prefer one clarifying question, then execute." or "Discuss options before committing."]
- [YOUR VALUES -- e.g., "Clarity over cleverness, working code over perfect code, shipped over theorized"]

## Context Engineering Rules

<!-- DO NOT MODIFY THESE unless you deeply understand why each one exists. -->
<!-- These protect the quality of your AI's reasoning. They are battle-tested. -->

- Never exceed 50% of the context window. Quality degrades exponentially past this point.
- Never use auto-compact. If approaching limit, trigger handoff protocol.
- Give sub-agents bite-sized specs, not entire project context.
- Read only the files needed for the current task. Use the project map, not the whole novel.
- After a bug fix taking more than 3 turns, suggest trimming the debugging context.
- Failed approaches get archived, not carried forward.
- Unrecognized files: flag, don't process. They may be old and irrelevant.
- **Model orchestration for sub-agents**: Main assistant always runs the strongest model. Sub-agents use the lightest model that can handle the task: light model for simple tasks (file sorting, formatting), mid-tier for moderate tasks (research, summarization), strongest for complex reasoning. When in doubt between two tiers, always use the heavier model. If a local LLM (Ollama) is available, use it for tasks that need zero cloud compute.

## Self-Improvement Protocol

When [YOUR AI NAME] discovers a correction, preference, or pattern during a session:
- Log it as a one-line dated lesson in the relevant project's status file
- If 3+ related lessons accumulate, create a dedicated context file in that project folder
<!-- This is how your AI gets smarter over time. Not vaguely -- concretely, in files you can read. -->

## Cost Constraints

<!-- ADJUST to match your situation. Delete if not relevant. -->
[YOUR COST APPROACH -- e.g., "Near-zero spend until projects generate revenue. Prefer free tiers, self-hosted, API-efficient approaches." or "Budget of $X/month for AI tools. Optimize within that." or delete this section entirely]

## The System

<!-- This is your system map. Start simple. Add rows as you add capabilities. -->

| Name | Role | Location |
|------|------|----------|
| **[YOUR AI NAME]** | [ROLE -- e.g., "The Steward -- organizes, builds, remembers"] | Claude Code in [YOUR WORKSPACE NAME] |

<!-- EXAMPLES OF ROWS YOU MIGHT ADD LATER: -->
<!-- | **[IDEATION AI NAME]** | Thinking partner, brainstorming | Claude Desktop / ChatGPT | -->
<!-- | **[LOCAL LLM NAME]** | Light lifting, free processing | Ollama on [YOUR SERVER] | -->
<!-- | **[YOUR WORKSPACE NAME]** | Home base workspace | [LOCATION] | -->
<!-- | **[YOUR INTAKE NAME]** | Voice/text/photo capture | Telegram bot on phone | -->
<!-- | **[YOUR VAULT NAME]** | Long-term knowledge archive | Obsidian / Notion / etc. | -->

## Cloud Sync Conflict Prevention

<!-- INCLUDE THIS SECTION if you sync your workspace between devices (iCloud, Dropbox, etc.) -->
<!-- DELETE THIS SECTION if you only use one computer. -->

Cloud sync creates conflict copies when two devices edit the same file simultaneously. Rules:
- **PROJECT_TRACKER.md**: Only write during session end. Never mid-session.
- **CLAUDE.md**: Rarely edit. Protocol changes only.
- **STATUS.md per project**: Use these for in-session updates. They rarely conflict because sessions focus on one project at a time.
```

---

## 8. Template: PROJECT_TRACKER.md

```markdown
# PROJECT_TRACKER.md -- [YOUR AI NAME] Working Memory

> Last updated: [DATE]
> Last session: [BRIEF DESCRIPTION OF WHAT HAPPENED]

---

## Briefing

<!-- Your AI reads this section first to understand what is hot right now. -->
<!-- Update this during the session-end cooldown. -->

**Most important right now**: [WHAT NEEDS ATTENTION MOST]
**Closest to done**: [WHAT IS ALMOST FINISHED]
**Current priority**: [WHAT YOU ARE ACTIVELY WORKING ON]

---

## Project States

<!-- Add one section per project. Your AI uses these to cold-start every session. -->
<!-- The format below is a template -- copy it for each project. -->

### [Project Name]
- **Status**: [ACTIVE / PAUSED / PLANNING / COMPLETE]
- **What it is**: [One sentence description]
- **Last activity**: [Date and what happened]
- **Where you left off**: [Exact state -- what was the last thing done?]
- **Next step**: [The single next action]
- **Blockers**: [Anything preventing progress. "None" is fine.]
- **Folder**: `projects/[project-folder-name]/`

---

## Idea Inbox

> Drop ideas here. They get acknowledged, saved, and redirected so they don't derail the current session.

- [YOUR FIRST IDEA -- or delete this line and start fresh]

---

## Session Log

| Date | Project | What Got Done | Next Step Set |
|------|---------|---------------|---------------|
| [DATE] | [PROJECT] | [SUMMARY] | [NEXT STEP] |

---

## Recurring Commitments

<!-- Things that limit your available time. Helps your AI understand your capacity. -->

- [YOUR JOB / MAIN TIME COMMITMENT]
- [FAMILY / PERSONAL COMMITMENTS]
- [YOUR TYPICAL WORK WINDOW -- e.g., "Evenings after 9pm, about 2 hours"]
```

---

## 9. Template: DECISION_LOG.md

```markdown
# DECISION_LOG.md -- [YOUR AI NAME] Decision Memory

> A first-class log of decisions, separate from the project tracker and the memory system.
>
> The tracker remembers what is happening. Memory remembers what is true.
> The decision log remembers what was decided -- why, by whom, and what would change it.

> Last updated: [DATE]

---

## How to Use This File

Every meaningful decision goes here, including:

- Architecture or tooling choices ("we use X instead of Y")
- Scope decisions ("we are NOT doing X this quarter")
- Naming or branding choices
- Process changes ("we now ship via X")
- Trade-offs that closed off an option

Update this file at session end (the cooldown ritual) whenever a decision was actually made -- not when one was merely discussed.

If a decision is reversible and recent, leave it in the table. If it is locked for the quarter, also list it under "Locked Decisions." If it is open, list it under "Open Decisions" and promote to the table when made.

---

## Decision Entries

| Date | Project | Decision | Why | Reversible? | Revisit Trigger |
|------|---------|----------|-----|-------------|-----------------|
| [DATE] | [PROJECT] | [WHAT WAS DECIDED] | [REASONING] | [YES / NO] | [WHAT WOULD MAKE THIS WORTH RE-OPENING] |

---

## Locked Decisions

> Decisions that are not up for re-debate this quarter. Re-open only if the revisit trigger fires.

- **[DATE]** -- [LOCKED DECISION] -- _see entry above_

---

## Open Decisions

> Decisions that need to be made soon. Promote to the table above when made.

- [ ] [DECISION TO BE MADE] -- _blocked on:_ [WHAT IS BLOCKING THE CALL]

---

## Anti-Patterns (What Goes Elsewhere)

To keep this file from becoming a dumping ground:

- **Tasks** belong in the project tracker, not here. "Send the email" is a task, not a decision.
- **Facts and patterns** belong in your AI's memory system. "User prefers terse responses" is feedback, not a decision.
- **Discussions** that did not end in a call belong in your session log. A decision needs an outcome.

If you are not sure: a decision changes what you are willing to do tomorrow. A note does not.
```

---

## 10. Troubleshooting and FAQ

**"Claude Code does not seem to read my CLAUDE.md."**

Make sure the file is named exactly `CLAUDE.md` (capital letters matter on some systems) and is in the root of the folder where you run `claude`. Claude Code looks for this file in the current directory.

**"My AI forgets things between sessions."**

This is expected at Level 1 -- that is what the PROJECT_TRACKER.md solves. Make sure your session-end cooldown is updating the tracker, and your session-start warmup is reading it. If the tracker is up to date but your AI is still forgetting, check that it is actually reading the file (ask it: "What does my project tracker say about X?").

**"My conversations get long and the AI starts making mistakes."**

This is context rot. It is the reason the 50% rule exists. When things get long, tell your AI: "Let's do a handoff." It will write a handoff file summarizing everything important, and you start a new session that reads that file.

**"I use cloud sync and I keep getting duplicate files."**

This happens when two devices edit the same file. The protocol's rule -- only update the tracker at session end, never mid-session -- prevents most conflicts. If you are still getting dupes, add a duplicate-check step to your session start protocol.

**"I am not a programmer. Can I still use sub-agents and automation?"**

Yes. Your AI can set up almost everything for you. At Level 3+, just describe what you want in plain language and let your AI build it. That is the entire point -- you direct, it executes.

**"How much does this cost?"**

Level 1-2 costs only your Claude subscription (currently ~$20/month for Pro). Levels 3+ can be done on free tiers of most services. The protocol was designed with a near-zero budget in mind.

**"I want to use ChatGPT / Gemini / another AI instead of Claude."**

The protocol concepts (session rituals, project tracker, context management, memory) work with any AI that can read files. The specific implementation in this guide uses Claude Code because it has the best file access and tool use. If your preferred AI has similar capabilities, adapt accordingly.

**"What if I want to change my protocol later?"**

Change it whenever you want. The CLAUDE.md file is yours. The protocol is a living document -- it should evolve as you learn what works for you. Your AI's self-improvement loop will suggest changes over time too.

---

## Afterword

This protocol was born out of necessity. A professional with a demanding day job, building twenty projects in limited evening windows, needed an AI that could keep up. Not an AI that forgets. Not an AI that degrades. Not an AI that needs hand-holding.

The result is a system that treats AI conversations not as disposable chat sessions but as persistent working relationships. The session rituals create continuity. The context rules protect quality. The memory system enables growth. The tracker provides truth.

None of this is magic. It is just good systems engineering applied to a new tool. The same way a well-organized workshop makes a craftsperson faster, a well-organized AI protocol makes a human-AI partnership stronger.

Build it your way. Name it your way. Make it yours.

Welcome to the craft.

---

*The Imprint Protocol -- originated at The Forge, open to all.*
*First shared: March 2026*
