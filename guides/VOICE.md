# Giving Your AI a Voice

> Local text-to-speech that runs on your hardware. No cloud APIs. No monthly fees. No data leaving your machine.

This guide sets up Piper TTS -- a free, open-source text-to-speech engine that runs entirely on your own hardware. Your AI writes text, Piper converts it to speech, and you hear it through Telegram, your speakers, or both.

---

## What You Need

- A server or always-on computer (same one running your Telegram bot)
- Python 3.8+ installed
- About 50MB of disk space per voice model

## Why Local TTS?

Cloud TTS services (ElevenLabs, Google, Amazon Polly) charge per character and send your text to their servers. For a persistent AI assistant that talks to you multiple times a day, costs add up and privacy goes down.

Piper runs locally. Free forever. Your words stay on your hardware.

The trade-off: local voices sound good but not human-perfect. For a daily briefing or quick reply, they are more than enough.

---

## Step 1: Install Piper

```bash
# Install via pip
pip install piper-tts

# Or download a prebuilt binary from GitHub
# https://github.com/rhasspy/piper/releases
```

Test it immediately:

```bash
echo "The forge is ready." | piper --model en_US-lessac-medium --output_file test.wav
```

Play `test.wav`. If you hear it, Piper is working.

## Step 2: Choose a Voice

Piper has dozens of voices in multiple languages. Browse them at:
https://rhasspy.github.io/piper-samples/

Popular choices:
- `en_US-lessac-medium` -- Clean American English, good for briefings
- `en_US-ryan-medium` -- Slightly deeper American English
- `en_GB-alba-medium` -- Scottish English (warm, distinctive)
- `en_GB-cori-medium` -- Welsh English

Download a voice model:

```bash
# Models auto-download on first use, or download manually:
piper --model en_GB-alba-medium --download-dir ~/piper-voices
```

## Step 3: Wire It Into Your System

### Option A: Voice Replies in Telegram

Add this to your Telegram bot script:

```javascript
const { execSync } = require('child_process');

function textToSpeech(text, outputPath) {
  // Piper TTS -- adjust model and speed to taste
  execSync(
    `echo "${text.replace(/"/g, '\\"')}" | piper --model en_GB-alba-medium --output_file "${outputPath}"`,
    { timeout: 30000 }
  );
}

// In your message handler, after generating a text reply:
const audioPath = `/tmp/reply_${Date.now()}.wav`;
textToSpeech(replyText, audioPath);
bot.sendVoice(chatId, audioPath);
```

### Option B: Morning Briefing via Telegram

Create a script that runs on a cron schedule:

```bash
#!/bin/bash
# daily-briefing.sh -- runs at 6 AM via cron

WORKSPACE="$HOME/Workshop"
AUDIO_FILE="/tmp/briefing_$(date +%Y%m%d).wav"

# Extract briefing from tracker
BRIEFING=$(sed -n '/## Briefing/,/---/p' "$WORKSPACE/PROJECT_TRACKER.md" | head -20)

# Convert to speech
echo "$BRIEFING" | piper --model en_GB-alba-medium --output_file "$AUDIO_FILE"

# Send via Telegram
CHAT_ID="your_chat_id"
TOKEN="your_bot_token"
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendVoice" \
  -F "chat_id=$CHAT_ID" \
  -F "voice=@$AUDIO_FILE" \
  -F "caption=Good morning. Here's your briefing."
```

Add to crontab:
```bash
crontab -e
# Add this line:
0 6 * * * /home/youruser/daily-briefing.sh
```

### Option C: Local Speaker Output

If your server has speakers attached (or you're on your main machine):

```bash
# Generate and play immediately
echo "Session complete. Three tasks finished, two ideas captured." | \
  piper --model en_US-lessac-medium --output_raw | \
  aplay -r 22050 -f S16_LE -t raw -
```

---

## Tuning the Voice

### Speed

Piper does not have a built-in speed control, but you can use `ffmpeg` to adjust:

```bash
# Generate the audio
echo "Your text here" | piper --model en_GB-alba-medium --output_file /tmp/voice.wav

# Speed up by 1.2x (good for briefings)
ffmpeg -i /tmp/voice.wav -filter:a "atempo=1.2" /tmp/voice_fast.wav -y
```

### Volume

```bash
# Boost volume
ffmpeg -i /tmp/voice.wav -filter:a "volume=1.5" /tmp/voice_loud.wav -y
```

### Combining Speed + Volume

```bash
ffmpeg -i /tmp/voice.wav -filter:a "atempo=1.2,volume=1.3" /tmp/voice_final.wav -y
```

---

## Voice Models Worth Trying

| Model | Language | Character | Good For |
|-------|----------|-----------|----------|
| `en_US-lessac-medium` | American | Clear, neutral | Daily briefings, status updates |
| `en_US-ryan-medium` | American | Warm, deeper | Conversational replies |
| `en_GB-alba-medium` | Scottish | Distinctive, warm | Personal assistant feel |
| `en_GB-cori-medium` | Welsh | Gentle, clear | Calm notifications |
| `de_DE-thorsten-medium` | German | Clear | German-language users |
| `es_ES-sharvard-medium` | Spanish | Natural | Spanish-language users |

Full list: https://rhasspy.github.io/piper-samples/

---

## Troubleshooting

**"piper: command not found"**
Make sure Piper is in your PATH. If installed via pip: `pip show piper-tts` to find the install location.

**Audio sounds robotic or choppy**
Try a `medium` or `high` quality model instead of `low`. The quality tiers are: low (fast, smaller), medium (balanced), high (best quality, larger file).

**Telegram sends voice but it sounds wrong**
Telegram expects OGG format. Convert first:
```bash
ffmpeg -i /tmp/voice.wav -codec:a libopus /tmp/voice.ogg -y
```
Then send the `.ogg` file.

**Voice generation is slow**
On a Raspberry Pi, expect 2-5 seconds per sentence. On a modern x86 machine, it is near-instant. If too slow, use a `low` quality model.

---

## What is Next

Once you have TTS working:
- Wire it into your cooldown skill so you hear a session summary
- Create a morning briefing cron job
- Add voice to your Telegram bot replies
- Experiment with different voices until you find one that feels right

The voice becomes part of your system's personality. Pick one you enjoy hearing.
