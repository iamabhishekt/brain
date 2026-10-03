# Ecommerce Website Agent Entry Point

This file is canonical project guidance for every coding agent and interface: Claude Code, Antigravity, Cursor, TRAE, Codex, Copilot, Gemini, JetBrains, and future tools.

Tool-specific files may add runtime instructions. They must not duplicate or override project rules here or in linked scoped documents.

## Workspace Boundary

Workspace root is the folder that contains `brain/` and project repositories/code.

- Start agent sessions from workspace root so universal context loads before entering subdirectories.
- Product source stays in the workspace root or designated project folders.
- Agent rules, tools, and shared state live in `brain/` and are surfaced via discovery symlinks in root.

## Mandatory Read Order

Before making decisions or changing files:

1. Read this file (`AGENTS.md` / `brain/AGENTS.md`).
2. Read `CLAUDE.md` / `brain/CLAUDE.md` (project directives, Claudify OS architecture).
3. Read `CURRENT_STATE.local.md` / `brain/CURRENT_STATE.local.md` when present (local cross-agent handoff state).
4. Read `Task Board.md` / `brain/state/task-board.md` for detailed local tasks.
5. Read `.claude/memory.md` (active session context and working style).
6. Read `.claude/knowledge-base.md` (system-wide learned rules and constraints).

## Non-Negotiable Invariants

1. **Phased Execution:** Break complex tasks into explicit phases of max 5 files. Complete one phase, verify it, and confirm before continuing.
2. **Forced Verification:** Run type checks and linters before marking tasks complete. Fix all resulting errors.
3. **No Secrets in Project Context:** Never store credentials, tokens, card data, private keys, or API keys in source code or git. Use `.env` files.
4. **Follow Memory Rituals:** Update `.claude/memory.md` and `Task Board.md` to keep context fresh across sessions.
5. **No Hallucinated Edits:** Always inspect and verify target files before and after editing.

## Context Ownership

| Information | Source of truth |
|---|---|
| Universal project constraints and read order | `AGENTS.md` |
| Claudify operating system architecture | `CLAUDE.md` |
| Current local handoff | `brain/CURRENT_STATE.local.md` |
| Detailed local tasks | `Task Board.md` (`brain/state/task-board.md`) |
| Quick capture scratchpad | `Scratchpad.md` (`brain/state/scratchpad.md`) |
| Chronological session record | `Daily Notes/` (`brain/state/daily-notes/`) |
| Tool mechanics, hooks, commands, skills | `brain/.claude/`, `brain/.cursor/`, `brain/.trae/`, `brain/.gemini/` |
| Architecture and system design | `brain/architecture/` |
| Curated documentation and research | `brain/documentation/` |

## Learning-By-Default (ON)

Every agent session runs with **learning mode on by default**. While doing project work, treat learning as part of the job — don't just ship code, grow understanding.

### What this means in practice
- **Reason before writing.** Before implementing, briefly surface the design tradeoffs and ask/confirm the approach when the decision is consequential. Borrowed from VibeWise (`vibe-wise-learn`).
- **Teach as you go.** When a concept comes up, explain it at the right level for the audience — plain English for non-engineers, precise for engineers. (`eli5`, `aas-explain-like-socrates`)
- **Learn continuously.** Capture non-obvious rules, gotchas, and decisions into the knowledge base as you discover them — so the next session inherits them. (`aas-cc-skill-continuous-learning`, `aas-learn`)
- **Improve the codebase's shape.** Periodically look for structural deepening opportunities, not just feature work. (`improve-codebase-architecture`, `aas-kaizen`)
- **Write the least that works.** Prefer stdlib, native features, and existing code over new dependencies and abstractions. The best code is the code you never wrote. (`ponytail`)
- **Talk concisely.** Say the important thing, drop throat-clearing. (`caveman`)

### Available learning skills
| Skill | Use when |
|---|---|
| `vibe-wise-learn` | Starting a new project or unfamiliar repo — reasoning-first onboarding |
| `eli5` | Explain anything to any audience (kids, managers, engineers, parents) |
| `aas-explain-like-socrates` | Socratic explanation instead of a dump of facts |
| `aas-tutorial-engineer` / `aas-technical-tutorials` | Turn a concept into a tutorial |
| `aas-learn` / `aas-cc-skill-continuous-learning` | Capture learnings into the knowledge base |
| `aas-learning-career-development` | Career-skill growth guidance |
| `aas-javascript-mastery` | Deepen JS/TS mastery |
| `aas-crossframe-teach` | Teach across frameworks |
| `aas-kaizen` | Continuous improvement of process and code shape |
| `teach` | Teach the user a new skill or concept over sessions |

### Default-on skill set
The canonical list of always-on skills lives at `brain/tool-config/default-skills.md`.

**Why this small set:** skills load at session start, so every default-on skill costs
context on every message. The always-on set is deliberately *small* — the highest-value,
broadly-useful learning skills only. Everything else (domain specialists, heavy guides,
the full Karpathy methodology set) is installed and available, but **opt-in**: just name
it and it loads for that session.

**Always-on (lightweight, high value):**
| Skill | What it does |
|---|---|
| `vibe-wise-learn` | Reasoning-first onboarding for new projects / unfamiliar repos |
| `eli5` | Explain anything to any audience |
| `aas-explain-like-socrates` | Socratic explanation instead of a fact dump |
| `aas-cc-skill-continuous-learning` | Capture learnings into the knowledge base |
| `karpathy-understanding-first` | Outsource thinking, never understanding |
| `karpathy-minimalism` | 200 lines of pure code beats 50 npm packages |
| `karpathy-llm-wiki` | Let the LLM maintain your knowledge base; you explore |
| `ponytail` | Write the least that works |
| `caveman` | Talk concisely; drop throat-clearing |

**Opt-in (installed, load on demand):** the rest of the Karpathy methodology set
(`karpathy-methodology`, `karpathy-agentic-engineering`, `karpathy-llm-simulator`,
`karpathy-autoresearch`, `karpathy-education-first`, `karpathy-meta-reflection`,
`karpathy-system-prompt-learning`, `karpathy-output-evolution`, `karpathy-idea-files`,
`karpathy-practice-environments`, `karpathy-supply-chain-hygiene`,
`karpathy-vibe-to-agentic`), plus `improve-codebase-architecture`, `code-review`, `tdd`,
`diagnosing-bugs`, `domain-modeling`, `codebase-design`, `grill-me`, `grill-with-docs`,
`research`, `prototype`, `handoff`, `wizard`, `teach`, and the remaining AAS learning
skills. Say "load X" to bring one in for a session.

### Karpathy learning strategy on X
Andrej Karpathy's public tweets are pulled into the brain on demand:

```bash
export APIFY_TOKEN='apify_api_...'   # get one at https://apify.com/store/tokens (free tier)
bash ~/brain/scripts/fetch-karpathy.sh 200
```

Output lands at `brain/documentation/karpathy-x-feed.jsonl` (one JSON row per tweet,
deduped across runs). The distilled methodology is also installed as skills
(`karpathy-methodology` + 14 sub-skills) — opt-in, load with "load karpathy-*".

### Turn it off
Say "pause learning" or "learning off" to suspend it for a session; say "resume learning" to bring it back.

## Local State

`CURRENT_STATE.local.md`, `Task Board.md`, `Daily Notes/`, and `Scratchpad.md` are local workflow files. Refresh local state from repository evidence and user direction; never invent completed work.
