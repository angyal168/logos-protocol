# Optional Tools -- Open Source Programs That Power the Protocol

> Every tool here is free and open source. None are required at Level 1. Add them as you level up.

These are the tools used in the original Forge build. Each one was chosen because it's free, self-hostable, and does its job without lock-in. Install what you need, ignore the rest.

## By Level

### Level 1-2: Foundation (Desktop Only)

| Tool | What It Does | Install | Why You Want It |
|------|-------------|---------|----------------|
| **Claude Code** | AI assistant CLI that reads your protocol | `npm install -g @anthropic-ai/claude-code` | This IS the protocol engine. Required. |
| **Node.js** | JavaScript runtime (needed for Claude Code) | [nodejs.org](https://nodejs.org) | Prerequisite for Claude Code. |
| **git** | Version control for your workspace | [git-scm.com](https://git-scm.com) | Never lose work. Track every change. |
| **VS Code** or **Cursor** | Text editor | [code.visualstudio.com](https://code.visualstudio.com) / [cursor.com](https://cursor.com) | Read and edit your files. Any editor works. |

### Level 3: Intake & Automation

| Tool | What It Does | Install | Why You Want It |
|------|-------------|---------|----------------|
| **n8n** | Visual workflow automation (self-hosted Zapier) | `docker run -d --name n8n -p 5678:5678 n8nio/n8n` | Automate repetitive workflows. Free, no limits. |
| **Docker** | Run apps in containers | [docker.com](https://www.docker.com/get-started) | Required for n8n and most self-hosted tools. |
| **Portainer** | Docker management UI | `docker run -d -p 9000:9000 portainer/portainer-ce` | Visual control panel for all your containers. |

### Level 4: Voice & Channels

| Tool | What It Does | Install | Why You Want It |
|------|-------------|---------|----------------|
| **Whisper** | Speech-to-text (transcribe voice memos) | `pip install openai-whisper` | Turn voice recordings into text your AI can read. |
| **faster-whisper** | Whisper but 4x faster, lower RAM | `pip install faster-whisper` | Same quality, runs on weaker hardware. |
| **Piper TTS** | Text-to-speech (give your AI a voice) | `pip install piper-tts` | Local voice synthesis. No cloud, no fees. |
| **ffmpeg** | Media processing (audio/video conversion) | `apt install ffmpeg` or [ffmpeg.org](https://ffmpeg.org) | Convert audio formats, adjust speed/volume, process video. |
| **Telegram** | Messaging app (bot platform) | [telegram.org](https://telegram.org) | Free bot API. Your mobile bridge to the workspace. |

### Level 5: Multi-Agent

| Tool | What It Does | Install | Why You Want It |
|------|-------------|---------|----------------|
| **Ollama** | Run AI models locally | [ollama.ai](https://ollama.ai) | Free local LLM inference. No API costs for light tasks. |
| **tmux** | Terminal multiplexer | `apt install tmux` or `brew install tmux` | Keep processes running after you disconnect. Essential for servers. |
| **Tailscale** | Mesh VPN (connect devices securely) | [tailscale.com](https://tailscale.com) | Access your server from anywhere. Free for personal use. |

### Level 6: Autonomous Operations

| Tool | What It Does | Install | Why You Want It |
|------|-------------|---------|----------------|
| **Uptime Kuma** | Self-hosted monitoring | `docker run -d -p 3001:3001 louislam/uptime-kuma` | Monitor all your services. Alerts when things go down. |
| **Obsidian** | Knowledge base / note-taking | [obsidian.md](https://obsidian.md) | Long-term memory vault. Plain text, local-first. |

### Utility Belt (Any Level)

| Tool | What It Does | Install |
|------|-------------|---------|
| **curl** | HTTP requests from terminal | Pre-installed on most systems |
| **jq** | Parse and query JSON | `apt install jq` or `brew install jq` |
| **Python 3** | Scripting runtime | [python.org](https://www.python.org) |
| **Remotion** | Programmatic video creation (React) | `npx create-video@latest` |

## Scripts in this directory

| Script | What It Does | When To Use |
|--------|-------------|-------------|
| **`fossil.sh`** | FOSL (Fear of State Loss) durability audit. Detects claude CLI processes running outside tmux -- the ones that die when the parent shell drops. | Run on demand to check session health. Wire into a 23:30 cron with `--notify` for a nightly Telegram bedtime ping before you close the laptop. |

## Hardware Recommendations

You don't need a server to start. But for Levels 4-6, an always-on machine makes everything easier:

**Budget option (~$150-300):**
- Mini PC (Intel N100 or Ryzen 5) with 16GB RAM
- Runs Docker, Ollama, n8n, Whisper, Piper, Telegram bot simultaneously
- Sits quietly on a shelf, draws 15-25 watts

**Free option:**
- An old laptop with Linux installed
- Keep the lid closed, SSH in from your main machine

**Cloud option ($5-20/month):**
- A VPS from Hetzner, DigitalOcean, or Linode
- Good enough for everything except Ollama (needs GPU for decent speed)

## Philosophy

Every tool here follows the same principle: **own your infrastructure.** No vendor lock-in, no surprise pricing, no "free tier that expires." If the company behind any of these tools disappears tomorrow, your files and your system keep working.

That said -- don't install everything at once. Start at Level 1 with just Claude Code and git. Add tools as you actually need them. The protocol tells you when.
