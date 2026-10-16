#!/usr/bin/env bash
# ==============================================================================
# create-project.sh — Initialize & Auto-Attach Any New Project to Universal Brain
# ==============================================================================
# Ensures that EVERY project created under @iamabhishekt automatically has:
# 1. Full Karpathy 4-check execution loop (Think before coding, simplicity/YAGNI,
#    surgical changes, goal-driven verify loop).
# 2. Universal multi-agent shims (AGENTS.md, CLAUDE.md, GEMINI.md, .agents,
#    .claude, .cursor, .gemini, .trae, .codex, .kilocode, .mcp.json).
# 3. Always-on frontend design & anti-slop standards (taste-skill v2,
#    impeccable, frontend-design, anti-ui-slop, brandkit, high-end-visual-design).
# 4. Reverse-engineering & network intelligence via rea.tools / REA MCP.
# 5. Continuous registration in ~/brain/projects/ and one-view task board tracking.
# ==============================================================================

set -euo pipefail

BRAIN_DIR="$HOME/brain"

if [ ! -d "$BRAIN_DIR" ]; then
  echo "Error: Universal Brain not found at $BRAIN_DIR"
  exit 1
fi

PROJECT_TARGET="${1:-.}"

if [ "$PROJECT_TARGET" = "." ]; then
  TARGET_DIR="$(pwd)"
  PROJECT_NAME="$(basename "$TARGET_DIR")"
else
  if [ -d "$PROJECT_TARGET" ]; then
    TARGET_DIR="$(cd "$PROJECT_TARGET" && pwd)"
    PROJECT_NAME="$(basename "$TARGET_DIR")"
  else
    mkdir -p "$PROJECT_TARGET"
    TARGET_DIR="$(cd "$PROJECT_TARGET" && pwd)"
    PROJECT_NAME="$(basename "$TARGET_DIR")"
  fi
fi

echo "========================================================"
echo " Initializing & Attaching Project for @iamabhishekt"
echo " Project Name: $PROJECT_NAME"
echo " Location:     $TARGET_DIR"
echo " Brain:        $BRAIN_DIR"
echo "========================================================"

cd "$TARGET_DIR"

# 1. Initialize Git if not initialized
if [ ! -d ".git" ]; then
  echo "  ✓ Initializing git repository..."
  git init
fi

# Configure iamabhishekt identity for this repository if not already set
LOCAL_GIT_USER="$(git config --local user.name 2>/dev/null || echo "")"
if [ -z "$LOCAL_GIT_USER" ]; then
  git config user.name "iamabhishekt"
  git config user.email "abhishek@limosys.com"
  echo "  ✓ Configured git user: iamabhishekt <abhishek@limosys.com>"
fi

# 2. Run attach-project.sh to link all universal agent shims
bash "$BRAIN_DIR/scripts/attach-project.sh" "$TARGET_DIR"

# 3. Verify .gitignore has brain and local scratch files
if [ -f ".gitignore" ]; then
  for IGNORE_PATTERN in "brain" ".claude.bak" ".env.local" "*.sqlite-shm" "*.sqlite-wal"; do
    if ! grep -q "^${IGNORE_PATTERN}$" .gitignore 2>/dev/null; then
      echo "$IGNORE_PATTERN" >> .gitignore
    fi
  done
else
  cat > .gitignore <<EOF
# Universal Brain link
brain
.claude.bak
.env.local
node_modules
target
dist
*.sqlite-shm
*.sqlite-wal
EOF
fi

# 4. Ensure hooks point to universal git hooks
git config core.hooksPath "$HOME/.config/git/hooks"

echo "========================================================"
echo " ✓ Project $PROJECT_NAME is fully configured!"
echo "   - Karpathy Loop & 4-Check Gate: Active"
echo "   - Frontend Anti-Slop (Taste, Impeccable, Brandkit): Active"
echo "   - REA Reverse-Engineering & MCP Tools: Ready"
echo "   - Multi-Agent Support: Claude, Antigravity, Cursor, Codex, Trae"
echo "========================================================"
