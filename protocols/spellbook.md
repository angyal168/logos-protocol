# SpellBook Protocol

> An ingestable specification that governs agent behavior. Feed it to an agent to bootstrap correct behavior.

## When To Use

- Starting any new agent pipeline or automated workflow
- Defining governance rules for a content production system
- Setting up a TartaurusLoop run (the SpellBook routes the loop)
- Any context where an agent needs explicit behavioral constraints

## When NOT To Use

- One-off tasks with no governance requirements
- Tasks where the existing CLAUDE.md protocol is sufficient

---

## Core Structure

```json
{
  "spec_id": "UNIQUE_IDENTIFIER",
  "version": "1.0",
  "author": "operator name",
  "description": "what this spellbook governs",

  "invariants": [
    "Rule that must never be violated",
    "No output is better than bad output",
    "Human gate before any publish/deploy action"
  ],

  "models": {
    "specify": "model for generation/reasoning (expensive, high-context)",
    "integrate": "model for synthesis/consolidation (fast, cheap)",
    "validate": "model or 'deterministic' for constraint checking",
    "image": "model for image generation (optional)"
  },

  "tools": {
    "tool_name": {
      "description": "what it does",
      "parameters": {},
      "constraints": "usage limits or safety boundaries"
    }
  },

  "loop_patterns": {
    "pattern_name": {
      "phases": ["FETCH", "SPECIFY", "VALIDATE", "INTEGRATE"],
      "description": "when to use this pattern"
    }
  },

  "output_formats": {
    "channel_name": {
      "max_length": 1500,
      "tone": "direct, precise",
      "template": "structure description"
    }
  },

  "human_gate": {
    "approval_required_before": ["publish", "deploy", "send"],
    "operator": "who approves"
  },

  "status_lifecycle": [
    "created", "specified", "validated", "integrated",
    "pending_review", "approved", "published", "rejected"
  ]
}
```

---

## Key Principles

1. **Invariants are first-class citizens.** Write them before code. They constrain everything downstream.
2. **The spec governs the agent.** The agent does not modify the spec. Ever.
3. **Human gate is explicit.** In the schema, not implicit in the workflow. If it's not declared, it doesn't exist.
4. **"No output is better than bad output"** is the default invariant for every SpellBook.
5. **Model routing is structural.** Expensive models for reasoning, cheap models for synthesis. Not accidental.
6. **Tools are allowlisted.** If it's not in the SpellBook, the agent cannot use it.
7. **Output formats are channel-aware.** Different channels get different constraints (length, tone, format).

---

## SpellBook vs CLAUDE.md

| | CLAUDE.md | SpellBook |
|---|-----------|-----------|
| **Scope** | Governs the steward across ALL work | Governs a specific pipeline or agent for a specific task |
| **Persistence** | Always loaded | Loaded when the pipeline runs |
| **Authority** | Parent | Child — inherits CLAUDE.md invariants, adds its own |
| **Format** | Markdown | JSON (machine-parseable, LLM-ingestable) |

SpellBooks are children of CLAUDE.md. They inherit its invariants and layer on domain-specific rules.

---

## Artifact Schema Template

Every artifact produced under a SpellBook should be self-contained:

```json
{
  "id": "unique_identifier",
  "status": "pending_review",
  "classification": {},
  "content": {},
  "receipt": {
    "created_by": "agent or operator",
    "created_at": "timestamp",
    "spec_id": "governing spellbook ID",
    "version": "spellbook version"
  }
}
```

Each artifact:
- Has its own classification and metadata
- Has its own status in the lifecycle
- Has a receipt (who created it, when, under what spec)
- Can be independently reviewed, approved, or rejected
- Does not depend on other artifacts to be useful

---

## Audience Constraint Pattern

Define your reader BEFORE your output format:

- **Who are they?** (expertise level, role, domain knowledge)
- **How much time do they have?** (90 seconds? 10 minutes? unlimited?)
- **What do they already know?** (skip basics, lead with delta)

These three constraints shape word limits, tone, structure, and level of detail. An audience constraint is not optional — it is a design input.

---

## Building a SpellBook (Step by Step)

1. **Name it.** What is this spellbook governing?
2. **Write invariants.** What must never be violated? (minimum 3)
3. **Define audience.** Who consumes the output?
4. **Choose models.** Which model for which phase?
5. **Allowlist tools.** What can the agent use?
6. **Define output formats.** Per channel, with constraints.
7. **Set the human gate.** What requires approval?
8. **Define the lifecycle.** What statuses can an artifact have?
9. **Validate.** Does every invariant have enforcement? Does every output have a gate?
10. **Save.** JSON file in the project directory. Reference it from the loop runner.
