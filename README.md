# Workspace Brain

`brain/` is the sole local owner for agent rules, tool configuration, working state,
architecture, documentation, research, chats, transcripts, scripts, and generated
assets for this workspace.

**This brain is multi-project.** It tracks every project you work on — not just one.
Project records live in `brain/projects/<project-name>/` and are surfaced in the
master task index at `brain/projects/TASK-INDEX.md`.

## What's tracked here

| Area | Where |
|---|---|
| **All projects** (100+) | `brain/projects/` — per-project `PROJECT.md`, `task-board.md`, `memory.md`, `scratchpad.md` |
| **Master task index** | `brain/projects/TASK-INDEX.md` — one view across every project |
| **Skills** (151) | `brain/.claude/skills/` — canonical; symlinked into `.agents`, `.kilocode`, etc. |
| **Agents, commands, hooks** | `brain/.claude/`, `brain/.cursor/`, `brain/.trae/`, `brain/.gemini/`, `brain/.codex/`, `brain/.opencode/`, `brain/.kilocode/`, `brain/.dsh/`, `brain/.codebuddy/`, `brain/.qwen/` |
| **Universal rules** | `brain/AGENTS.md`, `brain/CLAUDE.md` |
| **Working state** | `brain/state/` (task board, daily notes, scratchpad) |
| **Automation scripts** | `brain/scripts/` — repo scan, git-push hook, project attach, brain sync, master index |

## Workspace root

`/Users/abhishek` — agent sessions start here so universal context loads before
entering any subdirectory. Product source lives in `abhishek-projects/`, `brain/projects/`,
or wherever you keep it. `brain/` owns the cross-agent OS and state.

## Multi-Machine Sync & New PC Setup

To set up and provision symlinks on a new machine:

```bash
git clone https://github.com/iamabhishekt/brain.git ~/brain
cd ~/brain && bash scripts/setup-new-pc.sh
```

## Discovery Shims

| Root path | Brain owner |
|---|---|
| `AGENTS.md` | `brain/AGENTS.md` |
| `CLAUDE.md` | `brain/CLAUDE.md` |
| `GEMINI.md` | `brain/GEMINI.md` |
| `.claude` | `brain/.claude` |
| `.cursor` | `brain/.cursor` |
| `.trae` | `brain/.trae` |
| `.kilocode` | `brain/.kilocode` |
| `.dsh` | `brain/.dsh` |
| `.agents` | `brain/.agents` |
| `.codebuddy` | `brain/.codebuddy` |
| `.gemini` | `brain/.gemini` |
| `.codex` | `brain/.codex` |
| `.opencode` | `brain/.opencode` |
| `.qwen` | `brain/.qwen` |
| `.mcp.json` | `brain/.mcp.json` |
| `documentation` | `brain/documentation` |
| `skills-lock.json` | `brain/tool-config/skills-lock.json` |
| `Daily Notes` | `brain/state/daily-notes` |
| `Task Board.md` | `brain/state/task-board.md` |
| `Scratchpad.md` | `brain/state/scratchpad.md` |

## Content Ownership

| Content | Destination |
|---|---|
| Universal rules and current state | `brain/` |
| Architecture | `brain/architecture/` |
| Curated docs and research | `brain/documentation/` |
| Local task and daily state | `brain/state/` |
| Workspace utilities & scripts | `brain/scripts/` |
| Tool-specific metadata | `brain/tool-config/` |
| Runtimes | `brain/.claude/`, `brain/.gemini/`, `brain/.cursor/`, `brain/.trae/`, etc. |

## Default-On Skills

These skills are **on by default** for every agent session, so you learn efficiently
while doing project work. They're listed in `brain/AGENTS.md` ("Learning-By-Default")
and load at session start.

| Skill | What it does |
|---|---|
| `vibe-wise-learn` | Reasoning-first onboarding for new projects / unfamiliar repos |
| `eli5` | Explain anything to any audience (kids, managers, engineers, parents) |
| `aas-explain-like-socrates` | Socratic explanation instead of a fact dump |
| `aas-tutorial-engineer` | Turn a concept into a tutorial |
| `aas-technical-tutorials` | Technical tutorial authoring |
| `aas-learn` | Capture learnings into the knowledge base |
| `aas-cc-skill-continuous-learning` | Continuous learning discipline |
| `aas-learning-career-development` | Career-skill growth guidance |
| `aas-javascript-mastery` | Deepen JS/TS mastery |
| `aas-crossframe-teach` | Teach across frameworks |
| `aas-kaizen` | Continuous improvement of process and code shape |
| `teach` | Teach the user a new skill or concept over sessions |
| `ponytail` | Write the least that works — the best code is the code you never wrote |
| `caveman` | Talk concisely; drop throat-clearing |
| `improve-codebase-architecture` | Find structural deepening opportunities |
| `code-review` | Two-axis review (Standards + Spec) |
| `tdd` | Red-green-refactor test-driven development |
| `diagnosing-bugs` | Disciplined bug diagnosis loop |
| `domain-modeling` | Build and sharpen the project's domain model |
| `codebase-design` | Shared vocabulary for designing deep modules |
| `grill-me` / `grill-with-docs` | Relentless interview to sharpen a plan |
| `research` | Investigate against high-trust primary sources |
| `prototype` | Throwaway prototype to sanity-check a state/logic model |
| `handoff` | Compact a conversation into a handoff doc |
| `wizard` | Generate an interactive bash wizard for manual procedures |

To turn learning off for a session: say "pause learning" or "learning off".
To resume: say "resume learning".