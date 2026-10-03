# Memory

## Now
- Brain is multi-project: 25 owned repos tracked in `brain/projects/`, master index at `brain/projects/TASK-INDEX.md`. 75 forks removed from registry (tagged on GitHub, not tracked locally).
- Global pre-push hook wired (`~/.config/git/hooks/pre-push` → `brain/scripts/on-git-push.sh`); any iamabhishekt repo push auto-updates its brain entry.
- Skills: 165 in `brain/.claude/skills/` (canonical) + 32 arkcli native = 197 reachable across all agents. Default-on trimmed to 9 lightweight skills (~25 KB); rest opt-in.
- Discovery shims wired for Claude Code, Cursor, OpenCode, Kilo Code, Trae, Gemini, Codex, CodeBuddy, Qwen, DSH — `/start` and `/wrap-up` work in all of them.
- Karpathy X feed live at `brain/documentation/karpathy-x-feed.jsonl` (100 tweets), refreshed via `brain/scripts/fetch-karpathy.sh` (Apify token in macOS keychain).
- Apify token stored in keychain (service `apify`, account `apify`).
- GitHub: all 100 repos tagged with 14 topic categories for filtering.

## Project
- **vibe-wise** (https://github.com/nykooi1/vibe-wise.git) — Claude Code learning plugin by Noah Kim. Added to brain with full PROJECT.md/task-board/memory/scratchpad.
- **ecommerce-website** (Sattvora Enterprises) — React 19 / Vite / Tailwind v4 storefront. Frontend in `sattvora-frontend/`. Backend + payment integration still open.
- **C/Redis learning** — demo built at `/tmp/c-redis-demo/mini-redis.c`: 75-line C client talking real RESP to local Redis. Working: SET/GET verified.

## Working Style
- Edit mode: agent writes code upon request.
- Phased execution: max 5 files per phase.
- Code quality: clean code, proper typing, test verification.
- Learning-by-default ON; say "pause learning" to suspend.

## Recent Decisions
- [100326] Default-on skills reduced from 26 (~83 KB) to 9 (~25 KB); rest opt-in.
- [100326] README rewritten single → multi-project; manifest at `brain/tool-config/default-skills.md`.
- [100326] Karpathy methodology (15 skills) installed; X feed scraped via `khadinakbar/x-user-tweets-scraper`.
- [100326] All 100 GitHub repos tagged with 14 categories; 75 forks purged from brain registry.
- [100326] Discovery shims wired for all 10 agents — `/start` and `/wrap-up` now resolve everywhere.

## Open Threads
- C/Redis: extend mini-redis with nil-reply handling and a TDD test loop (load `tdd`).
- Refresh Karpathy feed: `bash ~/brain/scripts/fetch-karpathy.sh 200`.
- ecommerce-website backend / payment gateway integration.
- Verify discovery shims survive tool updates.