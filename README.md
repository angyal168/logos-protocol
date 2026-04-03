# The Imprint Protocol

> An open protocol for building an AI assistant that actually knows you.

Not a chatbot you re-explain yourself to every time. Not a novelty that impresses for five minutes and then collects dust. A persistent, evolving, working partner that gets sharper every session.

## What You Get

- An AI that cold-starts in seconds with full context of who you are and what you're working on
- Session rituals that prevent information loss between conversations
- A memory system that makes your AI measurably better over time
- Context rot protection that keeps reasoning sharp as conversations grow
- A clear upgrade path from basic assistant to autonomous agent

## Quick Start

**Prerequisites:** A Claude account with Claude Code access, a terminal, a folder.

```bash
# Install Claude Code
npm install -g @anthropic-ai/claude-code

# Create your workspace
mkdir ~/Workshop && cd ~/Workshop

# Copy the templates
# (paste templates/CLAUDE.md and templates/PROJECT_TRACKER.md into your workspace)

# Launch
claude
```

Then tell your AI: *"Let's do the Imprinting Ritual"* -- and answer 17 questions that make the protocol yours.

Full walkthrough: **[IMPRINT.md](IMPRINT.md)**

## What's Here

```
logos-protocol/
  IMPRINT.md                      The complete protocol (start here)
  templates/
    CLAUDE.md                     Drop-in protocol file for your workspace
    PROJECT_TRACKER.md            Working memory template
  guides/
    SKILLS.md                     How to create custom slash commands
    COMMANDS.md                   Built-in commands you can map (warmup, cooldown, cron)
    TELEGRAM.md                   Telegram bot setup for mobile access
    VOICE.md                      Local text-to-speech with Piper
    MYTHIC_QUESTIONS.md           Deep identity questions for people who need meaning first
  commands/                       40+ custom slash commands (copy to .claude/commands/)
    page-cro.md                   Optimize any marketing page for conversions
    copywriting.md                Write or improve marketing copy
    ai-seo.md                     Optimize content for AI search engines
    ...and 40+ more (see commands/README.md for full list)
  skills/                         18 ready-made skills (copy to .claude/skills/)
  tools/                          Open source programs that power each level
```

## The Roadmap

| Level | What You Get | Time to Set Up |
|-------|-------------|----------------|
| 1. Basic Assistant | AI that knows you, picks up where you left off | 30-60 min |
| 2. Memory & Persistence | Cross-session learning, git backup, handoff protocol | 1 session |
| 3. Intake & Automation | Phone drop zone, basic automations | 1-2 sessions |
| 4. Voice & Channels | Telegram bot, voice transcription, TTS replies | 2-3 sessions |
| 5. Multi-Agent | Sub-agents, local LLM, parallel work | 1-2 sessions |
| 6. Autonomous Operations | Scheduled tasks, proactive monitoring, overnight work | Ongoing |

## Staying Updated

```bash
cd logos-protocol
git pull
```

New guides, template improvements, and protocol refinements land here. Pull when you want them. Your personal CLAUDE.md and PROJECT_TRACKER.md are yours -- updates never overwrite your config.

## Origin

Built by a pharmacist with a demanding day job, building twenty projects in limited evening windows. He needed an AI that could keep up. The result is a system that treats AI conversations not as disposable chat sessions but as persistent working relationships.

The session rituals create continuity. The context rules protect quality. The memory system enables growth. The tracker provides truth.

---

*The Imprint Protocol -- originated at The Forge, open to all.*
*First shared: March 2026*
