#!/usr/bin/env bash
# ==============================================================================
# setup-new-pc.sh — Multi-Machine Provisioner for Central Brain & Claude Code
# ==============================================================================
# Run this script whenever setting up a new PC or secondary workstation:
#   git clone https://github.com/iamabhishekt/brain.git ~/brain
#   cd ~/brain && bash scripts/setup-new-pc.sh
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRAIN_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "========================================================"
echo " 🧠 Setting up Universal Brain on New PC"
echo " Brain Directory: ${BRAIN_DIR}"
echo "========================================================"

# 1. Check prerequisites
echo ""
echo "[1/4] Checking tools & authentication..."
check_tool() {
  if command -v "$1" >/dev/null 2>&1; then
    echo "  ✓ $1 is installed"
  else
    echo "  ⚠ $1 is NOT installed. ($2)"
  fi
}

check_tool "git" "Required for version control"
check_tool "gh" "GitHub CLI (sudo apt install gh / brew install gh)"
check_tool "node" "Node.js (https://nodejs.org)"
check_tool "pnpm" "pnpm package manager (npm install -g pnpm)"
check_tool "claude" "Claude Code CLI (curl -fsSL https://claude.ai/install.sh | bash)"

# Check GitHub authentication
if command -v gh >/dev/null 2>&1; then
  echo ""
  echo "Checking GitHub authentication status:"
  gh auth status || echo "  ⚠ Run 'gh auth login' to authenticate with GitHub."
fi

# 2. Configure Global Git Push Hook & Hooks Directory
echo ""
echo "[2/4] Setting up global Git hook trigger..."
HOOKS_DIR="$HOME/.config/git/hooks"
mkdir -p "$HOOKS_DIR"

chmod +x "${BRAIN_DIR}/scripts/on-git-push.sh"
chmod +x "${BRAIN_DIR}/scripts/sync-brain.sh"
chmod +x "${BRAIN_DIR}/scripts/"*.sh 2>/dev/null || true

ln -sf "${BRAIN_DIR}/scripts/on-git-push.sh" "${HOOKS_DIR}/pre-push"
git config --global core.hooksPath "${HOOKS_DIR}"
echo "  ✓ Global pre-push hook linked to: ${HOOKS_DIR}/pre-push"
echo "  ✓ core.hooksPath set to: ${HOOKS_DIR}"

# 3. Configure Global Claude Code Symlinks
echo ""
echo "[3/4] Linking global Claude Code commands & memory..."
CLAUDE_HOME="$HOME/.claude"
mkdir -p "$CLAUDE_HOME"

ln -sfn "${BRAIN_DIR}/.claude/commands" "${CLAUDE_HOME}/commands"
ln -sfn "${BRAIN_DIR}/.claude/agents" "${CLAUDE_HOME}/agents"
ln -sfn "${BRAIN_DIR}/CLAUDE.md" "${CLAUDE_HOME}/CLAUDE.md"

echo "  ✓ ~/.claude/commands -> ${BRAIN_DIR}/.claude/commands"
echo "  ✓ ~/.claude/agents   -> ${BRAIN_DIR}/.claude/agents"
echo "  ✓ ~/.claude/CLAUDE.md -> ${BRAIN_DIR}/CLAUDE.md"

# 4. Pull Latest Brain State
echo ""
echo "[4/4] Syncing latest brain state from GitHub..."
git -C "${BRAIN_DIR}" pull --rebase origin main || true
echo "  ✓ Brain is up to date."

echo ""
echo "========================================================"
echo " 🎉 New PC Setup Complete!"
echo "========================================================"
echo " Next Steps:"
echo " 1. Clone your project:"
echo "    git clone https://github.com/iamabhishekt/ecommerce-website.git"
echo "    cd ecommerce-website"
echo ""
echo " 2. Install dependencies & run:"
echo "    pnpm install"
echo "    pnpm dev"
echo ""
echo " 3. Launch Claude Code in your project:"
echo "    claude"
echo "    Type /start to load daily notes and task board from ~/brain"
echo "    Type /wrap-up at the end of the day to sync back to GitHub"
echo "========================================================"
