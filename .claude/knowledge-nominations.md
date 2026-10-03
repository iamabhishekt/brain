# Knowledge Nominations

Candidate learnings awaiting auditor review and promotion to `knowledge-base.md`.

Any agent can append nominations here during any task.
Format: `- [CATEGORY] [MMDDYY]: {pattern description} — Observed: {evidence}. Impact: {what it affects}.`

The auditor reviews these during each `/audit` cycle and promotes confirmed patterns to the knowledge base.
A pattern must be confirmed across 2+ instances before nomination, and verified by the auditor before promotion.

---

## Pending Nominations
<!-- Add candidate nominations below -->

- [100326] /wrap-up: Kilo Code discovers commands from `~/.kilo/command/` (singular, not `commands/`), while Claude Code/Cursor/OpenCode use `commands/` (plural) and Trae uses `workflows/`. Each agent has a different directory name for the same concept — wire all of them explicitly rather than assuming one layout. | Evidence: `/start` and `/wrap-up` were missing in Kilo despite existing in `brain/.claude/commands/`; adding `~/.kilo/command` → brain symlink fixed it. Impact: commands must be wired per-agent or they silently don't load.
- [100326] /wrap-up: When a symlinked skills dir (`~/.claude/skills` → brain) coexists with a real skills dir, relative symlinks inside it resolve against the symlink's target, not its physical location — use absolute paths or count `../` levels from the final resolved location. | Evidence: arkcli skills broke when `~/.claude/skills` became a symlink to `brain/.claude/skills`; `../skills.claude-native/agent-reach` resolved to `brain/.claude/skills.claude-native/` which doesn't exist. Fixed with `../../../.claude/skills.claude-native/`. Impact: one wrong relative level = broken skill.
- [100326] /wrap-up: GitHub forks with no `parent` or `source` are orphaned (template-based or private upstream gone) — they have nothing to sync and no local commits to preserve. Check `parent.fullName` and `source.fullName` before attempting a fork update. | Evidence: all 75 iamabhishekt forks returned null for both fields; `gh search topic:` returns global results, not just the user's repos, so verify via the REST API instead. Impact: avoid wasted sync attempts and false search results.
- [100326] /wrap-up: Apify Actor `khadinakbar/x-user-tweets-scraper` returns `tweet_id`/`text`/`created_at`/`like_count`, not the `id`/`postedAt`/`likesCount` fields a generic scraper docs suggest — always inspect the actual returned schema before writing a parser. | Evidence: first fetch returned 5 tweets with the unexpected schema; normalizing on save fixed it. Impact: wasted a fetch cycle before normalizing.
- [100326] /wrap-up: Beej's Guide moved — the old `/lang/c/` path 404s; current URL is `https://beej.us/guide/bgc/`. | Evidence: `curl` returned 404 for `beej.us/lang/c/`, 200 for `beej.us/guide/bgc/`. Impact: avoid dead links when onboarding to C.
