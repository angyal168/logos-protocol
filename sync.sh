#!/bin/bash
# sync.sh -- Sync local skills/commands to the logos-protocol GitHub repo
#
# Run from anywhere:
#   bash ~/workspace/github/logos-protocol/sync.sh
#
# What it does:
#   1. Copies skills from .claude/skills/ to the repo
#   2. Copies commands from .claude/commands/ to the repo
#   3. Commits and pushes if anything changed

REPO_DIR="${LOGOS_REPO_DIR:-$HOME/workspace/github/logos-protocol}"
SKILLS_SRC="${LOGOS_SKILLS_SRC:-$HOME/workspace/.claude/skills}"
COMMANDS_SRC="${LOGOS_COMMANDS_SRC:-$HOME/workspace/.claude/commands}"

# Skills to sync (add new ones here)
SKILLS=(
  brainstorming
  dispatching-parallel-agents
  docx
  executing-plans
  finishing-a-development-branch
  pdf
  pptx
  receiving-code-review
  requesting-code-review
  subagent-driven-development
  systematic-debugging
  test-driven-development
  using-git-worktrees
  using-superpowers
  verification-before-completion
  webapp-testing
  writing-plans
  writing-skills
  xlsx
)

# Commands to sync (add new ones here)
COMMANDS=(
  rally.md
  council.md
  smelt.md
  serious.md
  ralph.md
  dar.md
  forge-prompt.md
)

echo "=== Logos Protocol Sync ==="
echo ""

# Sync skills
echo "Syncing skills..."
for skill in "${SKILLS[@]}"; do
  if [ -d "$SKILLS_SRC/$skill" ]; then
    cp -r "$SKILLS_SRC/$skill" "$REPO_DIR/skills/"
    echo "  [ok] $skill"
  else
    echo "  [skip] $skill (not found locally)"
  fi
done

# Sync commands
echo ""
echo "Syncing commands..."
for cmd in "${COMMANDS[@]}"; do
  if [ -f "$COMMANDS_SRC/$cmd" ]; then
    cp "$COMMANDS_SRC/$cmd" "$REPO_DIR/commands/$cmd"
    echo "  [ok] $cmd"
  else
    echo "  [skip] $cmd (not found locally)"
  fi
done

# Check for changes
echo ""
cd "$REPO_DIR"
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  echo "No changes detected. Already in sync."
  exit 0
fi

# Show what changed
echo "Changes detected:"
git status --short
echo ""

# Commit and push
TIMESTAMP=$(date +"%Y-%m-%d %H:%M")
git add -A
git commit -m "sync: update skills and commands ($TIMESTAMP)

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>"

echo ""
echo "Pushing to GitHub..."
git push

echo ""
echo "=== Sync complete ==="
