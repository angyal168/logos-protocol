# Content Pipeline Protocol

> A six-phase autonomous content production pipeline. Discovers, filters, enriches, formats, curates, and delivers — with a human gate before publish.

## When To Use

- Building a knowledge digest, newsletter, or content production system
- Any workflow that: discovers content → filters → enriches → formats → publishes
- Automated research summaries from multiple sources
- Multi-channel content distribution (blog, social, email)

## When NOT To Use

- One-off content creation (just write it)
- Content that doesn't need source discovery (you already have the material)
- Real-time content (this is batch-oriented)

---

## The Six Phases

### Phase 1: CRAWL
Discover raw content from sources.
- Define source APIs or feeds (academic databases, RSS, APIs, web scraping)
- Set topic areas as search queries
- Deduplicate by unique identifier (DOI, URL, ID)
- Fetch metadata and abstracts/summaries
- **Output:** array of raw source items

### Phase 2: CLASSIFY
Score and filter for relevance.
- LLM-as-classifier: score each item 0.0–1.0 for relevance to your domain
- Assign domain/category tags
- Generate downstream queries for enrichment phase
- Suggest publishing channel per item
- Drop items below threshold (default: 0.5)
- **Output:** filtered, scored, tagged items

### Phase 3: QUERY
Enrich with domain-specific knowledge.
- For each surviving item, query your domain knowledge systems
- This is where domain expertise enters the pipeline
- Multiple query types: Q&A, classification/coding, ethical reasoning
- Parse responses and attach to items
- **Output:** enriched items with domain context

### Phase 4: FORMAT
Assemble into self-contained content units.
- Each unit is independently useful (no unit depends on another)
- Include: source citation, classification, domain analysis, structured tags, human annotation slot
- Extract structured metadata (codes, categories, key terms)
- Write each unit to disk as its own file
- **Output:** formatted content units ("pills")

### Phase 5: CURATE
Select the best for each channel.
- LLM-as-curator: select 0–N items per channel
- **"0 is valid output"** — quality over quantity. Never fill a quota with garbage.
- Apply channel-specific constraints (word count, tone, format)
- Bias toward your domain expertise
- **Output:** curated selections per channel

### Phase 6: DELIVER
Present for human approval and publish.
- Render final output (markdown, email, social post)
- Include a blank **"Your Perspective"** section for the human operator
- Save locally before sending anywhere
- Human reviews, adds their take, approves or rejects
- Only approved content publishes
- **Output:** published or rejected content with receipt

---

## Key Invariants

1. **No content is better than bad content.** Empty output is valid. "0 pills" is a correct answer.
2. **System analysis ALWAYS precedes human take.** The human adds perspective after seeing the system's work, not before.
3. **Each content unit must be independently useful.** No unit depends on another.
4. **Human gate before publish.** The system suggests; the human publishes.
5. **Source attribution is mandatory.** No orphan claims.

---

## Content Unit Schema

```json
{
  "id": "unique_identifier",
  "source": {
    "title": "",
    "url": "",
    "date": "",
    "authors": []
  },
  "classification": {
    "relevance_score": 0.0,
    "domain": "",
    "tags": []
  },
  "system_analysis": {
    "summary": "",
    "domain_queries": [],
    "codes": []
  },
  "human_take": {
    "raw": null,
    "edited": null
  },
  "status": "pending_review",
  "channels": ["blog", "social"],
  "created_at": "timestamp"
}
```

---

## Status Lifecycle

`crawled` → `classified` → `queried` → `formatted` → `pending_review` → `approved` → `published` | `rejected`

---

## Channel Configuration

Each channel has independent constraints:

```json
{
  "channel_name": {
    "max_items": 3,
    "max_length": 1500,
    "tone": "accessible but precise",
    "format": "markdown with headers",
    "schedule": "weekly Tuesday"
  }
}
```

---

## Graceful Degradation

Empty results at any phase produce valid "empty" output rather than crashing:
- CRAWL finds nothing → empty week email, not an error
- CLASSIFY drops everything → "no items met threshold" is a valid result
- CURATE selects 0 → quality gate held. Report it. Move on.

---

## Composition with Other Protocols

- **Governed by a SpellBook** — defines sources, thresholds, channels, invariants
- **Can run as a TartaurusLoop** `content_pipeline` pattern
- **Session logging follows DAR** — each phase is a Discovery → Artifact → Receipt
- **Can be triggered by RalphWiggum** for iterative quality improvement on existing content
