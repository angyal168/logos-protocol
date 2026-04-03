# Setting Up a Telegram Bot for Your AI

> Talk to your AI from anywhere. Drop voice memos, photos, and text from your phone. Get replies back.

This is the bridge between your phone and your workspace. Once set up, you can send your AI messages throughout the day -- ideas, voice memos, photos of whiteboards, quick questions -- and it all flows into your system.

---

## What You Need

- A Telegram account (free, on your phone)
- A server or always-on computer (a mini PC, a Raspberry Pi, a VPS, or even an old laptop)
- Claude Code installed on that server
- Node.js installed on that server

## The Architecture

```
Your Phone (Telegram)
    |
    v
Telegram Bot (@your_bot)
    |
    v
Your Server (Claude Code + bot script)
    |
    v
Your Workspace (files, projects, tracker)
```

You send a message on Telegram. Your bot receives it. Claude Code processes it. A reply comes back to Telegram. Your workspace files get updated.

---

## Step 1: Create Your Bot

1. Open Telegram and search for `@BotFather`
2. Send `/newbot`
3. Pick a name (what people see) -- e.g., "My Workshop Bot"
4. Pick a username (must end in `bot`) -- e.g., `my_workshop_bot`
5. BotFather gives you an API token. **Save this.** It looks like: `7123456789:AAF1234abcd5678efgh`

That is your bot. It exists now. It just does not do anything yet.

## Step 2: Set Up the Server

SSH into your server (or open terminal if it is local):

```bash
# Create a folder for your bot
mkdir ~/telegram-bot && cd ~/telegram-bot

# Initialize a Node.js project
npm init -y

# Install the Telegram bot library
npm install node-telegram-bot-api
```

## Step 3: Create the Bot Script

Create a file called `bot.js`:

```javascript
const TelegramBot = require('node-telegram-bot-api');
const { execSync, exec } = require('child_process');
const fs = require('fs');
const path = require('path');

// Configuration
const TOKEN = process.env.TELEGRAM_BOT_TOKEN;
const WORKSPACE = process.env.WORKSPACE_PATH || path.join(process.env.HOME, 'Workshop');
const ALLOWED_USERS = (process.env.ALLOWED_USERS || '').split(',').map(Number);

const bot = new TelegramBot(TOKEN, { polling: true });

// Security: only respond to allowed users
function isAllowed(msg) {
  if (ALLOWED_USERS.length === 0 || ALLOWED_USERS[0] === 0) return true;
  return ALLOWED_USERS.includes(msg.from.id);
}

// Handle text messages
bot.on('message', async (msg) => {
  if (!isAllowed(msg)) return;

  const chatId = msg.chat.id;

  // Handle voice messages
  if (msg.voice || msg.audio) {
    await bot.sendMessage(chatId, 'Voice received. Transcribing...');
    // Save to intake for processing
    const file = await bot.getFile(msg.voice?.file_id || msg.audio?.file_id);
    const filePath = path.join(WORKSPACE, 'intake', `voice_${Date.now()}.ogg`);
    // Download and save the file
    const fileUrl = `https://api.telegram.org/file/bot${TOKEN}/${file.file_path}`;
    exec(`curl -s "${fileUrl}" -o "${filePath}"`, (err) => {
      if (err) {
        bot.sendMessage(chatId, 'Failed to save voice file.');
      } else {
        bot.sendMessage(chatId, `Voice saved to intake. Will be processed next session.`);
      }
    });
    return;
  }

  // Handle photos
  if (msg.photo) {
    const photo = msg.photo[msg.photo.length - 1]; // highest resolution
    const file = await bot.getFile(photo.file_id);
    const ext = path.extname(file.file_path) || '.jpg';
    const filePath = path.join(WORKSPACE, 'intake', `photo_${Date.now()}${ext}`);
    const fileUrl = `https://api.telegram.org/file/bot${TOKEN}/${file.file_path}`;
    exec(`curl -s "${fileUrl}" -o "${filePath}"`, (err) => {
      if (err) {
        bot.sendMessage(chatId, 'Failed to save photo.');
      } else {
        const caption = msg.caption ? `\nCaption: ${msg.caption}` : '';
        bot.sendMessage(chatId, `Photo saved to intake.${caption}`);
      }
    });
    return;
  }

  // Handle text -- save to intake
  if (msg.text) {
    // Skip commands
    if (msg.text.startsWith('/')) {
      handleCommand(chatId, msg.text);
      return;
    }

    // Save text as intake file
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const filePath = path.join(WORKSPACE, 'intake', `note_${timestamp}.md`);
    fs.writeFileSync(filePath, `# Intake Note\n\n${msg.text}\n\n---\n*Received via Telegram: ${new Date().toLocaleString()}*\n`);
    bot.sendMessage(chatId, 'Captured. Will be sorted next session.');
  }
});

