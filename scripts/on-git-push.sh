#!/usr/bin/env bash
# ==============================================================================
# on-git-push.sh — Auto-Informs Universal Brain on any Git Push
# ==============================================================================
# Invoked by Git pre-push hook whenever code is pushed.
# Filters for iamabhishekt repositories and automatically registers/updates
# project tracking in ~/brain/projects/<project-name>/
# ==============================================================================

set -uo pipefail

BRAIN_DIR="$HOME/brain"

# 1. Safety & validation
if [ ! -d "$BRAIN_DIR" ]; then
  exit 0
fi

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
PROJECT_NAME="$(basename "$REPO_ROOT")"

# Don't track brain inside brain
if [ "$PROJECT_NAME" = "brain" ] || [ "$REPO_ROOT" = "$BRAIN_DIR" ]; then
  exit 0
fi

# 2. Check if this repository belongs to iamabhishekt
REMOTE_NAME="${1:-origin}"
REMOTE_URL="${2:-$(git remote get-url "$REMOTE_NAME" 2>/dev/null || echo "")}"
GIT_USER="$(git config user.name 2>/dev/null || echo "")"
GIT_EMAIL="$(git config user.email 2>/dev/null || echo "")"

IS_IAMABHISHEKT=false
if [[ "$REMOTE_URL" =~ "iamabhishekt" ]] || \
   [ "$GIT_USER" = "iamabhishekt" ] || \
   [ "$GIT_EMAIL" = "abhishekthakur.art@protonmail.com" ]; then
  IS_IAMABHISHEKT=true
fi

# If this repo is not owned by iamabhishekt (e.g. a work repo on another account), exit immediately
if [ "$IS_IAMABHISHEKT" = "false" ]; then
  exit 0
fi

# 3. Detect Project Details
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")"
LATEST_COMMIT_HASH="$(git rev-parse --short HEAD 2>/dev/null || echo "")"
LATEST_COMMIT_MSG="$(git log -1 --pretty=%B 2>/dev/null | head -n 1 || echo "")"
TIMESTAMP="$(date +"%Y-%m-%d %H:%M:%S")"

