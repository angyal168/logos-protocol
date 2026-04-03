# Optional Skills -- Ready-Made Slash Commands

> Drop any of these into your `.claude/skills/` folder and they work immediately.

These are the same skills used in the original Forge. Each one is battle-tested across dozens of sessions. Pick the ones that match your workflow. Ignore the rest.

## How to Install

```bash
# Copy a single skill
cp -r skills/brainstorming ~/.claude/skills/

# Or copy all of them
cp -r skills/* ~/.claude/skills/
```

Then type the slash command in your next Claude Code session.

## Available Skills

### Session & Workflow

| Skill | Command | What It Does |
|-------|---------|-------------|
| **brainstorming** | `/brainstorming` | Forces exploration of intent and requirements BEFORE any creative work. Prevents "build first, think later." |
| **writing-plans** | `/write-plan` | Designs implementation strategy for multi-step tasks before touching code. |
| **executing-plans** | `/execute-plan` | Executes a written plan in a separate session with review checkpoints. |
| **verification-before-completion** | `/verify` | Requires running actual verification commands before claiming work is done. No "I think it works" -- prove it. |
| **finishing-a-development-branch** | `/finish` | Guides merge/PR/cleanup decisions when implementation is complete. |

### Development

| Skill | Command | What It Does |
|-------|---------|-------------|
| **systematic-debugging** | `/debug` | Structured debugging protocol. Diagnose before fixing. No shotgun approaches. |
| **test-driven-development** | `/tdd` | Write tests first, implementation second. The right way. |
| **receiving-code-review** | `/review-received` | How to handle code review feedback with technical rigor, not blind agreement. |
| **requesting-code-review** | `/review-request` | Prepares work for review with proper context and verification. |
| **webapp-testing** | `/webapp-test` | Playwright-based toolkit for testing local web applications in the browser. |

### Agent Orchestration

| Skill | Command | What It Does |
|-------|---------|-------------|
| **dispatching-parallel-agents** | `/dispatch` | Launches 2+ independent sub-agents for parallel work. |
| **subagent-driven-development** | `/subagent-dev` | Executes implementation plans using independent sub-agents in current session. |
| **using-git-worktrees** | `/worktree` | Creates isolated git worktrees for feature work without disturbing main workspace. |

### Document Processing

| Skill | Command | What It Does |
|-------|---------|-------------|
| **pdf** | `/pdf` | Read, create, merge, split, watermark, encrypt, OCR -- anything PDF. |
| **docx** | `/docx` | Create, read, edit Word documents with formatting. |
| **pptx** | `/pptx` | Create, read, edit PowerPoint presentations. |
| **xlsx** | `/xlsx` | Create, read, edit spreadsheets. Charts, formulas, formatting. |

### Meta

| Skill | Command | What It Does |
|-------|---------|-------------|
| **writing-skills** | `/write-skill` | How to create your own custom skills. TDD methodology for skill authoring. |
| **using-superpowers** | `/superpowers` | Establishes how to find and use skills at conversation start. |

## Skill Compatibility

These skills are designed for Claude Code (Anthropic's CLI). They use the standard `.claude/skills/` directory structure with `SKILL.md` files. They should work on any OS where Claude Code runs.

Some skills reference sub-agent dispatch, which works best with Claude Opus or Sonnet models. Haiku may struggle with complex orchestration skills.

## Creating Your Own

See [guides/SKILLS.md](../guides/SKILLS.md) for a complete walkthrough on building custom skills from scratch.
