# Custom Commands -- Ready-Made Slash Commands

> Drop any of these into your `.claude/commands/` folder and they work immediately.

These are custom commands built at the Forge. They're different from skills -- commands are simpler (single markdown files) and live in `.claude/commands/` instead of `.claude/skills/`.

## How to Install

```bash
# Create the commands directory if it doesn't exist
mkdir -p ~/.claude/commands

# Copy one command
cp commands/page-cro.md ~/.claude/commands/

# Or copy all of them
cp commands/*.md ~/.claude/commands/
```

Then type the slash command (e.g., `/page-cro`) in your next Claude Code session.

## Available Commands

### Marketing & Content Strategy

| Command | File | What It Does |
|---------|------|-------------|
| `/content-strategy` | content-strategy.md | Plan a content strategy -- topics, formats, distribution |
| `/content-strategy-sms` | content-strategy-sms.md | Social media content strategy -- pillars, mix, cadence |
| `/content-calendar-sms` | content-calendar-sms.md | Plan a posting schedule and content calendar |
| `/content-repurposer-sms` | content-repurposer-sms.md | Turn one piece of content into multiple formats |
| `/marketing-ideas` | marketing-ideas.md | Generate marketing ideas and growth strategies |
| `/marketing-psychology` | marketing-psychology.md | Apply psychological principles to marketing |
| `/launch-strategy` | launch-strategy.md | Plan a product launch or feature release |
| `/product-marketing-context` | product-marketing-context.md | Create or update product marketing context |

### SEO & Search

| Command | File | What It Does |
|---------|------|-------------|
| `/ai-seo` | ai-seo.md | Optimize content for AI search engines and LLM citations |
| `/seo-audit` | seo-audit.md | Audit and diagnose SEO issues on a site |
| `/programmatic-seo` | programmatic-seo.md | Create SEO-driven pages at scale using templates and data |
| `/schema-markup` | schema-markup.md | Add, fix, or optimize schema markup and structured data |
| `/site-architecture` | site-architecture.md | Plan or restructure website page hierarchy and navigation |
| `/competitor-alternatives` | competitor-alternatives.md | Create competitor comparison or alternative pages |

### CRO (Conversion Rate Optimization)

| Command | File | What It Does |
|---------|------|-------------|
| `/page-cro` | page-cro.md | Optimize any marketing page for conversions |
| `/form-cro` | form-cro.md | Optimize lead capture, contact, and other forms |
| `/signup-flow-cro` | signup-flow-cro.md | Optimize signup, registration, and trial activation flows |
| `/onboarding-cro` | onboarding-cro.md | Optimize post-signup onboarding and user activation |
| `/popup-cro` | popup-cro.md | Create or optimize popups, modals, and overlays |
| `/paywall-upgrade-cro` | paywall-upgrade-cro.md | Create or optimize in-app paywalls and upgrade screens |
| `/ab-test-setup` | ab-test-setup.md | Plan, design, or implement A/B tests |
| `/analytics-tracking` | analytics-tracking.md | Set up, improve, or audit analytics tracking |

### Copywriting & Content Creation

| Command | File | What It Does |
|---------|------|-------------|
| `/copywriting` | copywriting.md | Write or improve marketing copy for any page |
| `/copy-editing` | copy-editing.md | Edit, review, or improve existing marketing copy |
| `/hook-writer-sms` | hook-writer-sms.md | Write opening lines and hooks that grab attention |
| `/post-writer-sms` | post-writer-sms.md | Write social media posts for LinkedIn, Twitter/X, Threads |
| `/thread-writer-sms` | thread-writer-sms.md | Write multi-part threads for Twitter/X or LinkedIn |
| `/social-content` | social-content.md | Create, schedule, or optimize social media content |
| `/viral-content` | viral-content.md | Generate content optimized for virality |

### Advertising & Outreach

| Command | File | What It Does |
|---------|------|-------------|
| `/ad-creative` | ad-creative.md | Generate ad creative -- headlines, descriptions, variations |
| `/paid-ads` | paid-ads.md | Plan and optimize paid advertising campaigns |
| `/cold-email` | cold-email.md | Write B2B cold emails and follow-up sequences |
| `/email-sequence` | email-sequence.md | Create or optimize email sequences and drip campaigns |

### Revenue & Growth

| Command | File | What It Does |
|---------|------|-------------|
| `/pricing-strategy` | pricing-strategy.md | Plan pricing, packaging, or monetization strategy |
| `/lead-magnets` | lead-magnets.md | Create or optimize lead magnets for email capture |
| `/free-tool-strategy` | free-tool-strategy.md | Plan or build a free tool for marketing purposes |
| `/referral-program` | referral-program.md | Create or optimize referral and affiliate programs |
| `/churn-prevention` | churn-prevention.md | Reduce churn, build save flows, recover failed payments |
| `/revops` | revops.md | Revenue operations, lead lifecycle, marketing-to-sales handoff |
| `/sales-enablement` | sales-enablement.md | Create sales collateral, pitch decks, objection handling |
| `/customer-research` | customer-research.md | Conduct, analyze, or synthesize customer research |

### Design & UX

| Command | File | What It Does |
|---------|------|-------------|
| `/ui-ux-pro` | ui-ux-pro.md | UI/UX design review and optimization |

### Video

| Command | File | What It Does |
|---------|------|-------------|
| `/yt-clipper` | yt-clipper.md | Smart YouTube video clipping with bilingual subtitles |

## Commands vs Skills

**Commands** (`.claude/commands/`): Single markdown files. Simple instructions. Quick to write, quick to load.

**Skills** (`.claude/skills/`): Folder with SKILL.md + supporting files. More structured, with YAML frontmatter for automatic triggering. Better for complex workflows.

Start with commands. Graduate to skills when a command needs supporting files or auto-triggering.
