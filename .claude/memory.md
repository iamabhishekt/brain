# Memory

## Now
- Brain is multi-project: 100 projects tracked in `brain/projects/`, master index at `brain/projects/TASK-INDEX.md`.
- Global pre-push hook wired (`~/.config/git/hooks/pre-push` → `brain/scripts/on-git-push.sh`); any iamabhishekt repo push auto-updates its brain entry.
- Skills: 165 installed in `brain/.claude/skills/` (canonical), symlinked into `.agents`, `.kilocode`.
- Default-on set trimmed to 9 lightweight skills (~25 KB); everything else opt-in.
- Karpathy X feed live at `brain/documentation/karpathy-x-feed.jsonl` (100 tweets), refreshed via `brain/scripts/fetch-karpathy.sh` (Apify token in macOS keychain).
- Apify token stored in keychain (service `apify`, account `apify`).

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
- [100326] Default-on skills reduced from 26 (~83 KB) to 9 (~25 KB) to cut per-message context cost; rest moved to opt-in.
- [100326] README rewritten from single-project to multi-project; default-on skills manifest at `brain/tool-config/default-skills.md`.
- [100326] Karpathy methodology (15 skills) installed from learnprompt/andrej-karpathy-skills; X feed scraped via Apify Actor `khadinakbar/x-user-tweets-scraper`.
- [100326] AAS installed as curated learning subset (10 skills), not the full 2,536-catalog.

## Open Threads
- C/Redis: extend mini-redis with nil-reply handling and a TDD test loop (load `tdd`).
- Refresh Karpathy feed: `bash ~/brain/scripts/fetch-karpathy.sh 200`.
- ecommerce-website backend / payment gateway integration.