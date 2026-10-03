# Project: vibe-wise

- **Remote URL:** https://github.com/nykooi1/vibe-wise.git
- **Local Path:** /Users/abhishek/abhishek-projects/vibe-wise
- **Tech Stack:** Python 3 (hooks + tests), Claude Code plugin (skills, Markdown instructions, hooks)
- **Last Active Branch:** main
- **Last Commit:** 1135f4a — "cut dev stuff from md"
- **Last Push Timestamp:** 2026-10-01 04:26:12 -0700
- **Status:** Active

## Overview
Auto-tracked project informed by git-push trigger.

**What it is:** VibeWise — a Claude Code plugin that puts learning first and keeps you in control while AI writes the code you designed. Claude asks for your approach first, helps you examine tradeoffs, and explains unfamiliar concepts. You shape the design and decide when it's ready to implement.

**Author:** Noah Kim (nykooi1). MIT license. Approved for Anthropic's Claude directory; installable via the `nykooi1/vibe-wise` GitHub marketplace.

**Key components:**
- `skills/learn/` — onboarding + behavior guides for reasoning-first learning
- `skills/reset/` — confirmed learning reset helper (`reset.py`)
- `hooks/session_start.py` — read-only Python SessionStart hook restoring learning context
- `tests/` — 37+ unittest tests covering activation, restoration, reset, rename coverage, symlink rejection