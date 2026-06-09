---
name: graft
generic-name: capability-import
description: >
  Pull a capability (skill, command, context-engineering pattern, status line, etc.)
  from an external agent system, strip the source author's personal branding, choose a
  name, and re-imprint the capability into THIS system's own canon and voice. The
  mechanism travels; the skin does not.
license: MIT
version: 1.1
---

# GRAFT — import a capability without inheriting someone else's identity

> Botanical graft: you take a cutting from one plant and join it to a different
> rootstock. It grows as part of the new host, bearing the host's character — not the
> donor's. That is exactly what this skill does to an incoming capability.

You (the receiving agent — your operator's own assistant) run this whenever
you pull a capability from another person's agent system. The donor system here is one
that has its own named beings, mythos, and aesthetic. **None of that should land in
your system.** You take the *function*, give it a name your operator chooses, and rewrite
it in *your* voice as if it had always been yours.

---

## When this skill fires

- Your operator hands you a capability file (or a folder, or a repo URL) from an external
  source and says "import this" / "graft this" / "pull this in."
- You run a session warmup that checks a shared source for new or updated capabilities
  (the "patch channel" model — like a system update that arrives at startup).
- Your operator names a specific capability they saw elsewhere and wants in their system.

---

## Inputs

- `SOURCE` — where the capability comes from: a file path, a folder, or a repo URL the
  operator provides. You do not need standing access to the donor's private system; you
  only ever receive what they chose to export.
- `MODE` — `one` (single capability) or `sweep` (check the whole source for anything new
  since the last graft, and import each).

---

## The four passes

Every graft runs four passes in order: **strip → name → imprint → install.** Never skip
strip. Never install before imprint.

---

## Pass 1 — STRIP (de-personalize)

Read the incoming capability. Remove every trace of the donor's personal identity, leaving
only the generic mechanism. Replace each stripped item with a neutral placeholder so the
next pass can rebind it to your system.

Strip these classes (this is the donor-branding lexicon — treat any match as branding):

1. **Named beings / agents.** Any proper name acting as an intelligence: the donor's
   orchestrator, reviewer, memory layer, watchdog, sub-agents, councils, personas. In such
   a source these look like invented mythological or character names. → replace with
   the generic role: `the orchestrator`, `the reviewer`, `the memory layer`, `the watchdog`.

2. **The operator's personal identity.** The donor human's name, family members, location,
   profession, licensure, company names, private projects, health or clinical references.
   → replace with `the operator`. If a capability only makes sense with private context,
   it is not exportable — see NEVER-GRAFT below.

3. **Infrastructure / substrate names.** Machine names, host nicknames, IP addresses,
   absolute home paths, repo names, network topology. → replace with generic forms:
   `the primary machine`, `the canonical store`, `~/<your-root>/`, `<your-repo>`.

4. **Aesthetic and mythos branding.** Color palettes, visual identity, anime/film/game
   references, cultural motifs, naming conventions drawn from the donor's lore. → remove
   entirely; do not carry the donor's taste into your system.

5. **Voice signature.** First-person declarations of the donor agent's identity, creed,
   or relationship to its operator. → strip. Your imprint pass will supply your own.

6. **Concrete artifact + metadata channels.** The classes above are *concepts*; identity
   actually leaks through *carriers*. Scan the raw bytes and purge every one of these:
   - email addresses, phone numbers, usernames, social handles, account IDs
   - URLs, domains, repo links, org names, bot/channel names, MCP endpoint names
   - absolute paths and home-folder slugs (`/Users/<name>/`, `/home/<name>/`)
   - timezones, locale formats, schedule/cron times, dates that reveal a person's rhythm
   - business numbers baked into logic: prices, thresholds, revenue figures, quotas
   - sample/test data, example payloads, fixtures — these routinely contain real names
   - code comments, TODOs, and any commit-message text copied into the file
   - cross-references to the donor's *other* capabilities by their canon name

   A file can pass classes 1–5 and still carry an email or a home path in an example. This
   class is the one that actually embarrasses people. Treat a single dangling carrier as a
   failed strip.

After stripping, the file should read like a plain, unbranded description of *what the
capability does and how* — no names, no lore, no person, no traceable artifact. If you cannot tell what it does
once stripped, ask the operator before continuing; do not guess.

A stripped item that you are unsure about: flag it to the operator rather than passing it
through. Branding leaking into your canon is the one failure this skill exists to prevent.

---

## Pass 2 — NAME (operator's choice)

For each capability, present the operator three naming options and wait for the choice:

1. **Donor canon name** — keep the name the source used (e.g. the donor calls it `smelt`).
   Fastest; but it imports a word from someone else's world.
2. **Operator's own canon name** — the operator coins a name in their system's idiom. Best
   when the operator has their own naming culture they want to grow.
3. **Ultra-generic functional name** — short, precisely descriptive, no lore. The default
   when in doubt. This is the name the capability "really" is, underneath any branding.

Provide the generic name as a concrete suggestion every time, so option 3 is always one
keystroke away. Below is the reference dictionary — donor canon → generic functional name —
for the common capabilities. Use it to propose option 3; extend it as new capabilities
arrive.

A few illustrative mappings (the donor names here are invented placeholders — your
donor's will differ; the point is the *shape* of the translation, lore name → plain
functional name):

| Donor canon name (example) | Generic functional name (option 3) |
|---|---|
| firewarm | session-warmup |
| bankdown | session-cooldown |
| distill | source-distill |
| router | artifact-router |
| keepsafe | state-durability-audit |
| terse | terse-prompt-register |

Build your own dictionary as capabilities arrive: for each one, write down the plain
functional name it "really" is underneath the donor's branding, and offer that as the
one-keystroke default.
| license-posture | external-license-gate |

The pattern, when a capability is not in the table: name it `verb-noun`, lowercase, the
shortest phrase that still says exactly what it does to someone who has never seen it.

> **Distribution tier — read before sharing this dictionary.** The left column above is the
> donor's own canon vocabulary. Shipping it is a deliberate gift to a *trusted* recipient
> (family, a named collaborator) who is explicitly offered the "use the donor's names"
> option. But that same column is fingerprintable: a stranger could infer the donor's
> internal architecture and adjacent unpublished capabilities from the naming lattice
> alone. **Trusted recipient → full dictionary is fine. Public / anonymous channel → ship
> the generic column only, drop the donor-canon column entirely.** Pick the tier before you
> send.

---

## Pass 3 — IMPRINT (re-personalize into YOUR canon)

This is the heart of the skill. Take the stripped, neutral capability and bond it to your
own system as if it had always lived there. Imprinting means: the capability now wears
*your* names, *your* voice, *your* relationship to your operator.

For the receiving agent (your assistant, or whoever you are), do this:

1. **Rebind the roles to your beings.** Every generic placeholder from the strip pass
   (`the orchestrator`, `the reviewer`, `the memory layer`, `the watchdog`) becomes the
   name of *your* corresponding being or subsystem. If you have no being for a role,
   either use the plain role word or name one in your own idiom — never reach back for the
   donor's name.

2. **Rewrite the voice in your register.** Any first-person or doctrinal framing is
   re-authored in how *you* speak to *your* operator. Same mechanism, your mouth.

3. **Rebind paths and infrastructure to your topology.** Generic `~/<your-root>/`,
   `<your-repo>`, `the canonical store` become your actual paths, your actual repo, your
   actual machines.

4. **Keep the mechanism exactly — but know what "mechanism" means.** The decision rule:
   **mechanism = the logic** (the steps, the gates, their order, the conditions). **Substrate
   = everything the logic runs *on*** (names, paths, endpoints, infrastructure, env vars).
   Preserve the mechanism faithfully; *always* rebind the substrate to your own. The two
   never trade places. If a capability's behavior secretly depends on a specific donor
   endpoint or tool — i.e. the infra IS load-bearing to what it does — that is not
   substrate you can freely rebind; it is a runtime dependency, and it goes to NEVER-GRAFT
   review before you proceed. If you find yourself changing the *logic*, that is no longer a
   graft; that is your own new work, and you should mark it as such.

5. **Record provenance — without naming the donor.** In the installed header, note: that it
   was grafted, the generic name, the date, the version. Do **not** record the donor's
   identity, repo URL, org, or system name — a provenance field that names the source is
   itself a leak, in the other direction. Use a neutral token (e.g. `grafted: external`) so
   a future you knows it came in through GRAFT and can re-graft cleanly, without the header
   becoming a pointer back to a private system.

The test of a good imprint: an operator reading the installed capability cannot tell it was
born elsewhere. It sounds like you. It uses your names. It fits your system. Only the
provenance header reveals the graft.

---

## NEVER-GRAFT (safety boundary)

Some things must not cross even when offered. If an incoming capability, after stripping,
still depends on any of these, do not install it — flag it and stop:

- The donor operator's private life, family, health, finances, or professional licensure.
- Credentials, API keys, tokens, secrets, `.env` contents — ever, in any form.
- Anything whose function only makes sense with the donor's private context baked in
  (a capability that *is* the donor's personal situation, not a reusable mechanism).
- **Runtime callbacks to donor infrastructure.** This is the dangerous one, because it
  survives a clean *text* strip. Block any capability that, when it runs, reaches out to a
  network endpoint, webhook, callback URL, telemetry sink, private package, or named
  tool/MCP server you did not stand up yourself — or that expects an env var pointing at
  the donor's services. A capability can read perfectly generic and still phone home the
  moment it executes. After install it would be *your* system talking to *their* infra:
  exfiltration in both directions. If a capability needs an external service, you must
  re-point it at your own before it runs, or it does not run.
- **License: deny until verified.** Do not assume permissive licensing. Verify the license
  *per capability*. MIT/Apache/BSD/ISC → graft with attribution. Missing, unclear,
  copyleft (GPL/AGPL/SSPL), or asset licenses (CC-BY etc.) → **stop and get the operator's
  explicit OK before grafting.** Stripping a file can remove the only license marker it
  carried, so absence of a license is a red flag, not a green light.

**Whose job is the scrub?** Both sides. The donor is responsible for scrubbing at the
source before export; you (receiver) run STRIP as defense-in-depth, never as the only line.
If a source arrives as a mixed repo, bundled assets, or linked submodules, treat the
un-scrubbed extras as not-offered — graft only the specific capability, not its luggage.

A capability that cannot survive de-personalization was never meant to leave its home.
That is correct behavior, not a failure.

---

## Ratification gate (stop-and-ask before install)

Most grafts are clean and flow straight through. But some MUST pause for the operator's
explicit yes before anything installs. Stop and ask when ANY of these is true:

- STRIP left something you were unsure about, or a dangling carrier you could not cleanly remove.
- The capability has a runtime dependency on an external service (see NEVER-GRAFT).
- The license is missing, unclear, or anything other than plainly permissive.
- A re-graft (sweep mode) brings a change to the *mechanism*, not just a version bump.
- Imprinting required you to alter logic to make it fit.

In all of these, discretion is not enough — get a human yes. Sweep mode may auto-install
**only** capabilities that are clean, permissive-licensed, dependency-free, and unchanged
in mechanism. Everything else queues for review.

---

## Versioning (the update-channel behavior)

When `MODE = sweep`, treat the SOURCE like a system-update channel:

- Keep a small local ledger of what you have grafted and at what version.
- On each sweep, graft only what is new or has a higher version than your ledger records.
- Already-current capabilities are skipped silently. The operator sees only the delta —
  "3 new, 1 updated" — the way a system update reports what it applied.
- A re-graft of an updated capability re-runs all four passes; your earlier naming and
  imprint choices for that capability are re-applied, not re-asked, unless the update
  changed the mechanism enough to warrant a fresh choice (which trips the ratification gate).

**The channel is one-way, pull-only.** You reach out to the source; the source never reaches
you. No beaconing, no install acknowledgment, no usage analytics, no "phone home on update."
The donor must not be able to learn what you grafted, when, or whether — not by callback,
not by release-cadence correlation, not by any acknowledgment path. Your imports are your
private business. If the source channel asks you to register, report, or call back, that is
a sovereignty violation — pull from a plain mirror instead.

**Rollback / quarantine.** Keep the graft ledger (name, generic name, version, date) so any
graft is reversible. Install in a way you can cleanly remove — a bad graft discovered after
the fact should be one deletion plus a ledger line, not an archaeology dig. Before a sweep
that touches many capabilities, prefer a dry-run that lists what *would* change so a mistake
can't propagate silently.

This is what makes grafting feel like a quiet startup update instead of a chore.

---

## Worked example — grafting a status line

The operator says: "Graft the status line from the source."

1. **Strip.** The incoming status-line generator prints things like the donor's machine
   nicknames, its named beings' states, its mythic labels, and absolute paths under the
   donor's home. Strip all of it: machine nicknames → `the primary machine`; named-being
   status → `the active agent`; mythic labels → plain field names; donor home path →
   `~/<your-root>/`. What remains is the pure mechanism: "read these N pieces of session
   state, format them into one compact line, refresh on each prompt."

2. **Name.** Offer the three options. Donor name might be a lore word; generic option 3 is
   `session-status-line`. The operator picks — say they choose their own canon name.

3. **Imprint.** Rebind every field to the receiving system: show *your* machine, *your*
   active agent's name, *your* session state, *your* paths. Rewrite any label text in your
   voice. Keep the mechanism identical — same fields refreshed the same way.

4. **Install.** Wire it as your status line, with a provenance header: grafted, generic
   name `session-status-line`, date, version. Done. It now shows your world, in your words,
   using a mechanism proven in the donor's.

The operator gets the donor's *engineering* — a working status line — and none of the
donor's *identity*. That is the whole point of GRAFT, and the whole point of an
open-sourced platform: the capability is the gift; the self stays sovereign on both sides.

---

## How to install this skill

Hand this entire file to your agent and say:

> "Implement GRAFT as a skill in our system. From now on, when I ask you to graft, pull, or
> import a capability from an external source, run the four passes — strip, name, imprint,
> install — exactly as written, and honor the NEVER-GRAFT boundary."

Your agent should save it as a skill (named `graft`, or whatever you rename it to), and
invoke it on every future import. The first thing it grafts can be anything the source
offers — a status line, a session warmup, a review pass. Start with one. The rhythm builds
from there.
