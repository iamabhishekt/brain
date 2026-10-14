# Default-On Skills Manifest

Canonical list of skills that are **on by default** for every agent session.
Last updated: 2026-10-03.

Source of truth: `brain/.claude/skills/` (canonical), symlinked into
`brain/.agents/skills/`, `brain/.kilocode/skills/`.

## Design principle: small default-on set

Skills load at session start, so every default-on skill costs context on **every
message**. The default-on set is therefore deliberately small — only the highest-value,
broadly-useful learning skills. Everything else is installed and available but **opt-in**:
say "load X" to bring it in for a session.

## Always-on (9 skills, ~25 KB total)

| Skill | Category | One-line |
|---|---|---|
| `vibe-wise-learn` | learning | Reasoning-first onboarding for new projects / unfamiliar repos |
| `eli5` | learning | Explain anything to any audience |
| `aas-explain-like-socrates` | learning | Socratic explanation instead of a fact dump |
| `aas-cc-skill-continuous-learning` | learning | Capture learnings into the knowledge base |
| `karpathy-understanding-first` | learning | Outsource thinking, never understanding |
| `karpathy-minimalism` | learning | 200 lines of pure code beats 50 npm packages |
| `karpathy-llm-wiki` | learning | Let the LLM maintain your KB; you do the exploring |
| `ponytail` | engineering | Write the least that works |
| `caveman` | engineering | Talk concisely; drop throat-clearing |
| `clean-code` | engineering | Uncle Bob Clean Code principles on every code edit |
| `clean-code-guard` | engineering | Guard-pass on generated/changed code blocks |
| `karpathy-guidelines` | engineering | Karpathy 4 checks on code change + execution loop |
| `make-it-click` | communication | Explanations using the Make-It-Click ladder |

## Opt-in (installed, load on demand)

The full Karpathy methodology set: `karpathy-methodology`,
`karpathy-agentic-engineering`, `karpathy-llm-simulator`, `karpathy-autoresearch`,
`karpathy-education-first`, `karpathy-meta-reflection`,
`karpathy-system-prompt-learning`, `karpathy-output-evolution`,
`karpathy-idea-files`, `karpathy-practice-environments`,
`karpathy-supply-chain-hygiene`, `karpathy-vibe-to-agentic`.

Plus: `improve-codebase-architecture`, `code-review`, `tdd`, `diagnosing-bugs`,
`domain-modeling`, `codebase-design`, `grill-me`, `grill-with-docs`, `research`,
`prototype`, `handoff`, `wizard`, `teach`, `aas-learn`, `aas-teach`,
`aas-tutorial-engineer`, `aas-technical-tutorials`, `aas-learning-career-development`,
`aas-crossframe-teach`, `aas-javascript-mastery`, `aas-kaizen`.

## Memory persistence

Learnings are written to `brain/.claude/knowledge-base.md` (auditor-gated) and
per-project `brain/projects/<name>/memory.md` by the `aas-cc-skill-continuous-learning`
and `karpathy-llm-wiki` skills. To keep memory small and durable:

- `brain/.claude/memory.md` is capped at ~100 lines (Write only) — prune stale items.
- `brain/.claude/knowledge-base.md` is capped at ~200 lines; every entry needs
  `[Source:]` provenance and no TBD/TODO.
- Run `/sync` mid-day to refresh memory and process the scratchpad.
- Run `/wrap-up` at end of session to persist state.

## Turn off for a session

Say `pause learning` or `learning off`. Say `resume learning` to bring it back.

## Exclusions

- The full Agentic Awesome Skills catalog (2,500+ skills) is **not** installed — only the learning-relevant subset above, to avoid bloating context.