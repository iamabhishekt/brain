# Provenance — vendored skill

## Upstream

| | |
|---|---|
| Skill | `make-it-click` |
| Repository | https://github.com/ajithraghavan/make-it-click |
| Commit | `634cc638779c9c9d47d7b448a33cbe2b73660afd` |
| Commit date | 2026-10-05 |
| License | MIT — Copyright (c) 2026 ajithraghavan (see `LICENSE`) |
| Retrieved | 2026-10-13 |
| Upstream state | 1 commit, 4 stars, ~1 week old. Young. Drift is managed — see below. |

Installed unmodified. Only `LICENSE` was added alongside the upstream folder.

## Idea credit

The format ladder comes from Andrej Karpathy's public notes:

- X post — https://x.com/karpathy/status/2105819303471976479

Upstream states it is **not affiliated with or endorsed by** Karpathy. That notice is preserved here.

`ASD-STE100` (Simplified Technical English) is a specification maintained by ASD Europe. This skill
contains no part of the specification or its approved-word dictionary. The rule summary in
`references/ste-writing.md` was written independently by the upstream author and is **not
authoritative**. Official text: https://www.asd-ste100.org

## Why it is vendored here

Karpathy's argument: models now do more of the work, so people spend more of their time checking
and understanding that work. The format of an answer is therefore a choice, not a default.

The ladder, lowest step that does the job:

| Step | Format | Reference |
|---|---|---|
| 1 | Controlled writing, STE style — strict / 80% / light | `references/ste-writing.md` |
| 2 | Diagram | `references/diagrams.md` |
| 3 | Interactive HTML page | `references/html-explainers.md` |
| 4 | Narrated explainer video, 3b1b style | `references/explainer-videos.md` |

Plus an **oversight mode** for reviewing agent work: what changed → why → risk → what the human
must check.

## Drift management

The upstream is young, so it will move. That risk is pinned and checked, not left to memory.

| File | Role |
|---|---|
| `vendor.json` | Machine-readable pin: repo, `pinned.commit`, per-file sha256 prefixes, known defects |
| `brain/scripts/check-vendored-skills.sh` | Drift report. Verifies local hashes, compares against the upstream HEAD commit, prints known defects |

```bash
bash brain/scripts/check-vendored-skills.sh          # human report
bash brain/scripts/check-vendored-skills.sh --quiet  # exit code only, for a hook
```

Exit codes: `0` clean, `1` drift, `2` bad environment.

**The script never applies an update.** No pull, no write. Upstream drift prints
`MOVED -> <sha>` and stops. Read the upstream diff, then update `pinned.commit` and `files.*`
in `vendor.json` by hand. An automated update path is the one thing deliberately missing — a
skill that silently rewrites the rules an agent follows is worse than one that is stale.

Offline, rate-limited, or renamed upstream prints `unreachable` and is **not** counted as drift,
so the script stays usable on a plane.

Note: `vendor.json` and `PROVENANCE.md` are the only files not in the hash manifest. The script
recognises them, so local notes do not read as tampering.

### Why not `brain/tool-config/skills-lock.json`

That file is the **mattpocock/skills installer lock**, not a general workspace lockfile —
`MIGRATION_MANIFEST.md` records it as tracking that installer's 40 dirs under `.agents/skills/`.
Adding this skill there would make a third-party installer believe it owns it, and a re-run could
delete or mis-manage the vendored copy. Pin belongs with the vendor.

## Local decisions

- **Placement:** `brain/.opencode/skills/` only. `brain/` is the synced cross-agent repo
  (`abhisheklimosys/jlimo-brain`, pushed by `brain/scripts/sync-brain.sh`). No copy was made into
  the other eight adapter folders, per `AGENTS.md`: "Update canonical owner. Do not copy same rule
  or state into multiple adapters."
- **STE is opt-in.** The default modes in `AGENTS.md` — including caveman full — stay unchanged.
  Caveman full already strips articles and filler, so it overlaps STE controlled writing. Use this
  skill when the user asks for a format or when output is large enough that prose is the wrong
  shape. Do not apply it by default.
- Requires `python3` for `scripts/ste_check.py`. Present on this machine (3.14.7). Optional — the
  skill works without it.

## Linter — verified, with one known gap

`scripts/ste_check.py` is a heuristic helper, not a compliance tool. Verified 2026-10-13 on this
install. It correctly flags:

- sentences over the limit (20 procedural / 25 descriptive)
- paragraphs over 6 sentences
- `-ing` forms outside technical names
- passive voice (`\b(is|are|was|were|be|been|being)\s+(\w+ed|\w+en)\b`)
- perfect tenses
- 16 unapproved-word substitutions

**Known gap — passive voice with an intervening adverb is missed.** The regex requires the
participle immediately after the auxiliary, so `was not cleaned`, `is being processed`, and
`has already been sent` all pass silently. Read for signal, not as a gate.

False positives are expected and the tool says so. `-ing` catches ordinary nouns ("ceiling").
Review every hit.

## Usage

```bash
# heuristic lint on written output
python3 scripts/ste_check.py <file.md>
python3 scripts/ste_check.py -            # stdin
python3 scripts/ste_check.py <file.md> --limit 20
```

Invocation phrasing that works well:

- "Explain X in 80% STE."
- "Diagram what this agent changed and what I need to check."
- "Make an interactive HTML explainer of X."
- "Create a 3b1b-style video explainer on X. Use local TTS." — step 4 takes real time and may need
  an API key, so confirm with the user before building one.
