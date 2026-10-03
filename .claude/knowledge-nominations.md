# Knowledge Nominations

Candidate learnings awaiting auditor review and promotion to `knowledge-base.md`.

Any agent can append nominations here during any task.
Format: `- [CATEGORY] [MMDDYY]: {pattern description} — Observed: {evidence}. Impact: {what it affects}.`

The auditor reviews these during each `/audit` cycle and promotes confirmed patterns to the knowledge base.
A pattern must be confirmed across 2+ instances before nomination, and verified by the auditor before promotion.

---

## Pending Nominations
<!-- Add candidate nominations below -->

- [100326] /wrap-up: Skills load at session start, so every default-on skill costs context on every message — trim the default-on set to the highest-value, lightweight skills and make the rest opt-in. | Evidence: 26 default-on skills measured ~83 KB of SKILL.md; heavy ones like `aas-tutorial-engineer` (16 KB) and `aas-learning-career-development` (15 KB) were pure overhead for routine work. Reduced to 9 skills (~25 KB). Impact: lower per-message context, faster sessions.
- [100326] /wrap-up: Apify Actor response schemas vary by Actor — always inspect the actual returned fields before writing a parser, and normalize on save. | Evidence: `khadinakbar/x-user-tweets-scraper` returns `tweet_id`/`text`/`created_at`/`like_count`, not the `id`/`postedAt`/`likesCount` fields the script initially assumed. Impact: wasted a fetch cycle before normalizing.
- [100326] /wrap-up: Store third-party API tokens in the macOS keychain (service + account), never in env or files — scripts read from keychain with env override. | Evidence: Apify token stored via `security add-generic-password -s apify -a apify -w ...`; `fetch-karpathy.sh` falls back to keychain if `APIFY_TOKEN` unset. Impact: token available across sessions without being committed or leaked.
- [100326] /wrap-up: Beej's Guide moved — the old `/lang/c/` path 404s; current URL is `https://beej.us/guide/bgc/`. | Evidence: `curl` returned 404 for `beej.us/lang/c/`, 200 for `beej.us/guide/bgc/`. Impact: avoid dead links when onboarding to C.
