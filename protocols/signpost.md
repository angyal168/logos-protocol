# Signpost Protocol -- Navigation for Agents and Operators

> A signpost is a README.md that tells you what a folder is, what's in it, and where to go next.
> It exists so that agents and operators can orient in one read instead of recursive exploration.

## When To Use

- Any folder at the **top 2-3 levels** of a project hierarchy
- Any folder where the **name alone doesn't explain the routing logic** (e.g., a folder with pointers, mixed content, or non-obvious boundaries)
- Any folder that **automated agents need to navigate** without human guidance
- Any folder containing **pointer references** to content living elsewhere

## When NOT To Use

- Deep in the tree where the path IS the explanation (e.g., `Canonical/V5.2/V5.2 Individual Modules/`)
- Folders with fewer than 3 files where the filenames are self-evident
- Temporary or scratch directories that will be deleted

---

## The Signpost File

Every signposted folder gets a `README.md` with this structure:

```markdown
# FolderName -- Short Purpose

**Status:** Active | Paused | Archive
**Owner:** Who maintains this
**Last Updated:** YYYY-MM-DD

## Purpose

One paragraph. What lives here and what doesn't. If there's a boundary
(e.g., "only canon, nothing else, ever"), state it as a hard rule.

## Folder Map

| Folder/File | What lives here |
|-------------|-----------------|
| `SubfolderA/` | Description |
| `SubfolderB/` | Description |
| `loose_file.md` | Description |

## Pointers (if applicable)

| Topic | Location | Notes |
|-------|----------|-------|
| Related thing | `../relative/path` | Why it's there, not here |
```

### Required Fields

| Field | When required | Why |
|-------|--------------|-----|
| **Name + Purpose** | Always | An agent reads this first to decide if it's in the right place |
| **Status** | Always | Prevents agents from working in archived folders |
| **Folder Map** | When folder has 3+ children | The routing table -- what's here, one line each |
| **Pointers** | When content is referenced but lives elsewhere | Prevents duplication. The pointer pattern is the most valuable part of this protocol. |
| **Owner** | Top 2 levels | So automated agents know who to route questions to |
| **Last Updated** | Top 2 levels | Staleness signal |

### Optional / Skip

| Field | When to skip |
|-------|-------------|
| **Rules section** | Only add if the folder has hard constraints (e.g., "nothing except canon") |
| **Root Files table** | Only if there are loose files at the folder root alongside subdirectories |

---

## The Pointer Pattern

The most valuable part of this protocol. When content is relevant to a folder but canonical elsewhere:

**DO:** Add a pointer row in the README referencing the canonical location.
```
| EHR Playbook | `../../2OPMD/Clinical/EHR_INTEGRATION_PLAYBOOK.md` | Integration strategy |
```

**DON'T:** Copy the file into the folder. Copies drift. Pointers don't.

**Rule:** Content has exactly ONE canonical location. Everything else is a pointer to it.

---

## Maintenance

Signposts rot. A stale README is worse than no README because it gives false confidence.

### Automation Layer Standing Instructions

1. **On file creation/move:** If a file is added to or removed from a signposted folder, update that folder's README.md in the same operation.
2. **On session end (`/bank` or whatever session-end command you configure):** Spot-check top-level signposts (project root, first-level folders). Flag any with `Last Updated` older than 7 days if the folder contents have changed.
3. **On session start (`/init` or whatever session-start command you configure):** Read top-level signposts as part of orientation. If one contradicts what you see, fix it immediately.

### Staleness Rules

| Signal | Action |
|--------|--------|
| README lists a file that doesn't exist | Remove the entry |
| README missing a file that does exist | Add the entry |
| README date is >7 days old and contents changed | Update the date and entries |
| Folder was archived or emptied | Update Status to Archive or delete the README |

---

## Depth Rules

| Depth | Signpost? | Example |
|-------|-----------|---------|
| Project root | **Yes, always** | `2026_2OPMD/README.md` |
| First-level folders | **Yes, always** | `EoH/README.md`, `2OPMD/README.md` |
| Second-level folders | **Yes, if routing isn't obvious** | `Canonical/README.md` (has hard rules), `Data/` (merged sources) |
| Third-level and deeper | **No, unless pointer-heavy** | Skip `V5.2 Individual Modules/` -- the path says it all |

The test: **Would an agent arriving at this folder for the first time waste >30 seconds figuring out what's here?** If yes, signpost it. If no, the folder name is enough.

---

## Anti-Patterns

| Don't do this | Do this instead |
|---------------|-----------------|
| README that just echoes the folder name ("Clinical -- clinical documents") | State what's IN vs. OUT, or skip the signpost |
| Copying files into a folder so the README can list them | Use a pointer row |
| Writing a README for every leaf folder | Only signpost where navigation is ambiguous |
| Letting READMEs accumulate without maintenance | Scheduled agents audit on session end |
| Putting operational state in README (current tasks, blockers) | That belongs in STATUS.md, not the signpost |

---

## Relationship to STATUS.md

Signposts (README.md) and status files (STATUS.md) are different tools:

| | README.md (Signpost) | STATUS.md |
|-|----------------------|-----------|
| **Purpose** | What IS here (structure) | What's HAPPENING here (operations) |
| **Changes when** | Files are added/moved/removed | Work progresses, blockers shift |
| **Read by** | Agents navigating the tree | Operators resuming work |
| **Lives at** | Any signposted folder | Project root and active workstreams only |

Don't mix them. A signpost that contains "where you left off" and "next steps" will rot twice as fast.
