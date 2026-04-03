# DAR Protocol — Discovery → Artifact → Receipt

> Every significant action follows three steps: discover why, produce what, leave proof.

## When To Use

- Any decision that changes system state
- Deployments, publications, financial commitments
- When you need to explain WHY something was done, not just WHAT
- When work needs to be auditable by a future operator (or future you)

## When NOT To Use

- Trivial file edits with obvious purpose
- Exploration/brainstorming with no state mutation
- Tasks where the git commit message is sufficient audit

---

## The Three Steps

### 1. Discovery
Why is this action being taken? What triggered it?
- The problem, request, or observation that initiated the work
- What was known and what was uncertain at decision time
- Any constraints or invariants that apply

### 2. Artifact
What was produced, changed, or decided?
- The concrete output: code, document, configuration, decision
- The state before and after (delta)
- Any tools, models, or references used

### 3. Receipt
Proof that the chain is intact.
- Who made the decision (operator or agent)
- When (timestamp)
- Under what authority (which spec, which invariant, which approval)
- Where the artifact lives (file path, commit hash, URL)
- Any HITL flags resolved or created

---

## Receipt Format — Lightweight

For quick decisions, inline or in commit messages:

```
[DAR] {timestamp}
Discovery: {why — one sentence}
Artifact: {what — file/commit/decision}
Receipt: {who authorized, under what spec}
```

## Receipt Format — Full

For deployments, publications, financial commitments:

```markdown
## DAR Entry — {title}
**Date:** {timestamp}
**Operator:** {who}
**Spec:** {governing spellbook or CLAUDE.md}

### Discovery
{What triggered this. What was known. What was uncertain.}

### Artifact
{What was produced. State delta. Files changed.}

### Receipt
{Authorization chain. HITL flags resolved. Validation status.}
```

---

## Key Principles

1. Every claim needs evidence. Every action needs justification. Every decision leaves a trace.
2. Receipts are produced when state mutates — not when state is read.
3. The receipt is not bureaucracy. It is proof that the chain of reasoning is intact.
4. A missing receipt means the action is unauditable. Unauditable actions accumulate as epistemic debt.
5. Epistemic debt compounds like technical debt — silently, then suddenly.

---

## Integration with Other Protocols

| Protocol | How DAR Applies |
|----------|----------------|
| **TartaurusLoop** | session.json IS the DAR trail. Every phase logs discovery (input), artifact (output), receipt (model, timestamp, outcome). |
| **SpellBook** | The SpellBook itself is a Discovery artifact with a governance receipt. |
| **Execution Contracts** | DEADLY_SERIOUS mode produces receipts. Brainstorming mode does not (no state mutation). |
| **Content Pipeline** | Each phase transition is a DAR entry. Published content has a full receipt chain. |
| **RalphWiggum** | No formal DAR — conversation history is the only trail. Use DAR for the final result only. |