detect_stack() {
  local STACK=()
  if [ -f "$REPO_ROOT/package.json" ] || [ -f "$REPO_ROOT/*/package.json" ]; then
    STACK+=("Node/JavaScript")
    if grep -rq "react" "$REPO_ROOT" --include="package.json" 2>/dev/null; then STACK+=("React"); fi
    if grep -rq "next" "$REPO_ROOT" --include="package.json" 2>/dev/null; then STACK+=("Next.js"); fi
    if grep -rq "vite" "$REPO_ROOT" --include="package.json" 2>/dev/null; then STACK+=("Vite"); fi
    if grep -rq "typescript" "$REPO_ROOT" --include="package.json" 2>/dev/null; then STACK+=("TypeScript"); fi
    if grep -rq "tailwindcss" "$REPO_ROOT" --include="package.json" 2>/dev/null; then STACK+=("Tailwind CSS"); fi
  fi
  if [ -f "$REPO_ROOT/Cargo.toml" ]; then STACK+=("Rust"); fi
  if [ -f "$REPO_ROOT/go.mod" ]; then STACK+=("Go"); fi
  if [ -f "$REPO_ROOT/requirements.txt" ] || [ -f "$REPO_ROOT/pyproject.toml" ]; then STACK+=("Python"); fi
  if [ -f "$REPO_ROOT/pom.xml" ] || [ -f "$REPO_ROOT/build.gradle" ]; then STACK+=("Java"); fi
  if [ -f "$REPO_ROOT/composer.json" ]; then STACK+=("PHP"); fi

  if [ ${#STACK[@]} -eq 0 ]; then
    echo "General / Codebase"
  else
    # Deduplicate and join with comma
    printf '%s, ' "${STACK[@]}" | sed 's/, $//'
  fi
}

TECH_STACK="$(detect_stack)"
PROJECT_DIR="$BRAIN_DIR/projects/$PROJECT_NAME"

# 4. Ensure project is attached to Universal Brain shims
if [ ! -L "$REPO_ROOT/brain" ] || [ ! -L "$REPO_ROOT/AGENTS.md" ] || [ ! -L "$REPO_ROOT/.agents" ]; then
  bash "$BRAIN_DIR/scripts/attach-project.sh" "$REPO_ROOT" >/dev/null 2>&1 || true
fi

# 5. Register or Update in Brain
IS_NEW_PROJECT=false
if [ ! -d "$PROJECT_DIR" ]; then
  IS_NEW_PROJECT=true
  mkdir -p "$PROJECT_DIR"
fi

# Update/Create PROJECT.md
cat > "$PROJECT_DIR/PROJECT.md" <<EOF
# Project: $PROJECT_NAME

- **Remote URL:** ${REMOTE_URL:-"Local"}
- **Local Path:** $REPO_ROOT
- **Tech Stack:** $TECH_STACK
- **Last Active Branch:** $CURRENT_BRANCH
- **Last Commit:** $LATEST_COMMIT_HASH — "$LATEST_COMMIT_MSG"
- **Last Push Timestamp:** $TIMESTAMP
- **Status:** Active

## Overview
Auto-tracked project informed by git-push trigger.
EOF

# Initialize task-board.md and memory.md if new
if [ ! -f "$PROJECT_DIR/task-board.md" ]; then
  cat > "$PROJECT_DIR/task-board.md" <<EOF
# Task Board: $PROJECT_NAME

## Today
- [x] Initialized project and repository
- [ ] Next feature milestone

## In Progress
<!-- Active tasks -->

## Done
- [x] Auto-registered project in Universal Brain
EOF
fi

if [ ! -f "$PROJECT_DIR/memory.md" ]; then
  cat > "$PROJECT_DIR/memory.md" <<EOF
# Memory: $PROJECT_NAME

## Now
- Active development on branch \`$CURRENT_BRANCH\`.
- Last commit: \`$LATEST_COMMIT_HASH\` ("$LATEST_COMMIT_MSG").

## Project
- **Name:** $PROJECT_NAME
- **Path:** $REPO_ROOT
- **Stack:** $TECH_STACK
EOF
fi

if [ ! -f "$PROJECT_DIR/CURRENT_STATE.local.md" ]; then
  cat > "$PROJECT_DIR/CURRENT_STATE.local.md" <<EOF
# Current Local State: $PROJECT_NAME

## Machines
- Linux ($REPO_ROOT)

## Focus
- Pushed commit \`$LATEST_COMMIT_HASH\` on branch \`$CURRENT_BRANCH\`.
EOF
fi

# Update projects/README.md table if new
if [ "$IS_NEW_PROJECT" = "true" ]; then
  if grep -q "## Registered Projects" "$BRAIN_DIR/projects/README.md" 2>/dev/null; then
    echo "| [\`$PROJECT_NAME\`](file://$REPO_ROOT) | \`$REPO_ROOT\` | Auto-tracked repository | $TECH_STACK | Active |" >> "$BRAIN_DIR/projects/README.md"
  fi
  echo "🧠 [Universal Brain] Registered new project: $PROJECT_NAME ($TECH_STACK)"
else
  echo "🧠 [Universal Brain] Updated project state: $PROJECT_NAME ($LATEST_COMMIT_HASH)"
fi

# 5. Background sync Brain to GitHub (non-blocking)
(
  cd "$BRAIN_DIR"
  git add "projects/$PROJECT_NAME" "projects/README.md" >/dev/null 2>&1 || true
  if ! git diff --cached --quiet 2>/dev/null; then
    git commit -m "sync(projects): update $PROJECT_NAME state from git-push [$TIMESTAMP]" >/dev/null 2>&1 || true
    git push origin main >/dev/null 2>&1 || true
  fi
) &

# 6. Regenerate the one-view task index across all projects
bash "${BRAIN_DIR}/scripts/master-index.sh" "${BRAIN_DIR}/projects/TASK-INDEX.md" >/dev/null 2>&1 || true

exit 0
