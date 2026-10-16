#!/usr/bin/env bash
# ==============================================================================
# on-git-commit.sh — Auto-Enforce Universal Brain & Skills on Git Commit
# ==============================================================================
# Invoked by Git post-commit hook.
# Whenever a commit occurs in an @iamabhishekt repository:
# 1. Checks if Universal Brain shims (brain, AGENTS.md, .agents, .claude, etc.) are present.
# 2. If missing, automatically runs attach-project.sh to link them.
# 3. Ensures multi-agent skills (Karpathy loop, Taste, Impeccable, REA) are ready.
# ==============================================================================

set -uo pipefail

BRAIN_DIR="$HOME/brain"

if [ ! -d "$BRAIN_DIR" ]; then
  exit 0
fi

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
PROJECT_NAME="$(basename "$REPO_ROOT")"

# Don't track brain inside brain
if [ "$PROJECT_NAME" = "brain" ] || [ "$REPO_ROOT" = "$BRAIN_DIR" ]; then
  exit 0
fi

# Verify if this repository belongs to iamabhishekt
REMOTE_URL="$(git remote get-url origin 2>/dev/null || echo "")"
GIT_USER="$(git config user.name 2>/dev/null || echo "")"
GIT_EMAIL="$(git config user.email 2>/dev/null || echo "")"

IS_IAMABHISHEKT=false
if [[ "$REMOTE_URL" =~ "iamabhishekt" ]] || \
   [ "$GIT_USER" = "iamabhishekt" ] || \
   [ "$GIT_EMAIL" = "abhishek@limosys.com" ] || \
   [ "$GIT_EMAIL" = "abhishekthakur.art@protonmail.com" ]; then
  IS_IAMABHISHEKT=true
fi

if [ "$IS_IAMABHISHEKT" = "false" ]; then
  exit 0
fi

# If shims are missing, auto-attach project
if [ ! -L "$REPO_ROOT/brain" ] || [ ! -L "$REPO_ROOT/AGENTS.md" ] || [ ! -L "$REPO_ROOT/.agents" ]; then
  bash "$BRAIN_DIR/scripts/attach-project.sh" "$REPO_ROOT" >/dev/null 2>&1 || true
fi

exit 0