// Handle commands
function handleCommand(chatId, text) {
  const cmd = text.split(' ')[0].toLowerCase();

  switch (cmd) {
    case '/status':
      // Read tracker briefing
      try {
        const tracker = fs.readFileSync(path.join(WORKSPACE, 'PROJECT_TRACKER.md'), 'utf8');
        const briefing = tracker.split('## Briefing')[1]?.split('---')[0] || 'No briefing found.';
        bot.sendMessage(chatId, `Current status:\n${briefing.trim()}`);
      } catch {
        bot.sendMessage(chatId, 'Could not read tracker.');
      }
      break;

    case '/ideas':
      // Read idea inbox
      try {
        const tracker = fs.readFileSync(path.join(WORKSPACE, 'PROJECT_TRACKER.md'), 'utf8');
        const ideas = tracker.split('## Idea Inbox')[1]?.split('---')[0] || 'No ideas found.';
        bot.sendMessage(chatId, `Ideas:\n${ideas.trim()}`);
      } catch {
        bot.sendMessage(chatId, 'Could not read ideas.');
      }
      break;

    case '/help':
      bot.sendMessage(chatId, [
        'Commands:',
        '/status -- Current project status',
        '/ideas -- View idea inbox',
        '/help -- This message',
        '',
        'Or just send text, voice, or photos.',
        'Everything lands in /intake/ for your next session.'
      ].join('\n'));
      break;

    default:
      bot.sendMessage(chatId, 'Unknown command. Try /help');
  }
}

console.log('Bot is running...');
```

## Step 4: Configure and Launch

```bash
# Set your environment variables
export TELEGRAM_BOT_TOKEN="your-token-here"
export WORKSPACE_PATH="/home/youruser/Workshop"
export ALLOWED_USERS="your_telegram_user_id"
```

To find your Telegram user ID, message `@userinfobot` on Telegram.

```bash
# Test it
node bot.js
```

Send a message to your bot on Telegram. If it responds, it is working.

## Step 5: Keep It Running

Use `tmux` or `systemd` to keep the bot alive:

**Option A: tmux (simple)**
```bash
tmux new -s bot
node bot.js
# Press Ctrl+B then D to detach
# Reconnect later: tmux attach -t bot
```

**Option B: systemd (production)**

Create `/etc/systemd/system/telegram-bot.service`:
```ini
[Unit]
Description=Telegram Workshop Bot
After=network.target

[Service]
Type=simple
User=youruser
WorkingDirectory=/home/youruser/telegram-bot
ExecStart=/usr/bin/node bot.js
Restart=always
RestartSec=10
Environment=TELEGRAM_BOT_TOKEN=your-token-here
Environment=WORKSPACE_PATH=/home/youruser/Workshop
Environment=ALLOWED_USERS=your_telegram_user_id

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl enable telegram-bot
sudo systemctl start telegram-bot
```

---

## Step 6: Add Voice Transcription (Optional, Level 4)

Install Whisper for automatic voice-to-text:

```bash
# Install Whisper (requires Python)
pip install openai-whisper

# Or use faster-whisper for lower resource usage
pip install faster-whisper
```

Add transcription to your bot script after saving the voice file:

```javascript
// After saving voice file to filePath:
exec(`whisper "${filePath}" --model small --output_format txt --output_dir "${path.join(WORKSPACE, 'intake')}"`, (err) => {
  if (err) {
    bot.sendMessage(chatId, 'Voice saved but transcription failed. Will process next session.');
  } else {
    const transcript = fs.readFileSync(filePath.replace('.ogg', '.txt'), 'utf8');
    bot.sendMessage(chatId, `Transcribed: "${transcript.trim().substring(0, 200)}..."`);
  }
});
```

---

## Level Up: Two-Way AI Chat

The basic bot above is an intake system -- you send stuff in, it saves it. For a full two-way AI experience (you send a message, Claude thinks, Claude replies), you need Claude Code running as a channel:

```bash
# This runs Claude Code in headless mode, connected to Telegram
# See the Claude Code documentation for channel/headless setup
claude --channel telegram --bot-token $TELEGRAM_BOT_TOKEN
```

This is a Level 4-5 feature. Get the basic intake bot working first, then upgrade.

## Security Notes

- **Always set ALLOWED_USERS.** Without it, anyone who finds your bot can send files to your workspace.
- **Never commit your bot token to git.** Use environment variables.
- **The bot has file access to your workspace.** Treat its security like you would SSH access.
- **Telegram messages are encrypted in transit** but stored on Telegram's servers. Do not send secrets through the bot.
