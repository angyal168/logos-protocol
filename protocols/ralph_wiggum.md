# RalphWiggum Protocol — Autonomous Iteration Loop

> The simplest autonomous agent pattern. Give it a task and a completion condition. It keeps working until the condition is met.

## When To Use

- Framework migrations
- Linting and code cleanup
- Test coverage improvement
- Build error resolution
- Any mechanically verifiable task with a clear success condition
- "Set it and check back in 30 minutes" tasks
- Implementation of a spec that TartaurusLoop already generated

## When NOT To Use

- Tasks requiring structured multi-stage generation → use `/tartaurus`
- Tasks where success isn't mechanically verifiable
- Creative/analytical work requiring human judgment at each step
- Tasks where a wrong iteration could cause damage (no safety guardrails beyond max iterations)

---

## Core Mechanism

1. **Define:** task description + completion promise (exact string or verifiable condition)
2. **Loop:** agent works on task → checks for completion condition → if not met, reinjects prompt
3. **Stop:** completion condition found OR max iterations reached

## Setup

```
Task:               {what needs to be done — clear, specific}
Completion Promise: {exact verifiable condition — "All tests pass", "0 lint errors", "Build succeeds"}
Max Iterations:     {safety cap — default 10}
```

---

## Key Properties

| Property | RalphWiggum |
|----------|-------------|
| State persistence | None between runs. Conversation history only. |
| Typed dependencies | None. Each iteration works from current codebase state. |
| Audit trail | Conversation history only. No formal log. |
| Model routing | Single model. No per-phase routing. |
| Completion signal | String match or command exit code. Static, set once. |

---

## The Insight: "You Are The Problem"

In manual iteration, the operator becomes a feedback relay — reading output, deciding next step, typing the next prompt. RalphWiggum removes that bottleneck. The operator sets the goal, the loop handles iteration.

This applies differently to each loop:
- **RalphWiggum:** you are the problem because you are the feedback relay. The loop removes you from mechanical iteration.
- **TartaurusLoop:** you are the problem because you write the spec. A bad spec produces a bad packet at scale, fast.

---

## Composition with TartaurusLoop

Natural sequence:
1. **TartaurusLoop** generates the spec / architecture / blueprint
2. **RalphWiggum** iterates the implementation until it meets the spec

TartaurusLoop builds the blueprint. RalphWiggum builds the building.

Can also use both in parallel:
- TartaurusLoop on the complex analytical work
- RalphWiggum on the mechanical cleanup tasks

---

## Comparison

| Dimension | RalphWiggum | TartaurusLoop |
|-----------|-------------|---------------|
| **Input** | Task + completion string | Structured spec (JSON) |
| **Completion** | String match | Stage-by-stage validation |
| **State** | Conversation only | checklist + session + state_graph |
| **Resume** | Restart from scratch | Resume-safe |
| **Audit** | None | Full session trail |
| **Sweet spot** | Fix existing things | Generate new things |
| **Weakest link** | Completion promise accuracy | Spec quality |
| **Operator load** | Low (set and forget) | High upfront (write the spec) |

---

## Safety Notes

1. **Always set max iterations.** Unbounded loops are dangerous.
2. **Completion promise must be precise.** If "0 errors" appears in output for the wrong reason, the loop stops prematurely.
3. **No HITL flags.** If it gets stuck, it burns iterations. Watch the output.
4. **No rollback.** Each iteration modifies the codebase. If an iteration breaks something, subsequent iterations inherit the breakage.
5. **3-iteration stall rule:** If no measurable progress for 3 consecutive iterations, stop and surface to the operator rather than burning remaining iterations.
