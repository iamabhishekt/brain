# Provenance — vendored skill

## Upstream

| | |
|---|---|
| Skill | `karpathy-guidelines` |
| Repository | https://github.com/multica-ai/andrej-karpathy-skills |
| Upstream file | `CLAUDE.md` |
| Commit | `2c606141936f1eeef17fa3043a72095b4765b9c2` |
| Commit date | 2026-04-20 |
| Commit subject | Sync Chinese README with English version (add Cursor section) (#95) |
| License | **none** — see below |
| Retrieved | 2026-10-13 |
| Upstream state | 28 commits, default branch `main` |

Vendored verbatim. Only YAML frontmatter was prepended, so the file loads as a
skill. Body integrity verified by sha256 comparison against the fetched
upstream — identical.

Upstream content is 4 behavioural principles for reducing LLM coding mistakes:
think before coding, simplicity first, surgical changes, goal-driven execution.

## No license — read this before redistributing

Upstream ships **no LICENSE file**. Verified 2026-10-13:

```
https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/LICENSE     -> HTTP 404
https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/LICENSE.md  -> HTTP 404
GitHub API license field: null
```

Under default copyright, absence of a license means redistribution is **not
granted**. This copy is for internal reference in this workspace and is pushed
to a private repo. Treat as do-not-redistribute. If it needs to ship in a
product or a public repo, get written permission or a license from the upstream
author first.

This is a real defect, recorded in `vendor.json` under `knownDefects`. It cannot
be fixed locally.

## Provenance of the ideas

The principles are attributed by the upstream author to Andrej Karpathy's
observations about LLM coding behaviour. Two independent links:

- Idea origin — https://github.com/multica-ai/andrej-karpathy-skills
- Karpathy's own account — https://x.com/karpathy

The upstream repo is **third-party**. Karpathy did not write it, and it is not
affiliated with or endorsed by him. This distinction matters when citing: cite
the repo for the text, Karpathy for the ideas, and never imply he authored this.

## Why this repo and not one of the near-duplicates

Six repos carry the same 4 principles. Verified before choosing:

| Repo | Shape | Why not |
|---|---|---|
| `multica-ai/andrej-karpathy-skills` | Single `CLAUDE.md`, no installer | **Chosen.** Content only, nothing to execute |
| `forrestchang/andrej-karpathy-skills` | `curl -o CLAUDE.md` | Installer overwrites the file outright |
| `Vincent-A-Yang/karpathy-skills-anycoding` | `curl … \| bash`, appends a marked block into `AGENTS.md` | **Would have rewritten this project's canonical `AGENTS.md`** |
| `syntax-syndicate/karpathy-skills` | Installs into ~9 tool folders | Adapter sprawl, duplicates canonical rules |
| `swarmclawai/andrej-karpathy-skills` | Installs into ~9 tool folders | Same |
| `forrestchang` variant | Multiple installer targets | Same |

Only the content was needed. Every alternative shipped an installer that writes
to `AGENTS.md` or sprays adapters across tool folders, which `AGENTS.md`
forbids: "Do not add agent framework, universal docs, or discovery adapters
inside nested product repositories" and "Update canonical owner. Do not copy same
rule or state into multiple adapters."

`multica-ai` was chosen because it has **nothing to run**. Installation here is a
file write, not a script execution.

## Local changes to the vendored text

Exactly one: YAML frontmatter was prepended so the file loads as a skill. The
body below the frontmatter is byte-identical to upstream `CLAUDE.md`.

The frontmatter `description` was written locally. It is not upstream text. It
lists triggers so the skill loads when reviewing work for over-engineering,
scope creep, drive-by refactors, or missing verification.

## Overlap with existing AGENTS.md modes — accepted, not an oversight

The four principles substantially duplicate modes already on by default:

| Principle | Existing mode | Coverage |
|---|---|---|
| 1. Think Before Coding | **Grill-me** | Full |
| 2. Simplicity First | **Ponytail** | Full |
| 3. Surgical Changes | **Ponytail** + Editing rule | Partial |
| 4. Goal-Driven Execution | **Clean-code-guard** | Partial |

Two elements are **not** in the existing modes and are the actual reason to keep
this:

- **The plan format.** `step → verify: check`, one line per step, written before
  multi-step work. Existing modes say "guard-pass before delivery" but do not ask
  for verification to be declared up front.
- **The trace test.** "Every changed line should trace directly to the user's
  request." This is a sharper form of the Editing rule's "keep changes scoped
  and reviewable", and it catches drive-by edits that scope-checking misses.

Those two are now written into `AGENTS.md` as the **Karpathy gate** default mode,
which composes the existing modes rather than restating them. Enabling both was
user-directed. The duplication is deliberate and recorded in `vendor.json` so a
later reader does not "fix" it by deleting one.

## Placement

`brain/.opencode/skills/` only. `brain/` is the synced cross-agent repo
(`abhisheklimosys/jlimo-brain`). No copy was made into the other adapter
folders, per `AGENTS.md`: "Update canonical owner. Do not copy same rule or state
into multiple adapters."

`AGENTS.md` at workspace root is a symlink to `brain/AGENTS.md`, so editing
`brain/AGENTS.md` updates the single canonical file that every agent reads. That
is why "for all agents" needed one edit and not nine.

## Drift management

Handled by the same mechanism as `make-it-click`:

| File | Role |
|---|---|
| `vendor.json` | Machine-readable pin: repo, `pinned.commit`, per-file sha256 prefixes, known defects |
| `brain/scripts/check-vendored-skills.sh` | Drift report across all vendored skills. Verifies local hashes, compares to upstream HEAD, prints known defects |

```bash
bash brain/scripts/check-vendored-skills.sh          # human report
bash brain/scripts/check-vendored-skills.sh --quiet  # exit code only, for a hook
```

Exit codes: `0` clean, `1` drift, `2` bad environment.

The script discovers manifests with `find -name vendor.json`, so this skill was
picked up with no change to the script. It **never applies an update** — no
pull, no write. Upstream drift prints `MOVED -> <sha>` and stops.

**Upstream has 28 commits and moved as recently as 2026-04.** It will drift.
Review the upstream diff by hand, then update `pinned.commit` and `files.*` by
hand.

### Why not `brain/tool-config/skills-lock.json`

That file is the **mattpocock/skills installer lock**, not a general workspace
lockfile. `MIGRATION_MANIFEST.md` records it as tracking that installer's dirs
under `.agents/skills/`. Adding this skill there would make a third-party
installer believe it owns it, and a re-run could delete the vendored copy. Pin
belongs with the vendor. Same reasoning as `make-it-click`.

## Stars figure — deliberately not recorded

The GitHub API reported `stargazers_count: 219462` and `forks_count: 22090` for
this repo. Those numbers are implausible for a single-file guidelines repo and
are **not recorded** in `vendor.json` — `starsAtInstall` is `null`.

The star count carries no weight for the pin. Commit sha, commit date and file
hashes do. Recording an implausible figure would make the manifest look
authoritative about something it cannot vouch for.