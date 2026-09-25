#!/usr/bin/env bash
# ==============================================================================
# attach-project.sh — Attach Any Project to the Universal Central Brain
# ==============================================================================
# Usage:
#   cd /path/to/my-project
#   bash ~/brain/scripts/attach-project.sh
# ==============================================================================

set -euo pipefail

BRAIN_DIR="$HOME/brain"
TARGET_DIR="${1:-$(pwd)}"
PROJECT_NAME="$(basename "$TARGET_DIR")"

if [ ! -d "$BRAIN_DIR" ]; then
  echo "Error: Universal Brain not found at $BRAIN_DIR"
  exit 1
fi

echo "========================================================"
echo " Attaching project to Universal Brain"
echo " Project: $PROJECT_NAME"
echo " Location: $TARGET_DIR"
echo " Brain:    $BRAIN_DIR"
echo "========================================================"

cd "$TARGET_DIR"

# 1. Symlink Brain directories & tool shims
link_shim() {
  local SRC="$1"
  local DEST="$2"

  if [ -L "$DEST" ]; then
    rm "$DEST"
  elif [ -d "$DEST" ] || [ -f "$DEST" ]; then
    echo "  [Notice] Backing up existing $DEST to ${DEST}.bak"
    mv "$DEST" "${DEST}.bak"
  fi

  ln -s "$SRC" "$DEST"
  echo "  ✓ Linked $DEST -> $SRC"
}

# Core agent shims
link_shim "$BRAIN_DIR" "brain"
link_shim "$BRAIN_DIR/.claude" ".claude"
link_shim "$BRAIN_DIR/.agents" ".agents"
link_shim "$BRAIN_DIR/.gemini" ".gemini"
link_shim "$BRAIN_DIR/.cursor" ".cursor"
link_shim "$BRAIN_DIR/.trae" ".trae"
link_shim "$BRAIN_DIR/.codex" ".codex"
link_shim "$BRAIN_DIR/.kilocode" ".kilocode"
link_shim "$BRAIN_DIR/.dsh" ".dsh"
link_shim "$BRAIN_DIR/.codebuddy" ".codebuddy"
link_shim "$BRAIN_DIR/.opencode" ".opencode"
link_shim "$BRAIN_DIR/.qwen" ".qwen"
link_shim "$BRAIN_DIR/.mcp.json" ".mcp.json"
link_shim "$BRAIN_DIR/tool-config/skills-lock.json" "skills-lock.json"

# Core instructions (if not present)
if [ ! -f "AGENTS.md" ]; then
  link_shim "$BRAIN_DIR/AGENTS.md" "AGENTS.md"
fi

if [ ! -f "CLAUDE.md" ]; then
  link_shim "$BRAIN_DIR/CLAUDE.md" "CLAUDE.md"
fi

if [ ! -f "GEMINI.md" ]; then
  link_shim "$BRAIN_DIR/GEMINI.md" "GEMINI.md"
fi

# 2. Register project in ~/brain/projects/
PROJECT_REGISTRY="$BRAIN_DIR/projects/$PROJECT_NAME"
mkdir -p "$PROJECT_REGISTRY"

if [ ! -f "$PROJECT_REGISTRY/PROJECT.md" ]; then
  cat > "$PROJECT_REGISTRY/PROJECT.md" <<EOF
# Project: $PROJECT_NAME

- **Attached:** $(date +"%Y-%m-%d %H:%M:%S")
- **Path:** $TARGET_DIR
- **Status:** Active

## Description
Registered project attached to Universal Central Brain.
EOF
  echo "  ✓ Registered in $PROJECT_REGISTRY/PROJECT.md"
fi

# 3. Ensure brain is ignored in project gitignore
if [ -f ".gitignore" ]; then
  if ! grep -q "^brain$" .gitignore && ! grep -q "^brain/" .gitignore; then
    echo -e "\n# Universal Brain link\nbrain\n" >> .gitignore
    echo "  ✓ Added brain to .gitignore"
  fi
fi

echo "========================================================"
echo " ✓ Project $PROJECT_NAME attached successfully!"
echo " Universal skills, agents, commands, and memory available."
echo "========================================================"
